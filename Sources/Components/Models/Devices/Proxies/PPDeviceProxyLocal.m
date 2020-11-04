//
//  PPDeviceProxyLocal.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceProxyLocal.h"
#import "PPDeviceCamera.h"
#import <sys/utsname.h>
#import "PPCloudEngine.h"

@interface PPDeviceProxyLocal ()

@end

@implementation PPDeviceProxyLocal

- (id)init {
    self = [super init];
    if(self) {
        self.initializationAttempts = 0;
        self.websocketResourceEndpoint = PPWebSocketResourceEndpointCamera;
    }
    return self;
}

- (PPDevice *)device {
    return [PPDevices localDeviceForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId];
}

- (void)setDevice:(PPDevice *)device {
    NSLog(@"%s device=%@", __PRETTY_FUNCTION__, device);
    if(!device) {
        NSLog(@"!!!");
    }
}

#pragma mark Local Device device ID helpers

+ (BOOL)isLocalDeviceWithId:(NSString *)deviceId locationId:(PPLocationId)locationId {
    NSString *localDeviceId = [PPDeviceProxyLocal localDeviceId:locationId];
    return [deviceId isEqualToString:localDeviceId];
}

+ (NSString *)localUDID {
    NSString *systemId;
    
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        // iOS 6 and up - identifierForVendor is more accurate
        systemId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    else {
        // iOS 5 - use the detailed name of the device model.  If you migrate to the same model phone, there's no way we can detect it.
        struct utsname systemInfo;
        uname(&systemInfo);
        systemId = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cameraUDID = [defaults stringForKey:@"cameraUDID"];
    NSString *originalSystemId = [defaults stringForKey:@"systemId"];
    
    if(systemId != nil) {
        if(originalSystemId != nil) {
            if(![originalSystemId isEqualToString:systemId]) {
                // We must have migrated user data to a new device, start fresh with a new camera UDID
                cameraUDID = nil;
            }
        }
        else {
            // We upgraded our app from 1.1.0 to 1.2.0, so now we need to initialize the systemId
            [defaults setObject:systemId forKey:@"systemId"];
            [defaults synchronize];
        }
    }
    
    if(cameraUDID == nil) {
        if(NSClassFromString(@"NSUUID") == nil) {
            CFUUIDRef udid = CFUUIDCreate(NULL);
            cameraUDID = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, udid));
            CFRelease(udid);
        }
        else {
            cameraUDID = [[NSUUID UUID] UUIDString];
        }
        if(systemId != nil) {
            [defaults setObject:systemId forKey:@"systemId"];
        }
        [defaults setObject:cameraUDID forKey:@"cameraUDID"];
        [defaults synchronize];
    }
    return cameraUDID;
}

#pragma mark Turn on

- (void)turnOn:(NSObject<PPDeviceProxyLocalDelegate> *)delegate proxyDelegate:(NSObject<PPDeviceProxyLocalWebsocketDelegate> *)proxyDelegate {
    
    self.delegate = delegate;
    self.proxyDelegate = proxyDelegate;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelector:@selector(start) withObject:nil afterDelay:DEVICE_LOCAL_INITIALIZATION_DELAY];
    });
}

- (void)turnOff {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    self.delegate = nil;
    [self.webSocket disconnect];
    
    if([self.proxyDelegate respondsToSelector:@selector(localDeviceDidTurnOff:)]) {
        [_proxyDelegate localDeviceDidTurnOff:self.device.deviceId];
    }
}

- (void)connectWebSocket {
    
    if([_delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
        [_delegate localDeviceProgress:PPDeviceProxyLocalProgressWebSocketConnecting message:@"WebSocket Connecting"];
    }
    
    self.webSocket = [[PPWebSocket alloc] initWithURL:[self webSocketURL] resourceEndpoint:PPWebSocketResourceEndpointCamera sessionId:_webSocketConfiguration.sessionId delegate:self];
    [_webSocket connect];
}

- (NSString *)webSocketURL {
    NSString *webSocketURL = nil;
    
    NSArray *streamingUrlArray = [[PPUrl streamingServerURLString:nil] componentsSeparatedByString:@"://"];
    _webSocketConfiguration.APIServerURL = [streamingUrlArray lastObject];
    _webSocketConfiguration.isAPIServerSSL = ([[streamingUrlArray firstObject] rangeOfString:@"https"].location != NSNotFound) ? YES : NO;
    
    if(_webSocketConfiguration.isAPIServerSSL) {
        webSocketURL = [NSString stringWithFormat:@"wss://%@",_webSocketConfiguration.APIServerURL];
    } else {
        webSocketURL = [NSString stringWithFormat:@"ws://%@",_webSocketConfiguration.APIServerURL];
    }
    return webSocketURL;
}

#pragma mark Execute Command

- (void)executeCommands:(NSArray *)parameters {
    for(PPDeviceParameter *parameter in parameters) {
        [self.device setParameter:parameter.name value:parameter.value index:parameter.index lastUpdateDate:[NSDate date]];
    }
    if([parameters count] > 0) {
        if([_proxyDelegate respondsToSelector:@selector(localDeviceDidExecuteCommand:)]) {
            [_proxyDelegate localDeviceDidExecuteCommand:parameters];
        }
    }
}

#pragma mark - Private


- (void)start {
    _initializationAttempts++;
    if(_initializationAttempts < PPDeviceProxyLocalInitializationAttemptsMax) {
        // Increment our progress bar
        if([_delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
            [_delegate localDeviceProgress:PPDeviceProxyLocalProgressInitializingProxy +(PPDeviceProxyLocalProgress)_initializationAttempts message:@"Initializing Proxy"];
        }
    }
    else {
        if([_delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
            [_delegate localDeviceProgress:PPDeviceProxyLocalProgressInitializingProxy message:@"Initializing Proxy"];
        }
    }
    if(_initializationAttempts == 1) {
        // Starting device initialization
        if([_delegate respondsToSelector:@selector(localDeviceDidBeginInitialization)]) {
            [_delegate localDeviceDidBeginInitialization];
        }
    }
    else if(_initializationAttempts >= PPDeviceProxyLocalInitializationAttemptsMax) {
        if(_initializationAttempts == PPDeviceProxyLocalInitializationAttemptsMax) {
            // This device has exceeded the maximum initialization attempts.  Prevent further attempts and notify the user.
            if([_delegate respondsToSelector:@selector(localDeviceDidFailInitializationWithError:)]) {
                [_delegate localDeviceDidFailInitializationWithError:[PPBaseModel resultCodeToNSError:10043 originatingClass:NSStringFromClass([self class])]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelector:@selector(start) withObject:nil afterDelay:DEVICE_LOCAL_INITIALIZATION_DELAY_EXTENDED];
        });
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
            [self.delegate localDeviceProgress:PPDeviceProxyLocalProgressProxyInitialized message:@"Proxy Initialized"];
        }
        if([self.proxyDelegate respondsToSelector:@selector(localDeviceInitialized)]) {
            [self.proxyDelegate localDeviceInitialized];
        }
        
        if([self.delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
            [self.delegate localDeviceProgress:PPDeviceProxyLocalProgressInitializingWebsocket message:@"Initializing Websocket"];
        }
        [self createWebSocket];
    });
}

/**
 * @return the camera ID for locationId, which combines the location ID with the UDID for a unique ID for the user's location.
 */
+ (NSString *)localDeviceId:(PPLocationId)locationId {
    return [NSString stringWithFormat:@"%@:%li", [PPDeviceProxyLocal localUDID], (long)locationId];
}

/**
 * Create the websocket connection
 */
- (void)createWebSocket {
    
    if([_delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
        [_delegate localDeviceProgress:PPDeviceProxyLocalProgressGatheringServer message:@"Gather server information"];
    }
    
    [self initializeWebSocket:^(NSError *error) {
        if(error) {
            if([self.delegate respondsToSelector:@selector(localDeviceDidFailInitializationWithError:)]) {
                [self.delegate localDeviceDidFailInitializationWithError:error];
            }
            return;
        }
        if([self.delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
            [self.delegate localDeviceProgress:PPDeviceProxyLocalProgressServerDefined message:@"Server defined"];
        }
        
        if(self.delegate) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self connectWebSocket];
                
            });
        }
    }];
}

- (void)initializeWebSocket:(PPErrorBlock)callback {
    __weak typeof(self)wself = self;
    NSString *path = [NSString stringWithFormat:@"session?deviceId=%@",self.device.deviceId];
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedStreamingEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:path relativeToURL:[[PPCloudEngine sharedStreamingEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    if([_proxyDelegate respondsToSelector:@selector(localDeviceDidRequestAuthToken)]) {
        [request setValue:[NSString stringWithFormat:@"esp token=%@", [_proxyDelegate localDeviceDidRequestAuthToken]] forHTTPHeaderField:@"PPCAuthorization"];
    }
    else {
        [request setValue:[PPUserAccounts currentUser].sessionKey forHTTPHeaderField:@"API_KEY"];
    }
    [[PPCloudEngine sharedStreamingEngine] operationWithRequest:request success:^(NSData *responseData) {
        NSError *error = nil;
        
#ifdef DEBUG
        NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
#endif
        
        NSDictionary* responseJson = [PPWebSocket processResponse:responseData error:&error];
        
        if(error) {
            callback(error);
            return;
        }
        
        wself.webSocketConfiguration = [[PPWebSocketConfiguration alloc] init];
        wself.webSocketConfiguration.imageServerURL = [responseJson objectForKey:@"imageServer"];
        wself.webSocketConfiguration.videoServerURL = [responseJson objectForKey:@"videoServer"];
        wself.webSocketConfiguration.sessionId = [responseJson objectForKey:@"sessionId"];
        wself.webSocketConfiguration.isAPIServerSSL = [[responseJson objectForKey:@"apiServerSsl"] boolValue];
        wself.webSocketConfiguration.isImageServerSSL = [[responseJson objectForKey:@"imageServerSsl"] boolValue];
        wself.webSocketConfiguration.isVideoServerSSL = [[responseJson objectForKey:@"videoServerSsl"] boolValue];
        
        NSArray *c = [wself.webSocketConfiguration.videoServerURL componentsSeparatedByString:@":"];
        if([c count] > 1) {
            wself.webSocketConfiguration.videoServerPort = [c objectAtIndex:1];
        }
        else {
            wself.webSocketConfiguration.videoServerPort = @"1935";
        }
        
#ifdef DEBUG
        NSLog(@"Received from PPC Server for devideID : %@ ", wself.device.deviceId);
        NSLog(@"\t Image Server = %@", wself.webSocketConfiguration.imageServerURL);
        NSLog(@"\t Video Server token = %@", wself.webSocketConfiguration.videoServerURL);
        NSLog(@"\t Session id = %@", wself.webSocketConfiguration.sessionId);
#endif
        
        if(wself.webSocketConfiguration.sessionId != nil) {
            callback(nil);
        }
        else {
            callback([PPWebSocket resultCodeToNSError:PPWebSocketErrorCodeWrongSessionID originatingClass:NSStringFromClass([wself class])]);
        }
        
    } failure:^(NSError *error) {
#ifdef DEBUG
        NSLog(@"Failure error = %@", error);
#endif
        callback(error);
    }];
}

- (void) releaseCameraWebSocket {
    if(self.webSocket) {
        [_webSocket disconnect];
        _webSocket = nil;
    }
}

#pragma mark - PPWebSocketDelegate

/** Notification that the websocket connected */
- (void)websocketDidConnect:(SRWebSocket*)session {
#ifdef DEBUG
    NSLog(@"%s session=%@", __PRETTY_FUNCTION__, session);
#endif
    if([_delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
        [_delegate localDeviceProgress:PPDeviceProxyLocalProgressWebSocketConnected message:@"Websocket Connected"];
    }
    
    if(self.delegate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if([self.delegate respondsToSelector:@selector(localDeviceProgress:message:)]) {
                [self.delegate localDeviceProgress:PPDeviceProxyLocalProgressFinished message:@"Finished"];
            }
            if([self.delegate respondsToSelector:@selector(localDeviceReady)]) {
                [self.delegate localDeviceReady];
            }
        });
    }
}

/** Notification that the websocket broke.  If you want to recreate it, you have to renew your sessionId and start over from the beginning */
- (void)websocketBroken {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    self.webSocket = nil;
    if(_delegate) {
        [self createWebSocket];
    }
}

/** Web socket received a message */
- (void)websocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message {
#ifdef DEBUG
    NSLog(@"%s message=%@", __PRETTY_FUNCTION__, message);
#endif
    
    NSError *error = nil;
    NSString* command = nil;
    NSString* value = nil;
    NSString* index = nil;
    
    NSDictionary *responseJson = [PPWebSocket processResponseData:[message dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    
    if(error) {
        if(error.code == PPWebSocketErrorCodePing) {
            [_webSocket pong];
        }
        return;
    }
    
    NSMutableArray *commands = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *responseJsonArray = [responseJson valueForKey:WS_PARAMS];
    if([responseJsonArray count] > 0) {
        for(NSDictionary *responseObj in responseJsonArray) {
            command = [responseObj objectForKey:COMMAND_NAME];
            index = [responseObj objectForKey:COMMAND_INDEX];
            value = [responseObj objectForKey:COMMAND_SET_VALUE];
            if(value == nil) {
                value = [responseObj objectForKey:COMMAND_VALUE];
            }
            
            // Extract our index from our parameter like {index:value}
            if([value rangeOfString:@"{"].location == 0 && [value rangeOfString:@"}"].location == value.length - 1 && [value rangeOfString:@":"].location != NSNotFound) {
                
                NSError *parsingError = nil;
                NSString *v = [[[value stringByReplacingOccurrencesOfString:@"{" withString:@"{\""] stringByReplacingOccurrencesOfString:@":" withString:@"\":\""] stringByReplacingOccurrencesOfString:@"}" withString:@"\"}"];
                NSDictionary *d = [NSJSONSerialization JSONObjectWithData:[v dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&parsingError];
                if(!parsingError) {
                    index = (NSString *)[d allKeys].firstObject;
                    value = [d objectForKey:index];
                }
            }
            PPDeviceParameter *parameter = [[PPDeviceParameter alloc] initWithName:command index:index value:value lastUpdateDate:[NSDate date]];
            [commands addObject:parameter];
        }
    }
    
    if([commands count] > 0) {
        [self executeCommands:commands];
    }
}

@end
