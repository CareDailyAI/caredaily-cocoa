//
//  PPDeviceParameters.m
//  Peoplepower
//
//  Created by Destry Teeter on 2/27/18.
//  Copyright © 2020 People Power. All rights reserved.
//

#import "PPDeviceParameters.h"
#import "PPDeviceTypes.h"

// Climate Control
NSString *FAN_MODE = @"fanMode";
NSString *FAN_MODE_SEQUENCE = @"fanModeSequence";
NSString *FAN_MODE_VALUES = @"fanModeValues";
NSString *SYSTEM_MODE = @"systemMode";
NSString *SYSTEM_MODE_VALUES = @"systemModeValues";
NSString *SYSTEM_MODE_STATUS = @"systemModeStatus";
NSString *COOLING_SETPOINT = @"coolingSetpoint";
NSString *MIN_COOLING_SETPOINT = @"minCoolingSetpoint";
NSString *MAX_COOLING_SETPOINT = @"maxCoolingSetpoint";
NSString *HEATING_SETPOINT = @"heatingSetpoint";
NSString *MIN_HEATING_SETPOINT = @"minHeatingSetpoint";
NSString *MAX_HEATING_SETPOINT = @"maxHeatingSetpoint";
NSString *HEAT_COOL_MIN_DELTA = @"heatCoolMinDelta";
NSString *TEMP_VALUES = @"tempValues";
NSString *POWER_STATUS = @"powerStatus";
NSString *SWING_MODE = @"swingMode";
NSString *SWING_MODE_VALUES = @"swingModeValues";

// Temperature
NSString *DEG_C = @"degC";
NSString *INTERNAL_DEG_C = @"internalDegC";

// Humidity
NSString *RELATIVE_HUMIDITY = @"relativeHumidity";

// Light
NSString *STATE = @"state";
NSString *CURRENT_LEVEL = @"currentLevel";
NSString *ILLUMINANCE = @"illuminance";

// Plug
NSString *OUTLET_STATUS = @"outletStatus";
NSString *POWER = @"power";
NSString *ENERGY = @"energy";

// Entry Sensor
NSString *DOOR_STATUS = @"doorStatus";

// Touch Sensor
NSString *VIBRATION_STATUS = @"vibrationStatus";

// Motion Sensor
NSString *MOTION_STATUS = @"motionStatus";

// Water Sensor
NSString *WATER_LEAK = @"waterLeak";

// Lock
NSString *LOCK_STATUS = @"lockStatus";
NSString *LOCK_STATUS_ALARM = @"lockStatusAlarm";

// Button
NSString *BUTTON_STATUS = @"buttonStatus";

// Alarm
NSString *ALARM_STATUS = @"alarmStatus";
NSString *ALARM_WARN = @"ppc.alarmWarn";
NSString *ALARM_DURATION = @"ppc.alarmDuration";
NSString *ALARM_STROBE = @"ppc.alarmStrobe";
NSString *ALARM_SQUAWK = @"ppc.alarmSquawk";
NSString *MODE = @"ppc.mode";
NSString *ALARM_LEVEL = @"ppc.alarmLevel";

// iBeacon
NSString *IBEACON_STATUS = @"ppc.iBeaconStatus";
NSString *IBEACON_PROXIMITY = @"ppc.iBeaconProximity";

// LintAlert
NSString *SIG_STATUS = @"sig.status";
NSString *SIG_CUR_MAX_LED = @"sig.curMaxLed";
NSString *SIG_TABLE = @"sig.table";
NSString *SIG_PRESSURE = @"sig.pressure";
NSString *SIG_WCI_PRESSURE = @"sig.wciPressure";
NSString *SIG_CLEAN = @"sig.clean";

// Netatmo
NSString *NAM_HEALTH_IDX = @"nam.healthIdx";

// Camera and others (previously existing)
NSString *CAMERA_NAME = @"ppc.cameraName";
NSString *RECORD_STATUS = @"recordStatus";
NSString *ACCESS_CAMERA_SETTINGS = @"accessCameraSettings";
NSString *AUDIO_STREAMING = @"audioStreaming";
NSString *VIDEO_STREAMING = @"videoStreaming";
NSString *HD_STATUS = @"ppc.hdStatus";
NSString *RAPID_MOTION_STATUS = @"ppc.rapidMotionStatus";
NSString *BATTERY_LEVEL = @"batteryLevel";
NSString *CHARGING = @"ppc.charging";
NSString *MOTION_DETECTION_STATUS = @"motionDetectionStatus"; // Use MOTION_STATUS for device<>parameter mapping.  This is only used for UI string<>parameter mapping.
NSString *AUTO_FOCUS = @"ppc.autoFocus";
NSString *AUDIO_STATUS = @"audioStatus";
NSString *SELECTED_CAMERA = @"selectedCamera";
NSString *RECORD_SECONDS = @"ppc.recordSeconds";
NSString *MOTION_SENSITIVITY = @"ppc.motionSensitivity";
NSString *AUDIO_SENSITIVITY = @"ppc.audioSensitivity";
NSString *TIMEZONE_ID = @"timeZoneId";
NSString *MOTION_ACTIVITY = @"ppc.motionActivity";
NSString *AUDIO_ACTIVITY = @"ppc.audioActivity";
NSString *VERSION = @"version";
NSString *ROBOT_CONNECTED = @"ppc.robotConnected";
NSString *ROBOT_MOTION_DIRECTION = @"ppc.robotMotionDirection";
NSString *ROBOT_VANTAGE_SPHERICAL_COORDINATES = @"ppc.robotVantageSphericalCoordinates";
NSString *ROBOT_VANTAGE_TIME = @"ppc.robotVantageTimer";
NSString *ROBOT_VANTAGE_NAME = @"ppc.robotVantageName";
NSString *ROBOT_VANTAGE_SEQUENCE = @"ppc.robotVantageSequence";
NSString *ROBOT_VANTAGE_MOVE_TO_INDEX = @"ppc.robotVantageMoveToIndex";
NSString *ROBOT_VANTAGE_CONFIGURATION_STATUS = @"ppc.robotVantageConfigurationStatus";
NSString *ROBOT_ORIENTATION = @"ppc.robotOrientation";
NSString *AVAILABLE_BYTES = @"ppc.availableBytes";
NSString *TWITTER_AUTO_SHARE = @"twitterAutoShare";
NSString *TWITTER_DESCRIPTION = @"twitterDescription";
NSString *TWITTER_REMINDER = @"ppc.twitterReminder";
NSString *TWITTER_STATUS = @"ppc.twitterStatus";
NSString *MOTION_COUNTDOWN_TIME = @"ppc.motionCountDownTime";
NSString *BLACKOUT_SCREEN_ON = @"ppc.blackoutScreenOn";
NSString *WARNING_STATUS = @"ppc.warningStatus";
NSString *WARNING_TEXT = @"ppc.warningText";
NSString *KEYPAD_STATUS = @"ppc.keypadStatus";
NSString *RECORD_FULL_DURATION = @"ppc.recordFullDuration";
NSString *FLASH_ON = @"ppc.flashOn";
NSString *SUPPORTS_VIDEO_CALL = @"ppc.supportsVideoCall";
NSString *OUTPUT_VOLUME = @"ppc.outputVolume";
NSString *CAPTURE_IMAGE = @"ppc.captureImage";
NSString *ALARM = @"ppc.alarm";
NSString *PLAY_SOUND = @"ppc.playSound";
NSString *COUNTDOWN = @"ppc.countdown";
NSString *VISUAL_COUNTDOWN = @"ppc.visualCountdown";
NSString *MOTION_ALARM = @"ppc.motionAlarm";
NSString *FIRMWARE = @"firmware";
NSString *MODEL = @"model";
NSString *FIRMWARE_UPDATE_STATUS = @"firmwareUpdateStatus";
NSString *FIRMWARE_URL = @"firmwareUrl";
NSString *FIRMWARE_CHECK_SUM = @"firmwareCheckSum";
NSString *NETWORK_TYPE = @"netType";

// Picture Frame
NSString *ALERT_TITLE = @"ppc.alertTitle";
NSString *ALERT_SUBTITLE = @"ppc.alertSubtitle";
NSString *ALERT_QUESTION_ID = @"ppc.alertQuestionId";
NSString *ALERT_MESSAGE = @"ppc.alertMessage";
NSString *ALERT_ICON = @"ppc.alertIcon";
NSString *ALERT_TIMESTAMP_MS = @"ppc.alertTimestampMs";
NSString *ALERT_DURATION_MS = @"ppc.alertDurationMs";
NSString *ALERT_PRIORITY = @"ppc.alertPriority";
NSString *ALERT_STATUS = @"ppc.alertStatus";

// Messaging
NSString *NOTIFICATION = @"ppc.notification";

@implementation PPDeviceParameters

+ (NSString *)stringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options {
    NSString *returnString;
    NSString *value;
    NSInteger deviceTypeId = PPDeviceTypeIdNone;
    NSString *index;
    if(options) {
        if([options valueForKey:DEVICE_PARAMETER_KEY_VALUE]) {
            value = [options valueForKey:DEVICE_PARAMETER_KEY_VALUE];
        }
        if([options valueForKey:DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID]) {
            deviceTypeId = ((NSString *)[options valueForKey:DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID]).integerValue;
        }
        if([options valueForKey:DEVICE_PARAMETER_KEY_INDEX]) {
            index = [options valueForKey:DEVICE_PARAMETER_KEY_INDEX];
        }
    }
    
    // Normalize true/false values
    if([value isEqualToString:@"true"]
       || [value isEqualToString:@"ON"]) {
        value = @"1";
    }
    else if([value isEqualToString:@"false"]
            || [value isEqualToString:@"OFF"]) {
        value = @"0";
    }
    if([parameter isEqualToString:SYSTEM_MODE]) {
        if(!value) {
            returnString = NSLocalizedString(@"System Mode", @"Label - System Mode");
        }
        else {
            PPDeviceParametersSystemMode systemMode = (PPDeviceParametersSystemMode)value.integerValue;
            switch (systemMode) {
                case PPDeviceParametersSystemModeOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersSystemModeAuto:
                    returnString = NSLocalizedString(@"Auto", @"Label - Auto");
                    break;
                case PPDeviceParametersSystemModeCool:
                    returnString = NSLocalizedString(@"Cool", @"Label - Cool");
                    break;
                case PPDeviceParametersSystemModeHeat:
                    returnString = NSLocalizedString(@"Heat", @"Label - Heat");
                    break;
                case PPDeviceParametersSystemModeEmergencyHeat:
                    returnString = NSLocalizedString(@"Emergency Heat", @"Label - Emergency Heat");
                    break;
                case PPDeviceParametersSystemModePrecooling:
                    returnString = NSLocalizedString(@"Precooling", @"Label - Precooling");
                    break;
                case PPDeviceParametersSystemModeFanOnly:
                    returnString = NSLocalizedString(@"Fan Only", @"Label - Fan Only");
                    break;
                case PPDeviceParametersSystemModeDry:
                    returnString = NSLocalizedString(@"Dry", @"Label - Dry");
                    break;
                case PPDeviceParametersSystemModeAuxiliaryHeat:
                    returnString = NSLocalizedString(@"Auxiliary Heat", @"Label - Auxiliary Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_VALUES]) {
        if(!value) {
            return @"SYSTEM_MODE_VALUES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"System Mode Status", @"Label - System Mode Status");
        }
        else {
            PPDeviceParametersSystemModeStatus systemModeStatus = (PPDeviceParametersSystemModeStatus)value.integerValue;
            switch (systemModeStatus) {
                case PPDeviceParametersSystemModeStatusOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersSystemModeStatusCool:
                    returnString = NSLocalizedString(@"Cool", @"Label - Cool");
                    break;
                case PPDeviceParametersSystemModeStatusHeat:
                    returnString = NSLocalizedString(@"Heat", @"Label - Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE]) {
        if(!value) {
            returnString = NSLocalizedString(@"Fan Mode", @"Label - Fan Mode");
        }
        else {
            PPDeviceParametersFanMode fanMode = (PPDeviceParametersFanMode)value.integerValue;
            switch (fanMode) {
                case PPDeviceParametersFanModeOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersFanModeLow:
                    returnString = NSLocalizedString(@"Low", @"Label - Low");
                    break;
                case PPDeviceParametersFanModeMedium:
                    returnString = NSLocalizedString(@"Medium", @"Label - Medium");
                    break;
                case PPDeviceParametersFanModeHigh:
                    returnString = NSLocalizedString(@"High", @"Label - High");
                    break;
                case PPDeviceParametersFanModeOn:
                    returnString = NSLocalizedString(@"On", @"Label - On");
                    break;
                case PPDeviceParametersFanModeAuto:
                    returnString = NSLocalizedString(@"Auto", @"Label - Auto");
                    break;
                case PPDeviceParametersFanModeSmart:
                    returnString = NSLocalizedString(@"Smart", @"Label - Smart");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SWING_MODE]) {
        if(!value) {
            returnString = NSLocalizedString(@"Swing Mode", @"Label - Swing Mode");
        }
        else {
            PPDeviceParametersSwingMode swingMode = (PPDeviceParametersSwingMode)value.integerValue;
            switch (swingMode) {
                case PPDeviceParametersSwingModeStopped:
                    returnString = NSLocalizedString(@"Stopped", @"Label - Stopped");
                    break;
                case PPDeviceParametersSwingModeRangeFull:
                case PPDeviceParametersSwingModeRangeTop:
                case PPDeviceParametersSwingModeRangeMiddle:
                case PPDeviceParametersSwingModeRangeBottom:
                    returnString = NSLocalizedString(@"Range", @"Label - Range");
                    break;
                case PPDeviceParametersSwingModeFixedTop:
                case PPDeviceParametersSwingModeFixedMiddleTop:
                case PPDeviceParametersSwingModeFixedMiddle:
                case PPDeviceParametersSwingModeFixedMiddleBottom:
                case PPDeviceParametersSwingModeFixedBottom:
                    returnString = NSLocalizedString(@"Fixed", @"Label - Fixed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:STATE]) {
        if(!value) {
            returnString = NSLocalizedString(@"State", @"Label - State");
        }
        else {
            PPDeviceParametersState state = (PPDeviceParametersState)value.integerValue;
            switch (state) {
                case PPDeviceParametersStateOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersStateOn:
                    returnString = NSLocalizedString(@"On", @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:CURRENT_LEVEL]) {
        if(!value) {
            returnString = NSLocalizedString(@"Brightness", @"Label - Brightness");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:OUTLET_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Outlet Status", @"Label - Outlet Status");
        }
        else {
            PPDeviceParametersOutletStatus outletStatus = (PPDeviceParametersOutletStatus)value.integerValue;
            switch (outletStatus) {
                case PPDeviceParametersOutletStatusOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersOutletStatusOn:
                    returnString = NSLocalizedString(@"On", @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Power Status", @"Label - Power Status");
        }
        else {
            PPDeviceParametersPowerStatus powerStatus = (PPDeviceParametersPowerStatus)value.integerValue;
            switch (powerStatus) {
                case PPDeviceParametersPowerStatusOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                case PPDeviceParametersPowerStatusOn:
                    returnString = NSLocalizedString(@"On", @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER]) {
        if(!value) {
            returnString = NSLocalizedString(@"Power", @"Label - Power");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@ watts", value];
        }
    }
    else if([parameter isEqualToString:DEG_C]) {
        if(!value) {
            returnString = NSLocalizedString(@"Temperature", @"Label - Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:INTERNAL_DEG_C]) {
        if(!value) {
            returnString = NSLocalizedString(@"Internal Temperature", @"Label - Internal Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:COOLING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedString(@"Cooling Setpoint", @"Label - Cooling Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:HEATING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedString(@"Heating Setpoint", @"Label - Heating Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RELATIVE_HUMIDITY]) {
        if(!value) {
            returnString = NSLocalizedString(@"Relative Humidity", @"Label - Relative Humidity");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:DOOR_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Door Status", @"Label - Door Status");
        }
        else {
            PPDeviceParametersDoorStatus doorStatus = (PPDeviceParametersDoorStatus)value.integerValue;
            switch (doorStatus) {
                case PPDeviceParametersDoorStatusClosed:
                    returnString = NSLocalizedString(@"Closed", @"Detail Label - Closed");
                    break;
                case PPDeviceParametersDoorStatusOpen:
                    returnString = NSLocalizedString(@"Open", @"Detail Label - Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:VIBRATION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Vibration Status", @"Label - Vibration Status");
        }
        else {
            PPDeviceParametersVibrationStatus vibrationStatus = (PPDeviceParametersVibrationStatus)value.integerValue;
            switch (vibrationStatus) {
                case PPDeviceParametersVibrationStatusStill:
                    returnString = NSLocalizedString(@"Still", @"Detail Label - Still");
                    break;
                case PPDeviceParametersVibrationStatusMoved:
                    returnString = NSLocalizedString(@"Moved", @"Detail Label - Moved");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:MOTION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Motion Status", @"Label - Motion Status");
        }
        else {
            PPDeviceParametersMotionStatus motionStatus = (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedString(@"No Motion", @"Detail Label - No Motion");
                    break;
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedString(@"Motion", @"Detail Label - Motion");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WATER_LEAK]) {
        if(!value) {
            returnString = NSLocalizedString(@"Water Leak", @"Label - Water Leak");
        }
        else {
            PPDeviceParametersWaterLeak waterLeak = (PPDeviceParametersWaterLeak)value.integerValue;
            switch (waterLeak) {
                case PPDeviceParametersWaterLeakDry:
                    returnString = NSLocalizedString(@"Dry", @"Detail Label - Dry");
                    break;
                case PPDeviceParametersWaterLeakWet:
                    returnString = NSLocalizedString(@"Wet", @"Detail Label - Wet");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Lock Status", @"Label - Lock Status");
        }
        else {
            PPDeviceParametersLockStatus lockStatus = (PPDeviceParametersLockStatus)value.integerValue;
            switch (lockStatus) {
                case PPDeviceParametersLockStatusLocked:
                    returnString = NSLocalizedString(@"Locked", @"Detail Label - Locked");
                    break;
                case PPDeviceParametersLockStatusUnlocked:
                    returnString = NSLocalizedString(@"Unlocked", @"Detail Label - Unlocked");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS_ALARM]) {
        if(!value) {
            returnString = NSLocalizedString(@"Lock Status Alarm", @"Label - Lock Status Alarm");
        }
        else {
            PPDeviceParametersLockStatusAlarm lockStatusAlarm = (PPDeviceParametersLockStatusAlarm)value.integerValue;
            switch (lockStatusAlarm) {
                case PPDeviceParametersLockStatusAlarmOK:
                    returnString = NSLocalizedString(@"OK", @"Detail Label - OK");
                    break;
                case PPDeviceParametersLockStatusAlarmDeadboltJammed:
                    returnString = NSLocalizedString(@"Deadbolt Jammed", @"Detail Label - Deadbolt Jammed");
                    break;
                case PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults:
                    returnString = NSLocalizedString(@"Lock Reset to Factory Defaults", @"Detail Label - Lock Reset to Factory Defaults");
                    break;
                case PPDeviceParametersLockStatusAlarmRFModulePowerCycled:
                    returnString = NSLocalizedString(@"RF Module Power Cycled", @"Detail Label - RF Module Power Cycled");
                    break;
                case PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit:
                    returnString = NSLocalizedString(@"Wrong Code Entry Limit", @"Detail Label - Wrong Code Entry Limit");
                    break;
                case PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved:
                    returnString = NSLocalizedString(@"Front Escutcheon Removed", @"Detail Label - Front Escutcheon Removed");
                    break;
                case PPDeviceParametersLockStatusAlarmDoorForcedOpen:
                    returnString = NSLocalizedString(@"Door Forced Open", @"Detail Label - Door Forced Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BUTTON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Button Status", @"Label - Button Status");
        }
        else {
            PPDeviceParametersButtonStatus buttonStatus = (PPDeviceParametersButtonStatus)value.integerValue;
            switch (buttonStatus) {
                case PPDeviceParametersButtonStatusReleased:
                    returnString = NSLocalizedString(@"Released", @"Detail Label - Released");
                    break;
                case PPDeviceParametersButtonStatusPressed:
                    returnString = NSLocalizedString(@"Pressed", @"Detail Label - Pressed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ALARM_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"Alarm Status", @"Label - Alarm Status");
        }
        else {
            PPDeviceParametersAlarmStatus alarmStatus = (PPDeviceParametersAlarmStatus)value.integerValue;
            switch (alarmStatus) {
                case PPDeviceParametersAlarmStatusInactive:
                    returnString = NSLocalizedString(@"Inactive", @"Detail Label - Inactive");
                    break;
                case PPDeviceParametersAlarmStatusActive:
                    returnString = NSLocalizedString(@"Active", @"Detail Label - Active");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_WARN]) {
        if(!value) {
            returnString = NSLocalizedString(@"Alarm Warn", @"Label - Alarm Warn");
        }
        else {
            if(deviceTypeId == PPDeviceTypeIdNone) {
                returnString = NSLocalizedString(@"Alarm Warn", @"Label - Alarm Warn");
            }
            else if(deviceTypeId == PPDeviceTypeIdSmartenitSiren) {
                PPDeviceParametersAlarmWarnSmartenit alarmWarn = (PPDeviceParametersAlarmWarnSmartenit)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnSmartenitSecurityDrill:
                        returnString = NSLocalizedString(@"Security Drill", @"Detail Label - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitStop:
                        returnString = NSLocalizedString(@"Stop alarm", @"Detail Label - Stop alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitBurglar:
                        returnString = NSLocalizedString(@"Burglar alarm", @"Detail Label - Burglar alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitFire:
                        returnString = NSLocalizedString(@"Fire alarm", @"Detail Label - Fire alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitEmergency:
                        returnString = NSLocalizedString(@"Emergency alarm", @"Detail Label - Emergency alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese1:
                        returnString = NSLocalizedString(@"Chinese1", @"Detail Label - Chinese1");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese2:
                        returnString = NSLocalizedString(@"Chinese2", @"Detail Label - Chinese2");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese3:
                        returnString = NSLocalizedString(@"Chinese3", @"Detail Label - Chinese3");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese4:
                        returnString = NSLocalizedString(@"Chinese4", @"Detail Label - Chinese4");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese5:
                        returnString = NSLocalizedString(@"Chinese5", @"Detail Label - Chinese5");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese6:
                        returnString = NSLocalizedString(@"Chinese6", @"Detail Label - Chinese6");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese7:
                        returnString = NSLocalizedString(@"Chinese7", @"Detail Label - Chinese7");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese8:
                        returnString = NSLocalizedString(@"Chinese8", @"Detail Label - Chinese8");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickOnce:
                        returnString = NSLocalizedString(@"Click once", @"Detail Label - Click once");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickMulitple:
                        returnString = NSLocalizedString(@"Mulitple clicks", @"Detail Label - Multiple clicks");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitNoSound:
                        returnString = NSLocalizedString(@"No sound", @"Detail Label - No sound");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitDoorbell:
                        returnString = NSLocalizedString(@"Doorbell", @"Detail Label - Doorbell");
                        break;
                        
                    default:
                        returnString = @"undefined";
                        break;
                }
            }
            else if (deviceTypeId == PPDeviceTypeIdLinkHighSiren) {
                PPDeviceParametersAlarmWarnLinkHigh alarmWarn = (PPDeviceParametersAlarmWarnLinkHigh)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnLinkHighSecurityDrill:
                        returnString = NSLocalizedString(@"Security Drill", @"Detail Label - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighAlarm:
                        returnString = NSLocalizedString(@"Alarm", @"Detail Label - Alarm");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDog:
                        returnString = NSLocalizedString(@"Dog", @"Detail Label - Dog");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWarning:
                        returnString = NSLocalizedString(@"Warning", @"Detail Label - Warning");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBling:
                        returnString = NSLocalizedString(@"Bling", @"Detail Label - Bling");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBird:
                        returnString = NSLocalizedString(@"Bird", @"Detail Label - Bird");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDroid:
                        returnString = NSLocalizedString(@"Droid", @"Detail Label - Droid");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighLock:
                        returnString = NSLocalizedString(@"Lock", @"Detail Label - Lock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighPhaser:
                        returnString = NSLocalizedString(@"Phaser", @"Detail Label - Phaser");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDoorbel:
                        returnString = NSLocalizedString(@"Doorbel", @"Detail Label - Doorbel");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunCock:
                        returnString = NSLocalizedString(@"GunCock", @"Detail Label - GunCock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunShot:
                        returnString = NSLocalizedString(@"GunShot", @"Detail Label - GunShot");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighSwitch:
                        returnString = NSLocalizedString(@"Switch", @"Detail Label - Switch");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighTrumpet:
                        returnString = NSLocalizedString(@"Trumpet", @"Detail Label - Trumpet");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWhistle:
                        returnString = NSLocalizedString(@"Whistle", @"Detail Label - Whistle");
                        break;
                        
                    default:
                        returnString = @"undefined";
                        break;
                }
            }
            else if (deviceTypeId == PPDeviceTypeIdDevelcoSiren) {
                PPDeviceParametersAlarmWarnDevelco alarmWarn = (PPDeviceParametersAlarmWarnDevelco)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnDevelcoSilence:
                        returnString = NSLocalizedString(@"Silence", @"Detail Label - Silence");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBurglar:
                        returnString = NSLocalizedString(@"Burglar", @"Detail Label - Burglar");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoFire:
                        returnString = NSLocalizedString(@"Fire", @"Detail Label - Fire");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoEmergency:
                        returnString = NSLocalizedString(@"Emergency", @"Detail Label - Emergency");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicP:
                        returnString = NSLocalizedString(@"PanicP", @"Detail Label - PanicP");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicF:
                        returnString = NSLocalizedString(@"PanicF", @"Detail Label - PanicF");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicE:
                        returnString = NSLocalizedString(@"PanicE", @"Detail Label - PanicE");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome:
                        returnString = NSLocalizedString(@"BeepBeepWelcome", @"Detail Label - BeepBeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepWelcome:
                        returnString = NSLocalizedString(@"BeepWelcome", @"Detail Label - BeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeep:
                        returnString = NSLocalizedString(@"BeepBeep", @"Detail Label - BeepBeep");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeep:
                        returnString = NSLocalizedString(@"Beep", @"Detail Label - Beep");
                        break;
                        
                    default:
                        returnString = @"undefined";
                        break;
                }
            }
        }
    }
    else if([parameter isEqualToString:ALARM_DURATION]) {
        if(!value) {
            returnString = NSLocalizedString(@"Alarm Duration", @"Label - Alarm Duration");
        }
        else {
            PPDeviceParametersAlarmDuration alarmDuration = (PPDeviceParametersAlarmDuration)value.integerValue;
            switch (alarmDuration) {
                case PPDeviceParametersAlarmDurationStop:
                    returnString = NSLocalizedString(@"Stop", @"Detail Label - Stop");
                    break;
                case PPDeviceParametersAlarmDurationOnce:
                    returnString = NSLocalizedString(@"Play once", @"Detail Label - Play once");
                    break;
                    
                default:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"Play for %i seconds", @"Detail Label - Play for {n} seconds"), alarmDuration];
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_STROBE]) {
        if(!value) {
            returnString = NSLocalizedString(@"Alarm Strobe", @"Label - Alarm Strobe");
        }
        else {
            PPDeviceParametersAlarmStrobe alarmStrobe = (PPDeviceParametersAlarmStrobe)value.integerValue;
            switch (alarmStrobe) {
                case PPDeviceParametersAlarmStrobeOn:
                    returnString = NSLocalizedString(@"Strobe on", @"Detail Label - Strobe on");
                    break;
                case PPDeviceParametersAlarmStrobeOff:
                    returnString = NSLocalizedString(@"Strobe off", @"Detail Label - Strobe off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_SQUAWK]) {
        if(!value) {
            returnString = NSLocalizedString(@"Alarm Squawk", @"Label - Alarm Squawk");
        }
        else {
            PPDeviceParametersAlarmSquawk alarmSquawk = (PPDeviceParametersAlarmSquawk)value.integerValue;
            switch (alarmSquawk) {
                case PPDeviceParametersAlarmSquawkArmed:
                    returnString = NSLocalizedString(@"Squawk armed", @"Detail Label - Squawk sarmed");
                    break;
                case PPDeviceParametersAlarmSquawkDisarmed:
                    returnString = NSLocalizedString(@"Squawk disarmed", @"Detail Label - Squawk disarmed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"iBeacon Status", @"Label - iBeacon Status");
        }
        else {
            PPDeviceParametersIBeaconStatus iBeaconStatus = (PPDeviceParametersIBeaconStatus)value.integerValue;
            switch (iBeaconStatus) {
                case PPDeviceParametersIBeaconStatusOn:
                    returnString = NSLocalizedString(@"On", @"Label - On");
                    break;
                case PPDeviceParametersIBeaconStatusOff:
                    returnString = NSLocalizedString(@"Off", @"Label - Off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_PROXIMITY]) {
        if(!value) {
            returnString = NSLocalizedString(@"iBeacon Proximity", @"Label - iBeacon Proximity");
        }
        else {
            PPDeviceParametersIBeaconProximity iBeaconProximity = (PPDeviceParametersIBeaconProximity)value.integerValue;
            switch (iBeaconProximity) {
                case PPDeviceParametersIBeaconProximityUnknown:
                    returnString = NSLocalizedString(@"Unknown", @"Label - Unknown");
                    break;
                case PPDeviceParametersIBeaconProximityImmediate:
                    returnString = NSLocalizedString(@"Immediate", @"Label - Immediate");
                    break;
                case PPDeviceParametersIBeaconProximityNear:
                    returnString = NSLocalizedString(@"Near", @"Label - Near");
                    break;
                case PPDeviceParametersIBeaconProximityFar:
                    returnString = NSLocalizedString(@"Far", @"Label - Far");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_STATUS]) {
        if(!value) {
            returnString = NSLocalizedString(@"LintAlert Status", @"Label - LintAlert Status");
        }
        else {
            PPDeviceParametersSigStatus sigStatus = (PPDeviceParametersSigStatus)value.integerValue;
            switch (sigStatus) {
                case PPDeviceParametersSigStatusOff:
                    returnString = NSLocalizedString(@"Dryer Off", @"Label - LintAlert Dryer Off");
                    break;
                case PPDeviceParametersSigStatusOn:
                    returnString = NSLocalizedString(@"Dryer On", @"Label - LintAlert Dryer On");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_CUR_MAX_LED]) {
        if(!value) {
            returnString = NSLocalizedString(@"LintAlert Current LED", @"Label - LintAlert Current LED");
        }
        else {
            PPDeviceParametersSigCurMaxLed sigCurMaxLed = (PPDeviceParametersSigCurMaxLed)value.integerValue;
            if(sigCurMaxLed <= PPDeviceParametersSigCurMaxLedOK) {
                returnString = NSLocalizedString(@"OK", @"Detail Label - LintAlert OK");
            }
            else if(sigCurMaxLed == PPDeviceParametersSigCurMaxLedWarning) {
                returnString = NSLocalizedString(@"Warning", @"Detail Label - LintAlert Warning");
            }
            else {
                returnString = NSLocalizedString(@"Blocked", @"Detail Label - LintAlert Blocked");
            }
        }
    }
    else if([parameter isEqualToString:NAM_HEALTH_IDX]) {
        if(!value) {
            returnString = NSLocalizedString(@"Netatmo Health Coach Status", @"Label - Netatmo Health Coach Status");
        }
        else {
            PPDeviceParametersNamHealthIdx namHealthIdx = (PPDeviceParametersNamHealthIdx)value.integerValue;
            switch (namHealthIdx) {
                case PPDeviceParametersNamHealthIdxHealthy:
                    returnString = NSLocalizedString(@"Healthy", @"Label - Netatmo Health Coath stauts - Healthy");
                    break;
                case PPDeviceParametersNamHealthIdxFine:
                    returnString = NSLocalizedString(@"Fine", @"Label - Netatmo Health Coath stauts - Fine");
                    break;
                case PPDeviceParametersNamHealthIdxFair:
                    returnString = NSLocalizedString(@"Fair", @"Label - Netatmo Health Coath stauts - Fair");
                    break;
                case PPDeviceParametersNamHealthIdxPoor:
                    returnString = NSLocalizedString(@"Poor", @"Label - Netatmo Health Coath stauts - Poor");
                    break;
                case PPDeviceParametersNamHealthIdxUnhealthy:
                    returnString = NSLocalizedString(@"Unhealthy", @"Label - Netatmo Health Coath stauts - Unhealthy");
                    break;
                    
                default:
                    return @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE_SEQUENCE]) {
        if(!value) {
            return @"FAN_MODE_SEQUENCE";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FAN_MODE_VALUES]) {
        if(!value) {
            return @"FAN_MODE_VALUES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_COOLING_SETPOINT]) {
        if(!value) {
            return @"MIN_COOLING_SETPOINT";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_COOLING_SETPOINT]) {
        if(!value) {
            return @"MAX_COOLING_SETPOINT";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_HEATING_SETPOINT]) {
        if(!value) {
            return @"MIN_HEATING_SETPOINT";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_HEATING_SETPOINT]) {
        if(!value) {
            return @"MAX_HEATING_SETPOINT";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:TEMP_VALUES]) {
        if(!value) {
            return @"TEMP_VALUES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SWING_MODE_VALUES]) {
        if(!value) {
            return @"SWING_MODE_VALUES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RECORD_STATUS]) {
        if(!value) {
            return @"RECORD_STATUS";
        }
        else {
            PPDeviceParametersRecordStatus recordStatus = (PPDeviceParametersRecordStatus)value.integerValue;
            switch (recordStatus) {
                case PPDeviceParametersRecordStatusRecording:
                    returnString = NSLocalizedString(@"Recording", @"Label - Recording");
                    break;
                case PPDeviceParametersRecordStatusNotRecording:
                    returnString = NSLocalizedString(@"Not recording", @"Label - Not recording");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ACCESS_CAMERA_SETTINGS]) {
        if(!value) {
            return @"ACCESS_CAMERA_SETTINGS";
        }
        else {
            
            PPDeviceParametersAccessCameraSettings accessCameraSettings = (PPDeviceParametersAccessCameraSettings)value.integerValue;
            switch (accessCameraSettings) {
                case PPDeviceParametersAccessCameraSettingsOn:
                    returnString = NSLocalizedString(@"Remote control enabled", @"Label - Recording");
                    break;
                case PPDeviceParametersAccessCameraSettingsOff:
                    returnString = NSLocalizedString(@"Remote control disabled", @"Label - Remote control disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_STREAMING]) {
        if(!value) {
            return @"AUDIO_STREAMING";
        }
        else {
            
            PPDeviceParametersAudioStreaming audioStreaming = (PPDeviceParametersAudioStreaming)value.integerValue;
            switch (audioStreaming) {
                case PPDeviceParametersAudioStreamingOn:
                    returnString = NSLocalizedString(@"Audio streaming enabled", @"Label - Audio streaming enabled");
                    break;
                case PPDeviceParametersAudioStreamingOff:
                    returnString = NSLocalizedString(@"Audio streaming disabled", @"Label - Audio streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VIDEO_STREAMING]) {
        if(!value) {
            return @"VIDEO_STREAMING";
        }
        else {
            
            PPDeviceParametersVideoStreaming videoStreaming = (PPDeviceParametersVideoStreaming)value.integerValue;
            switch (videoStreaming) {
                case PPDeviceParametersVideoStreamingOn:
                    returnString = NSLocalizedString(@"Video streaming enabled", @"Label - Video streaming enabled");
                    break;
                case PPDeviceParametersVideoStreamingOff:
                    returnString = NSLocalizedString(@"Video streaming disabled", @"Label - Video streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:HD_STATUS]) {
        if(!value) {
            return @"HD_STATUS";
        }
        else {
            
            PPDeviceParametersHDStatus HDStatus = (PPDeviceParametersHDStatus)value.integerValue;
            switch (HDStatus) {
                case PPDeviceParametersHDStatusOn:
                    returnString = NSLocalizedString(@"HD Status enabled", @"Label - HD Status enabled");
                    break;
                case PPDeviceParametersHDStatusOff:
                    returnString = NSLocalizedString(@"HD Status disabled", @"Label - HD Status disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RAPID_MOTION_STATUS]) {
        if(!value) {
            return @"RAPID_MOTION_STATUS";
        }
        else {
            
            PPDeviceParametersRapidMotionStatus rapidMotionStatus = (PPDeviceParametersRapidMotionStatus)value.integerValue;
            
            int rapidMotionStatusSeconds = 0;
            int rapidMotionStatusMinutes = 0;
            int rapidMotionStatusHours = 0;
            
            switch (rapidMotionStatus) {
                case PPDeviceParametersRapidMotionStatusMinProVideo:
                    returnString = NSLocalizedString(@"As fast as possible", @"Label - As fast as possible");
                    break;
                default:
                    rapidMotionStatusSeconds = (int)value.integerValue % 60;
                    rapidMotionStatusMinutes = (int)(value.integerValue / 60) % 60;
                    rapidMotionStatusHours = (int)value.integerValue / 3600;
                    
                    if(rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes == 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedString(@"%d hr", @"Label - {number} hours"), rapidMotionStatusHours];
                    } else if (rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes > 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min", @"Label - {number} minutes"), rapidMotionStatusMinutes];
                    } else {
                        returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min %d sec", @"Label - {number} minutes {number} seconds"), rapidMotionStatusMinutes , rapidMotionStatusSeconds];
                    }
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BATTERY_LEVEL]) {
        if(!value) {
            return @"BATTERY_LEVEL";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:CHARGING]) {
        if(!value) {
            return @"CHARGING";
        }
        else {
            
            PPDeviceParametersCharging charging = (PPDeviceParametersCharging)value.integerValue;
            switch (charging) {
                case PPDeviceParametersChargingTrue:
                    returnString = NSLocalizedString(@"Charging", @"Label - Charging");
                    break;
                case PPDeviceParametersChargingFalse:
                    returnString = NSLocalizedString(@"Not charging", @"Label - Not charging");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:MOTION_DETECTION_STATUS]) {
        if(!value) {
            return @"MOTION_STATUS";
        }
        else {
            
            PPDeviceParametersMotionStatus motionStatus= (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedString(@"Detecting Motion", @"Label - Detecting Motion");
                    break;
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedString(@"Not detecting motion", @"Label - Not detecting motion");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUTO_FOCUS]) {
        if(!value) {
            return @"AUTO_FOCUS";
        }
        else {
            
            PPDeviceParametersAutoFocus autoFocus = (PPDeviceParametersAutoFocus)value.integerValue;
            switch (autoFocus) {
                case PPDeviceParametersAutoFocusShouldFocus:
                    returnString = NSLocalizedString(@"Focusing", @"Label - Focusing");
                    break;
                default:
                    returnString = NSLocalizedString(@"Focused", @"Label - Focused");
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_STATUS]) {
        if(!value) {
            return @"AUDIO_STATUS";
        }
        else {
            
            PPDeviceParametersAudioStatus audioStatus = (PPDeviceParametersAudioStatus)value.integerValue;
            switch (audioStatus) {
                case PPDeviceParametersAudioStatusAudio:
                    returnString = NSLocalizedString(@"Detecting Audio", @"Label - Detecting Audio");
                    break;
                case PPDeviceParametersAudioStatusNoAudio:
                    returnString = NSLocalizedString(@"Not detecting audio", @"Label - Not detecting audio");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SELECTED_CAMERA]) {
        if(!value) {
            return @"SELECTED_CAMERA";
        }
        else {
            
            PPDeviceParametersSelectedCamera selectedCamera = (PPDeviceParametersSelectedCamera)value.integerValue;
            switch (selectedCamera) {
                case PPDeviceParametersSelectedCameraRearOnly:
                case PPDeviceParametersSelectedCameraRear:
                    returnString = NSLocalizedString(@"Rear camera", @"Label - Rear camera");
                    break;
                case PPDeviceParametersSelectedCameraFront:
                    returnString = NSLocalizedString(@"Front camera", @"Label - Front camera");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RECORD_SECONDS]) {
        if(!value) {
            return @"RECORD_SECONDS";
        }
        else {
            int motionRecordMinutes = 0;
            int motionRecordSeconds = 0;
            
            if(value.integerValue < 60) {
                motionRecordMinutes = 0;
                motionRecordSeconds = (int)value.integerValue;
            } else {
                motionRecordMinutes = (int)value.integerValue / 60;
                motionRecordSeconds = (int)value.integerValue % 60;
            }
            
            if(motionRecordMinutes == 0) {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d sec", @"Label - {number} seconds"), motionRecordSeconds];
            } else if (motionRecordSeconds == 0 && motionRecordMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min", @"Label - {number} minutes"), motionRecordMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min %d sec", @"Label - {number} minutes {number} seconds"), motionRecordMinutes , motionRecordSeconds];
            }
        }
    }
    else if([parameter isEqualToString:MOTION_SENSITIVITY]) {
        if(!value) {
            return @"MOTION_SENSITIVITY";
        }
        else {
            
            PPDeviceParametersMotionSensitiviy motionSensitivity = (PPDeviceParametersMotionSensitiviy)value.integerValue;
            switch (motionSensitivity) {
                case PPDeviceParametersMotionSensitiviyTiny:
                    returnString = NSLocalizedString(@"Detect tiny movements", @"Label - Detect tiny movements");
                    break;
                case PPDeviceParametersMotionSensitiviySmall:
                    returnString = NSLocalizedString(@"Detect small movements", @"Label - Detect small movements");
                    break;
                case PPDeviceParametersMotionSensitiviyNormal:
                    returnString = NSLocalizedString(@"Detect normal movements", @"Label - Detect normal movements");
                    break;
                case PPDeviceParametersMotionSensitiviyLarge:
                    returnString = NSLocalizedString(@"Detect large movements", @"Label - Detect large movements");
                    break;
                case PPDeviceParametersMotionSensitiviyHuge:
                    returnString = NSLocalizedString(@"Detect huge movements", @"Label - Detect huge movements");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_SENSITIVITY]) {
        if(!value) {
            return @"AUDIO_SENSITIVITY";
        }
        else {
            
            PPDeviceParametersAudioSensitiviy audioSensitivity = (PPDeviceParametersAudioSensitiviy)value.integerValue;
            switch (audioSensitivity) {
                case PPDeviceParametersAudioSensitiviyTiny:
                    returnString = NSLocalizedString(@"Detect tiny aounds", @"Label - Detect tiny sounds");
                    break;
                case PPDeviceParametersAudioSensitiviySmall:
                    returnString = NSLocalizedString(@"Detect small sounds", @"Label - Detect small sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyNormal:
                    returnString = NSLocalizedString(@"Detect normal sounds", @"Label - Detect normal sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyLarge:
                    returnString = NSLocalizedString(@"Detect large sounds", @"Label - Detect large sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyHuge:
                    returnString = NSLocalizedString(@"Detect huge sounds", @"Label - Detect huge sounds");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VERSION]) {
        if(!value) {
            return @"VERSION";
        }
        else {
            returnString =  value;
        }
    }
    else if([parameter isEqualToString:ROBOT_CONNECTED]) {
        if(!value) {
            return @"ROBOT_CONNECTED";
        }
        else {
            
            PPDeviceParametersRobotConnected robotConnected = (PPDeviceParametersRobotConnected)value.integerValue;
            switch (robotConnected) {
                case PPDeviceParametersRobotConnectedNone:
                    returnString = NSLocalizedString(@"No robot connected", @"Label - No robot connected");
                    break;
                case PPDeviceParametersRobotConnectedGalileo:
                    returnString = NSLocalizedString(@"Galileo", @"Label - Galileo");
                    break;
                case PPDeviceParametersRobotConnectedKubi:
                    returnString = NSLocalizedString(@"KUBI", @"Label - KUBI");
                    break;
                case PPDeviceParametersRobotConnectedRomo:
                    returnString = NSLocalizedString(@"Romo", @"Label - Romo");
                    break;
                case PPDeviceParametersRobotConnectedGalileoBT:
                    returnString = NSLocalizedString(@"Galileo BT", @"Label - Galileo BT");
                    break;
                case PPDeviceParametersRobotConnected360:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"%@ 360", @"Label - {AppName} 360"), [PPBaseModel appName:NO]];
                    break;
                case PPDeviceParametersRobotConnectedUnknown:
                    returnString = NSLocalizedString(@"Unknown robot", @"Label - Unknown robot");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ROBOT_MOTION_DIRECTION]) {
        if(!value) {
            return @"ROBOT_MOTION_DIRECTION";
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_SPHERICAL_COORDINATES]) {
        if(!value) {
            return @"ROBOT_VANTAGE_SPHERICAL_COORDINATES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_TIME]) {
        if(!value) {
            return @"ROBOT_VANTAGE_TIME";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_NAME]) {
        if(!value) {
            return @"ROBOT_VANTAGE_NAME";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_SEQUENCE]) {
        if(!value) {
            return @"ROBOT_VANTAGE_SEQUENCE";
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_MOVE_TO_INDEX]) {
        if(!value) {
            return @"ROBOT_VANTAGE_MOVE_TO_INDEX";
        }
    }
    else if([parameter isEqualToString:ROBOT_VANTAGE_CONFIGURATION_STATUS]) {
        if(!value) {
            return @"ROBOT_VANTAGE_CONFIGURATION_STATUS";
        }
        else {
            
            PPDeviceParametersRobotVantageConfigurationStatus configurationStatus = (PPDeviceParametersRobotVantageConfigurationStatus)value.integerValue;
            switch (configurationStatus) {
                case PPDeviceParametersRobotVantageConfigurationStatusHardReset:
                    returnString = NSLocalizedString(@"Hard Reset", @"Label - Hard Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusWarmReset:
                    returnString = NSLocalizedString(@"Warm Reset", @"Label - Warm Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUART:
                    returnString = NSLocalizedString(@"Reset UART", @"Label - Reset UART");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue:
                    returnString = NSLocalizedString(@"Reset UART queue", @"Label - Reset UART queue");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard:
                    returnString = NSLocalizedString(@"Reboot motor control board", @"Label - Reboot motor control board");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusReady:
                    returnString = NSLocalizedString(@"Ready", @"Label - Ready");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"Configure vantage point %@", @"Label - Configure vantage point {vantage point index}"), value];
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ROBOT_ORIENTATION]) {
        if(!value) {
            return @"ROBOT_ORIENTATION";
        }
        else {
            
            PPDeviceParametersRobotOrientation orientation = (PPDeviceParametersRobotOrientation)value.integerValue;
            switch (orientation) {
                case PPDeviceParametersRobotOrientationShouldFlip:
                    returnString = NSLocalizedString(@"Flip vertical", @"Label - Flip vertical");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AVAILABLE_BYTES]) {
        if(!value) {
            return @"AVAILABLE_BYTES";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:TWITTER_AUTO_SHARE]) {
        if(!value) {
            return @"TWITTER_AUTO_SHARE";
        }
        else {
            
            PPDeviceParametersTwitterAutoShare autoShare = (PPDeviceParametersTwitterAutoShare)value.integerValue;
            switch (autoShare) {
                case PPDeviceParametersTwitterAutoShareOff:
                    returnString = NSLocalizedString(@"Twitter auto-sharing disabled", @"Label - Twitter auto-sharing disabled");
                    break;
                case PPDeviceParametersTwitterAutoShareOn:
                    returnString = NSLocalizedString(@"Twitter auto-sharing enabled", @"Label - Twitter auto-sharing enabled");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:TWITTER_DESCRIPTION]) {
        if(!value) {
            return @"TWITTER_DESCRIPTION";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:TWITTER_REMINDER]) {
        if(!value) {
            return @"TWITTER_REMINDER";
        }
        else {
            
            PPDeviceParametersTwitterReminder reminder = (PPDeviceParametersTwitterReminder)value.integerValue;
            switch (reminder) {
                case PPDeviceParametersTwitterReminderOff:
                    returnString = NSLocalizedString(@"Twitter reminder disabled", @"Label - Twitter reminder disabled");
                    break;
                case PPDeviceParametersTwitterReminderOn:
                    returnString = NSLocalizedString(@"Twitter reminder enabled", @"Label - Twitter reminder enabled");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:TWITTER_STATUS]) {
        if(!value) {
            return @"TWITTER_STATUS";
        }
        else {
            
            PPDeviceParametersTwitterStatus status = (PPDeviceParametersTwitterStatus)value.integerValue;
            switch (status) {
                case PPDeviceParametersTwitterStatusOff:
                    returnString = NSLocalizedString(@"Twitter disabled", @"Label - Twitter disabled");
                    break;
                case PPDeviceParametersTwitterStatusOn:
                    returnString = NSLocalizedString(@"Twitter enabled", @"Label - Twitter enabled");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:MOTION_COUNTDOWN_TIME]) {
        if(!value) {
            return @"MOTION_COUNTDOWN_TIME";
        }
        else {
            int motionCountDownMinutes = 0;
            int motionCountDownSeconds = 0;
            
            if(value.integerValue < 60) {
                motionCountDownMinutes = 0;
                motionCountDownSeconds = (int)value.integerValue;
            } else {
                motionCountDownMinutes = (int)value.integerValue / 60;
                motionCountDownSeconds = (int)value.integerValue % 60;
            }
            
            if(motionCountDownMinutes == 0) {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d sec", @"Label - {number} seconds"), motionCountDownSeconds];
            } else if (motionCountDownSeconds == 0 && motionCountDownMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min", @"Label - {number} minutes"), motionCountDownMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"%d min %d sec", @"Label - {number} minutes {number} seconds"), motionCountDownMinutes , motionCountDownSeconds];
            }
        }
    }
    else if([parameter isEqualToString:BLACKOUT_SCREEN_ON]) {
        if(!value) {
            return @"BLACKOUT_SCREEN_ON";
        }
        else {
            
            PPDeviceParametersBlackoutScreenOn blackout = (PPDeviceParametersBlackoutScreenOn)value.integerValue;
            switch (blackout) {
                case PPDeviceParametersBlackoutScreenOnOff:
                    returnString = NSLocalizedString(@"Blackout disabled", @"Label - Blackout disabled");
                    break;
                case PPDeviceParametersBlackoutScreenOnOn:
                    returnString = NSLocalizedString(@"Blackout enabled", @"Label - Blackout enabled");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WARNING_STATUS]) {
        if(!value) {
            return @"WARNING_STATUS";
        }
        else {
            
            PPDeviceParametersWarningStatus warningStatus = (PPDeviceParametersWarningStatus)value.integerValue;
            switch (warningStatus) {
                case PPDeviceParametersWarningStatusOff:
                    returnString = NSLocalizedString(@"Warning status disabled", @"Label - Warning status disabled");
                    break;
                case PPDeviceParametersWarningStatusOn:
                    returnString = NSLocalizedString(@"Warning status enabled", @"Label - Warning status enabled");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WARNING_TEXT]) {
        if(!value) {
            return @"WARNING_TEXT";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:KEYPAD_STATUS]) {
        if(!value) {
            return @"KEYPAD_STATUS";
        }
    }
    else if([parameter isEqualToString:RECORD_FULL_DURATION]) {
        if(!value) {
            return @"RECORD_FULL_DURATION";
        }
        else {
            
            PPDeviceParametersRecordFullDuration recordFullDuration = (PPDeviceParametersRecordFullDuration)value.integerValue;
            switch (recordFullDuration) {
                case PPDeviceParametersRecordFullDurationOff:
                    returnString = NSLocalizedString(@"Stop recording after motion goes away", @"Label - Stop recording after motion goes away");
                    break;
                case PPDeviceParametersRecordFullDurationOn:
                    returnString = NSLocalizedString(@"Continue recording even after motion goes away", @"Label - Continue recording even after motion goes away");
                    break;
                default:
                    break;
            }
            
        }
    }
    else if([parameter isEqualToString:FLASH_ON]) {
        if(!value) {
            return @"FLASH_ON";
        }
        else {
            
            PPDeviceParametersFlashOn flashOn = (PPDeviceParametersFlashOn)value.integerValue;
            switch (flashOn) {
                case PPDeviceParametersFlashOnOn:
                    returnString = NSLocalizedString(@"Flash on", @"Label - Flash off");
                    break;
                case PPDeviceParametersFlashOnOff:
                case PPDeviceParametersFlashOnWasOn:
                    returnString = NSLocalizedString(@"Flash off", @"Label - Flash off");
                    break;
                case PPDeviceParametersFlashOnNoFlash:
                    returnString = NSLocalizedString(@"No Flash", @"Label - No Flash");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SUPPORTS_VIDEO_CALL]) {
        if(!value) {
            return @"SUPPORTS_VIDEO_CALL";
        }
        else {
            
            PPDeviceParametersSupportsVideoCall videoCall = (PPDeviceParametersSupportsVideoCall)value.integerValue;
            switch (videoCall) {
                case PPDeviceParametersSupportsVideoCallFalse:
                    returnString = NSLocalizedString(@"Video calling not supported", @"Label - Video calling not supported");
                    break;
                case PPDeviceParametersSupportsVideoCallTrue:
                    returnString = NSLocalizedString(@"Video calling supported", @"Label - Video calling supported");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:OUTPUT_VOLUME]) {
        if(!value) {
            return @"OUTPUT_VOLUME";
        }
        else {
            if(value.integerValue <= 0) {
                returnString = NSLocalizedString(@"Camera speaker volume is muted.", @"Camera - Label describing this camera is muted");
            }
            else if (value.integerValue >= PPDeviceParametersOutputVolumeMax) {
                returnString = NSLocalizedString(@"Camera speaker volume is maxed.", @"Camera - Label describing this camera's volume is maxed");
            }
            else {
                returnString = [NSString stringWithFormat:NSLocalizedString(@"Camera speaker volume is at %.0f%%.", @"Label - Camera speaker volume is at {number}{percent %}"),(float)(value.floatValue / PPDeviceParametersOutputVolumeMax) * 100];
            }
        }
    }
    else if([parameter isEqualToString:CAPTURE_IMAGE]) {
        if(!value) {
            return @"CAPTURE_IMAGE";
        }
    }
    else if([parameter isEqualToString:ALARM]) {
        if(!value) {
            return @"ALARM";
        }
        else {
            
            PPDeviceParametersAlarm alarm = (PPDeviceParametersAlarm)value.integerValue;
            switch (alarm) {
                case PPDeviceParametersAlarmOn:
                    returnString = NSLocalizedString(@"Alarm is active", @"Label - Alarm is active");
                    break;
                case PPDeviceParametersAlarmOff:
                    returnString = NSLocalizedString(@"Alarm is off", @"Label - Alarm is off");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"Alarm will beep %i times", @"Label - Alarm will beep %@ times"), value];
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"Alarm will beep %i times", @"Label - Alarm will beep %@ times"), value];
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:PLAY_SOUND]) {
        if(!value) {
            return @"PLAY_SOUND";
        }
    }
    else if([parameter isEqualToString:COUNTDOWN]) {
        if(!value) {
            return @"COUNTDOWN";
        }
    }
    else if([parameter isEqualToString:VISUAL_COUNTDOWN]) {
        if(!value) {
            return @"VISUAL_COUNTDOWN";
        }
    }
    else if([parameter isEqualToString:MOTION_ALARM]) {
        if(!value) {
            return @"MOTION_ALARM";
        }
        else {
            
            PPDeviceParametersAlarm alarm = (PPDeviceParametersAlarm)value.integerValue;
            switch (alarm) {
                case PPDeviceParametersAlarmOn:
                    returnString = NSLocalizedString(@"Sound alarm when motion is detected", @"Label - Sound alarm when motion is detected");
                    break;
                case PPDeviceParametersAlarmOff:
                    
                    returnString = NSLocalizedString(@"Disabled", @"Label - Disabled");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = NSLocalizedString(@"Beep 1 time when motion is detected", @"Label - Beep 1 time when motion is detected");
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedString(@"Beep %@ times when motion is detected", @"Label - Beep 2 times when motion is detected"), value];
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FIRMWARE]) {
        if(!value) {
            return @"FIRMWARE";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MODEL]) {
        if(!value) {
            return @"MODEL";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FIRMWARE_UPDATE_STATUS]) {
        if(!value) {
            return @"FIRMWARE_UPDATE_STATUS";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FIRMWARE_URL]) {
        if(!value) {
            return @"FIRMWARE_URL";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FIRMWARE_CHECK_SUM]) {
        if(!value) {
            return @"FIRMWARE_CHECK_SUM";
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:NOTIFICATION]) {
        if(!value) {
            return @"NOTIFICATION";
        }
        else {
            returnString = value;
        }
    }
    
    
    return returnString;
}

+ (NSDictionary *)fontIconStringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options {
    NSLog(@"%s deprecated. Use PPDeviceParameterUI+fontIconStringForDeviceParameter:options:", __FUNCTION__);
    return nil;
}

+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId {
    return [PPDeviceParameters parameterOptionsWithValue:value deviceTypeId:deviceTypeId index:nil];
}

+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId index:(NSString *)index {
    NSMutableDictionary *options = [[NSMutableDictionary alloc] initWithCapacity:2];
    if(value) {
        [options setValue:value forKey:DEVICE_PARAMETER_KEY_VALUE];
    }
    if(deviceTypeId != PPDeviceTypeIdNone) {
        [options setValue:[NSNumber numberWithInteger:deviceTypeId] forKey:DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID];
    }
    if(index) {
        [options setValue:index forKey:DEVICE_PARAMETER_KEY_INDEX];
    }
    return options;
}

+ (NSArray *)fanModesForSequence:(PPDeviceParametersFanModeSequence)sequence {
    NSArray *availableModes;
    if(sequence == PPDeviceParametersFanModeSequenceLowMedHigh) {
        availableModes = @[@(PPDeviceParametersFanModeLow),@(PPDeviceParametersFanModeMedium),@(PPDeviceParametersFanModeHigh)];
    }
    else if(sequence == PPDeviceParametersFanModeSequenceLowHigh) {
        availableModes = @[@(PPDeviceParametersFanModeLow),@(PPDeviceParametersFanModeHigh)];
    }
    else if(sequence == PPDeviceParametersFanModeSequenceLowMedHighAuto) {
        availableModes = @[@(PPDeviceParametersFanModeLow),@(PPDeviceParametersFanModeMedium),@(PPDeviceParametersFanModeHigh),@(PPDeviceParametersFanModeAuto)];
    }
    else if(sequence == PPDeviceParametersFanModeSequenceLowHighAuto) {
        availableModes = @[@(PPDeviceParametersFanModeLow),@(PPDeviceParametersFanModeHigh),@(PPDeviceParametersFanModeAuto)];
    }
    else if(sequence == PPDeviceParametersFanModeSequenceOnAuto) {
        availableModes = @[@(PPDeviceParametersFanModeOn),@(PPDeviceParametersFanModeAuto)];
    }
    return availableModes;
}

+ (NSArray *)systemModeStatuses {
    return @[@(PPDeviceParametersSystemModeStatusOff), @(PPDeviceParametersSystemModeStatusCool), @(PPDeviceParametersSystemModeStatusHeat)];
}

+ (NSArray *)powerStatuses {
    return @[@(PPDeviceParametersPowerStatusOff), @(PPDeviceParametersPowerStatusOn)];
}

+ (BOOL)parameterSupportsHistoricalMeasurements:(NSString *)parameter {
    BOOL supportsHistoricalMeasurements = NO;
    supportsHistoricalMeasurements |= [parameter isEqualToString:COOLING_SETPOINT];
    supportsHistoricalMeasurements |= [parameter isEqualToString:HEATING_SETPOINT];
    supportsHistoricalMeasurements |= [parameter isEqualToString:DEG_C];
    supportsHistoricalMeasurements |= [parameter isEqualToString:INTERNAL_DEG_C];
    supportsHistoricalMeasurements |= [parameter isEqualToString:RELATIVE_HUMIDITY];
    supportsHistoricalMeasurements |= [parameter isEqualToString:POWER];
    supportsHistoricalMeasurements |= [parameter isEqualToString:ENERGY];
    supportsHistoricalMeasurements |= [parameter isEqualToString:DOOR_STATUS];
    supportsHistoricalMeasurements |= [parameter isEqualToString:VIBRATION_STATUS];
    supportsHistoricalMeasurements |= [parameter isEqualToString:WATER_LEAK];
    supportsHistoricalMeasurements |= [parameter isEqualToString:LOCK_STATUS];
    supportsHistoricalMeasurements |= [parameter isEqualToString:BUTTON_STATUS];
    supportsHistoricalMeasurements |= [parameter isEqualToString:SIG_PRESSURE];
    supportsHistoricalMeasurements |= [parameter isEqualToString:SIG_WCI_PRESSURE];
    supportsHistoricalMeasurements |= [parameter isEqualToString:MOTION_STATUS];
    
    return supportsHistoricalMeasurements;
}
@end
