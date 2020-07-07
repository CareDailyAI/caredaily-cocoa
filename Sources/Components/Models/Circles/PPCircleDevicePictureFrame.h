//
//  PPCircleDevicePictureFrame.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCircleDevice.h"

@interface PPCircleDevicePictureFrame : PPCircleDevice

// Camera
@property (nonatomic) PPDeviceParametersSelectedCamera selectedCamera;

// Flash
@property (nonatomic) PPDeviceParametersSelectedFlash selectedFlash;

// Recording
@property (nonatomic) PPDeviceParametersAudioStatus audioStatus;
@property (nonatomic) PPDeviceParametersRecordStatus recordStatus;
@property (nonatomic) PPDeviceParametersAudioSensitiviy audioSensitivity;

// Streaming
@property (nonatomic) PPDeviceParametersAudioStreaming audioStreaming;
@property (nonatomic) PPDeviceParametersVideoStreaming videoStreaming;
@property (nonatomic) PPDeviceParametersSupportsVideoCall supportsVideoCall;

// Various
@property (nonatomic) PPDeviceParametersBatteryLevel batteryLevel;
@property (nonatomic) PPDeviceParametersCharging charging;
@property (nonatomic) PPVersion *version;
@property (nonatomic) long long availableBytes;
@property (nonatomic) PPDeviceParametersBlackoutScreenOn blackoutScreenOn;
@property (nonatomic) PPDeviceParametersOutputVolume outputVolume;

// Care
@property (nonatomic) NSString *alertTitle;
@property (nonatomic) NSString *alertSubtitle;
@property (nonatomic) PPQuestionId alertQuestionId;
@property (nonatomic) NSString *alertMessage;
@property (nonatomic) NSString *alertIcon;
@property (nonatomic) NSDate *alertTimestamp;
@property (nonatomic) PPDeviceParametersAlertDuration alertDuration;
@property (nonatomic) PPDeviceParametersAlertPriority alertPriority;
@property (nonatomic) NSString *playSound;
@property (nonatomic) PPDeviceParametersAlertStatus alertStatus;
@property (nonatomic) NSString *notification;

// Volatile Parameters
@property (nonatomic) NSString *streamId;
@property (nonatomic) NSInteger recordStream;

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId;

+ (PPCircleDevicePictureFrame *)initWithDictionary:(NSDictionary *)deviceDict;

/**
 * Supports Video.
 * Check if this device has any available cameras
 *
 * @return BOOL True if this device has a supported camera
 **/
+ (BOOL)supportsVideo;

- (void)syncSelectedCamera;

/// Override Realm.io setters with custom methods

- (void)updateSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera;

- (void)updateSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash;

- (void)updateAudioStatus:(PPDeviceParametersAudioStatus)audioStatus;

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus;

- (void)updateAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming;

- (void)updateVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming;

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall;

- (void)updateBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel;

- (void)updateCharging:(PPDeviceParametersCharging)charging;

- (void)updateVersion:(PPVersion *)version;

- (void)updateAvailableBytes:(unsigned long long)availableBytes;

- (void)updateBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn;

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume;

- (void)updateAlertTitle:(NSString *)alertTitle;

- (void)updateAlertSubtitle:(NSString *)alertSubtitle;

- (void)updateAlertQuestionId:(PPQuestionId)alertQuestionId;

- (void)updateAlertMessage:(NSString *)alertMessage;

- (void)updateAlertIcon:(NSString *)alertIcon;

- (void)updateAlertTimestamp:(NSDate *)alertTimestamp;

- (void)updateAlertDuration:(PPDeviceParametersAlertDuration)alertDuration;

- (void)updateAlertPriority:(PPDeviceParametersAlertPriority)alertPriority;

- (void)updatePlaySound:(NSString *)playSound;

- (void)updateAlertStatus:(PPDeviceParametersAlertStatus)alertStatus;

- (void)updateNotification:(NSString *)notification;

@end

