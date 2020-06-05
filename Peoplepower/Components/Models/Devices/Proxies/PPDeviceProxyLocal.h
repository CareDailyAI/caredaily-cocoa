//
//  PPDeviceProxyLocal.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"
#import "PPWebSocket.h"
#import "PPWebSocketConfiguration.h"

extern float DEVICE_LOCAL_INITIALIZATION_DELAY;
extern float DEVICE_LOCAL_INITIALIZATION_DELAY_EXTENDED;

extern NSString *WS_PARAMS;
extern NSString *COMMAND_NAME;
extern NSString *COMMAND_INDEX;
extern NSString *COMMAND_SET_VALUE;
extern NSString *COMMAND_VALUE;
extern NSString *SESSION_ID;

extern float DEVICE_CAMERA_LOCAL_VERIFY_VIEWERS_AFTER_SEC;
extern float DEVICE_CAMERA_LOCAL_VERIFY_VIEWERS_AFTER_SEC_PERIODICALLY;

extern NSString *STREAM_ERROR;
extern NSString *STREAM_STATUS;
extern NSString *STREAM_ID;
extern NSString *RESULT_CODE;
extern NSString *RECORD_STREAM;

extern NSString *VIDEO_CALL_SESSION_DETAILS;
extern NSString *VIDEO_CALL_ACTIVE_SESSION_ID;
extern NSString *VIDEO_CALL_NOW_STREAMING_SESSION_ID;
extern NSString *VIDEO_CALL_HANGUP_WITH_SESSION_ID;
extern NSString *VIDEO_CALL_IS_BUSY;

extern NSInteger DEVICE_CAMERA_LOCAL_RESTART_INTERVAL;

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalProgress) {
    PPDeviceProxyLocalProgressNone                  = -1,
    PPDeviceProxyLocalProgressDefault               = 0,
    PPDeviceProxyLocalProgressInitializingProxy     = 10,
    PPDeviceProxyLocalProgressProxyInitialized      = 20,
    PPDeviceProxyLocalProgressInitializingWebsocket = 30,
    PPDeviceProxyLocalProgressGatheringServer       = 40,
    PPDeviceProxyLocalProgressServerDefined         = 50,
    PPDeviceProxyLocalProgressWebSocketConnecting   = 60,
    PPDeviceProxyLocalProgressWebSocketConnected    = 70,
    PPDeviceProxyLocalProgressWebsocketInitialized  = 80,
    
    PPDeviceProxyLocalProgressPlayerOff             = 1,
    PPDeviceProxyLocalProgressPlayerConfiguration   = 31,
    PPDeviceProxyLocalProgressPlayerConnecting      = 61,
    PPDeviceProxyLocalProgressPlayerConnected       = 91,
    
    PPDeviceProxyLocalProgressFinished              = 100
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyPlayerStatus) {
    PPDeviceProxyPlayerStatusConnectionErrorNotReachable = 0,
    PPDeviceProxyPlayerStatusConnectionErrorWWAN = 1,
    PPDeviceProxyPlayerStatusConnectionErrorWiFi = 2,
    PPDeviceProxyPlayerStatusVideoDisabled = 3,
    PPDeviceProxyPlayerStatusDisconnected = 4,
    PPDeviceProxyPlayerStatusInterrupted = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalRegistrationAttempts) {
    PPDeviceProxyLocalRegistrationAttemptsNone = -1,
    PPDeviceProxyLocalRegistrationAttemptsMax = 10
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalInitializationAttempts) {
    PPDeviceProxyLocalInitializationAttemptsNone = -1,
    PPDeviceProxyLocalInitializationAttemptsMax = 9
};


@protocol PPDeviceProxyLocalDelegate <NSObject>

/** Notify delegate of current progress. */
- (void)localDeviceProgress:(PPDeviceProxyLocalProgress)progress message:(NSString *)message;

- (void)localDeviceDidBeginInitialization;
- (void)localDeviceDidFailInitializationWithError:(NSError *)error;
- (void)localDeviceReady;

@end

@protocol PPDeviceProxyLocalWebsocketDelegate <NSObject>

- (void)localDeviceInitialized;
- (void)localDeviceDidTurnOff:(NSString *)deviceId;
- (void)localDeviceDidExecuteCommand:(NSArray *)parameters;
- (NSString *)localDeviceDidRequestAuthToken;
- (void)localDeviceDidUpdateDeviceProperty:(NSString *)name value:(NSString *)value index:(NSString *)index;
- (void)localDeviceDidUpdateDeviceName:(NSString *)name;

@end

@interface PPDeviceProxyLocal : NSObject <PPWebSocketDelegate>

@property (nonatomic, weak, readwrite) NSObject<PPDeviceProxyLocalDelegate> *delegate;
@property (nonatomic, weak, readwrite) NSObject<PPDeviceProxyLocalWebsocketDelegate> *proxyDelegate;

@property (nonatomic, strong, readonly) PPDevice *device;

@property (nonatomic) PPDeviceProxyLocalRegistrationAttempts registrationAttempts;
@property (nonatomic) PPDeviceProxyLocalInitializationAttempts initializationAttempts;

@property (nonatomic, strong) PPWebSocket *webSocket;
@property (nonatomic, strong) PPWebSocketConfiguration *webSocketConfiguration;
@property (nonatomic) PPWebSocketResourceEndpoint websocketResourceEndpoint;

- (id)init;

+ (BOOL)isLocalDeviceWithId:(NSString *)deviceId locationId:(PPLocationId)locationId;
+ (NSString *)localDeviceId:(PPLocationId)locationId;
+ (NSString *)localUDID;

- (void)turnOn:(NSObject<PPDeviceProxyLocalDelegate> *)delegate proxyDelegate:(NSObject<PPDeviceProxyLocalWebsocketDelegate> *)proxyDelegate;
- (void)turnOff;
- (void)connectWebSocket;
- (void)initializeWebSocket:(PPErrorBlock)callback;
- (NSString *)webSocketURL;

- (void)executeCommands:(NSArray *)parameters;

@end
