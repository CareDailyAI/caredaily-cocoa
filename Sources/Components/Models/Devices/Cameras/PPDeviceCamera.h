//
//  PPDeviceCamera.h
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDevice.h"
#import "PPVersion.h"
#import "PPVideoToken.h"

@interface PPDeviceCamera : PPDevice

// Camera
@property (nonatomic) PPDeviceParametersSelectedCamera selectedCamera;

// Flash
@property (nonatomic) PPDeviceParametersSelectedFlash selectedFlash;

// Motion Detection/Recording
@property (nonatomic) PPDeviceParametersCameraMotionStatus motionStatus;
@property (nonatomic) PPDeviceParametersRecordSeconds recordSeconds;
@property (nonatomic) PPDeviceParametersMotionSensitiviy motionSensitivity;
@property (nonatomic) PPDeviceParametersMotionActivity motionActivity;
@property (nonatomic) PPDeviceParametersRapidMotionStatus rapidMotionStatus;
@property (nonatomic) PPDeviceParametersMotionCountDownTime motionCountDownTime;
@property (nonatomic) PPDeviceParametersRecordFullDuration recordFullDuration;
@property (nonatomic) PPDeviceParametersRecordStatus recordStatus;
@property (nonatomic) PPDeviceParametersAlarm motionAlarm;

// Audio Detection/Recording
@property (nonatomic) PPDeviceParametersAudioStatus audioStatus;
@property (nonatomic) PPDeviceParametersAudioSensitiviy audioSensitivity;
@property (nonatomic) PPDeviceParametersAudioActivity audioActivity;

// Streaming
@property (nonatomic) PPDeviceParametersAudioStreaming audioStreaming;
@property (nonatomic) PPDeviceParametersVideoStreaming videoStreaming;
@property (nonatomic) PPDeviceParametersAccessCameraSettings accessCameraSettings;
@property (nonatomic) PPDeviceParametersWarningStatus warningStatus;
@property (nonatomic, strong) NSString *warningText;
@property (nonatomic) PPDeviceParametersSupportsVideoCall supportsVideoCall;

// Robot
@property (nonatomic) PPDeviceParametersRobotConnected robotConnected;
@property (nonatomic) PPDeviceParametersRobotMotionDirection robotMotionDirection;
@property (nonatomic) RLMArray<PPDeviceParameterRobotVantagePoint *><PPDeviceParameterRobotVantagePoint> *robotVantagePoints;
@property (nonatomic) RLMArray<RLMString> *robotVantageTimers;
@property (nonatomic) RLMArray<RLMString> *robotVantageNames;
@property (nonatomic) RLMArray<RLMString> *robotVantageSequence;
@property (nonatomic) PPDeviceParametersRobotVantageConfigurationStatus robotVantageConfigurationStatus;
@property (nonatomic) NSInteger robotVantageMoveToIndex;
@property (nonatomic) PPDeviceParametersRobotOrientation robotOrientation;

// Twitter
@property (nonatomic) PPDeviceParametersTwitterReminder twitterReminder;
@property (nonatomic) PPDeviceParametersTwitterAutoShare twitterAutoShare;
@property (nonatomic) NSString *twitterDescription;
@property (nonatomic) PPDeviceParametersTwitterStatus twitterStatus;

// Various
@property (nonatomic) PPDeviceParametersHDStatus HDStatus;
@property (nonatomic) PPDeviceParametersBatteryLevel batteryLevel;
@property (nonatomic) PPDeviceParametersCharging charging;
@property (nonatomic) PPVersion *version;
@property (nonatomic) long long availableBytes;
@property (nonatomic) PPDeviceParametersBlackoutScreenOn blackoutScreenOn;
@property (nonatomic) PPDeviceParametersAutoFocus autoFocus;
@property (nonatomic) PPDeviceParametersOutputVolume outputVolume;
@property (nonatomic) PPDeviceParametersCaptureImage captureImage;

// Security
@property (nonatomic) PPDeviceParametersAlarm alarm;
@property (nonatomic) NSString *playSound;
@property (nonatomic) PPDeviceParametersCountdown countdown;
@property (nonatomic) PPDeviceParametersVisualCountdown visualCountdown;
@property (nonatomic) NSString *keypadStatus;
@property (nonatomic) NSString *mode;

// Volatile Parameters
@property (nonatomic) NSString *streamId;
@property (nonatomic) NSInteger recordStream;

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId userId:(PPUserId)userId;
- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId __attribute__((deprecated));

+ (PPDeviceCamera *)initWithDictionary:(NSDictionary *)deviceDict;

+ (NSMutableArray *)defaultParameters;

+ (NSArray *)kvoObservers;

/**
 * Supports Video.
 * Check if this device has any available cameras
 *
 * @return BOOL True if this device has a supported camera
 **/
+ (BOOL)supportsVideo;

- (void)syncSelectedCamera;

#pragma mark - Setter

/// Override realm.io settings with custom methods

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

- (void)updateRobotVantageSequence:(NSMutableArray *)robotVantageSequence;

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
