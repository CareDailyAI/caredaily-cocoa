//
//  PPDeviceCamera.h
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"
#import "PPVersion.h"
#import "PPVideoToken.h"

// Camera parameter refresh interval
extern NSInteger CAMERA_REFRESH_INTERVAL;

// Motion recording duration
extern PPDeviceParametersRecordSeconds CAMERA_MOTION_RECORDING_DURATION_FREE_MAX;
extern PPDeviceParametersRecordSeconds CAMERA_MOTION_RECORDING_DURATION_PRO_MAX;
extern PPDeviceParametersRecordSeconds CAMERA_MOTION_RECORDING_DURATION_MIN;
extern PPDeviceParametersRecordSeconds CAMERA_MOTION_RECORDING_DURATION_DEFAULT;

// Motion recording thumbnail interval
extern NSInteger CAMERA_MOTION_RECORDING_THUMBNAIL_INTERVAL;

// Motion detection reset interval
extern NSInteger CAMERA_MOTION_DETECTION_RESET_INTERVAL;

// Motion detection countdown duration
extern PPDeviceParametersMotionCountDownTime CAMERA_MOTION_DETECTION_COUNTDOWN_DEFAULT;

// Streaming connection attemp limit
extern NSInteger CAMERA_STREAMING_CONNECTION_ATTEMPT_LIMIT;

// Motion detection sensitivity
extern PPDeviceParametersMotionSensitiviy CAMERA_MOTION_DETECTION_SENSITIVITY_DEFAULT;

// Motion recording interval
extern PPDeviceParametersRapidMotionStatus CAMERA_MOTION_RECORDING_INTERVAL_FREE_MIN;
extern PPDeviceParametersRapidMotionStatus CAMERA_MOTION_RECORDING_INTERVAL_PRO_MIN;
extern PPDeviceParametersRapidMotionStatus CAMERA_MOTION_RECORDING_INTERVAL_MAX;
extern PPDeviceParametersRapidMotionStatus CAMERA_MOTION_RECORDING_INTERVAL_DEFAULT;

// Camera output volume
extern PPDeviceParametersOutputVolume CAMERA_VOLUME_OUTPUT_MAXIMUM;
extern PPDeviceParametersOutputVolume CAMERA_VOLUME_OUTPUT_DEFAULT;


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

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId;

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

- (void)setRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index;
- (void)setRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index;
- (void)setRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index;

@end
