//
//  PPDevicePictureFrameLocal.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrame.h"

@interface PPDevicePictureFrameLocal : PPDevicePictureFrame

+ (PPDevicePictureFrameLocal *)initWithDictionary:(NSDictionary *)deviceDict;

/// Override realm.io setters with custom methods

- (void)updateSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera;

- (void)updateSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash;

- (void)updateAudioStatus:(PPDeviceParametersAudioStatus)audioStatus;

- (void)updateAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity;

- (void)updateAudioActivity:(PPDeviceParametersAudioActivity)audioActivity;

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
