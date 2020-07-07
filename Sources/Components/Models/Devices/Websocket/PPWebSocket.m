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
@end

@implementation PPWebSocket
+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"delegate", @"webSocket"];
}

-(id) initWithURL:(NSString*)URL resourceEndpoint:(PPWebSocketResourceEndpoint)resourceEndpoint sessionId:(NSString*)sessionId delegate:(NSObject<PPWebSocketDelegate> *)delegate {
	self = [super init];
	if(self) {
        switch (resourceEndpoint) {
            case PPWebSocketResourceEndpointCamera:
                _connectURL = [NSString stringWithFormat:@"%@/camera", URL];
                break;
            case PPWebSocketResourceEndpointViewer:
                _connectURL = [NSString stringWithFormat:@"%@/viewer", URL];
                break;
                
            default:
                _connectURL = [NSString stringWithFormat:@"%@/camera", URL];
                break;
        }
		_sessionId = sessionId;
		_delegate = delegate;
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

-(void)pong {
	NSString *requestJson = [NSString stringWithFormat:@"{}"];
	
	if (_webSocket.readyState == SR_OPEN) {
		[_webSocket send:requestJson];
	}
}


#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
	
	if(self.delegate) {
		[self declareConnected];
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
		[_delegate websocketBroken];
	}
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
#ifdef DEBUG
	NSLog(@"%s wasClean=%d code=%li reason=%@",__PRETTY_FUNCTION__, wasClean, (long)code, reason);
#endif
	
	_webSocket.delegate = nil;
	if(_delegate) {
		[_delegate websocketBroken];
	}
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
	if(_delegate) {
		[_delegate websocket:webSocket didReceiveMessage:message];
	}
}

/**
 * Every time we connect to the server, we have to declare our connection session ID back to the server.
 */
- (void)declareConnected {
	NSString *requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\"}", self.sessionId];
	
#ifdef DEBUG
	NSLog(@"%s command: %@", __PRETTY_FUNCTION__, requestJson);
#endif
	
	[_webSocket send:requestJson];

}

- (void)dealloc {
	if(_webSocket) {
		_webSocket.delegate = nil;
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
    
    return [NSError errorWithDomain:@"StreamingAPI" code:resultCode userInfo:errorDetail];
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
    
    NSInteger resultCode = [[responseJson objectForKey:@"resultCode"] integerValue];
    
    if(resultCode > 0) {
        *error = [PPWebSocket resultCodeToNSError:resultCode];
        return nil;
    }
    
    return responseJson;
}

@end
