//
//  PPCircleDeviceCamera.h
//  PPiOSCore
//
//  Created by Destry Teeter on 8/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCircleDevice.h"

@interface PPCircleDeviceCamera : PPCircleDevice

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
@property (nonatomic) NSMutableArray *robotVantagePoints;
@property (nonatomic) NSMutableArray *robotVantageTimers;
@property (nonatomic) NSMutableArray *robotVantageNames;
@property (nonatomic) NSMutableArray *robotVantageSequence;
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
@property (nonatomic) unsigned long long availableBytes;
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

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId;

+ (PPCircleDeviceCamera *)initWithDictionary:(NSDictionary *)deviceDict;

/**
 * Supports Video.
 * Check if this device has any available cameras
 *
 * @return BOOL True if this device has a supported camera
 **/
+ (BOOL)supportsVideo;

- (void)syncSelectedCamera;

#pragma mark - Setter

- (void)setRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index;
- (void)setRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index;
- (void)setRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index;

@end
