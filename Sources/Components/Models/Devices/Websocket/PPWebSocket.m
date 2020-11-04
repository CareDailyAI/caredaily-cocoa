//
//  PPWebSocket.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPWebSocket.h"

@interface PPWebSocket ()
@property (nonatomic, strong) NSString *connectURL;
@property (nonatomic, weak, readwrite) NSObject<PPWebSocketDelegate> *delegate;
@property (nonatomic) PPWebSocketResourceEndpoint resourceEndpoint;
@end

@implementation PPWebSocket
+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"delegate", @"webSocket"];
}

-(id) initWithURL:(NSString*)URL resourceEndpoint:(PPWebSocketResourceEndpoint)resourceEndpoint sessionId:(NSString*)sessionId delegate:(NSObject<PPWebSocketDelegate> *)delegate {
	self = [super init];
	if(self) {
        _resourceEndpoint = resourceEndpoint;
		_sessionId = sessionId;
		_delegate = delegate;
        
        switch (resourceEndpoint) {
            case PPWebSocketResourceEndpointCamera:
                _connectURL = [NSString stringWithFormat:@"%@/camera", URL];
                break;
            case PPWebSocketResourceEndpointViewer:
                _connectURL = [NSString stringWithFormat:@"%@/viewer", URL];
                break;
                
            default:
                _connectURL = [NSString stringWithFormat:@"%@", URL];
                break;
        }
	}
	return self;
}

-(void)connect {
	[self disconnect];
    
#ifdef DEBUG
    NSLog(@"%s URL=%@", __PRETTY_FUNCTION__, _connectURL);
#endif
	self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_connectURL]]];
    _webSocket.delegate = self;
    [_webSocket open];
}


/**
 * On disconnect, we destroy references to our delegate first.
 * This is an important point:  because then when we call the [close]
 * method on the websocket, there will be no [websocketBroken event that gets passed up
 * the stack, and therefore our delegate up above will not try to automatically reconnect us.
 */
-(void)disconnect {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
	if(_webSocket) {
		_delegate = nil;
		_webSocket.delegate = nil;
        [_webSocket close];
		_webSocket = nil;
    }
}

/**
 * Send a ping to the server
 */
-(void)ping {
    NSString *request;

    switch (_resourceEndpoint) {
            
        default:
            request = @"?";
            break;
    }
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }
}

/**
 * Response to servers request before it times us out
 */
-(void)pong {
    NSString *request;
	
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            request = @"{}";
            break;
            
        default:
            request = @"!";
            break;
    }
	if (_webSocket.readyState == SR_OPEN) {
		[_webSocket send:request];
	}
}

/**
 * Every time we connect to the server, we have to declare our connection session ID back to the server.
 */
- (void)declareConnected {
    NSString *uuid;
    [self declareConnected:&uuid];
}
- (void)declareConnected:(NSString * _Nullable __autoreleasing *)uuid {
    NSDictionary *data;
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            data = @{
                @"sessionId": self.sessionId
            };
            break;
            
        default:
        {
            NSUUID *UUID = [NSUUID UUID];
            *uuid = UUID.UUIDString;
            data = @{
                @"id": *uuid,
                @"key": self.sessionId,
                @"goal": @(PPWebSocketGoalAuth),
            };
            break;
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        NSLog(@"%s Invalid format (%@): %@", __PRETTY_FUNCTION__, error, data);
        return;
    }
    NSString *request = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"%s command: %@", __PRETTY_FUNCTION__, request);
#endif
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }

}

/**
 * The server will return supported subscription types based on the session scope.
 */
- (void)requestPresence {
    NSString *uuid;
    [self requestPresence:&uuid];
}
- (void)requestPresence:(NSString * _Nullable __autoreleasing *)uuid {
    NSDictionary *data;
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            data = @{};
            break;
            
        default:
        {
            NSUUID *UUID = [NSUUID UUID];
            *uuid = UUID.UUIDString;
            data = @{
                @"id": *uuid,
                @"goal": @(PPWebSocketGoalPresence),
            };
            break;
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        NSLog(@"%s Invalid format (%@): %@", __PRETTY_FUNCTION__, error, data);
        return;
    }
    NSString *request = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"%s command: %@", __PRETTY_FUNCTION__, request);
#endif
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }
}

/**
 * Status
 * The server will return current session subscription.
 */
- (void)retrieveStatus {
    NSString *uuid;
    [self retrieveStatus:&uuid];
}
- (void)retrieveStatus:(NSString * _Nullable __autoreleasing *)uuid {
    NSDictionary *data;
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            data = @{};
            break;
            
        default:
        {
            NSUUID *UUID = [NSUUID UUID];
            *uuid = UUID.UUIDString;
            data = @{
                @"id": *uuid,
                @"goal": @(PPWebSocketGoalStatus),
            };
            break;
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        NSLog(@"%s Invalid format (%@): %@", __PRETTY_FUNCTION__, error, data);
        return;
    }
    NSString *request = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"%s command: %@", __PRETTY_FUNCTION__, request);
#endif
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }
}

/**
 * Subscribe
 * Client can subscribe on new data and events coming to the server.
 * Client can have only one subscription with same parameters.
 *
 * To subscribe on a data model, client sends a request with the goal "subscribe" and the subscription options.
 * After approval, the server starts sending to client the messages containing the data objects that match the subscription options.
 * A new subscription request can absorb previously created subscriptions if it subscribes to a wider range of data of the same kind.
 *
 * Currently supported subscription types:
 * 1 - narratives
 * 2 - organization narratives
 */
- (void)subscribe:(NSDictionary *)subscription {
    NSString *uuid;
    [self subscribe:subscription uuid:&uuid];
}
- (void)subscribe:(NSDictionary *)subscription uuid:(NSString * _Nullable __autoreleasing *)uuid {
    NSDictionary *data;
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            data = @{};
            break;
            
        default:
        {
            NSUUID *UUID = [NSUUID UUID];
            *uuid = UUID.UUIDString;
            data = @{
                @"id": *uuid,
                @"goal": @(PPWebSocketGoalSubscribe),
                @"subscription": subscription
            };
            break;
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        NSLog(@"%s Invalid format (%@): %@", __PRETTY_FUNCTION__, error, data);
        return;
    }
    NSString *request = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"%s command: %@", __PRETTY_FUNCTION__, request);
#endif
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }
}

/**
 * Unsubscribe
 */
- (void)unsubscribe:(NSInteger)type {
    NSString *uuid;
    [self unsubscribe:type uuid:&uuid];
}
- (void)unsubscribe:(NSInteger)type uuid:(NSString * _Nullable __autoreleasing *)uuid {
    NSDictionary *data;
    switch (_resourceEndpoint) {
        case PPWebSocketResourceEndpointCamera:
        case PPWebSocketResourceEndpointViewer:
            data = @{};
            break;
            
        default:
        {
            NSUUID *UUID = [NSUUID UUID];
            *uuid = UUID.UUIDString;
            data = @{
                @"id": *uuid,
                @"goal": @(PPWebSocketGoalUnsubscribe),
                @"subscription": @{
                    @"id": @(type)
                }
            };
            break;
        }
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        NSLog(@"%s Invalid format (%@): %@", __PRETTY_FUNCTION__, error, data);
        return;
    }
    NSString *request = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"%s command: %@", __PRETTY_FUNCTION__, request);
#endif
    if (_webSocket.readyState == SR_OPEN) {
        [_webSocket send:request];
    }
}

- (void)dealloc {
    if(_webSocket) {
        _webSocket.delegate = nil;
    }
}


#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
	
	if(self.delegate) {
        switch (_resourceEndpoint) {
            case PPWebSocketResourceEndpointCamera:
            case PPWebSocketResourceEndpointViewer:
                [self declareConnected];
            default:
                break;
        }
		[_delegate websocketDidConnect:webSocket];
	}
	else {
		[self disconnect];
	}
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
#ifdef DEBUG
	NSLog(@"%s error=%@",__PRETTY_FUNCTION__, error.description);
#endif
	
	_webSocket.delegate = nil;
	if(_delegate) {
        if ([_delegate respondsToSelector:@selector(websocketBroken:reason:)]) {
            [_delegate websocketBroken:error.code reason:error.description];
        }
        else {
            [_delegate websocketBroken];
        }
	}
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
#ifdef DEBUG
	NSLog(@"%s wasClean=%d code=%li reason=%@",__PRETTY_FUNCTION__, wasClean, (long)code, reason);
#endif
	
	_webSocket.delegate = nil;
	if(_delegate) {
        if ([_delegate respondsToSelector:@selector(websocketBroken:reason:)]) {
            [_delegate websocketBroken:code reason:reason];
        }
        else {
            [_delegate websocketBroken];
        }
	}
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
#ifdef DEBUG
    NSLog(@"%s message=%@",__PRETTY_FUNCTION__, message);
#endif
	if(_delegate) {
		[_delegate websocket:webSocket didReceiveMessage:message];
	}
}

#pragma mark - PPBaseModel

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode argument:(NSString *)argument {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    switch(resultCode) {
        case PPWebSocketErrorCodeSuccess:
            return nil;
        case PPWebSocketErrorCodeInternalError:
            [errorDetail setValue:@"Sorry! Something went wrong. Our engineers are alerted and we're fixing it!" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeWrongAPIKey:
            [errorDetail setValue:@"You are no longer signed in." forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeWrongAuthToken:
            [errorDetail setValue:@"Wrong device authentication token." forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeWrongDeviceID:
            [errorDetail setValue:@"That device is no longer in your account" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeWrongSessionID:
            [errorDetail setValue:@"Wrong session ID" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeCameraNotConnected:
            [errorDetail setValue:@"This camera is not connected" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeCameraConnected:
            [errorDetail setValue:@"This camera is connected" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeWrongParameterValue:
            [errorDetail setValue:@"Wrong parameter value" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeMissingMandatoryParameter:
            [errorDetail setValue:@"Missing mandatory parameter value" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodePing:
            [errorDetail setValue:@"Ping!" forKey:NSLocalizedDescriptionKey];
            break;
        case PPWebSocketErrorCodeServiceTemporarilyUnavailable:
            [errorDetail setValue:@"Service is temporarily unavailable" forKey:NSLocalizedDescriptionKey];
            break;
            
    }
    
    if (argument != nil && ![argument isEqualToString:@""]) {
        [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
    }
    
    return [NSError errorWithDomain:@"com.peoplepowerco.lib.Peoplepower.websocket" code:resultCode userInfo:errorDetail];
}

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode {
    return [PPWebSocket resultCodeToNSError:resultCode argument:nil];
}

/**
 * Process the result of an AFHTTPRequestOperation
 */
+ (NSDictionary *)processResponse:(NSData *)responseObject error:(NSError **)error {
    return [PPWebSocket processResponseData:responseObject error:error];
}

/**
 * Process the raw response data
 */
+ (NSDictionary *)processResponseData:(NSData *)responseData error:(NSError **)error {
    NSError *parseError;
    NSDictionary *responseJson;
    
    // Trying to avoid a crash that in our production baseline in Presence 4.0.8
    @try {
        responseJson = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&parseError];
    } @catch (NSException *exception) {
        *error = [PPWebSocket resultCodeToNSError:PPWebSocketErrorCodeInternalError];
        return nil;
    }
    
    if(parseError) {
        *error = parseError;
        return nil;
    }
    
    NSInteger resultCode = 0;
    if ([responseJson objectForKey:@"resultCode"]) {
        resultCode = [[responseJson objectForKey:@"resultCode"] integerValue];
    }
    
    if(resultCode > 0) {
        *error = [PPWebSocket resultCodeToNSError:resultCode argument:[responseJson objectForKey:@"resultCodeMessage"]];
        return nil;
    }
    
    return responseJson;
}

@end
