//
//  PPDeviceProxyLocalPictureFrame.h
//  PPiOSCore
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrameLocal.h"
#import "PPDeviceProxyLocal.h"
#import "PPWebSocketCamera.h"

@protocol PPDeviceProxyLocalPictureFrameDelegate <PPDeviceProxyLocalDelegate>

/** PictureFrame must start publishing the stream. */
- (void)pictureFrameMustStartPublishing;

/** PictureFrame must stop publishing */
- (void)pictureFrameMustStopPublishing;

/** @return YES if the pictureFrame is streaming */
- (BOOL)pictureFrameIsPublishing;

- (void)pictureFrameStartedPublishing;

- (void)pictureFrameStoppedPublishing;

/** This pictureFrame answered a video call */
- (void)pictureFrameAnsweredVideoCall:(NSString *)deviceId;

/** This pictureFrame should connect to video call */
- (void)connectToVideoCall:(PPWebSocketConfiguration *)videoCallConfiguration;

/** This pictureFrame hung up a video call */
- (void)pictureFrameHungUpVideoCall;

/** The video call is playing loud audio, temporarily mute the mic so we don't cause feedback */
- (void)pictureFrameVideoCallPlayingLoudAudio;

///** The pictureFrame failed to acquire a valid api key */
//- (void)mobilePictureFrameFailedToAcquireAPIKey;
//
///** The pictureFrame no longer exists in our location */
//- (void)mobilePictureFrameNoLongerExists;

///** Gathered dedicated pictureFrame url */
//- (void)mobilePictureFrameDidReturnDedicatedPictureFrameUrl;

@end

@interface PPDeviceProxyLocalPictureFrame : PPDeviceProxyLocal <PPWebSocketDelegate>

@property (nonatomic, weak, readwrite) NSObject<PPDeviceProxyLocalPictureFrameDelegate> *delegate;

@property (nonatomic, strong, readonly) PPDevicePictureFrameLocal *device;

@property (nonatomic, strong) PPWebSocketCamera *webSocket;

- (id)init;

#pragma mark - Local Device device ID helpers

+ (BOOL)isLocalDeviceWithId:(NSString *)deviceId locationId:(PPLocationId)locationId;
+ (NSString *)localUDID;

#pragma mark - Initialization

- (void)turnOn:(NSObject<PPDeviceProxyLocalPictureFrameDelegate> *)delegate proxyDelegate:(NSObject<PPDeviceProxyLocalWebsocketDelegate> *)proxyDelegate;
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

