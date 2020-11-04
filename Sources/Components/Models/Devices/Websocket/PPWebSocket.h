//
//  PPWebSocket.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>

@protocol PPWebSocketDelegate <NSObject>
/** Notification that the websocket connected */
- (void)websocketDidConnect:(SRWebSocket * _Nonnull )session;

/** Notification that the websocket broke.  If you want to recreate it, you have to renew your sessionId and start over from the beginning */
- (void)websocketBroken;

/** Web socket received a message */
- (void)websocket:(SRWebSocket * _Nonnull )webSocket didReceiveMessage:(id _Nonnull )message;

@optional
/** Notification that the websocket broke with additional status messaging.  If implemented, will override "websocketBroken" */
- (void)websocketBroken:(NSInteger)code reason:(NSString *)reason;
@end

typedef NS_OPTIONS(NSInteger, PPWebSocketResourceEndpoint) {
    PPWebSocketResourceEndpointCamera = 0,
    PPWebSocketResourceEndpointViewer = 1,
    PPWebSocketResourceEndpointDefault = 2
};

/** Viewer status */
typedef NS_OPTIONS(NSInteger, PPWebSocketViewerStatus) {
	PPWebSocketViewerDisconnected = -1,
	PPWebSocketViewerNoChange = 0,
	PPWebSocketViewerConnected = 1,
};

/** Goals */
typedef NS_OPTIONS(NSInteger, PPWebSocketGoal) {
    PPWebSocketGoalAuth        = 1, // websocket session authentication request and response
    PPWebSocketGoalPresence    = 2, // availability of subscriptions within current scope that available for current user
    PPWebSocketGoalSubscribe   = 3, // subscription to specific data coming from other sources
    PPWebSocketGoalUnsubscribe = 4, // unsubscribe from a single subscription
    PPWebSocketGoalStatus      = 5, // status of current subscriptions
    PPWebSocketGoalData        = 6, // data event from the server
};

/** Types */
typedef NS_OPTIONS(NSInteger, PPWebSocketType) {
    PPWebSocketTypeNarratives               = 1, // Narratives
    PPWebSocketTypeOrganizationNarratives   = 2, // Organization Narratives
    PPWebSocketTypeLocationStates           = 3, // Location States
};

/** Operation
 * The client can subscribe on specific action on the data object. The operation field is a bimask of possible actions between 1 to 7
 */
typedef NS_OPTIONS(NSInteger, PPWebSocketOperation) {
    PPWebSocketOperationCreate      = 1 << 0, //
    PPWebSocketOperationUpdate      = 1 << 1, // availability of subscriptions within current scope that available for current user
    PPWebSocketOperationDelete     = 1 << 2, // subscription to specific data coming from other sources
};

typedef NS_OPTIONS(NSInteger, PPWebSocketErrorCode) {
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

@property (nonatomic, strong) SRWebSocket * _Nullable webSocket;
@property (nonatomic, strong) NSString * _Nullable sessionId;

/**
 * Initialize the websocket
 * @param URL NSString The URL to connect to
 * @param sessionId NSString The session ID generated from the GET /streaming/session?deviceId=<device id> API
 * @param resourceEndpoint PPDeviceProxyLocalWebsocketResourceEndpoint Endpoint to attach to URL (defaults to "/camera")
 * @param delegate the delegate to send event notifications to
 */
-(id) initWithURL:(NSString * _Nonnull )URL resourceEndpoint:(PPWebSocketResourceEndpoint)resourceEndpoint sessionId:(NSString * _Nullable )sessionId delegate:(NSObject<PPWebSocketDelegate> * _Nullable )delegate;

/**
 * Once you connect a websocket, it will always try to auto-reconnect
 */
- (void)connect;

/**
 * Disconnecting will kill the websocket and prevent it from attempting to auto-respawn
 */
- (void)disconnect;

/**
 * Send a ping to the server
 */
- (void)ping;

/**
 * Send back a pong, in response to a ping
 */
- (void)pong;

/**
 * Auth
 * Every time we connect to the server, we have to declare our connection session ID back to the server.
 */
- (void)declareConnected;
- (void)declareConnected:(NSString * _Nullable __autoreleasing *)uuid;

/**
 * Presence
 * The server will return supported subscription types based on the session scope.
 */
- (void)requestPresence;
- (void)requestPresence:(NSString * _Nullable __autoreleasing *)uuid;

/**
 * Status
 * The server will return current session subscription.
 */
- (void)retrieveStatus;
- (void)retrieveStatus:(NSString * _Nullable __autoreleasing *)uuid;

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
- (void)subscribe:(NSDictionary * _Nonnull )subscriptionData;
- (void)subscribe:(NSDictionary * _Nonnull )subscriptionData uuid:(NSString * _Nullable __autoreleasing *)uuid;

/**
 * Unsubscribe
 */
- (void)unsubscribe:(NSInteger)type;
- (void)unsubscribe:(NSInteger)type uuid:(NSString * _Nullable * _Nullable )uuid;

#pragma mark - PPBaseModel overrides

+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode argument:(NSString * _Nullable )argument;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode;
+ (NSDictionary * _Nullable )processResponse:(NSData * _Nonnull )responseObject error:(NSError * _Nullable * _Nullable )error;
+ (NSDictionary * _Nullable )processResponseData:(NSData * _Nonnull )responseData error:(NSError * _Nullable * _Nullable )error;

@end
