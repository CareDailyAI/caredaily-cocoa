//
//  PPDeviceProxyLocalCamera.h
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceCameraLocal.h"
#import "PPDeviceProxyLocal.h"
#import "PPWebSocketCamera.h"

@protocol PPDeviceProxyLocalCameraDelegate <PPDeviceProxyLocalDelegate>

/** Camera must start publishing the stream. */
- (void)cameraMustStartPublishing;

/** Camera must stop publishing */
- (void)cameraMustStopPublishing;

/** @return YES if the camera is streaming */
- (BOOL)cameraIsPublishing;

- (void)cameraStartedPublishing;

- (void)cameraStoppedPublishing;

/** This camera answered a video call */
- (void)cameraAnsweredVideoCall:(NSString *)deviceId;

/** This camera should connect to video call */
- (void)connectToVideoCall:(PPWebSocketConfiguration *)videoCallConfiguration;

/** This camera hung up a video call */
- (void)cameraHungUpVideoCall;

/** The video call is playing loud audio, temporarily mute the mic so we don't cause feedback */
- (void)cameraVideoCallPlayingLoudAudio;

///** The camera failed to acquire a valid api key */
//- (void)mobileCameraFailedToAcquireAPIKey;
//
///** The camera no longer exists in our location */
//- (void)mobileCameraNoLongerExists;

///** Gathered dedicated camera url */
//- (void)mobileCameraDidReturnDedicatedCameraUrl;

@end

@interface PPDeviceProxyLocalCamera : PPDeviceProxyLocal <PPWebSocketDelegate>

@property (nonatomic, weak, readwrite) NSObject<PPDeviceProxyLocalCameraDelegate> *delegate;

@property (nonatomic, strong, readonly) PPDeviceCameraLocal *device;

@property (nonatomic, strong) PPWebSocketCamera *webSocket;

- (id)init;

#pragma mark - Local Device device ID helpers

+ (BOOL)isLocalDeviceWithId:(NSString *)deviceId locationId:(PPLocationId)locationId;
+ (NSString *)localUDID;

#pragma mark - Initialization

- (void)turnOn:(NSObject<PPDeviceProxyLocalCameraDelegate> *)delegate proxyDelegate:(NSObject<PPDeviceProxyLocalWebsocketDelegate> *)proxyDelegate;
- (void)turnOff;

+ (BOOL)wasProxyOn;
    
- (void)connectWebSocket;
- (NSString *)webSocketURL;

#pragma mark - Streaming

- (void)startPublishing;

- (void)hangUpVideoCall:(NSString *)sessionId;

- (void)attemptToAnswerVideoCall:(PPWebSocketConfiguration *)configuration deviceId:(NSString *)deviceId;

- (void)stopPublishing;

- (void)verifyViewers;

- (void)recordStream:(NSInteger)recordStream;

- (void)sendMessageToStartPlayer;

- (void)sendErrorMessageToPlayer:(NSString *)message;


#pragma mark - Execute Command

- (void)executeCommands:(NSArray *)parameters;

@end

