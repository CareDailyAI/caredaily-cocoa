//
//  PPWebSocket.h
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
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
