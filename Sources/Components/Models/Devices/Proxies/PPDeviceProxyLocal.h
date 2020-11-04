//
//  PPDeviceProxyLocal.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"
#import "PPWebSocket.h"
#import "PPWebSocketConfiguration.h"

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

@interface PPDeviceProxyLocal : PPBaseModel <PPWebSocketDelegate>

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
