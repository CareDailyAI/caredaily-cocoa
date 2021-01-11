//
//  PPDeviceParameters.m
//  Peoplepower
//
//  Created by Destry Teeter on 2/27/18.
//  Copyright © 2020 People Power. All rights reserved.
//

#import "PPDeviceParameters.h"
#import "PPDeviceTypes.h"

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
            returnString = NSLocalizedStringFromTableInBundle(@"System Mode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - System Mode");
        }
        else {
            PPDeviceParametersSystemMode systemMode = (PPDeviceParametersSystemMode)value.integerValue;
            switch (systemMode) {
                case PPDeviceParametersSystemModeOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersSystemModeAuto:
                    returnString = NSLocalizedStringFromTableInBundle(@"Auto", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Auto");
                    break;
                case PPDeviceParametersSystemModeCool:
                    returnString = NSLocalizedStringFromTableInBundle(@"Cool", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Cool");
                    break;
                case PPDeviceParametersSystemModeHeat:
                    returnString = NSLocalizedStringFromTableInBundle(@"Heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Heat");
                    break;
                case PPDeviceParametersSystemModeEmergencyHeat:
                    returnString = NSLocalizedStringFromTableInBundle(@"Emergency Heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Emergency Heat");
                    break;
                case PPDeviceParametersSystemModePrecooling:
                    returnString = NSLocalizedStringFromTableInBundle(@"Precooling", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Precooling");
                    break;
                case PPDeviceParametersSystemModeFanOnly:
                    returnString = NSLocalizedStringFromTableInBundle(@"Fan Only", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Fan Only");
                    break;
                case PPDeviceParametersSystemModeDry:
                    returnString = NSLocalizedStringFromTableInBundle(@"Dry", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Dry");
                    break;
                case PPDeviceParametersSystemModeAuxiliaryHeat:
                    returnString = NSLocalizedStringFromTableInBundle(@"Auxiliary Heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Auxiliary Heat");
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
            returnString = NSLocalizedStringFromTableInBundle(@"System Mode Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - System Mode Status");
        }
        else {
            PPDeviceParametersSystemModeStatus systemModeStatus = (PPDeviceParametersSystemModeStatus)value.integerValue;
            switch (systemModeStatus) {
                case PPDeviceParametersSystemModeStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersSystemModeStatusCool:
                    returnString = NSLocalizedStringFromTableInBundle(@"Cool", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Cool");
                    break;
                case PPDeviceParametersSystemModeStatusHeat:
                    returnString = NSLocalizedStringFromTableInBundle(@"Heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Fan Mode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Fan Mode");
        }
        else {
            PPDeviceParametersFanMode fanMode = (PPDeviceParametersFanMode)value.integerValue;
            switch (fanMode) {
                case PPDeviceParametersFanModeOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersFanModeLow:
                    returnString = NSLocalizedStringFromTableInBundle(@"Low", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Low");
                    break;
                case PPDeviceParametersFanModeMedium:
                    returnString = NSLocalizedStringFromTableInBundle(@"Medium", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Medium");
                    break;
                case PPDeviceParametersFanModeHigh:
                    returnString = NSLocalizedStringFromTableInBundle(@"High", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - High");
                    break;
                case PPDeviceParametersFanModeOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - On");
                    break;
                case PPDeviceParametersFanModeAuto:
                    returnString = NSLocalizedStringFromTableInBundle(@"Auto", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Auto");
                    break;
                case PPDeviceParametersFanModeSmart:
                    returnString = NSLocalizedStringFromTableInBundle(@"Smart", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Smart");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SWING_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Swing Mode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Swing Mode");
        }
        else {
            PPDeviceParametersSwingMode swingMode = (PPDeviceParametersSwingMode)value.integerValue;
            switch (swingMode) {
                case PPDeviceParametersSwingModeStopped:
                    returnString = NSLocalizedStringFromTableInBundle(@"Stopped", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Stopped");
                    break;
                case PPDeviceParametersSwingModeRangeFull:
                case PPDeviceParametersSwingModeRangeTop:
                case PPDeviceParametersSwingModeRangeMiddle:
                case PPDeviceParametersSwingModeRangeBottom:
                    returnString = NSLocalizedStringFromTableInBundle(@"Range", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Range");
                    break;
                case PPDeviceParametersSwingModeFixedTop:
                case PPDeviceParametersSwingModeFixedMiddleTop:
                case PPDeviceParametersSwingModeFixedMiddle:
                case PPDeviceParametersSwingModeFixedMiddleBottom:
                case PPDeviceParametersSwingModeFixedBottom:
                    returnString = NSLocalizedStringFromTableInBundle(@"Fixed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Fixed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:STATE]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"State", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - State");
        }
        else {
            PPDeviceParametersState state = (PPDeviceParametersState)value.integerValue;
            switch (state) {
                case PPDeviceParametersStateOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersStateOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:CURRENT_LEVEL]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Brightness", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Brightness");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:OUTLET_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Outlet Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Outlet Status");
        }
        else {
            PPDeviceParametersOutletStatus outletStatus = (PPDeviceParametersOutletStatus)value.integerValue;
            switch (outletStatus) {
                case PPDeviceParametersOutletStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersOutletStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Power Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Power Status");
        }
        else {
            PPDeviceParametersPowerStatus powerStatus = (PPDeviceParametersPowerStatus)value.integerValue;
            switch (powerStatus) {
                case PPDeviceParametersPowerStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                case PPDeviceParametersPowerStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Power", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Power");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@ watts", value];
        }
    }
    else if([parameter isEqualToString:DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Temperature", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:INTERNAL_DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Internal Temperature", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Internal Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:COOLING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Cooling Setpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Cooling Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:HEATING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Heating Setpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Heating Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RELATIVE_HUMIDITY]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Relative Humidity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Relative Humidity");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:DOOR_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Door Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Door Status");
        }
        else {
            PPDeviceParametersDoorStatus doorStatus = (PPDeviceParametersDoorStatus)value.integerValue;
            switch (doorStatus) {
                case PPDeviceParametersDoorStatusClosed:
                    returnString = NSLocalizedStringFromTableInBundle(@"Closed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Closed");
                    break;
                case PPDeviceParametersDoorStatusOpen:
                    returnString = NSLocalizedStringFromTableInBundle(@"Open", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:VIBRATION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Vibration Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Vibration Status");
        }
        else {
            PPDeviceParametersVibrationStatus vibrationStatus = (PPDeviceParametersVibrationStatus)value.integerValue;
            switch (vibrationStatus) {
                case PPDeviceParametersVibrationStatusStill:
                    returnString = NSLocalizedStringFromTableInBundle(@"Still", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Still");
                    break;
                case PPDeviceParametersVibrationStatusMoved:
                    returnString = NSLocalizedStringFromTableInBundle(@"Moved", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Moved");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:MOTION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Motion Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Motion Status");
        }
        else {
            PPDeviceParametersMotionStatus motionStatus = (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringFromTableInBundle(@"No Motion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - No Motion");
                    break;
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedStringFromTableInBundle(@"Motion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Motion");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WATER_LEAK]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Water Leak", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Water Leak");
        }
        else {
            PPDeviceParametersWaterLeak waterLeak = (PPDeviceParametersWaterLeak)value.integerValue;
            switch (waterLeak) {
                case PPDeviceParametersWaterLeakDry:
                    returnString = NSLocalizedStringFromTableInBundle(@"Dry", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Dry");
                    break;
                case PPDeviceParametersWaterLeakWet:
                    returnString = NSLocalizedStringFromTableInBundle(@"Wet", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Wet");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Lock Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Lock Status");
        }
        else {
            PPDeviceParametersLockStatus lockStatus = (PPDeviceParametersLockStatus)value.integerValue;
            switch (lockStatus) {
                case PPDeviceParametersLockStatusLocked:
                    returnString = NSLocalizedStringFromTableInBundle(@"Locked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Locked");
                    break;
                case PPDeviceParametersLockStatusUnlocked:
                    returnString = NSLocalizedStringFromTableInBundle(@"Unlocked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Unlocked");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS_ALARM]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Lock Status Alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Lock Status Alarm");
        }
        else {
            PPDeviceParametersLockStatusAlarm lockStatusAlarm = (PPDeviceParametersLockStatusAlarm)value.integerValue;
            switch (lockStatusAlarm) {
                case PPDeviceParametersLockStatusAlarmOK:
                    returnString = NSLocalizedStringFromTableInBundle(@"OK", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - OK");
                    break;
                case PPDeviceParametersLockStatusAlarmDeadboltJammed:
                    returnString = NSLocalizedStringFromTableInBundle(@"Deadbolt Jammed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Deadbolt Jammed");
                    break;
                case PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults:
                    returnString = NSLocalizedStringFromTableInBundle(@"Lock Reset to Factory Defaults", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Lock Reset to Factory Defaults");
                    break;
                case PPDeviceParametersLockStatusAlarmRFModulePowerCycled:
                    returnString = NSLocalizedStringFromTableInBundle(@"RF Module Power Cycled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - RF Module Power Cycled");
                    break;
                case PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit:
                    returnString = NSLocalizedStringFromTableInBundle(@"Wrong Code Entry Limit", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Wrong Code Entry Limit");
                    break;
                case PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved:
                    returnString = NSLocalizedStringFromTableInBundle(@"Front Escutcheon Removed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Front Escutcheon Removed");
                    break;
                case PPDeviceParametersLockStatusAlarmDoorForcedOpen:
                    returnString = NSLocalizedStringFromTableInBundle(@"Door Forced Open", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Door Forced Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BUTTON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Button Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Button Status");
        }
        else {
            PPDeviceParametersButtonStatus buttonStatus = (PPDeviceParametersButtonStatus)value.integerValue;
            switch (buttonStatus) {
                case PPDeviceParametersButtonStatusReleased:
                    returnString = NSLocalizedStringFromTableInBundle(@"Released", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Released");
                    break;
                case PPDeviceParametersButtonStatusPressed:
                    returnString = NSLocalizedStringFromTableInBundle(@"Pressed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Pressed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ALARM_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Alarm Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Status");
        }
        else {
            PPDeviceParametersAlarmStatus alarmStatus = (PPDeviceParametersAlarmStatus)value.integerValue;
            switch (alarmStatus) {
                case PPDeviceParametersAlarmStatusInactive:
                    returnString = NSLocalizedStringFromTableInBundle(@"Inactive", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Inactive");
                    break;
                case PPDeviceParametersAlarmStatusActive:
                    returnString = NSLocalizedStringFromTableInBundle(@"Active", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Active");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_WARN]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Alarm Warn", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Warn");
        }
        else {
            if(deviceTypeId == PPDeviceTypeIdNone) {
                returnString = NSLocalizedStringFromTableInBundle(@"Alarm Warn", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Warn");
            }
            else if(deviceTypeId == PPDeviceTypeIdSmartenitSiren) {
                PPDeviceParametersAlarmWarnSmartenit alarmWarn = (PPDeviceParametersAlarmWarnSmartenit)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnSmartenitSecurityDrill:
                        returnString = NSLocalizedStringFromTableInBundle(@"Security Drill", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitStop:
                        returnString = NSLocalizedStringFromTableInBundle(@"Stop alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Stop alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitBurglar:
                        returnString = NSLocalizedStringFromTableInBundle(@"Burglar alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Burglar alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitFire:
                        returnString = NSLocalizedStringFromTableInBundle(@"Fire alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Fire alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitEmergency:
                        returnString = NSLocalizedStringFromTableInBundle(@"Emergency alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Emergency alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese1:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese1", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese1");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese2:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese2", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese2");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese3:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese3", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese3");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese4:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese4", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese4");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese5:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese5", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese5");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese6:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese6", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese6");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese7:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese7", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese7");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese8:
                        returnString = NSLocalizedStringFromTableInBundle(@"Chinese8", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Chinese8");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickOnce:
                        returnString = NSLocalizedStringFromTableInBundle(@"Click once", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Click once");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickMulitple:
                        returnString = NSLocalizedStringFromTableInBundle(@"Mulitple clicks", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Multiple clicks");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitNoSound:
                        returnString = NSLocalizedStringFromTableInBundle(@"No sound", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - No sound");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitDoorbell:
                        returnString = NSLocalizedStringFromTableInBundle(@"Doorbell", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Doorbell");
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
                        returnString = NSLocalizedStringFromTableInBundle(@"Security Drill", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighAlarm:
                        returnString = NSLocalizedStringFromTableInBundle(@"Alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Alarm");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDog:
                        returnString = NSLocalizedStringFromTableInBundle(@"Dog", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Dog");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWarning:
                        returnString = NSLocalizedStringFromTableInBundle(@"Warning", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Warning");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBling:
                        returnString = NSLocalizedStringFromTableInBundle(@"Bling", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Bling");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBird:
                        returnString = NSLocalizedStringFromTableInBundle(@"Bird", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Bird");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDroid:
                        returnString = NSLocalizedStringFromTableInBundle(@"Droid", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Droid");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighLock:
                        returnString = NSLocalizedStringFromTableInBundle(@"Lock", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Lock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighPhaser:
                        returnString = NSLocalizedStringFromTableInBundle(@"Phaser", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Phaser");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDoorbel:
                        returnString = NSLocalizedStringFromTableInBundle(@"Doorbel", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Doorbel");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunCock:
                        returnString = NSLocalizedStringFromTableInBundle(@"GunCock", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - GunCock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunShot:
                        returnString = NSLocalizedStringFromTableInBundle(@"GunShot", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - GunShot");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighSwitch:
                        returnString = NSLocalizedStringFromTableInBundle(@"Switch", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Switch");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighTrumpet:
                        returnString = NSLocalizedStringFromTableInBundle(@"Trumpet", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Trumpet");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWhistle:
                        returnString = NSLocalizedStringFromTableInBundle(@"Whistle", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Whistle");
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
                        returnString = NSLocalizedStringFromTableInBundle(@"Silence", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Silence");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBurglar:
                        returnString = NSLocalizedStringFromTableInBundle(@"Burglar", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Burglar");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoFire:
                        returnString = NSLocalizedStringFromTableInBundle(@"Fire", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Fire");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoEmergency:
                        returnString = NSLocalizedStringFromTableInBundle(@"Emergency", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Emergency");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicP:
                        returnString = NSLocalizedStringFromTableInBundle(@"PanicP", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - PanicP");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicF:
                        returnString = NSLocalizedStringFromTableInBundle(@"PanicF", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - PanicF");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicE:
                        returnString = NSLocalizedStringFromTableInBundle(@"PanicE", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - PanicE");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome:
                        returnString = NSLocalizedStringFromTableInBundle(@"BeepBeepWelcome", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - BeepBeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepWelcome:
                        returnString = NSLocalizedStringFromTableInBundle(@"BeepWelcome", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - BeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeep:
                        returnString = NSLocalizedStringFromTableInBundle(@"BeepBeep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - BeepBeep");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeep:
                        returnString = NSLocalizedStringFromTableInBundle(@"Beep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Beep");
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
            returnString = NSLocalizedStringFromTableInBundle(@"Alarm Duration", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Duration");
        }
        else {
            PPDeviceParametersAlarmDuration alarmDuration = (PPDeviceParametersAlarmDuration)value.integerValue;
            switch (alarmDuration) {
                case PPDeviceParametersAlarmDurationStop:
                    returnString = NSLocalizedStringFromTableInBundle(@"Stop", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Stop");
                    break;
                case PPDeviceParametersAlarmDurationOnce:
                    returnString = NSLocalizedStringFromTableInBundle(@"Play once", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Play once");
                    break;
                    
                default:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Play for %i seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Play for {n} seconds"), alarmDuration];
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_STROBE]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Alarm Strobe", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Strobe");
        }
        else {
            PPDeviceParametersAlarmStrobe alarmStrobe = (PPDeviceParametersAlarmStrobe)value.integerValue;
            switch (alarmStrobe) {
                case PPDeviceParametersAlarmStrobeOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Strobe on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Strobe on");
                    break;
                case PPDeviceParametersAlarmStrobeOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Strobe off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Strobe off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_SQUAWK]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Alarm Squawk", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm Squawk");
        }
        else {
            PPDeviceParametersAlarmSquawk alarmSquawk = (PPDeviceParametersAlarmSquawk)value.integerValue;
            switch (alarmSquawk) {
                case PPDeviceParametersAlarmSquawkArmed:
                    returnString = NSLocalizedStringFromTableInBundle(@"Squawk armed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Squawk sarmed");
                    break;
                case PPDeviceParametersAlarmSquawkDisarmed:
                    returnString = NSLocalizedStringFromTableInBundle(@"Squawk disarmed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - Squawk disarmed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"iBeacon Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - iBeacon Status");
        }
        else {
            PPDeviceParametersIBeaconStatus iBeaconStatus = (PPDeviceParametersIBeaconStatus)value.integerValue;
            switch (iBeaconStatus) {
                case PPDeviceParametersIBeaconStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - On");
                    break;
                case PPDeviceParametersIBeaconStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_PROXIMITY]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"iBeacon Proximity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - iBeacon Proximity");
        }
        else {
            PPDeviceParametersIBeaconProximity iBeaconProximity = (PPDeviceParametersIBeaconProximity)value.integerValue;
            switch (iBeaconProximity) {
                case PPDeviceParametersIBeaconProximityUnknown:
                    returnString = NSLocalizedStringFromTableInBundle(@"Unknown", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Unknown");
                    break;
                case PPDeviceParametersIBeaconProximityImmediate:
                    returnString = NSLocalizedStringFromTableInBundle(@"Immediate", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Immediate");
                    break;
                case PPDeviceParametersIBeaconProximityNear:
                    returnString = NSLocalizedStringFromTableInBundle(@"Near", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Near");
                    break;
                case PPDeviceParametersIBeaconProximityFar:
                    returnString = NSLocalizedStringFromTableInBundle(@"Far", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Far");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"LintAlert Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - LintAlert Status");
        }
        else {
            PPDeviceParametersSigStatus sigStatus = (PPDeviceParametersSigStatus)value.integerValue;
            switch (sigStatus) {
                case PPDeviceParametersSigStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Dryer Off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - LintAlert Dryer Off");
                    break;
                case PPDeviceParametersSigStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Dryer On", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - LintAlert Dryer On");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_CUR_MAX_LED]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"LintAlert Current LED", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - LintAlert Current LED");
        }
        else {
            PPDeviceParametersSigCurMaxLed sigCurMaxLed = (PPDeviceParametersSigCurMaxLed)value.integerValue;
            if(sigCurMaxLed <= PPDeviceParametersSigCurMaxLedOK) {
                returnString = NSLocalizedStringFromTableInBundle(@"OK", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - LintAlert OK");
            }
            else if(sigCurMaxLed == PPDeviceParametersSigCurMaxLedWarning) {
                returnString = NSLocalizedStringFromTableInBundle(@"Warning", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - LintAlert Warning");
            }
            else {
                returnString = NSLocalizedStringFromTableInBundle(@"Blocked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detail Label - LintAlert Blocked");
            }
        }
    }
    else if([parameter isEqualToString:NAM_HEALTH_IDX]) {
        if(!value) {
            returnString = NSLocalizedStringFromTableInBundle(@"Netatmo Health Coach Status", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coach Status");
        }
        else {
            PPDeviceParametersNamHealthIdx namHealthIdx = (PPDeviceParametersNamHealthIdx)value.integerValue;
            switch (namHealthIdx) {
                case PPDeviceParametersNamHealthIdxHealthy:
                    returnString = NSLocalizedStringFromTableInBundle(@"Healthy", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coath stauts - Healthy");
                    break;
                case PPDeviceParametersNamHealthIdxFine:
                    returnString = NSLocalizedStringFromTableInBundle(@"Fine", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coath stauts - Fine");
                    break;
                case PPDeviceParametersNamHealthIdxFair:
                    returnString = NSLocalizedStringFromTableInBundle(@"Fair", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coath stauts - Fair");
                    break;
                case PPDeviceParametersNamHealthIdxPoor:
                    returnString = NSLocalizedStringFromTableInBundle(@"Poor", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coath stauts - Poor");
                    break;
                case PPDeviceParametersNamHealthIdxUnhealthy:
                    returnString = NSLocalizedStringFromTableInBundle(@"Unhealthy", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Netatmo Health Coath stauts - Unhealthy");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Recording", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Recording");
                    break;
                case PPDeviceParametersRecordStatusNotRecording:
                    returnString = NSLocalizedStringFromTableInBundle(@"Not recording", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Not recording");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Remote control enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Recording");
                    break;
                case PPDeviceParametersAccessCameraSettingsOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Remote control disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Remote control disabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Audio streaming enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Audio streaming enabled");
                    break;
                case PPDeviceParametersAudioStreamingOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Audio streaming disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Audio streaming disabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Video streaming enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Video streaming enabled");
                    break;
                case PPDeviceParametersVideoStreamingOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Video streaming disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Video streaming disabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"HD Status enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - HD Status enabled");
                    break;
                case PPDeviceParametersHDStatusOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"HD Status disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - HD Status disabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"As fast as possible", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - As fast as possible");
                    break;
                default:
                    rapidMotionStatusSeconds = (int)value.integerValue % 60;
                    rapidMotionStatusMinutes = (int)(value.integerValue / 60) % 60;
                    rapidMotionStatusHours = (int)value.integerValue / 3600;
                    
                    if(rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes == 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d hr", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} hours"), rapidMotionStatusHours];
                    } else if (rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes > 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes"), rapidMotionStatusMinutes];
                    } else {
                        returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min %d sec", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes {number} seconds"), rapidMotionStatusMinutes , rapidMotionStatusSeconds];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Charging", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Charging");
                    break;
                case PPDeviceParametersChargingFalse:
                    returnString = NSLocalizedStringFromTableInBundle(@"Not charging", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Not charging");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Detecting Motion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detecting Motion");
                    break;
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringFromTableInBundle(@"Not detecting motion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Not detecting motion");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Focusing", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Focusing");
                    break;
                default:
                    returnString = NSLocalizedStringFromTableInBundle(@"Focused", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Focused");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Detecting Audio", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detecting Audio");
                    break;
                case PPDeviceParametersAudioStatusNoAudio:
                    returnString = NSLocalizedStringFromTableInBundle(@"Not detecting audio", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Not detecting audio");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Rear camera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Rear camera");
                    break;
                case PPDeviceParametersSelectedCameraFront:
                    returnString = NSLocalizedStringFromTableInBundle(@"Front camera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Front camera");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d sec", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} seconds"), motionRecordSeconds];
            } else if (motionRecordSeconds == 0 && motionRecordMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes"), motionRecordMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min %d sec", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes {number} seconds"), motionRecordMinutes , motionRecordSeconds];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect tiny movements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect tiny movements");
                    break;
                case PPDeviceParametersMotionSensitiviySmall:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect small movements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect small movements");
                    break;
                case PPDeviceParametersMotionSensitiviyNormal:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect normal movements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect normal movements");
                    break;
                case PPDeviceParametersMotionSensitiviyLarge:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect large movements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect large movements");
                    break;
                case PPDeviceParametersMotionSensitiviyHuge:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect huge movements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect huge movements");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect tiny aounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect tiny sounds");
                    break;
                case PPDeviceParametersAudioSensitiviySmall:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect small sounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect small sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyNormal:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect normal sounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect normal sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyLarge:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect large sounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect large sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyHuge:
                    returnString = NSLocalizedStringFromTableInBundle(@"Detect huge sounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Detect huge sounds");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"No robot connected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - No robot connected");
                    break;
                case PPDeviceParametersRobotConnectedGalileo:
                    returnString = NSLocalizedStringFromTableInBundle(@"Galileo", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Galileo");
                    break;
                case PPDeviceParametersRobotConnectedKubi:
                    returnString = NSLocalizedStringFromTableInBundle(@"KUBI", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - KUBI");
                    break;
                case PPDeviceParametersRobotConnectedRomo:
                    returnString = NSLocalizedStringFromTableInBundle(@"Romo", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Romo");
                    break;
                case PPDeviceParametersRobotConnectedGalileoBT:
                    returnString = NSLocalizedStringFromTableInBundle(@"Galileo BT", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Galileo BT");
                    break;
                case PPDeviceParametersRobotConnected360:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%@ 360", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {AppName} 360"), [PPBaseModel appName:NO]];
                    break;
                case PPDeviceParametersRobotConnectedUnknown:
                    returnString = NSLocalizedStringFromTableInBundle(@"Unknown robot", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Unknown robot");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Hard Reset", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Hard Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusWarmReset:
                    returnString = NSLocalizedStringFromTableInBundle(@"Warm Reset", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Warm Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUART:
                    returnString = NSLocalizedStringFromTableInBundle(@"Reset UART", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Reset UART");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue:
                    returnString = NSLocalizedStringFromTableInBundle(@"Reset UART queue", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Reset UART queue");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard:
                    returnString = NSLocalizedStringFromTableInBundle(@"Reboot motor control board", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Reboot motor control board");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusReady:
                    returnString = NSLocalizedStringFromTableInBundle(@"Ready", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Ready");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Configure vantage point %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Configure vantage point {vantage point index}"), value];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Flip vertical", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Flip vertical");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter auto-sharing disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter auto-sharing disabled");
                    break;
                case PPDeviceParametersTwitterAutoShareOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter auto-sharing enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter auto-sharing enabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter reminder disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter reminder disabled");
                    break;
                case PPDeviceParametersTwitterReminderOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter reminder enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter reminder enabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter disabled");
                    break;
                case PPDeviceParametersTwitterStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Twitter enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Twitter enabled");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d sec", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} seconds"), motionCountDownSeconds];
            } else if (motionCountDownSeconds == 0 && motionCountDownMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes"), motionCountDownMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%d min %d sec", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - {number} minutes {number} seconds"), motionCountDownMinutes , motionCountDownSeconds];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Blackout disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Blackout disabled");
                    break;
                case PPDeviceParametersBlackoutScreenOnOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Blackout enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Blackout enabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Warning status disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Warning status disabled");
                    break;
                case PPDeviceParametersWarningStatusOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Warning status enabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Warning status enabled");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Stop recording after motion goes away", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Stop recording after motion goes away");
                    break;
                case PPDeviceParametersRecordFullDurationOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Continue recording even after motion goes away", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Continue recording even after motion goes away");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Flash on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Flash off");
                    break;
                case PPDeviceParametersFlashOnOff:
                case PPDeviceParametersFlashOnWasOn:
                    returnString = NSLocalizedStringFromTableInBundle(@"Flash off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Flash off");
                    break;
                case PPDeviceParametersFlashOnNoFlash:
                    returnString = NSLocalizedStringFromTableInBundle(@"No Flash", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - No Flash");
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Video calling not supported", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Video calling not supported");
                    break;
                case PPDeviceParametersSupportsVideoCallTrue:
                    returnString = NSLocalizedStringFromTableInBundle(@"Video calling supported", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Video calling supported");
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
                returnString = NSLocalizedStringFromTableInBundle(@"Camera speaker volume is muted.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Camera - Label describing this camera is muted");
            }
            else if (value.integerValue >= PPDeviceParametersOutputVolumeMax) {
                returnString = NSLocalizedStringFromTableInBundle(@"Camera speaker volume is maxed.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Camera - Label describing this camera's volume is maxed");
            }
            else {
                returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Camera speaker volume is at %.0f%%.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Camera speaker volume is at {number}{percent %}"),(float)(value.floatValue / PPDeviceParametersOutputVolumeMax) * 100];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Alarm is active", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm is active");
                    break;
                case PPDeviceParametersAlarmOff:
                    returnString = NSLocalizedStringFromTableInBundle(@"Alarm is off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm is off");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Alarm will beep %i times", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm will beep %@ times"), value];
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Alarm will beep %i times", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Alarm will beep %@ times"), value];
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
                    returnString = NSLocalizedStringFromTableInBundle(@"Sound alarm when motion is detected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Sound alarm when motion is detected");
                    break;
                case PPDeviceParametersAlarmOff:
                    
                    returnString = NSLocalizedStringFromTableInBundle(@"Disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Disabled");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = NSLocalizedStringFromTableInBundle(@"Beep 1 time when motion is detected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Beep 1 time when motion is detected");
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Beep %@ times when motion is detected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Beep 2 times when motion is detected"), value];
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
