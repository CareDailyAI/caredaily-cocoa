//
//  PPDeviceCameraLocal.h
//  PPiOSCore
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceCamera.h"

@interface PPDeviceCameraLocal : PPDeviceCamera

+ (PPDeviceCameraLocal *)initWithDictionary:(NSDictionary *)deviceDict;

/// Override realm.io setters with custom methods

- (void)updateSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera;

- (void)updateSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash;

- (void)updateMotionStatus:(PPDeviceParametersCameraMotionStatus)motionStatus;

- (void)updateRecordSeconds:(PPDeviceParametersRecordSeconds)recordSeconds;

- (void)updateMotionSensitivity:(PPDeviceParametersMotionSensitiviy)motionSensitivity;

- (void)updateMotionActivity:(PPDeviceParametersMotionActivity)motionActivity;

- (void)updateRapidMotionStatus:(PPDeviceParametersRapidMotionStatus)rapidMotionStatus;

- (void)updateMotionCountDownTime:(PPDeviceParametersMotionCountDownTime)motionCountDownTime;

- (void)updateRecordFullDuration:(PPDeviceParametersRecordFullDuration)recordFullDuration;

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus;

- (void)updateMotionAlarm:(PPDeviceParametersAlarm)motionAlarm;

- (void)updateAudioStatus:(PPDeviceParametersAudioStatus)audioStatus;

- (void)updateAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity;

- (void)updateAudioActivity:(PPDeviceParametersAudioActivity)audioActivity;

- (void)updateAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming;

- (void)updateVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming;

- (void)updateAccessCameraSettings:(PPDeviceParametersAccessCameraSettings)accessCameraSettings;

- (void)updateWarningStatus:(PPDeviceParametersWarningStatus)warningStatus;

- (void)updateWarningText:(NSString *)warningText;

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall;

- (void)updateRobotConnected:(PPDeviceParametersRobotConnected)robotConnected;

- (void)updateRobotMotionDirection:(PPDeviceParametersRobotMotionDirection)robotMotionDirection;

- (void)updateRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index;

- (void)updateRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index;

- (void)updateRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index;

- (void)updateRobotVantageSequence:(NSMutableOrderedSet *)robotVantageSequence;

- (void)updateRobotVantageConfigurationStatus:(PPDeviceParametersRobotVantageConfigurationStatus)robotVantageConfigurationStatus;

- (void)updateRobotVantageMoveToIndex:(NSInteger)robotVantageMoveToIndex;

- (void)updateRobotOrientation:(PPDeviceParametersRobotOrientation)robotOrientation;

- (void)updateTwitterReminder:(PPDeviceParametersTwitterReminder)twitterReminder;

- (void)updateTwitterAutoShare:(PPDeviceParametersTwitterAutoShare)twitterAutoShare;

- (void)updateTwitterDescription:(NSString *)twitterDescription;

- (void)updateTwitterStatus:(PPDeviceParametersTwitterStatus)twitterStatus;

- (void)updateHDStatus:(PPDeviceParametersHDStatus)HDStatus;

- (void)updateBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel;

- (void)updateCharging:(PPDeviceParametersCharging)charging;

- (void)updateVersion:(PPVersion *)version;

- (void)updateAvailableBytes:(unsigned long long)availableBytes;

- (void)updateBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn;

- (void)updateAutoFocus:(PPDeviceParametersAutoFocus)autoFocus;

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume;

- (void)updateCaptureImage:(PPDeviceParametersCaptureImage)captureImage;

- (void)updateAlarm:(PPDeviceParametersAlarm)alarm;

- (void)updatePlaySound:(NSString *)playSound;

- (void)updateCountdown:(PPDeviceParametersCountdown)countdown;

- (void)updateVisualCountdown:(PPDeviceParametersVisualCountdown)visualCountdown;

- (void)updateKeypadStatus:(NSString *)keypadStatus;

- (void)updateMode:(NSString *)mode;

@end

RLM_ARRAY_TYPE(PPDeviceCameraLocal)
