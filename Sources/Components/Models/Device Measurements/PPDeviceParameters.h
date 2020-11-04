//
//  PPDeviceParameters.h
//  Peoplepower
//
//  Created by Destry Teeter on 2/27/18.
//  Copyright © 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"

#ifndef DEVICE_PARAMETER_KEY_VALUE
#define DEVICE_PARAMETER_KEY_VALUE @"value"
#endif

#ifndef DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID
#define DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID @"deviceTypeId"
#endif

#ifndef DEVICE_PARAMETER_KEY_INDEX
#define DEVICE_PARAMETER_KEY_INDEX @"index"
#endif

// Climate Control
extern NSString *FAN_MODE;
extern NSString *FAN_MODE_SEQUENCE;
extern NSString *FAN_MODE_VALUES;
extern NSString *SYSTEM_MODE;
extern NSString *SYSTEM_MODE_VALUES;
extern NSString *SYSTEM_MODE_STATUS;
extern NSString *COOLING_SETPOINT;
extern NSString *MIN_COOLING_SETPOINT;
extern NSString *MAX_COOLING_SETPOINT;
extern NSString *HEATING_SETPOINT;
extern NSString *MIN_HEATING_SETPOINT;
extern NSString *MAX_HEATING_SETPOINT;
extern NSString *HEAT_COOL_MIN_DELTA;
extern NSString *TEMP_VALUES;
extern NSString *POWER_STATUS;
extern NSString *SWING_MODE;
extern NSString *SWING_MODE_VALUES;

// Temperature
extern NSString *DEG_C;
extern NSString *INTERNAL_DEG_C;

// Humidity
extern NSString *RELATIVE_HUMIDITY;

// Light
extern NSString *STATE;
extern NSString *CURRENT_LEVEL;
extern NSString *ILLUMINANCE;

// Plug
extern NSString *OUTLET_STATUS;
extern NSString *POWER;
extern NSString *ENERGY;

// Entry Sensor
extern NSString *DOOR_STATUS;

// Touch Sensor
extern NSString *VIBRATION_STATUS;

// Motion Sensor
extern NSString *MOTION_STATUS;

// Water Sensor
extern NSString *WATER_LEAK;

// Lock
extern NSString *LOCK_STATUS;
extern NSString *LOCK_STATUS_ALARM;

// Button
extern NSString *BUTTON_STATUS;

// Alarm
extern NSString *ALARM_STATUS;
extern NSString *ALARM_WARN;
extern NSString *ALARM_DURATION;
extern NSString *ALARM_STROBE;
extern NSString *ALARM_SQUAWK;
extern NSString *MODE;
extern NSString *ALARM_LEVEL;

// iBeacon
extern NSString *IBEACON_STATUS;
extern NSString *IBEACON_PROXIMITY;

// LintAlert
extern NSString *SIG_STATUS;
extern NSString *SIG_CUR_MAX_LED;
extern NSString *SIG_TABLE;
extern NSString *SIG_PRESSURE;
extern NSString *SIG_WCI_PRESSURE;
extern NSString *SIG_CLEAN;


// Netatmo
extern NSString *NAM_HEALTH_IDX;

// Camera and others (previously existing)
extern NSString *CAMERA_NAME;
extern NSString *RECORD_STATUS;
extern NSString *ACCESS_CAMERA_SETTINGS;
extern NSString *AUDIO_STREAMING;
extern NSString *VIDEO_STREAMING;
extern NSString *HD_STATUS;
extern NSString *RAPID_MOTION_STATUS;
extern NSString *BATTERY_LEVEL;
extern NSString *CHARGING;
extern NSString *MOTION_DETECTION_STATUS;
extern NSString *AUTO_FOCUS;
extern NSString *AUDIO_STATUS;
extern NSString *SELECTED_CAMERA;
extern NSString *RECORD_SECONDS;
extern NSString *MOTION_SENSITIVITY;
extern NSString *AUDIO_SENSITIVITY;
extern NSString *TIMEZONE_ID;
extern NSString *MOTION_ACTIVITY;
extern NSString *AUDIO_ACTIVITY;
extern NSString *VERSION;
extern NSString *ROBOT_CONNECTED;
extern NSString *ROBOT_MOTION_DIRECTION;
extern NSString *ROBOT_VANTAGE_SPHERICAL_COORDINATES;
extern NSString *ROBOT_VANTAGE_TIME;
extern NSString *ROBOT_VANTAGE_NAME;
extern NSString *ROBOT_VANTAGE_SEQUENCE;
extern NSString *ROBOT_VANTAGE_MOVE_TO_INDEX;
extern NSString *ROBOT_VANTAGE_CONFIGURATION_STATUS;
extern NSString *ROBOT_ORIENTATION;
extern NSString *AVAILABLE_BYTES;
extern NSString *TWITTER_AUTO_SHARE;
extern NSString *TWITTER_DESCRIPTION;
extern NSString *TWITTER_REMINDER;
extern NSString *TWITTER_STATUS;
extern NSString *MOTION_COUNTDOWN_TIME;
extern NSString *BLACKOUT_SCREEN_ON;
extern NSString *WARNING_STATUS;
extern NSString *WARNING_TEXT;
extern NSString *KEYPAD_STATUS;
extern NSString *RECORD_FULL_DURATION;
extern NSString *FLASH_ON;
extern NSString *SUPPORTS_VIDEO_CALL;
extern NSString *OUTPUT_VOLUME;
extern NSString *CAPTURE_IMAGE;
extern NSString *ALARM;
extern NSString *PLAY_SOUND;
extern NSString *COUNTDOWN;
extern NSString *VISUAL_COUNTDOWN;
extern NSString *MOTION_ALARM;
extern NSString *FIRMWARE;
extern NSString *MODEL;
extern NSString *FIRMWARE_UPDATE_STATUS;
extern NSString *FIRMWARE_URL;
extern NSString *FIRMWARE_CHECK_SUM;
extern NSString *NETWORK_TYPE;

// Picture Frame
extern NSString *ALERT_TITLE;
extern NSString *ALERT_SUBTITLE;
extern NSString *ALERT_QUESTION_ID;
extern NSString *ALERT_MESSAGE;
extern NSString *ALERT_ICON;
extern NSString *ALERT_TIMESTAMP_MS;
extern NSString *ALERT_DURATION_MS;
extern NSString *ALERT_PRIORITY;
extern NSString *ALERT_STATUS;

// Messaging
extern NSString *NOTIFICATION;

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSystemMode) {
    PPDeviceParametersSystemModeOff = 0,
    PPDeviceParametersSystemModeAuto = 1,
    PPDeviceParametersSystemModeCool = 3,
    PPDeviceParametersSystemModeHeat = 4,
    PPDeviceParametersSystemModeEmergencyHeat = 5,
    PPDeviceParametersSystemModePrecooling = 6,
    PPDeviceParametersSystemModeFanOnly = 7,
    PPDeviceParametersSystemModeDry = 8,
    PPDeviceParametersSystemModeAuxiliaryHeat = 9,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSystemModeStatus) {
    PPDeviceParametersSystemModeStatusOff = 0,
    PPDeviceParametersSystemModeStatusCool = 1,
    PPDeviceParametersSystemModeStatusHeat = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFanMode) {
    PPDeviceParametersFanModeOff = 0,
    PPDeviceParametersFanModeLow = 1,
    PPDeviceParametersFanModeMedium = 2,
    PPDeviceParametersFanModeHigh = 3,
    PPDeviceParametersFanModeOn = 4,
    PPDeviceParametersFanModeAuto = 5,
    PPDeviceParametersFanModeSmart = 6,
    PPDeviceParametersFanModeCirculate = 7,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFanModeSequence) {
    PPDeviceParametersFanModeSequenceLowMedHigh = 0,
    PPDeviceParametersFanModeSequenceLowHigh = 1,
    PPDeviceParametersFanModeSequenceLowMedHighAuto = 2,
    PPDeviceParametersFanModeSequenceLowHighAuto = 3,
    PPDeviceParametersFanModeSequenceOnAuto = 4
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSwingMode) {
    PPDeviceParametersSwingModeStopped = 0,
    PPDeviceParametersSwingModeRangeFull = 1,
    PPDeviceParametersSwingModeRangeTop = 2,
    PPDeviceParametersSwingModeRangeMiddle = 3,
    PPDeviceParametersSwingModeRangeBottom = 4,
    PPDeviceParametersSwingModeFixedTop = 5,
    PPDeviceParametersSwingModeFixedMiddleTop = 6,
    PPDeviceParametersSwingModeFixedMiddle = 7,
    PPDeviceParametersSwingModeFixedMiddleBottom = 8,
    PPDeviceParametersSwingModeFixedBottom = 9
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersState) {
    PPDeviceParametersStateOff = 0,
    PPDeviceParametersStateOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersOutletStatus) {
    PPDeviceParametersOutletStatusOff = 0,
    PPDeviceParametersOutletStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersPowerStatus) {
    PPDeviceParametersPowerStatusOff = 0,
    PPDeviceParametersPowerStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersDoorStatus) {
    PPDeviceParametersDoorStatusClosed = 0,
    PPDeviceParametersDoorStatusOpen = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVibrationStatus) {
    PPDeviceParametersVibrationStatusStill = 0,
    PPDeviceParametersVibrationStatusMoved = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionStatus) {
    PPDeviceParametersMotionStatusNoMotion = 0,
    PPDeviceParametersMotionStatusMotion = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersWaterLeak) {
    PPDeviceParametersWaterLeakDry = 0,
    PPDeviceParametersWaterLeakWet = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersLockStatus) {
    PPDeviceParametersLockStatusUnlocked = 0,
    PPDeviceParametersLockStatusLocked = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersLockStatusAlarm) {
    PPDeviceParametersLockStatusAlarmOK = 0,
    PPDeviceParametersLockStatusAlarmDeadboltJammed = 1,
    PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults = 2,
    PPDeviceParametersLockStatusAlarmRFModulePowerCycled = 3,
    PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit = 4,
    PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved = 5,
    PPDeviceParametersLockStatusAlarmDoorForcedOpen = 6,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersButtonStatus) {
    PPDeviceParametersButtonStatusReleased = 0,
    PPDeviceParametersButtonStatusPressed = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmStatus) {
    PPDeviceParametersAlarmStatusInactive = 0,
    PPDeviceParametersAlarmStatusActive = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnSmartenit) {
    PPDeviceParametersAlarmWarnSmartenitSecurityDrill = -1,
    PPDeviceParametersAlarmWarnSmartenitStop = 0,
    PPDeviceParametersAlarmWarnSmartenitBurglar = 1,
    PPDeviceParametersAlarmWarnSmartenitFire = 2,
    PPDeviceParametersAlarmWarnSmartenitEmergency = 3,
    PPDeviceParametersAlarmWarnSmartenitChinese1 = 4,
    PPDeviceParametersAlarmWarnSmartenitChinese2 = 5,
    PPDeviceParametersAlarmWarnSmartenitChinese3 = 6,
    PPDeviceParametersAlarmWarnSmartenitChinese4 = 7,
    PPDeviceParametersAlarmWarnSmartenitChinese5 = 8,
    PPDeviceParametersAlarmWarnSmartenitChinese6 = 9,
    PPDeviceParametersAlarmWarnSmartenitChinese7 = 10,
    PPDeviceParametersAlarmWarnSmartenitChinese8 = 13,
    PPDeviceParametersAlarmWarnSmartenitClickOnce = 11,
    PPDeviceParametersAlarmWarnSmartenitClickMulitple = 12,
    PPDeviceParametersAlarmWarnSmartenitNoSound = 14,
    PPDeviceParametersAlarmWarnSmartenitDoorbell = 15
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnLinkHigh) {
    PPDeviceParametersAlarmWarnLinkHighSecurityDrill = -1,
    PPDeviceParametersAlarmWarnLinkHighAlarm = 1,
    PPDeviceParametersAlarmWarnLinkHighDog = 2,
    PPDeviceParametersAlarmWarnLinkHighWarning = 3,
    PPDeviceParametersAlarmWarnLinkHighBling = 4,
    PPDeviceParametersAlarmWarnLinkHighBird = 5,
    PPDeviceParametersAlarmWarnLinkHighDroid = 6,
    PPDeviceParametersAlarmWarnLinkHighLock = 7,
    PPDeviceParametersAlarmWarnLinkHighPhaser = 8,
    PPDeviceParametersAlarmWarnLinkHighDoorbel = 9,
    PPDeviceParametersAlarmWarnLinkHighGunCock = 10,
    PPDeviceParametersAlarmWarnLinkHighGunShot = 11,
    PPDeviceParametersAlarmWarnLinkHighSwitch = 12,
    PPDeviceParametersAlarmWarnLinkHighTrumpet = 13,
    PPDeviceParametersAlarmWarnLinkHighWhistle = 14
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnDevelco) {
    PPDeviceParametersAlarmWarnDevelcoSilence = 0,
    PPDeviceParametersAlarmWarnDevelcoBurglar = 1,
    PPDeviceParametersAlarmWarnDevelcoFire = 2,
    PPDeviceParametersAlarmWarnDevelcoEmergency = 3,
    PPDeviceParametersAlarmWarnDevelcoPanicP = 4,
    PPDeviceParametersAlarmWarnDevelcoPanicF = 5,
    PPDeviceParametersAlarmWarnDevelcoPanicE = 6,
    PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome = 12,
    PPDeviceParametersAlarmWarnDevelcoBeepWelcome = 13,
    PPDeviceParametersAlarmWarnDevelcoBeepBeep = 14,
    PPDeviceParametersAlarmWarnDevelcoBeep = 15,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmDuration) {
    PPDeviceParametersAlarmDurationStop = 0,
    PPDeviceParametersAlarmDurationOnce = 1,
    PPDeviceParametersAlarmDurationPlayForXSeconds = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmStrobe) {
    PPDeviceParametersAlarmStrobeOff = 0,
    PPDeviceParametersAlarmStrobeOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmSquawk) {
    PPDeviceParametersAlarmSquawkArmed = 0,
    PPDeviceParametersAlarmSquawkDisarmed = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmLevel) {
    PPDeviceParametersAlarmLevelLow       = 0,
    PPDeviceParametersAlarmLevelMedium    = 1,
    PPDeviceParametersAlarmLevelHigh      = 2,
    PPDeviceParametersAlarmLevelVeryHight = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIBeaconStatus) {
    PPDeviceParametersIBeaconStatusOn = 0,
    PPDeviceParametersIBeaconStatusOff = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIBeaconProximity) {
    PPDeviceParametersIBeaconProximityUnknown = 0,
    PPDeviceParametersIBeaconProximityImmediate = 1,
    PPDeviceParametersIBeaconProximityNear = 2,
    PPDeviceParametersIBeaconProximityFar = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSigStatus) {
    PPDeviceParametersSigStatusOff = 0,
    PPDeviceParametersSigStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSigCurMaxLed) {
    PPDeviceParametersSigCurMaxLedNone = 0,
    PPDeviceParametersSigCurMaxLedOK = 3,
    PPDeviceParametersSigCurMaxLedWarning = 4,
    PPDeviceParametersSigCurMaxLedBlocked = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersNamHealthIdx) {
    PPDeviceParametersNamHealthIdxHealthy = 0,
    PPDeviceParametersNamHealthIdxFine = 1,
    PPDeviceParametersNamHealthIdxFair = 2,
    PPDeviceParametersNamHealthIdxPoor = 3,
    PPDeviceParametersNamHealthIdxUnhealthy = 4
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSelectedCamera) {
    PPDeviceParametersSelectedCameraFront = 0,
    PPDeviceParametersSelectedCameraRear = 1,
    PPDeviceParametersSelectedCameraRearOnly = 2,
    PPDeviceParametersSelectedCameraNone = 3,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAccessCameraSettings) {
    PPDeviceParametersAccessCameraSettingsOff = 0,
    PPDeviceParametersAccessCameraSettingsOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioStreaming) {
    PPDeviceParametersAudioStreamingOff = 0,
    PPDeviceParametersAudioStreamingOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVideoStreaming) {
    PPDeviceParametersVideoStreamingOff = 0,
    PPDeviceParametersVideoStreamingOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersHDStatus) {
    PPDeviceParametersHDStatusOff = 0,
    PPDeviceParametersHDStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRapidMotionStatus) {
    PPDeviceParametersRapidMotionStatusMinProVideo = 60,
    PPDeviceParametersRapidMotionStatusMin = 300,
    PPDeviceParametersRapidMotionStatusDefault = 1800,
    PPDeviceParametersRapidMotionStatusMax = 3600
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersBatteryLevel) {
    PPDeviceParametersBatteryLevelDead = 0,
    PPDeviceParametersBatteryLevelFull = 100
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCharging) {
    PPDeviceParametersChargingFalse = 0,
    PPDeviceParametersChargingTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCameraMotionStatus) {
    PPDeviceParametersCameraMotionStatusDisabledByRule = -1,
    PPDeviceParametersCameraMotionStatusDisabled = 0,
    PPDeviceParametersCameraMotionStatusEnabled = 1,
    PPDeviceParametersCameraMotionStatusEnabledByRule = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioStatus) {
    PPDeviceParametersAudioStatusNoAudio = 0,
    PPDeviceParametersAudioStatusAudio = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAutoFocus) {
    PPDeviceParametersAutoFocusShouldFocus = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordSeconds) {
    PPDeviceParametersRecordSecondsMinimum = 5,
    PPDeviceParametersRecordSecondsDefault = 30,
    PPDeviceParametersRecordSecondsMaximum = 60,
    PPDeviceParametersRecordSecondsMaximumProVideo = 300
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionSensitiviy) {
    PPDeviceParametersMotionSensitiviyTiny = 0,
    PPDeviceParametersMotionSensitiviySmall = 10,
    PPDeviceParametersMotionSensitiviyNormal = 20,
    PPDeviceParametersMotionSensitiviyLarge = 30,
    PPDeviceParametersMotionSensitiviyHuge = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioSensitiviy) {
    PPDeviceParametersAudioSensitiviyTiny = 0,
    PPDeviceParametersAudioSensitiviySmall = 10,
    PPDeviceParametersAudioSensitiviyNormal = 20,
    PPDeviceParametersAudioSensitiviyLarge = 30,
    PPDeviceParametersAudioSensitiviyHuge = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotConnected) {
    PPDeviceParametersRobotConnectedNone = 0,
    PPDeviceParametersRobotConnectedGalileo = 1,
    PPDeviceParametersRobotConnectedKubi = 2,
    PPDeviceParametersRobotConnectedRomo = 3,
    PPDeviceParametersRobotConnectedGalileoBT = 4,
    PPDeviceParametersRobotConnected360 = 5,
    PPDeviceParametersRobotConnectedUnknown = 6
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotMotionDirection) {
    PPDeviceParametersRobotMotionDirectionAll = 0,
    PPDeviceParametersRobotMotionDirectionRight = 10,
    PPDeviceParametersRobotMotionDirectionLeft = 20,
    PPDeviceParametersRobotMotionDirectionUp = 30,
    PPDeviceParametersRobotMotionDirectionDown = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotVantageConfigurationStatus) {
    PPDeviceParametersRobotVantageConfigurationStatusHardReset = -5,
    PPDeviceParametersRobotVantageConfigurationStatusWarmReset = -4,
    PPDeviceParametersRobotVantageConfigurationStatusResetUART = -3,
    PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue = -2,
    PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard = -1,
    PPDeviceParametersRobotVantageConfigurationStatusReady = 0,
    PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotOrientation) {
    PPDeviceParametersRobotOrientationShouldFlip = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterAutoShare) {
    PPDeviceParametersTwitterAutoShareOff = 0,
    PPDeviceParametersTwitterAutoShareOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterReminder) {
    PPDeviceParametersTwitterReminderOff = 0,
    PPDeviceParametersTwitterReminderOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterStatus) {
    PPDeviceParametersTwitterStatusOff = 0,
    PPDeviceParametersTwitterStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionCountDownTime) {
    PPDeviceParametersMotionCountDownTimeMinimum = 5,
    PPDeviceParametersMotionCountDownTimeDefault = 30,
    PPDeviceParametersMotionCountDownTimeMaximum = 60
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersBlackoutScreenOn) {
    PPDeviceParametersBlackoutScreenOnOff = 0,
    PPDeviceParametersBlackoutScreenOnOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionActivity) {
    PPDeviceParametersMotionActivityNone = 0,
    PPDeviceParametersMotionActivityDetected = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioActivity) {
    PPDeviceParametersAudioActivityNone = 0,
    PPDeviceParametersAudioActivityDetected = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersOutputVolume) {
    PPDeviceParametersOutputVolumeMuted = 0,
    PPDeviceParametersOutputVolumeMax = 16
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordStatus) {
    PPDeviceParametersRecordStatusNotRecording = 0,
    PPDeviceParametersRecordStatusRecording = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersWarningStatus) {
    PPDeviceParametersWarningStatusOff = 0,
    PPDeviceParametersWarningStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordFullDuration) {
    PPDeviceParametersRecordFullDurationOff = 0,
    PPDeviceParametersRecordFullDurationOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSupportsVideoCall) {
    PPDeviceParametersSupportsVideoCallFalse = 0,
    PPDeviceParametersSupportsVideoCallTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFlashOn) {
    PPDeviceParametersFlashOnNoFlash = -1,
    PPDeviceParametersFlashOnOff = 0,
    PPDeviceParametersFlashOnOn = 1,
    PPDeviceParametersFlashOnWasOn = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSelectedFlash) {
    PPDeviceParametersSelectedFlashNone = -1,
    PPDeviceParametersSelectedFlashOff = 0,
    PPDeviceParametersSelectedFlashOn = 1,
    PPDeviceParametersSelectedFlashWasOn = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCaptureImage) {
    PPDeviceParametersCaptureImageDisabled = -1,
    PPDeviceParametersCaptureImageEnabled = 0,
    PPDeviceParametersCaptureImageAlert = 1,
    PPDeviceParametersCaptureImageNoAlert = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarm) {
    PPDeviceParametersAlarmOff = 0,
    PPDeviceParametersAlarmOn = 0x1,
    PPDeviceParametersAlarmBeep1 = 0x2,
    PPDeviceParametersAlarmBeep2 = 0x3,
    PPDeviceParametersAlarmBeep3 = 0x4,
    
    // 0x5 through 0x0FFF represent "Beep for this many seconds" starting at a rate of 1 beep every 2 seconds, and steadily increasing to a rate of 1 beep every 100 ms
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCountdown) {
    PPDeviceParametersCountdownOff = -1,
    PPDeviceParametersCountdownOffAndClose = 0,
    PPDeviceParametersCountdownOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVisualCountdown) {
    PPDeviceParametersVisualCountdownOff = 0,
    PPDeviceParametersVisualCountdownOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertDuration) {
    PPDeviceParametersAlertDurationNone = -1,
    PPDeviceParametersAlertDurationDefault = 30
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertPriority) {
    PPDeviceParametersAlertPriorityNone = -1,
    PPDeviceParametersAlertPriorityDebug = 0,
    PPDeviceParametersAlertPriorityInfo = 1,
    PPDeviceParametersAlertPriorityWarning = 2,
    PPDeviceParametersAlertPriorityCritical = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertStatus) {
    PPDeviceParametersAlertStatusNone = 0,
    PPDeviceParametersAlertStatusAlerting = 1,
    PPDeviceParametersAlertStatusDismissed = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersNetType) {
    PPDeviceParametersNetTypeEthernet = 1,
    PPDeviceParametersNetTypeWiFi     = 2,
    PPDeviceParametersNetTypeCellular = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIlluminance) {
    PPDeviceParametersIlluminanceDark       = 0,
    PPDeviceParametersIlluminanceDim        = 20,
    PPDeviceParametersIlluminanceLight      = 50,
    PPDeviceParametersIlluminanceBright     = 250,
    PPDeviceParametersIlluminanceVeryBright = 100000
};

@interface PPDeviceParameters : PPBaseModel

/*
 * Change parameter into user friend string
 *
 * Configured parameter options: deviceTypeId, value
 *
 * @param parameter NSString parameter name
 * @param options NSDictionary parameter options.
 *
 * @return NSString user friend string for parameter value.  If no value, then return default name for parameter.
 */
+ (NSString *)stringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options;

+ (NSDictionary *)fontIconStringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options __attribute__((deprecated));

+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId;
+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId index:(NSString *)index;

+ (NSArray *)fanModesForSequence:(PPDeviceParametersFanModeSequence)sequence;

+ (NSArray *)systemModeStatuses;

+ (NSArray *)powerStatuses;

/*
 * Check if a historical measurements are supported for a given parameter
 *
 * @param parameter NSString parameter name
 *
 * @return BOOL true if this parameter supports historical measurements
 */
+ (BOOL)parameterSupportsHistoricalMeasurements:(NSString *)parameter;

@end
