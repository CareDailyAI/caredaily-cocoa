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
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"System Mode", @"Device Parameter - System Mode");
        }
        else {
            PPDeviceParametersSystemMode systemMode = (PPDeviceParametersSystemMode)value.integerValue;
            switch (systemMode) {
                case PPDeviceParametersSystemModeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersSystemModeAuto:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.auto", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Auto", @"Device Parameter - Auto");
                    break;
                case PPDeviceParametersSystemModeCool:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.cool", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Cool", @"Device Parameter - Cool");
                    break;
                case PPDeviceParametersSystemModeHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Heat", @"Device Parameter - Heat");
                    break;
                case PPDeviceParametersSystemModeEmergencyHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.emergencyheat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Emergency Heat", @"Device Parameter - Emergency Heat");
                    break;
                case PPDeviceParametersSystemModePrecooling:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.precooling", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Precooling", @"Device Parameter - Precooling");
                    break;
                case PPDeviceParametersSystemModeFanOnly:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.fanonly", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fan Only", @"Device Parameter - Fan Only");
                    break;
                case PPDeviceParametersSystemModeDry:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.dry", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Dry", @"Device Parameter - Dry");
                    break;
                case PPDeviceParametersSystemModeAuxiliaryHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.auxiliaryheat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Auxiliary Heat", @"Device Parameter - Auxiliary Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodevalues", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"System Mode Values", @"Device Parameter - System Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"System Mode Status", @"Device Parameter - System Mode Status");
        }
        else {
            PPDeviceParametersSystemModeStatus systemModeStatus = (PPDeviceParametersSystemModeStatus)value.integerValue;
            switch (systemModeStatus) {
                case PPDeviceParametersSystemModeStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersSystemModeStatusCool:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.cool", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Cool", @"Device Parameter - Cool");
                    break;
                case PPDeviceParametersSystemModeStatusHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.heat", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Heat", @"Device Parameter - Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fan Mode", @"Device Parameter - Fan Mode");
        }
        else {
            PPDeviceParametersFanMode fanMode = (PPDeviceParametersFanMode)value.integerValue;
            switch (fanMode) {
                case PPDeviceParametersFanModeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersFanModeLow:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.low", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Low", @"Device Parameter - Low");
                    break;
                case PPDeviceParametersFanModeMedium:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.medium", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Medium", @"Device Parameter - Medium");
                    break;
                case PPDeviceParametersFanModeHigh:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.high", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"High", @"Device Parameter - High");
                    break;
                case PPDeviceParametersFanModeOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"On", @"Device Parameter - On");
                    break;
                case PPDeviceParametersFanModeAuto:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.auto", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Auto", @"Device Parameter - Auto");
                    break;
                case PPDeviceParametersFanModeSmart:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.smart", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Smart", @"Device Parameter - Smart");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SWING_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Swing Mode", @"Device Parameter - Swing Mode");
        }
        else {
            PPDeviceParametersSwingMode swingMode = (PPDeviceParametersSwingMode)value.integerValue;
            switch (swingMode) {
                case PPDeviceParametersSwingModeStopped:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.stopped", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stopped", @"Device Parameter - Stopped");
                    break;
                case PPDeviceParametersSwingModeRangeFull:
                case PPDeviceParametersSwingModeRangeTop:
                case PPDeviceParametersSwingModeRangeMiddle:
                case PPDeviceParametersSwingModeRangeBottom:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.range", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Range", @"Device Parameter - Range");
                    break;
                case PPDeviceParametersSwingModeFixedTop:
                case PPDeviceParametersSwingModeFixedMiddleTop:
                case PPDeviceParametersSwingModeFixedMiddle:
                case PPDeviceParametersSwingModeFixedMiddleBottom:
                case PPDeviceParametersSwingModeFixedBottom:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.fixed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fixed", @"Device Parameter - Fixed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:STATE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"State", @"Device Parameter - State");
        }
        else {
            PPDeviceParametersState state = (PPDeviceParametersState)value.integerValue;
            switch (state) {
                case PPDeviceParametersStateOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersStateOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state.on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:CURRENT_LEVEL]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.brightness", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Brightness", @"Device Parameter - Brightness");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:OUTLET_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Outlet Status", @"Device Parameter - Outlet Status");
        }
        else {
            PPDeviceParametersOutletStatus outletStatus = (PPDeviceParametersOutletStatus)value.integerValue;
            switch (outletStatus) {
                case PPDeviceParametersOutletStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersOutletStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus.on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Power Status", @"Device Parameter - Power Status");
        }
        else {
            PPDeviceParametersPowerStatus powerStatus = (PPDeviceParametersPowerStatus)value.integerValue;
            switch (powerStatus) {
                case PPDeviceParametersPowerStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersPowerStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus.on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.power", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Power", @"Device Parameter - Power");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@ watts", value];
        }
    }
    else if([parameter isEqualToString:DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.temperature", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Temperature", @"Device Parameter - Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:INTERNAL_DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.internaltemperature", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Internal Temperature", @"Device Parameter - Internal Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:COOLING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.coolingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Cooling Setpoint", @"Device Parameter - Cooling Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:HEATING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.heatingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Heating Setpoint", @"Device Parameter - Heating Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RELATIVE_HUMIDITY]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.relativehumidity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Relative Humidity", @"Device Parameter - Relative Humidity");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:DOOR_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Door Status", @"Device Parameter - Door Status");
        }
        else {
            PPDeviceParametersDoorStatus doorStatus = (PPDeviceParametersDoorStatus)value.integerValue;
            switch (doorStatus) {
                case PPDeviceParametersDoorStatusClosed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus.closed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Closed", @"Detail Device Parameter - Closed");
                    break;
                case PPDeviceParametersDoorStatusOpen:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus.open", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Open", @"Detail Device Parameter - Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:VIBRATION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Vibration Status", @"Device Parameter - Vibration Status");
        }
        else {
            PPDeviceParametersVibrationStatus vibrationStatus = (PPDeviceParametersVibrationStatus)value.integerValue;
            switch (vibrationStatus) {
                case PPDeviceParametersVibrationStatusStill:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus.still", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Still", @"Detail Device Parameter - Still");
                    break;
                case PPDeviceParametersVibrationStatusMoved:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus.moved", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Moved", @"Detail Device Parameter - Moved");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:MOTION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Motion Status", @"Device Parameter - Motion Status");
        }
        else {
            PPDeviceParametersMotionStatus motionStatus = (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.nomotion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"No Motion", @"Detail Device Parameter - No Motion");
                    break;
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.motion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Motion", @"Detail Device Parameter - Motion");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WATER_LEAK]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Water Leak", @"Device Parameter - Water Leak");
        }
        else {
            PPDeviceParametersWaterLeak waterLeak = (PPDeviceParametersWaterLeak)value.integerValue;
            switch (waterLeak) {
                case PPDeviceParametersWaterLeakDry:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak.dry", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Dry", @"Detail Device Parameter - Dry");
                    break;
                case PPDeviceParametersWaterLeakWet:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak.wet", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Wet", @"Detail Device Parameter - Wet");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Lock Status", @"Device Parameter - Lock Status");
        }
        else {
            PPDeviceParametersLockStatus lockStatus = (PPDeviceParametersLockStatus)value.integerValue;
            switch (lockStatus) {
                case PPDeviceParametersLockStatusLocked:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus.locked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Locked", @"Detail Device Parameter - Locked");
                    break;
                case PPDeviceParametersLockStatusUnlocked:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus.unlocked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Unlocked", @"Detail Device Parameter - Unlocked");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS_ALARM]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Lock Status Alarm", @"Device Parameter - Lock Status Alarm");
        }
        else {
            PPDeviceParametersLockStatusAlarm lockStatusAlarm = (PPDeviceParametersLockStatusAlarm)value.integerValue;
            switch (lockStatusAlarm) {
                case PPDeviceParametersLockStatusAlarmOK:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.ok", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"OK", @"Detail Device Parameter - OK");
                    break;
                case PPDeviceParametersLockStatusAlarmDeadboltJammed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.deadboltjammed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Deadbolt Jammed", @"Detail Device Parameter - Deadbolt Jammed");
                    break;
                case PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.lockresettofactorydefaults", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Lock Reset to Factory Defaults", @"Detail Device Parameter - Lock Reset to Factory Defaults");
                    break;
                case PPDeviceParametersLockStatusAlarmRFModulePowerCycled:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.rfmodulepowercycled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"RF Module Power Cycled", @"Detail Device Parameter - RF Module Power Cycled");
                    break;
                case PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.wrongcodeentrylimit", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Wrong Code Entry Limit", @"Detail Device Parameter - Wrong Code Entry Limit");
                    break;
                case PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.frontescutcheonremoved", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Front Escutcheon Removed", @"Detail Device Parameter - Front Escutcheon Removed");
                    break;
                case PPDeviceParametersLockStatusAlarmDoorForcedOpen:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.doorforcedopen", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Door Forced Open", @"Detail Device Parameter - Door Forced Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BUTTON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Button Status", @"Device Parameter - Button Status");
        }
        else {
            PPDeviceParametersButtonStatus buttonStatus = (PPDeviceParametersButtonStatus)value.integerValue;
            switch (buttonStatus) {
                case PPDeviceParametersButtonStatusReleased:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus.released", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Released", @"Detail Device Parameter - Released");
                    break;
                case PPDeviceParametersButtonStatusPressed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus.pressed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Pressed", @"Detail Device Parameter - Pressed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ALARM_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Status", @"Device Parameter - Alarm Status");
        }
        else {
            PPDeviceParametersAlarmStatus alarmStatus = (PPDeviceParametersAlarmStatus)value.integerValue;
            switch (alarmStatus) {
                case PPDeviceParametersAlarmStatusInactive:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus.inactive", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Inactive", @"Detail Device Parameter - Inactive");
                    break;
                case PPDeviceParametersAlarmStatusActive:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus.active", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Active", @"Detail Device Parameter - Active");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_WARN]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Warn", @"Device Parameter - Alarm Warn");
        }
        else {
            if(deviceTypeId == PPDeviceTypeIdNone) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Warn", @"Device Parameter - Alarm Warn");
            }
            else if(deviceTypeId == PPDeviceTypeIdSmartenitSiren) {
                PPDeviceParametersAlarmWarnSmartenit alarmWarn = (PPDeviceParametersAlarmWarnSmartenit)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnSmartenitSecurityDrill:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.securitydrill", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Security Drill", @"Detail Device Parameter - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitStop:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.stopalarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stop alarm", @"Detail Device Parameter - Stop alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitBurglar:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.burglaralarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Burglar alarm", @"Detail Device Parameter - Burglar alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitFire:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.firealarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fire alarm", @"Detail Device Parameter - Fire alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitEmergency:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.emergencyalarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Emergency alarm", @"Detail Device Parameter - Emergency alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese1:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese1", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese1", @"Detail Device Parameter - Chinese1");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese2:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese2", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese2", @"Detail Device Parameter - Chinese2");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese3:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese3", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese3", @"Detail Device Parameter - Chinese3");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese4:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese4", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese4", @"Detail Device Parameter - Chinese4");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese5:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese5", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese5", @"Detail Device Parameter - Chinese5");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese6:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese6", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese6", @"Detail Device Parameter - Chinese6");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese7:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese7", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese7", @"Detail Device Parameter - Chinese7");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese8:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese8", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Chinese8", @"Detail Device Parameter - Chinese8");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickOnce:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.clickonce", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Click once", @"Detail Device Parameter - Click once");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickMulitple:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.mulitpleclicks", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Mulitple clicks", @"Detail Device Parameter - Multiple clicks");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitNoSound:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.nosound", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"No sound", @"Detail Device Parameter - No sound");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitDoorbell:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.doorbell", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Doorbell", @"Detail Device Parameter - Doorbell");
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
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.securitydrill", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Security Drill", @"Detail Device Parameter - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighAlarm:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.alarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm", @"Detail Device Parameter - Alarm");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDog:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.dog", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Dog", @"Detail Device Parameter - Dog");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWarning:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.warning", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Warning", @"Detail Device Parameter - Warning");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBling:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.bling", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Bling", @"Detail Device Parameter - Bling");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBird:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.bird", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Bird", @"Detail Device Parameter - Bird");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDroid:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.droid", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Droid", @"Detail Device Parameter - Droid");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighLock:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.lock", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Lock", @"Detail Device Parameter - Lock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighPhaser:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.phaser", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Phaser", @"Detail Device Parameter - Phaser");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDoorbel:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.doorbell", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Doorbell", @"Detail Device Parameter - Doorbell");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunCock:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.guncock", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"GunCock", @"Detail Device Parameter - GunCock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunShot:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.gunshot", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"GunShot", @"Detail Device Parameter - GunShot");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighSwitch:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.switch", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Switch", @"Detail Device Parameter - Switch");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighTrumpet:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.trumpet", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Trumpet", @"Detail Device Parameter - Trumpet");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWhistle:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.whistle", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Whistle", @"Detail Device Parameter - Whistle");
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
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.silence", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Silence", @"Detail Device Parameter - Silence");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBurglar:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.burglar", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Burglar", @"Detail Device Parameter - Burglar");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoFire:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.fire", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fire", @"Detail Device Parameter - Fire");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoEmergency:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.emergency", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Emergency", @"Detail Device Parameter - Emergency");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicP:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.p", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"PanicP", @"Detail Device Parameter - PanicP");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicF:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.f", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"PanicF", @"Detail Device Parameter - PanicF");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicE:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.e", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"PanicE", @"Detail Device Parameter - PanicE");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepbeepwelcome", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"BeepBeepWelcome", @"Detail Device Parameter - BeepBeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepWelcome:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepwelcome", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"BeepWelcome", @"Detail Device Parameter - BeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeep:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepbeep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"BeepBeep", @"Detail Device Parameter - BeepBeep");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeep:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Beep", @"Detail Device Parameter - Beep");
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
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Duration", @"Device Parameter - Alarm Duration");
        }
        else {
            PPDeviceParametersAlarmDuration alarmDuration = (PPDeviceParametersAlarmDuration)value.integerValue;
            switch (alarmDuration) {
                case PPDeviceParametersAlarmDurationStop:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.stop", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stop", @"Detail Device Parameter - Stop");
                    break;
                case PPDeviceParametersAlarmDurationOnce:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.playonce", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Play once", @"Detail Device Parameter - Play once");
                    break;
                    
                default:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.play.seconds.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Play for %@ seconds", @"Detail Device Parameter - Play for {n} seconds"), alarmDuration];
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_STROBE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Strobe", @"Device Parameter - Alarm Strobe");
        }
        else {
            PPDeviceParametersAlarmStrobe alarmStrobe = (PPDeviceParametersAlarmStrobe)value.integerValue;
            switch (alarmStrobe) {
                case PPDeviceParametersAlarmStrobeOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe.strobeon", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Strobe on", @"Detail Device Parameter - Strobe on");
                    break;
                case PPDeviceParametersAlarmStrobeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe.strobeoff", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Strobe off", @"Detail Device Parameter - Strobe off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_SQUAWK]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm Squawk", @"Device Parameter - Alarm Squawk");
        }
        else {
            PPDeviceParametersAlarmSquawk alarmSquawk = (PPDeviceParametersAlarmSquawk)value.integerValue;
            switch (alarmSquawk) {
                case PPDeviceParametersAlarmSquawkArmed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk.squawkarmed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Squawk armed", @"Detail Device Parameter - Squawk sarmed");
                    break;
                case PPDeviceParametersAlarmSquawkDisarmed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk.squawkdisarmed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Squawk disarmed", @"Detail Device Parameter - Squawk disarmed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"iBeacon Status", @"Device Parameter - iBeacon Status");
        }
        else {
            PPDeviceParametersIBeaconStatus iBeaconStatus = (PPDeviceParametersIBeaconStatus)value.integerValue;
            switch (iBeaconStatus) {
                case PPDeviceParametersIBeaconStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus.on", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"On", @"Device Parameter - On");
                    break;
                case PPDeviceParametersIBeaconStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus.off", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Off", @"Device Parameter - Off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_PROXIMITY]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"iBeacon Proximity", @"Device Parameter - iBeacon Proximity");
        }
        else {
            PPDeviceParametersIBeaconProximity iBeaconProximity = (PPDeviceParametersIBeaconProximity)value.integerValue;
            switch (iBeaconProximity) {
                case PPDeviceParametersIBeaconProximityUnknown:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.unknown", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Unknown", @"Device Parameter - Unknown");
                    break;
                case PPDeviceParametersIBeaconProximityImmediate:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.immediate", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Immediate", @"Device Parameter - Immediate");
                    break;
                case PPDeviceParametersIBeaconProximityNear:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.near", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Near", @"Device Parameter - Near");
                    break;
                case PPDeviceParametersIBeaconProximityFar:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.far", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Far", @"Device Parameter - Far");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"LintAlert Status", @"Device Parameter - LintAlert Status");
        }
        else {
            PPDeviceParametersSigStatus sigStatus = (PPDeviceParametersSigStatus)value.integerValue;
            switch (sigStatus) {
                case PPDeviceParametersSigStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus.dryeroff", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Dryer Off", @"Device Parameter - LintAlert Dryer Off");
                    break;
                case PPDeviceParametersSigStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus.dryeron", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Dryer On", @"Device Parameter - LintAlert Dryer On");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_CUR_MAX_LED]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"LintAlert Current LED", @"Device Parameter - LintAlert Current LED");
        }
        else {
            PPDeviceParametersSigCurMaxLed sigCurMaxLed = (PPDeviceParametersSigCurMaxLed)value.integerValue;
            if(sigCurMaxLed <= PPDeviceParametersSigCurMaxLedOK) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.ok", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"OK", @"Detail Device Parameter - LintAlert OK");
            }
            else if(sigCurMaxLed == PPDeviceParametersSigCurMaxLedWarning) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.warning", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Warning", @"Detail Device Parameter - LintAlert Warning");
            }
            else {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.blocked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Blocked", @"Detail Device Parameter - LintAlert Blocked");
            }
        }
    }
    else if([parameter isEqualToString:NAM_HEALTH_IDX]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Netatmo Health Coach Status", @"Device Parameter - Netatmo Health Coach Status");
        }
        else {
            PPDeviceParametersNamHealthIdx namHealthIdx = (PPDeviceParametersNamHealthIdx)value.integerValue;
            switch (namHealthIdx) {
                case PPDeviceParametersNamHealthIdxHealthy:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.healthy", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Healthy", @"Device Parameter - Netatmo Health Coath stauts - Healthy");
                    break;
                case PPDeviceParametersNamHealthIdxFine:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.fine", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fine", @"Device Parameter - Netatmo Health Coath stauts - Fine");
                    break;
                case PPDeviceParametersNamHealthIdxFair:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.fair", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fair", @"Device Parameter - Netatmo Health Coath stauts - Fair");
                    break;
                case PPDeviceParametersNamHealthIdxPoor:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.poor", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Poor", @"Device Parameter - Netatmo Health Coath stauts - Poor");
                    break;
                case PPDeviceParametersNamHealthIdxUnhealthy:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.unhealthy", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Unhealthy", @"Device Parameter - Netatmo Health Coath stauts - Unhealthy");
                    break;
                    
                default:
                    return @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE_SEQUENCE]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.fanmodesequence", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fan Mode Sequence", @"Device Parameter - Fan Mode Sequence");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FAN_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.fanmodevalues", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Fan Mode Values", @"Device Parameter - Fan Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_COOLING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.mincoolingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Minimum Cooling Setpoint", @"Device Parameter - Minimum Cooling Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_COOLING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.maxcoolingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Maximum Cooling Setpoint", @"Device Parameter - Maximum Cooling Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_HEATING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.minheatingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Minimum Heating Setpoint", @"Device Parameter - Minimum Heating Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_HEATING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.maxheatingsetpoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Maximum Heating Setpoint", @"Device Parameter - Maximum Heating Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:TEMP_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.tempvalues", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Temperature Values", @"Device Parameter - Temperature Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SWING_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.swingmodevalues", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Swing Mode Values", @"Device Parameter - Swing Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RECORD_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Record Status", @"Device Parameter - Record Status");
        }
        else {
            PPDeviceParametersRecordStatus recordStatus = (PPDeviceParametersRecordStatus)value.integerValue;
            switch (recordStatus) {
                case PPDeviceParametersRecordStatusRecording:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus.recording", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Recording", @"Device Parameter - Recording");
                    break;
                case PPDeviceParametersRecordStatusNotRecording:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus.notrecording", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Not recording", @"Device Parameter - Not recording");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ACCESS_CAMERA_SETTINGS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Access Camera Settings", @"Device Parameter - Access Camera Settings");
        }
        else {
            
            PPDeviceParametersAccessCameraSettings accessCameraSettings = (PPDeviceParametersAccessCameraSettings)value.integerValue;
            switch (accessCameraSettings) {
                case PPDeviceParametersAccessCameraSettingsOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings.remotecontrolenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Remote control enabled", @"Device Parameter - Remote control enabled");
                    break;
                case PPDeviceParametersAccessCameraSettingsOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings.remotecontroldisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Remote control disabled", @"Device Parameter - Remote control disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_STREAMING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Audio Streaming", @"Device Parameter - Audio Streaming");
        }
        else {
            
            PPDeviceParametersAudioStreaming audioStreaming = (PPDeviceParametersAudioStreaming)value.integerValue;
            switch (audioStreaming) {
                case PPDeviceParametersAudioStreamingOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming.audiostreamingenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Audio streaming enabled", @"Device Parameter - Audio streaming enabled");
                    break;
                case PPDeviceParametersAudioStreamingOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming.audiostreamingdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Audio streaming disabled", @"Device Parameter - Audio streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VIDEO_STREAMING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Video Streaming", @"Device Parameter - Video Streaming");
        }
        else {
            
            PPDeviceParametersVideoStreaming videoStreaming = (PPDeviceParametersVideoStreaming)value.integerValue;
            switch (videoStreaming) {
                case PPDeviceParametersVideoStreamingOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming.videostreamingenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Video streaming enabled", @"Device Parameter - Video streaming enabled");
                    break;
                case PPDeviceParametersVideoStreamingOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming.videostreamingdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Video streaming disabled", @"Device Parameter - Video streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:HD_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"HD Status", @"Device Parameter - HD Status");
        }
        else {
            
            PPDeviceParametersHDStatus HDStatus = (PPDeviceParametersHDStatus)value.integerValue;
            switch (HDStatus) {
                case PPDeviceParametersHDStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus.hdstatusenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"HD Status enabled", @"Device Parameter - HD Status enabled");
                    break;
                case PPDeviceParametersHDStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus.hdstatusdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"HD Status disabled", @"Device Parameter - HD Status disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RAPID_MOTION_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Rapid Motion Status", @"Device Parameter - Rapid Motion Status");
        }
        else {
            
            PPDeviceParametersRapidMotionStatus rapidMotionStatus = (PPDeviceParametersRapidMotionStatus)value.integerValue;
            
            int rapidMotionStatusSeconds = 0;
            int rapidMotionStatusMinutes = 0;
            int rapidMotionStatusHours = 0;
            
            switch (rapidMotionStatus) {
                case PPDeviceParametersRapidMotionStatusMinProVideo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.asfastaspossible", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"As fast as possible", @"Device Parameter - As fast as possible");
                    break;
                default:
                    rapidMotionStatusSeconds = (int)value.integerValue % 60;
                    rapidMotionStatusMinutes = (int)(value.integerValue / 60) % 60;
                    rapidMotionStatusHours = (int)value.integerValue / 3600;
                    
                    if(rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes == 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.hours", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d hr", @"Device Parameter - {number} hours"), rapidMotionStatusHours];
                    } else if (rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes > 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.minutes", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min", @"Device Parameter - {number} minutes"), rapidMotionStatusMinutes];
                    } else {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.minutes_seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), rapidMotionStatusMinutes , rapidMotionStatusSeconds];
                    }
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BATTERY_LEVEL]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.batterylevel", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Battery Level", @"Device Parameter - Battery Level");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:CHARGING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.charging", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Charging", @"Device Parameter - Charging");
        }
        else {
            
            PPDeviceParametersCharging charging = (PPDeviceParametersCharging)value.integerValue;
            switch (charging) {
                case PPDeviceParametersChargingTrue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.charging.charging", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Charging", @"Device Parameter - Charging");
                    break;
                case PPDeviceParametersChargingFalse:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.charging.notcharging", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Not charging", @"Device Parameter - Not charging");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:MOTION_DETECTION_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Motion Status", @"Device Parameter - Motion Status");
        }
        else {
            
            PPDeviceParametersMotionStatus motionStatus= (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.detectingmotion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detecting Motion", @"Device Parameter - Detecting Motion");
                    break;
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.notdetectingmotion", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Not Detecting Motion", @"Device Parameter - Not Detecting Motion");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUTO_FOCUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Auto Focus", @"Device Parameter - Auto Focus");
        }
        else {
            
            PPDeviceParametersAutoFocus autoFocus = (PPDeviceParametersAutoFocus)value.integerValue;
            switch (autoFocus) {
                case PPDeviceParametersAutoFocusShouldFocus:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus.focusing", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Focusing", @"Device Parameter - Focusing");
                    break;
                default:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus.focused", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Focused", @"Device Parameter - Focused");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter._.Detecting Audio", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detecting Audio", @"Device Parameter - Detecting Audio");
                    break;
                case PPDeviceParametersAudioStatusNoAudio:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter._.Not detecting audio", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Not detecting audio", @"Device Parameter - Not detecting audio");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SELECTED_CAMERA]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Selected Camera", @"Device Parameter - Selected Camera");
        }
        else {
            
            PPDeviceParametersSelectedCamera selectedCamera = (PPDeviceParametersSelectedCamera)value.integerValue;
            switch (selectedCamera) {
                case PPDeviceParametersSelectedCameraRearOnly:
                case PPDeviceParametersSelectedCameraRear:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera.rearcamera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Rear camera", @"Device Parameter - Rear camera");
                    break;
                case PPDeviceParametersSelectedCameraFront:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera.frontcamera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Front camera", @"Device Parameter - Front camera");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RECORD_SECONDS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Record Seconds", @"Device Parameter - Record Seconds");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d sec", @"Device Parameter - {number} seconds"), motionRecordSeconds];
            } else if (motionRecordSeconds == 0 && motionRecordMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.minutes", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min", @"Device Parameter - {number} minutes"), motionRecordMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.minutes_seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), motionRecordMinutes , motionRecordSeconds];
            }
        }
    }
    else if([parameter isEqualToString:MOTION_SENSITIVITY]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Motion Sensitivity", @"Device Parameter - Motion Sensitivity");
        }
        else {
            
            PPDeviceParametersMotionSensitiviy motionSensitivity = (PPDeviceParametersMotionSensitiviy)value.integerValue;
            switch (motionSensitivity) {
                case PPDeviceParametersMotionSensitiviyTiny:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detecttinymovements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect tiny movements", @"Device Parameter - Detect tiny movements");
                    break;
                case PPDeviceParametersMotionSensitiviySmall:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectsmallmovements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect small movements", @"Device Parameter - Detect small movements");
                    break;
                case PPDeviceParametersMotionSensitiviyNormal:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectnormalmovements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect normal movements", @"Device Parameter - Detect normal movements");
                    break;
                case PPDeviceParametersMotionSensitiviyLarge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectlargemovements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect large movements", @"Device Parameter - Detect large movements");
                    break;
                case PPDeviceParametersMotionSensitiviyHuge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detecthugemovements", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect huge movements", @"Device Parameter - Detect huge movements");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_SENSITIVITY]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Audio Sensitivity", @"Device Parameter - Audio Sensitivity");
        }
        else {
            
            PPDeviceParametersAudioSensitiviy audioSensitivity = (PPDeviceParametersAudioSensitiviy)value.integerValue;
            switch (audioSensitivity) {
                case PPDeviceParametersAudioSensitiviyTiny:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detecttinysounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect tiny sounds", @"Device Parameter - Detect tiny sounds");
                    break;
                case PPDeviceParametersAudioSensitiviySmall:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectsmallsounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect small sounds", @"Device Parameter - Detect small sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyNormal:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectnormalsounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect normal sounds", @"Device Parameter - Detect normal sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyLarge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectlargesounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect large sounds", @"Device Parameter - Detect large sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyHuge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detecthugesounds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Detect huge sounds", @"Device Parameter - Detect huge sounds");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VERSION]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.version", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Version", @"Device Parameter - Version");
        }
        else {
            returnString =  value;
        }
    }
    else if([parameter isEqualToString:ROBOT_CONNECTED]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Robot Connected", @"Device Parameter - Robot Connected");
        }
        else {
            
            PPDeviceParametersRobotConnected robotConnected = (PPDeviceParametersRobotConnected)value.integerValue;
            switch (robotConnected) {
                case PPDeviceParametersRobotConnectedNone:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.norobotconnected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"No robot connected", @"Device Parameter - No robot connected");
                    break;
                case PPDeviceParametersRobotConnectedGalileo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.galileo", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Galileo", @"Device Parameter - Galileo");
                    break;
                case PPDeviceParametersRobotConnectedKubi:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.kubi", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"KUBI", @"Device Parameter - KUBI");
                    break;
                case PPDeviceParametersRobotConnectedRomo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.romo", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Romo", @"Device Parameter - Romo");
                    break;
                case PPDeviceParametersRobotConnectedGalileoBT:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.galileobt", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Galileo BT", @"Device Parameter - Galileo BT");
                    break;
                case PPDeviceParametersRobotConnected360:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.presence360", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%@ 360", @"Device Parameter - {AppName} 360"), [PPBaseModel appName:NO]];
                    break;
                case PPDeviceParametersRobotConnectedUnknown:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.unknownrobot", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Unknown robot", @"Device Parameter - Unknown robot");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.hardreset", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Hard Reset", @"Device Parameter - Hard Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusWarmReset:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.warmreset", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Warm Reset", @"Device Parameter - Warm Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUART:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.resetuart", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Reset UART", @"Device Parameter - Reset UART");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.resetuardqueue", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Reset UART queue", @"Device Parameter - Reset UART queue");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.rebootmotorcontrolboard", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Reboot motor control board", @"Device Parameter - Reboot motor control board");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusReady:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.ready", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Ready", @"Device Parameter - Ready");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.configurevantagepoint", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Configure vantage point %@", @"Device Parameter - Configure vantage point {vantage point index}"), value];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotorientation.flipvertical", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Flip vertical", @"Device Parameter - Flip vertical");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterautoshare.twitterautosharingdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter auto-sharing disabled", @"Device Parameter - Twitter auto-sharing disabled");
                    break;
                case PPDeviceParametersTwitterAutoShareOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterautoshare.twitterautosharingenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter auto-sharing enabled", @"Device Parameter - Twitter auto-sharing enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterreminder.twitterreminderdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter reminder disabled", @"Device Parameter - Twitter reminder disabled");
                    break;
                case PPDeviceParametersTwitterReminderOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterreminder.twitterreminderenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter reminder enabled", @"Device Parameter - Twitter reminder enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterstatus.twitterdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter disabled", @"Device Parameter - Twitter disabled");
                    break;
                case PPDeviceParametersTwitterStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterstatus.twitterenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Twitter enabled", @"Device Parameter - Twitter enabled");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d sec", @"Device Parameter - {number} seconds"), motionCountDownSeconds];
            } else if (motionCountDownSeconds == 0 && motionCountDownMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.minutes", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min", @"Device Parameter - {number} minutes"), motionCountDownMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.minutes_seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), motionCountDownMinutes , motionCountDownSeconds];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.blackoutscreenon.blackoutdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Blackout disabled", @"Device Parameter - Blackout disabled");
                    break;
                case PPDeviceParametersBlackoutScreenOnOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.blackoutscreenon.blackoutenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Blackout enabled", @"Device Parameter - Blackout enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.warningstatus.warningstatusdisabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Warning status disabled", @"Device Parameter - Warning status disabled");
                    break;
                case PPDeviceParametersWarningStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.warningstatus.warningstatusenabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Warning status enabled", @"Device Parameter - Warning status enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordfullduration.stop", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stop recording after motion goes away", @"Device Parameter - Stop recording after motion goes away");
                    break;
                case PPDeviceParametersRecordFullDurationOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordfullduration.continue", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Continue recording even after motion goes away", @"Device Parameter - Continue recording even after motion goes away");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.flashon", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Flash on", @"Device Parameter - Flash on");
                    break;
                case PPDeviceParametersFlashOnOff:
                case PPDeviceParametersFlashOnWasOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.flashoff", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Flash off", @"Device Parameter - Flash off");
                    break;
                case PPDeviceParametersFlashOnNoFlash:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.noflash", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"No Flash", @"Device Parameter - No Flash");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.supportsvideocall.videocallingnotsupported", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Video calling not supported", @"Device Parameter - Video calling not supported");
                    break;
                case PPDeviceParametersSupportsVideoCallTrue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.supportsvideocall.videocallingsupported", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Video calling supported", @"Device Parameter - Video calling supported");
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
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumemuted", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Camera speaker volume is muted.", @"Camera - Label describing this camera is muted");
            }
            else if (value.integerValue >= PPDeviceParametersOutputVolumeMax) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumemaxed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Camera speaker volume is maxed.", @"Camera - Label describing this camera's volume is maxed");
            }
            else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumelevel", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Camera speaker volume is at %.0f%%.", @"Device Parameter - Camera speaker volume is at {number}{percent %}"),(float)(value.floatValue / PPDeviceParametersOutputVolumeMax) * 100];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmisactive", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm is active", @"Device Parameter - Alarm is active");
                    break;
                case PPDeviceParametersAlarmOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmisoff", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm is off", @"Device Parameter - Alarm is off");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmwillbeep.count", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm will beep %@ times", @"Device Parameter - Alarm will beep %@ times"), value];
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmwillbeep.count", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Alarm will beep %@ times", @"Device Parameter - Alarm will beep %@ times"), value];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.soundalarm", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Sound alarm when motion is detected", @"Device Parameter - Sound alarm when motion is detected");
                    break;
                case PPDeviceParametersAlarmOff:
                    
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.disabled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Disabled", @"Device Parameter - Disabled");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.beep.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Beep 1 time when motion is detected", @"Device Parameter - Beep 1 time when motion is detected");
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.beep.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Beep %@ times when motion is detected", @"Device Parameter - Beep 2 times when motion is detected"), value];
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
