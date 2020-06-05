//
//  PPWebSocket.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>

@protocol PPWebSocketDelegate <NSObject>
/** Notification that the websocket connected */
- (void)websocketDidConnect:(SRWebSocket*)session;

/** Notification that the websocket broke.  If you want to recreate it, you have to renew your sessionId and start over from the beginning */
- (void)websocketBroken;

/** Web socket received a message */
- (void)websocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message;
@end

typedef NS_OPTIONS(NSInteger, PPWebSocketResourceEndpoint) {
    PPWebSocketResourceEndpointCamera = 0,
    PPWebSocketResourceEndpointViewer = 1
};

/** Viewer status */
typedef NS_OPTIONS(NSInteger, PPWebSocketViewerStatus) {
	PPWebSocketViewerDisconnected = -1,
	PPWebSocketViewerNoChange = 0,
	PPWebSocketViewerConnected = 1,
};

typedef NS_OPTIONS(NSInteger, PPWebSocketErrorCodes) {
    PPWebSocketErrorCodeSuccess = 0,
    PPWebSocketErrorCodeInternalError = 1,
    PPWebSocketErrorCodeWrongAPIKey = 2,
    PPWebSocketErrorCodeWrongAuthToken = 3,
    PPWebSocketErrorCodeWrongDeviceID = 4,
    PPWebSocketErrorCodeWrongSessionID = 5,
    PPWebSocketErrorCodeCameraNotConnected = 6,
    PPWebSocketErrorCodeCameraConnected = 7,
    PPWebSocketErrorCodeWrongParameterValue = 8,
    PPWebSocketErrorCodeMissingMandatoryParameter = 9,
    PPWebSocketErrorCodePing = 10,
    PPWebSocketErrorCodeServiceTemporarilyUnavailable = 30,
};

@interface PPWebSocket : PPBaseModel <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, strong) NSString *sessionId;

/**
 * Initialize the websocket
 * @param URL NSString The URL to connect to
 * @param sessionId NSString The session ID generated from the GET /streaming/session?deviceId=<device id> API
 * @param resourceEndpoint PPDeviceProxyLocalWebsocketResourceEndpoint Endpoint to attach to URL (defaults to "/camera")
 * @param delegate the delegate to send event notifications to
 */
-(id) initWithURL:(NSString*)URL resourceEndpoint:(PPWebSocketResourceEndpoint)resourceEndpoint sessionId:(NSString*)sessionId delegate:(NSObject<PPWebSocketDelegate> *)delegate;

/**
 * Once you connect a websocket, it will always try to auto-reconnect
 */
- (void)connect;

/**
 * Disconnecting will kill the websocket and prevent it from attempting to auto-respawn
 */
- (void)disconnect;

/**
 * Send back a pong, in response to a ping
 */
- (void)pong;

#pragma mark - PPBaseModel overrides

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode argument:(NSString *)argument;
+ (NSError *)resultCodeToNSError:(NSInteger)resultCode;
+ (NSDictionary *)processResponse:(NSData *)responseObject error:(NSError **)error;
+ (NSDictionary *)processResponseData:(NSData *)responseData error:(NSError **)error;

@end
