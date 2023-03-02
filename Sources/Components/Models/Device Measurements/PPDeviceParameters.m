//
//  PPDeviceParameters.m
//  Peoplepower
//
//  Created by Destry Teeter on 2/27/18.
//  Copyright © 2023 People Power Company. All rights reserved.
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
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode", nil, [PPBaseModel bundle], @"System Mode", @"Device Parameter - System Mode");
        }
        else {
            PPDeviceParametersSystemMode systemMode = (PPDeviceParametersSystemMode)value.integerValue;
            switch (systemMode) {
                case PPDeviceParametersSystemModeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersSystemModeAuto:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.auto", nil, [PPBaseModel bundle], @"Auto", @"Device Parameter - Auto");
                    break;
                case PPDeviceParametersSystemModeCool:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.cool", nil, [PPBaseModel bundle], @"Cool", @"Device Parameter - Cool");
                    break;
                case PPDeviceParametersSystemModeHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.heat", nil, [PPBaseModel bundle], @"Heat", @"Device Parameter - Heat");
                    break;
                case PPDeviceParametersSystemModeEmergencyHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.emergencyheat", nil, [PPBaseModel bundle], @"Emergency Heat", @"Device Parameter - Emergency Heat");
                    break;
                case PPDeviceParametersSystemModePrecooling:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.precooling", nil, [PPBaseModel bundle], @"Precooling", @"Device Parameter - Precooling");
                    break;
                case PPDeviceParametersSystemModeFanOnly:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.fanonly", nil, [PPBaseModel bundle], @"Fan Only", @"Device Parameter - Fan Only");
                    break;
                case PPDeviceParametersSystemModeDry:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.dry", nil, [PPBaseModel bundle], @"Dry", @"Device Parameter - Dry");
                    break;
                case PPDeviceParametersSystemModeAuxiliaryHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmode.auxiliaryheat", nil, [PPBaseModel bundle], @"Auxiliary Heat", @"Device Parameter - Auxiliary Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodevalues", nil, [PPBaseModel bundle], @"System Mode Values", @"Device Parameter - System Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SYSTEM_MODE_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus", nil, [PPBaseModel bundle], @"System Mode Status", @"Device Parameter - System Mode Status");
        }
        else {
            PPDeviceParametersSystemModeStatus systemModeStatus = (PPDeviceParametersSystemModeStatus)value.integerValue;
            switch (systemModeStatus) {
                case PPDeviceParametersSystemModeStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersSystemModeStatusCool:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.cool", nil, [PPBaseModel bundle], @"Cool", @"Device Parameter - Cool");
                    break;
                case PPDeviceParametersSystemModeStatusHeat:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.systemmodestatus.heat", nil, [PPBaseModel bundle], @"Heat", @"Device Parameter - Heat");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode", nil, [PPBaseModel bundle], @"Fan Mode", @"Device Parameter - Fan Mode");
        }
        else {
            PPDeviceParametersFanMode fanMode = (PPDeviceParametersFanMode)value.integerValue;
            switch (fanMode) {
                case PPDeviceParametersFanModeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersFanModeLow:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.low", nil, [PPBaseModel bundle], @"Low", @"Device Parameter - Low");
                    break;
                case PPDeviceParametersFanModeMedium:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.medium", nil, [PPBaseModel bundle], @"Medium", @"Device Parameter - Medium");
                    break;
                case PPDeviceParametersFanModeHigh:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.high", nil, [PPBaseModel bundle], @"High", @"Device Parameter - High");
                    break;
                case PPDeviceParametersFanModeOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.on", nil, [PPBaseModel bundle], @"On", @"Device Parameter - On");
                    break;
                case PPDeviceParametersFanModeAuto:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.auto", nil, [PPBaseModel bundle], @"Auto", @"Device Parameter - Auto");
                    break;
                case PPDeviceParametersFanModeSmart:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.fanmode.smart", nil, [PPBaseModel bundle], @"Smart", @"Device Parameter - Smart");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SWING_MODE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode", nil, [PPBaseModel bundle], @"Swing Mode", @"Device Parameter - Swing Mode");
        }
        else {
            PPDeviceParametersSwingMode swingMode = (PPDeviceParametersSwingMode)value.integerValue;
            switch (swingMode) {
                case PPDeviceParametersSwingModeStopped:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.stopped", nil, [PPBaseModel bundle], @"Stopped", @"Device Parameter - Stopped");
                    break;
                case PPDeviceParametersSwingModeRangeFull:
                case PPDeviceParametersSwingModeRangeTop:
                case PPDeviceParametersSwingModeRangeMiddle:
                case PPDeviceParametersSwingModeRangeBottom:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.range", nil, [PPBaseModel bundle], @"Range", @"Device Parameter - Range");
                    break;
                case PPDeviceParametersSwingModeFixedTop:
                case PPDeviceParametersSwingModeFixedMiddleTop:
                case PPDeviceParametersSwingModeFixedMiddle:
                case PPDeviceParametersSwingModeFixedMiddleBottom:
                case PPDeviceParametersSwingModeFixedBottom:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.swingmode.fixed", nil, [PPBaseModel bundle], @"Fixed", @"Device Parameter - Fixed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:STATE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state", nil, [PPBaseModel bundle], @"State", @"Device Parameter - State");
        }
        else {
            PPDeviceParametersState state = (PPDeviceParametersState)value.integerValue;
            switch (state) {
                case PPDeviceParametersStateOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersStateOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.state.on", nil, [PPBaseModel bundle], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:CURRENT_LEVEL]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.brightness", nil, [PPBaseModel bundle], @"Brightness", @"Device Parameter - Brightness");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:OUTLET_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus", nil, [PPBaseModel bundle], @"Outlet Status", @"Device Parameter - Outlet Status");
        }
        else {
            PPDeviceParametersOutletStatus outletStatus = (PPDeviceParametersOutletStatus)value.integerValue;
            switch (outletStatus) {
                case PPDeviceParametersOutletStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersOutletStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outletstatus.on", nil, [PPBaseModel bundle], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus", nil, [PPBaseModel bundle], @"Power Status", @"Device Parameter - Power Status");
        }
        else {
            PPDeviceParametersPowerStatus powerStatus = (PPDeviceParametersPowerStatus)value.integerValue;
            switch (powerStatus) {
                case PPDeviceParametersPowerStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                case PPDeviceParametersPowerStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.powerstatus.on", nil, [PPBaseModel bundle], @"On", @"Device Parameter - On");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:POWER]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.power", nil, [PPBaseModel bundle], @"Power", @"Device Parameter - Power");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@ watts", value];
        }
    }
    else if([parameter isEqualToString:DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.temperature", nil, [PPBaseModel bundle], @"Temperature", @"Device Parameter - Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:INTERNAL_DEG_C]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.internaltemperature", nil, [PPBaseModel bundle], @"Internal Temperature", @"Device Parameter - Internal Temperature");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:COOLING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.coolingsetpoint", nil, [PPBaseModel bundle], @"Cooling Setpoint", @"Device Parameter - Cooling Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:HEATING_SETPOINT]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.heatingsetpoint", nil, [PPBaseModel bundle], @"Heating Setpoint", @"Device Parameter - Heating Setpoint");
        }
        else {
            // Allow controllers to handle setting temperature information
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RELATIVE_HUMIDITY]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.relativehumidity", nil, [PPBaseModel bundle], @"Relative Humidity", @"Device Parameter - Relative Humidity");
        }
        else {
            returnString = [NSString stringWithFormat:@"%@%%", value];
        }
    }
    else if([parameter isEqualToString:DOOR_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus", nil, [PPBaseModel bundle], @"Door Status", @"Device Parameter - Door Status");
        }
        else {
            PPDeviceParametersDoorStatus doorStatus = (PPDeviceParametersDoorStatus)value.integerValue;
            switch (doorStatus) {
                case PPDeviceParametersDoorStatusClosed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus.closed", nil, [PPBaseModel bundle], @"Closed", @"Detail Device Parameter - Closed");
                    break;
                case PPDeviceParametersDoorStatusOpen:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.doorstatus.open", nil, [PPBaseModel bundle], @"Open", @"Detail Device Parameter - Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:VIBRATION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus", nil, [PPBaseModel bundle], @"Vibration Status", @"Device Parameter - Vibration Status");
        }
        else {
            PPDeviceParametersVibrationStatus vibrationStatus = (PPDeviceParametersVibrationStatus)value.integerValue;
            switch (vibrationStatus) {
                case PPDeviceParametersVibrationStatusStill:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus.still", nil, [PPBaseModel bundle], @"Still", @"Detail Device Parameter - Still");
                    break;
                case PPDeviceParametersVibrationStatusMoved:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.vibrationstatus.moved", nil, [PPBaseModel bundle], @"Moved", @"Detail Device Parameter - Moved");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:MOTION_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus", nil, [PPBaseModel bundle], @"Motion Status", @"Device Parameter - Motion Status");
        }
        else {
            PPDeviceParametersMotionStatus motionStatus = (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.nomotion", nil, [PPBaseModel bundle], @"No Motion", @"Detail Device Parameter - No Motion");
                    break;
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.motion", nil, [PPBaseModel bundle], @"Motion", @"Detail Device Parameter - Motion");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:WATER_LEAK]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak", nil, [PPBaseModel bundle], @"Water Leak", @"Device Parameter - Water Leak");
        }
        else {
            PPDeviceParametersWaterLeak waterLeak = (PPDeviceParametersWaterLeak)value.integerValue;
            switch (waterLeak) {
                case PPDeviceParametersWaterLeakDry:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak.dry", nil, [PPBaseModel bundle], @"Dry", @"Detail Device Parameter - Dry");
                    break;
                case PPDeviceParametersWaterLeakWet:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.waterleak.wet", nil, [PPBaseModel bundle], @"Wet", @"Detail Device Parameter - Wet");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus", nil, [PPBaseModel bundle], @"Lock Status", @"Device Parameter - Lock Status");
        }
        else {
            PPDeviceParametersLockStatus lockStatus = (PPDeviceParametersLockStatus)value.integerValue;
            switch (lockStatus) {
                case PPDeviceParametersLockStatusLocked:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus.locked", nil, [PPBaseModel bundle], @"Locked", @"Detail Device Parameter - Locked");
                    break;
                case PPDeviceParametersLockStatusUnlocked:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatus.unlocked", nil, [PPBaseModel bundle], @"Unlocked", @"Detail Device Parameter - Unlocked");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:LOCK_STATUS_ALARM]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm", nil, [PPBaseModel bundle], @"Lock Status Alarm", @"Device Parameter - Lock Status Alarm");
        }
        else {
            PPDeviceParametersLockStatusAlarm lockStatusAlarm = (PPDeviceParametersLockStatusAlarm)value.integerValue;
            switch (lockStatusAlarm) {
                case PPDeviceParametersLockStatusAlarmOK:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.ok", nil, [PPBaseModel bundle], @"OK", @"Detail Device Parameter - OK");
                    break;
                case PPDeviceParametersLockStatusAlarmDeadboltJammed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.deadboltjammed", nil, [PPBaseModel bundle], @"Deadbolt Jammed", @"Detail Device Parameter - Deadbolt Jammed");
                    break;
                case PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.lockresettofactorydefaults", nil, [PPBaseModel bundle], @"Lock Reset to Factory Defaults", @"Detail Device Parameter - Lock Reset to Factory Defaults");
                    break;
                case PPDeviceParametersLockStatusAlarmRFModulePowerCycled:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.rfmodulepowercycled", nil, [PPBaseModel bundle], @"RF Module Power Cycled", @"Detail Device Parameter - RF Module Power Cycled");
                    break;
                case PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.wrongcodeentrylimit", nil, [PPBaseModel bundle], @"Wrong Code Entry Limit", @"Detail Device Parameter - Wrong Code Entry Limit");
                    break;
                case PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.frontescutcheonremoved", nil, [PPBaseModel bundle], @"Front Escutcheon Removed", @"Detail Device Parameter - Front Escutcheon Removed");
                    break;
                case PPDeviceParametersLockStatusAlarmDoorForcedOpen:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lockstatusalarm.doorforcedopen", nil, [PPBaseModel bundle], @"Door Forced Open", @"Detail Device Parameter - Door Forced Open");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BUTTON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus", nil, [PPBaseModel bundle], @"Button Status", @"Device Parameter - Button Status");
        }
        else {
            PPDeviceParametersButtonStatus buttonStatus = (PPDeviceParametersButtonStatus)value.integerValue;
            switch (buttonStatus) {
                case PPDeviceParametersButtonStatusReleased:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus.released", nil, [PPBaseModel bundle], @"Released", @"Detail Device Parameter - Released");
                    break;
                case PPDeviceParametersButtonStatusPressed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.buttonstatus.pressed", nil, [PPBaseModel bundle], @"Pressed", @"Detail Device Parameter - Pressed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ALARM_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus", nil, [PPBaseModel bundle], @"Alarm Status", @"Device Parameter - Alarm Status");
        }
        else {
            PPDeviceParametersAlarmStatus alarmStatus = (PPDeviceParametersAlarmStatus)value.integerValue;
            switch (alarmStatus) {
                case PPDeviceParametersAlarmStatusInactive:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus.inactive", nil, [PPBaseModel bundle], @"Inactive", @"Detail Device Parameter - Inactive");
                    break;
                case PPDeviceParametersAlarmStatusActive:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstatus.active", nil, [PPBaseModel bundle], @"Active", @"Detail Device Parameter - Active");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_WARN]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn", nil, [PPBaseModel bundle], @"Alarm Warn", @"Device Parameter - Alarm Warn");
        }
        else {
            if(deviceTypeId == PPDeviceTypeIdNone) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn", nil, [PPBaseModel bundle], @"Alarm Warn", @"Device Parameter - Alarm Warn");
            }
            else if(deviceTypeId == PPDeviceTypeIdSmartenitSiren) {
                PPDeviceParametersAlarmWarnSmartenit alarmWarn = (PPDeviceParametersAlarmWarnSmartenit)value.integerValue;
                switch (alarmWarn) {
                    case PPDeviceParametersAlarmWarnSmartenitSecurityDrill:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.securitydrill", nil, [PPBaseModel bundle], @"Security Drill", @"Detail Device Parameter - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitStop:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.stopalarm", nil, [PPBaseModel bundle], @"Stop alarm", @"Detail Device Parameter - Stop alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitBurglar:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.burglaralarm", nil, [PPBaseModel bundle], @"Burglar alarm", @"Detail Device Parameter - Burglar alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitFire:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.firealarm", nil, [PPBaseModel bundle], @"Fire alarm", @"Detail Device Parameter - Fire alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitEmergency:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.emergencyalarm", nil, [PPBaseModel bundle], @"Emergency alarm", @"Detail Device Parameter - Emergency alarm");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese1:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese1", nil, [PPBaseModel bundle], @"Chinese1", @"Detail Device Parameter - Chinese1");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese2:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese2", nil, [PPBaseModel bundle], @"Chinese2", @"Detail Device Parameter - Chinese2");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese3:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese3", nil, [PPBaseModel bundle], @"Chinese3", @"Detail Device Parameter - Chinese3");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese4:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese4", nil, [PPBaseModel bundle], @"Chinese4", @"Detail Device Parameter - Chinese4");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese5:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese5", nil, [PPBaseModel bundle], @"Chinese5", @"Detail Device Parameter - Chinese5");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese6:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese6", nil, [PPBaseModel bundle], @"Chinese6", @"Detail Device Parameter - Chinese6");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese7:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese7", nil, [PPBaseModel bundle], @"Chinese7", @"Detail Device Parameter - Chinese7");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitChinese8:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.chinese8", nil, [PPBaseModel bundle], @"Chinese8", @"Detail Device Parameter - Chinese8");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickOnce:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.clickonce", nil, [PPBaseModel bundle], @"Click once", @"Detail Device Parameter - Click once");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitClickMulitple:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.mulitpleclicks", nil, [PPBaseModel bundle], @"Mulitple clicks", @"Detail Device Parameter - Multiple clicks");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitNoSound:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.nosound", nil, [PPBaseModel bundle], @"No sound", @"Detail Device Parameter - No sound");
                        break;
                    case PPDeviceParametersAlarmWarnSmartenitDoorbell:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.smartenit.doorbell", nil, [PPBaseModel bundle], @"Doorbell", @"Detail Device Parameter - Doorbell");
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
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.securitydrill", nil, [PPBaseModel bundle], @"Security Drill", @"Detail Device Parameter - Security Drill");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighAlarm:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.alarm", nil, [PPBaseModel bundle], @"Alarm", @"Detail Device Parameter - Alarm");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDog:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.dog", nil, [PPBaseModel bundle], @"Dog", @"Detail Device Parameter - Dog");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWarning:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.warning", nil, [PPBaseModel bundle], @"Warning", @"Detail Device Parameter - Warning");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBling:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.bling", nil, [PPBaseModel bundle], @"Bling", @"Detail Device Parameter - Bling");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighBird:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.bird", nil, [PPBaseModel bundle], @"Bird", @"Detail Device Parameter - Bird");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDroid:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.droid", nil, [PPBaseModel bundle], @"Droid", @"Detail Device Parameter - Droid");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighLock:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.lock", nil, [PPBaseModel bundle], @"Lock", @"Detail Device Parameter - Lock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighPhaser:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.phaser", nil, [PPBaseModel bundle], @"Phaser", @"Detail Device Parameter - Phaser");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighDoorbel:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.doorbell", nil, [PPBaseModel bundle], @"Doorbell", @"Detail Device Parameter - Doorbell");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunCock:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.guncock", nil, [PPBaseModel bundle], @"GunCock", @"Detail Device Parameter - GunCock");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighGunShot:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.gunshot", nil, [PPBaseModel bundle], @"GunShot", @"Detail Device Parameter - GunShot");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighSwitch:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.switch", nil, [PPBaseModel bundle], @"Switch", @"Detail Device Parameter - Switch");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighTrumpet:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.trumpet", nil, [PPBaseModel bundle], @"Trumpet", @"Detail Device Parameter - Trumpet");
                        break;
                    case PPDeviceParametersAlarmWarnLinkHighWhistle:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.linkhigh.whistle", nil, [PPBaseModel bundle], @"Whistle", @"Detail Device Parameter - Whistle");
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
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.silence", nil, [PPBaseModel bundle], @"Silence", @"Detail Device Parameter - Silence");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBurglar:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.burglar", nil, [PPBaseModel bundle], @"Burglar", @"Detail Device Parameter - Burglar");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoFire:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.fire", nil, [PPBaseModel bundle], @"Fire", @"Detail Device Parameter - Fire");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoEmergency:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.emergency", nil, [PPBaseModel bundle], @"Emergency", @"Detail Device Parameter - Emergency");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicP:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.p", nil, [PPBaseModel bundle], @"PanicP", @"Detail Device Parameter - PanicP");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicF:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.f", nil, [PPBaseModel bundle], @"PanicF", @"Detail Device Parameter - PanicF");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoPanicE:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.panic.e", nil, [PPBaseModel bundle], @"PanicE", @"Detail Device Parameter - PanicE");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepbeepwelcome", nil, [PPBaseModel bundle], @"BeepBeepWelcome", @"Detail Device Parameter - BeepBeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepWelcome:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepwelcome", nil, [PPBaseModel bundle], @"BeepWelcome", @"Detail Device Parameter - BeepWelcome");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeepBeep:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beepbeep", nil, [PPBaseModel bundle], @"BeepBeep", @"Detail Device Parameter - BeepBeep");
                        break;
                    case PPDeviceParametersAlarmWarnDevelcoBeep:
                        returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmwarn.develco.beep", nil, [PPBaseModel bundle], @"Beep", @"Detail Device Parameter - Beep");
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
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration", nil, [PPBaseModel bundle], @"Alarm Duration", @"Device Parameter - Alarm Duration");
        }
        else {
            PPDeviceParametersAlarmDuration alarmDuration = (PPDeviceParametersAlarmDuration)value.integerValue;
            switch (alarmDuration) {
                case PPDeviceParametersAlarmDurationStop:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.stop", nil, [PPBaseModel bundle], @"Stop", @"Detail Device Parameter - Stop");
                    break;
                case PPDeviceParametersAlarmDurationOnce:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.playonce", nil, [PPBaseModel bundle], @"Play once", @"Detail Device Parameter - Play once");
                    break;
                    
                default:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarmduration.play.seconds.multiple", nil, [PPBaseModel bundle], @"Play for %@ seconds", @"Detail Device Parameter - Play for {n} seconds"), alarmDuration];
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_STROBE]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe", nil, [PPBaseModel bundle], @"Alarm Strobe", @"Device Parameter - Alarm Strobe");
        }
        else {
            PPDeviceParametersAlarmStrobe alarmStrobe = (PPDeviceParametersAlarmStrobe)value.integerValue;
            switch (alarmStrobe) {
                case PPDeviceParametersAlarmStrobeOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe.strobeon", nil, [PPBaseModel bundle], @"Strobe on", @"Detail Device Parameter - Strobe on");
                    break;
                case PPDeviceParametersAlarmStrobeOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmstrobe.strobeoff", nil, [PPBaseModel bundle], @"Strobe off", @"Detail Device Parameter - Strobe off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    
    else if([parameter isEqualToString:ALARM_SQUAWK]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk", nil, [PPBaseModel bundle], @"Alarm Squawk", @"Device Parameter - Alarm Squawk");
        }
        else {
            PPDeviceParametersAlarmSquawk alarmSquawk = (PPDeviceParametersAlarmSquawk)value.integerValue;
            switch (alarmSquawk) {
                case PPDeviceParametersAlarmSquawkArmed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk.squawkarmed", nil, [PPBaseModel bundle], @"Squawk armed", @"Detail Device Parameter - Squawk sarmed");
                    break;
                case PPDeviceParametersAlarmSquawkDisarmed:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarmsquawk.squawkdisarmed", nil, [PPBaseModel bundle], @"Squawk disarmed", @"Detail Device Parameter - Squawk disarmed");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus", nil, [PPBaseModel bundle], @"iBeacon Status", @"Device Parameter - iBeacon Status");
        }
        else {
            PPDeviceParametersIBeaconStatus iBeaconStatus = (PPDeviceParametersIBeaconStatus)value.integerValue;
            switch (iBeaconStatus) {
                case PPDeviceParametersIBeaconStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus.on", nil, [PPBaseModel bundle], @"On", @"Device Parameter - On");
                    break;
                case PPDeviceParametersIBeaconStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconstatus.off", nil, [PPBaseModel bundle], @"Off", @"Device Parameter - Off");
                    break;
                    
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:IBEACON_PROXIMITY]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity", nil, [PPBaseModel bundle], @"iBeacon Proximity", @"Device Parameter - iBeacon Proximity");
        }
        else {
            PPDeviceParametersIBeaconProximity iBeaconProximity = (PPDeviceParametersIBeaconProximity)value.integerValue;
            switch (iBeaconProximity) {
                case PPDeviceParametersIBeaconProximityUnknown:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.unknown", nil, [PPBaseModel bundle], @"Unknown", @"Device Parameter - Unknown");
                    break;
                case PPDeviceParametersIBeaconProximityImmediate:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.immediate", nil, [PPBaseModel bundle], @"Immediate", @"Device Parameter - Immediate");
                    break;
                case PPDeviceParametersIBeaconProximityNear:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.near", nil, [PPBaseModel bundle], @"Near", @"Device Parameter - Near");
                    break;
                case PPDeviceParametersIBeaconProximityFar:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.ibeaconproximity.far", nil, [PPBaseModel bundle], @"Far", @"Device Parameter - Far");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_STATUS]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus", nil, [PPBaseModel bundle], @"LintAlert Status", @"Device Parameter - LintAlert Status");
        }
        else {
            PPDeviceParametersSigStatus sigStatus = (PPDeviceParametersSigStatus)value.integerValue;
            switch (sigStatus) {
                case PPDeviceParametersSigStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus.dryeroff", nil, [PPBaseModel bundle], @"Dryer Off", @"Device Parameter - LintAlert Dryer Off");
                    break;
                case PPDeviceParametersSigStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertstatus.dryeron", nil, [PPBaseModel bundle], @"Dryer On", @"Device Parameter - LintAlert Dryer On");
                    break;
                default:
                    returnString = @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SIG_CUR_MAX_LED]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled", nil, [PPBaseModel bundle], @"LintAlert Current LED", @"Device Parameter - LintAlert Current LED");
        }
        else {
            PPDeviceParametersSigCurMaxLed sigCurMaxLed = (PPDeviceParametersSigCurMaxLed)value.integerValue;
            if(sigCurMaxLed <= PPDeviceParametersSigCurMaxLedOK) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.ok", nil, [PPBaseModel bundle], @"OK", @"Detail Device Parameter - LintAlert OK");
            }
            else if(sigCurMaxLed == PPDeviceParametersSigCurMaxLedWarning) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.warning", nil, [PPBaseModel bundle], @"Warning", @"Detail Device Parameter - LintAlert Warning");
            }
            else {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.lintalertcurrentled.blocked", nil, [PPBaseModel bundle], @"Blocked", @"Detail Device Parameter - LintAlert Blocked");
            }
        }
    }
    else if([parameter isEqualToString:NAM_HEALTH_IDX]) {
        if(!value) {
            returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus", nil, [PPBaseModel bundle], @"Netatmo Health Coach Status", @"Device Parameter - Netatmo Health Coach Status");
        }
        else {
            PPDeviceParametersNamHealthIdx namHealthIdx = (PPDeviceParametersNamHealthIdx)value.integerValue;
            switch (namHealthIdx) {
                case PPDeviceParametersNamHealthIdxHealthy:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.healthy", nil, [PPBaseModel bundle], @"Healthy", @"Device Parameter - Netatmo Health Coath stauts - Healthy");
                    break;
                case PPDeviceParametersNamHealthIdxFine:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.fine", nil, [PPBaseModel bundle], @"Fine", @"Device Parameter - Netatmo Health Coath stauts - Fine");
                    break;
                case PPDeviceParametersNamHealthIdxFair:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.fair", nil, [PPBaseModel bundle], @"Fair", @"Device Parameter - Netatmo Health Coath stauts - Fair");
                    break;
                case PPDeviceParametersNamHealthIdxPoor:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.poor", nil, [PPBaseModel bundle], @"Poor", @"Device Parameter - Netatmo Health Coath stauts - Poor");
                    break;
                case PPDeviceParametersNamHealthIdxUnhealthy:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.netatmohealthcoachstatus.unhealthy", nil, [PPBaseModel bundle], @"Unhealthy", @"Device Parameter - Netatmo Health Coath stauts - Unhealthy");
                    break;
                    
                default:
                    return @"undefined";
                    break;
            }
        }
    }
    else if([parameter isEqualToString:FAN_MODE_SEQUENCE]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.fanmodesequence", nil, [PPBaseModel bundle], @"Fan Mode Sequence", @"Device Parameter - Fan Mode Sequence");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:FAN_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.fanmodevalues", nil, [PPBaseModel bundle], @"Fan Mode Values", @"Device Parameter - Fan Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_COOLING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.mincoolingsetpoint", nil, [PPBaseModel bundle], @"Minimum Cooling Setpoint", @"Device Parameter - Minimum Cooling Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_COOLING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.maxcoolingsetpoint", nil, [PPBaseModel bundle], @"Maximum Cooling Setpoint", @"Device Parameter - Maximum Cooling Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MIN_HEATING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.minheatingsetpoint", nil, [PPBaseModel bundle], @"Minimum Heating Setpoint", @"Device Parameter - Minimum Heating Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:MAX_HEATING_SETPOINT]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.maxheatingsetpoint", nil, [PPBaseModel bundle], @"Maximum Heating Setpoint", @"Device Parameter - Maximum Heating Setpoint");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:TEMP_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.tempvalues", nil, [PPBaseModel bundle], @"Temperature Values", @"Device Parameter - Temperature Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:SWING_MODE_VALUES]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.swingmodevalues", nil, [PPBaseModel bundle], @"Swing Mode Values", @"Device Parameter - Swing Mode Values");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:RECORD_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus", nil, [PPBaseModel bundle], @"Record Status", @"Device Parameter - Record Status");
        }
        else {
            PPDeviceParametersRecordStatus recordStatus = (PPDeviceParametersRecordStatus)value.integerValue;
            switch (recordStatus) {
                case PPDeviceParametersRecordStatusRecording:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus.recording", nil, [PPBaseModel bundle], @"Recording", @"Device Parameter - Recording");
                    break;
                case PPDeviceParametersRecordStatusNotRecording:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordstatus.notrecording", nil, [PPBaseModel bundle], @"Not recording", @"Device Parameter - Not recording");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:ACCESS_CAMERA_SETTINGS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings", nil, [PPBaseModel bundle], @"Access Camera Settings", @"Device Parameter - Access Camera Settings");
        }
        else {
            
            PPDeviceParametersAccessCameraSettings accessCameraSettings = (PPDeviceParametersAccessCameraSettings)value.integerValue;
            switch (accessCameraSettings) {
                case PPDeviceParametersAccessCameraSettingsOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings.remotecontrolenabled", nil, [PPBaseModel bundle], @"Remote control enabled", @"Device Parameter - Remote control enabled");
                    break;
                case PPDeviceParametersAccessCameraSettingsOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.accesscamerasettings.remotecontroldisabled", nil, [PPBaseModel bundle], @"Remote control disabled", @"Device Parameter - Remote control disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_STREAMING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming", nil, [PPBaseModel bundle], @"Audio Streaming", @"Device Parameter - Audio Streaming");
        }
        else {
            
            PPDeviceParametersAudioStreaming audioStreaming = (PPDeviceParametersAudioStreaming)value.integerValue;
            switch (audioStreaming) {
                case PPDeviceParametersAudioStreamingOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming.audiostreamingenabled", nil, [PPBaseModel bundle], @"Audio streaming enabled", @"Device Parameter - Audio streaming enabled");
                    break;
                case PPDeviceParametersAudioStreamingOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiostreaming.audiostreamingdisabled", nil, [PPBaseModel bundle], @"Audio streaming disabled", @"Device Parameter - Audio streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VIDEO_STREAMING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming", nil, [PPBaseModel bundle], @"Video Streaming", @"Device Parameter - Video Streaming");
        }
        else {
            
            PPDeviceParametersVideoStreaming videoStreaming = (PPDeviceParametersVideoStreaming)value.integerValue;
            switch (videoStreaming) {
                case PPDeviceParametersVideoStreamingOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming.videostreamingenabled", nil, [PPBaseModel bundle], @"Video streaming enabled", @"Device Parameter - Video streaming enabled");
                    break;
                case PPDeviceParametersVideoStreamingOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.videostreaming.videostreamingdisabled", nil, [PPBaseModel bundle], @"Video streaming disabled", @"Device Parameter - Video streaming disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:HD_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus", nil, [PPBaseModel bundle], @"HD Status", @"Device Parameter - HD Status");
        }
        else {
            
            PPDeviceParametersHDStatus HDStatus = (PPDeviceParametersHDStatus)value.integerValue;
            switch (HDStatus) {
                case PPDeviceParametersHDStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus.hdstatusenabled", nil, [PPBaseModel bundle], @"HD Status enabled", @"Device Parameter - HD Status enabled");
                    break;
                case PPDeviceParametersHDStatusOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.hdstatus.hdstatusdisabled", nil, [PPBaseModel bundle], @"HD Status disabled", @"Device Parameter - HD Status disabled");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RAPID_MOTION_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus", nil, [PPBaseModel bundle], @"Rapid Motion Status", @"Device Parameter - Rapid Motion Status");
        }
        else {
            
            PPDeviceParametersRapidMotionStatus rapidMotionStatus = (PPDeviceParametersRapidMotionStatus)value.integerValue;
            
            int rapidMotionStatusSeconds = 0;
            int rapidMotionStatusMinutes = 0;
            int rapidMotionStatusHours = 0;
            
            switch (rapidMotionStatus) {
                case PPDeviceParametersRapidMotionStatusMinProVideo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.asfastaspossible", nil, [PPBaseModel bundle], @"As fast as possible", @"Device Parameter - As fast as possible");
                    break;
                default:
                    rapidMotionStatusSeconds = (int)value.integerValue % 60;
                    rapidMotionStatusMinutes = (int)(value.integerValue / 60) % 60;
                    rapidMotionStatusHours = (int)value.integerValue / 3600;
                    
                    if(rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes == 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.hours", nil, [PPBaseModel bundle], @"%d hr", @"Device Parameter - {number} hours"), rapidMotionStatusHours];
                    } else if (rapidMotionStatusSeconds == 0 && rapidMotionStatusMinutes > 0) {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.minutes", nil, [PPBaseModel bundle], @"%d min", @"Device Parameter - {number} minutes"), rapidMotionStatusMinutes];
                    } else {
                        returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.rapidmotionstatus.minutes_seconds", nil, [PPBaseModel bundle], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), rapidMotionStatusMinutes , rapidMotionStatusSeconds];
                    }
                    break;
            }
        }
    }
    else if([parameter isEqualToString:BATTERY_LEVEL]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.batterylevel", nil, [PPBaseModel bundle], @"Battery Level", @"Device Parameter - Battery Level");
        }
        else {
            returnString = value;
        }
    }
    else if([parameter isEqualToString:CHARGING]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.charging", nil, [PPBaseModel bundle], @"Charging", @"Device Parameter - Charging");
        }
        else {
            
            PPDeviceParametersCharging charging = (PPDeviceParametersCharging)value.integerValue;
            switch (charging) {
                case PPDeviceParametersChargingTrue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.charging.charging", nil, [PPBaseModel bundle], @"Charging", @"Device Parameter - Charging");
                    break;
                case PPDeviceParametersChargingFalse:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.charging.notcharging", nil, [PPBaseModel bundle], @"Not charging", @"Device Parameter - Not charging");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:MOTION_DETECTION_STATUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus", nil, [PPBaseModel bundle], @"Motion Status", @"Device Parameter - Motion Status");
        }
        else {
            
            PPDeviceParametersMotionStatus motionStatus= (PPDeviceParametersMotionStatus)value.integerValue;
            switch (motionStatus) {
                case PPDeviceParametersMotionStatusMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.detectingmotion", nil, [PPBaseModel bundle], @"Detecting Motion", @"Device Parameter - Detecting Motion");
                    break;
                case PPDeviceParametersMotionStatusNoMotion:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionstatus.notdetectingmotion", nil, [PPBaseModel bundle], @"Not Detecting Motion", @"Device Parameter - Not Detecting Motion");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUTO_FOCUS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus", nil, [PPBaseModel bundle], @"Auto Focus", @"Device Parameter - Auto Focus");
        }
        else {
            
            PPDeviceParametersAutoFocus autoFocus = (PPDeviceParametersAutoFocus)value.integerValue;
            switch (autoFocus) {
                case PPDeviceParametersAutoFocusShouldFocus:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus.focusing", nil, [PPBaseModel bundle], @"Focusing", @"Device Parameter - Focusing");
                    break;
                default:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.autofocus.focused", nil, [PPBaseModel bundle], @"Focused", @"Device Parameter - Focused");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter._.Detecting Audio", nil, [PPBaseModel bundle], @"Detecting Audio", @"Device Parameter - Detecting Audio");
                    break;
                case PPDeviceParametersAudioStatusNoAudio:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter._.Not detecting audio", nil, [PPBaseModel bundle], @"Not detecting audio", @"Device Parameter - Not detecting audio");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:SELECTED_CAMERA]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera", nil, [PPBaseModel bundle], @"Selected Camera", @"Device Parameter - Selected Camera");
        }
        else {
            
            PPDeviceParametersSelectedCamera selectedCamera = (PPDeviceParametersSelectedCamera)value.integerValue;
            switch (selectedCamera) {
                case PPDeviceParametersSelectedCameraRearOnly:
                case PPDeviceParametersSelectedCameraRear:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera.rearcamera", nil, [PPBaseModel bundle], @"Rear camera", @"Device Parameter - Rear camera");
                    break;
                case PPDeviceParametersSelectedCameraFront:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.selectedcamera.frontcamera", nil, [PPBaseModel bundle], @"Front camera", @"Device Parameter - Front camera");
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:RECORD_SECONDS]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds", nil, [PPBaseModel bundle], @"Record Seconds", @"Device Parameter - Record Seconds");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.seconds", nil, [PPBaseModel bundle], @"%d sec", @"Device Parameter - {number} seconds"), motionRecordSeconds];
            } else if (motionRecordSeconds == 0 && motionRecordMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.minutes", nil, [PPBaseModel bundle], @"%d min", @"Device Parameter - {number} minutes"), motionRecordMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.recordseconds.minutes_seconds", nil, [PPBaseModel bundle], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), motionRecordMinutes , motionRecordSeconds];
            }
        }
    }
    else if([parameter isEqualToString:MOTION_SENSITIVITY]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity", nil, [PPBaseModel bundle], @"Motion Sensitivity", @"Device Parameter - Motion Sensitivity");
        }
        else {
            
            PPDeviceParametersMotionSensitiviy motionSensitivity = (PPDeviceParametersMotionSensitiviy)value.integerValue;
            switch (motionSensitivity) {
                case PPDeviceParametersMotionSensitiviyTiny:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detecttinymovements", nil, [PPBaseModel bundle], @"Detect tiny movements", @"Device Parameter - Detect tiny movements");
                    break;
                case PPDeviceParametersMotionSensitiviySmall:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectsmallmovements", nil, [PPBaseModel bundle], @"Detect small movements", @"Device Parameter - Detect small movements");
                    break;
                case PPDeviceParametersMotionSensitiviyNormal:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectnormalmovements", nil, [PPBaseModel bundle], @"Detect normal movements", @"Device Parameter - Detect normal movements");
                    break;
                case PPDeviceParametersMotionSensitiviyLarge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detectlargemovements", nil, [PPBaseModel bundle], @"Detect large movements", @"Device Parameter - Detect large movements");
                    break;
                case PPDeviceParametersMotionSensitiviyHuge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionsensitivity.detecthugemovements", nil, [PPBaseModel bundle], @"Detect huge movements", @"Device Parameter - Detect huge movements");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:AUDIO_SENSITIVITY]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity", nil, [PPBaseModel bundle], @"Audio Sensitivity", @"Device Parameter - Audio Sensitivity");
        }
        else {
            
            PPDeviceParametersAudioSensitiviy audioSensitivity = (PPDeviceParametersAudioSensitiviy)value.integerValue;
            switch (audioSensitivity) {
                case PPDeviceParametersAudioSensitiviyTiny:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detecttinysounds", nil, [PPBaseModel bundle], @"Detect tiny sounds", @"Device Parameter - Detect tiny sounds");
                    break;
                case PPDeviceParametersAudioSensitiviySmall:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectsmallsounds", nil, [PPBaseModel bundle], @"Detect small sounds", @"Device Parameter - Detect small sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyNormal:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectnormalsounds", nil, [PPBaseModel bundle], @"Detect normal sounds", @"Device Parameter - Detect normal sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyLarge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detectlargesounds", nil, [PPBaseModel bundle], @"Detect large sounds", @"Device Parameter - Detect large sounds");
                    break;
                case PPDeviceParametersAudioSensitiviyHuge:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.audiosensitivity.detecthugesounds", nil, [PPBaseModel bundle], @"Detect huge sounds", @"Device Parameter - Detect huge sounds");
                    break;
                default:
                    break;
            }
        }
    }
    else if([parameter isEqualToString:VERSION]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.version", nil, [PPBaseModel bundle], @"Version", @"Device Parameter - Version");
        }
        else {
            returnString =  value;
        }
    }
    else if([parameter isEqualToString:ROBOT_CONNECTED]) {
        if(!value) {
            return NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected", nil, [PPBaseModel bundle], @"Robot Connected", @"Device Parameter - Robot Connected");
        }
        else {
            
            PPDeviceParametersRobotConnected robotConnected = (PPDeviceParametersRobotConnected)value.integerValue;
            switch (robotConnected) {
                case PPDeviceParametersRobotConnectedNone:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.norobotconnected", nil, [PPBaseModel bundle], @"No robot connected", @"Device Parameter - No robot connected");
                    break;
                case PPDeviceParametersRobotConnectedGalileo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.galileo", nil, [PPBaseModel bundle], @"Galileo", @"Device Parameter - Galileo");
                    break;
                case PPDeviceParametersRobotConnectedKubi:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.kubi", nil, [PPBaseModel bundle], @"KUBI", @"Device Parameter - KUBI");
                    break;
                case PPDeviceParametersRobotConnectedRomo:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.romo", nil, [PPBaseModel bundle], @"Romo", @"Device Parameter - Romo");
                    break;
                case PPDeviceParametersRobotConnectedGalileoBT:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.galileobt", nil, [PPBaseModel bundle], @"Galileo BT", @"Device Parameter - Galileo BT");
                    break;
                case PPDeviceParametersRobotConnected360:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.presence360", nil, [PPBaseModel bundle], @"%@ 360", @"Device Parameter - {AppName} 360"), [PPBaseModel appName:NO]];
                    break;
                case PPDeviceParametersRobotConnectedUnknown:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotconnected.unknownrobot", nil, [PPBaseModel bundle], @"Unknown robot", @"Device Parameter - Unknown robot");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.hardreset", nil, [PPBaseModel bundle], @"Hard Reset", @"Device Parameter - Hard Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusWarmReset:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.warmreset", nil, [PPBaseModel bundle], @"Warm Reset", @"Device Parameter - Warm Reset");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUART:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.resetuart", nil, [PPBaseModel bundle], @"Reset UART", @"Device Parameter - Reset UART");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.resetuardqueue", nil, [PPBaseModel bundle], @"Reset UART queue", @"Device Parameter - Reset UART queue");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.rebootmotorcontrolboard", nil, [PPBaseModel bundle], @"Reboot motor control board", @"Device Parameter - Reboot motor control board");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusReady:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.ready", nil, [PPBaseModel bundle], @"Ready", @"Device Parameter - Ready");
                    break;
                case PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.robotvantageconfigurationstatus.configurevantagepoint", nil, [PPBaseModel bundle], @"Configure vantage point %@", @"Device Parameter - Configure vantage point {vantage point index}"), value];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.robotorientation.flipvertical", nil, [PPBaseModel bundle], @"Flip vertical", @"Device Parameter - Flip vertical");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterautoshare.twitterautosharingdisabled", nil, [PPBaseModel bundle], @"Twitter auto-sharing disabled", @"Device Parameter - Twitter auto-sharing disabled");
                    break;
                case PPDeviceParametersTwitterAutoShareOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterautoshare.twitterautosharingenabled", nil, [PPBaseModel bundle], @"Twitter auto-sharing enabled", @"Device Parameter - Twitter auto-sharing enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterreminder.twitterreminderdisabled", nil, [PPBaseModel bundle], @"Twitter reminder disabled", @"Device Parameter - Twitter reminder disabled");
                    break;
                case PPDeviceParametersTwitterReminderOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterreminder.twitterreminderenabled", nil, [PPBaseModel bundle], @"Twitter reminder enabled", @"Device Parameter - Twitter reminder enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterstatus.twitterdisabled", nil, [PPBaseModel bundle], @"Twitter disabled", @"Device Parameter - Twitter disabled");
                    break;
                case PPDeviceParametersTwitterStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.twitterstatus.twitterenabled", nil, [PPBaseModel bundle], @"Twitter enabled", @"Device Parameter - Twitter enabled");
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
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.seconds", nil, [PPBaseModel bundle], @"%d sec", @"Device Parameter - {number} seconds"), motionCountDownSeconds];
            } else if (motionCountDownSeconds == 0 && motionCountDownMinutes > 0) {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.minutes", nil, [PPBaseModel bundle], @"%d min", @"Device Parameter - {number} minutes"), motionCountDownMinutes];
            } else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motioncountdowntime.minutes_seconds", nil, [PPBaseModel bundle], @"%d min %d sec", @"Device Parameter - {number} minutes {number} seconds"), motionCountDownMinutes , motionCountDownSeconds];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.blackoutscreenon.blackoutdisabled", nil, [PPBaseModel bundle], @"Blackout disabled", @"Device Parameter - Blackout disabled");
                    break;
                case PPDeviceParametersBlackoutScreenOnOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.blackoutscreenon.blackoutenabled", nil, [PPBaseModel bundle], @"Blackout enabled", @"Device Parameter - Blackout enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.warningstatus.warningstatusdisabled", nil, [PPBaseModel bundle], @"Warning status disabled", @"Device Parameter - Warning status disabled");
                    break;
                case PPDeviceParametersWarningStatusOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.warningstatus.warningstatusenabled", nil, [PPBaseModel bundle], @"Warning status enabled", @"Device Parameter - Warning status enabled");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordfullduration.stop", nil, [PPBaseModel bundle], @"Stop recording after motion goes away", @"Device Parameter - Stop recording after motion goes away");
                    break;
                case PPDeviceParametersRecordFullDurationOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.recordfullduration.continue", nil, [PPBaseModel bundle], @"Continue recording even after motion goes away", @"Device Parameter - Continue recording even after motion goes away");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.flashon", nil, [PPBaseModel bundle], @"Flash on", @"Device Parameter - Flash on");
                    break;
                case PPDeviceParametersFlashOnOff:
                case PPDeviceParametersFlashOnWasOn:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.flashoff", nil, [PPBaseModel bundle], @"Flash off", @"Device Parameter - Flash off");
                    break;
                case PPDeviceParametersFlashOnNoFlash:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.flashon.noflash", nil, [PPBaseModel bundle], @"No Flash", @"Device Parameter - No Flash");
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.supportsvideocall.videocallingnotsupported", nil, [PPBaseModel bundle], @"Video calling not supported", @"Device Parameter - Video calling not supported");
                    break;
                case PPDeviceParametersSupportsVideoCallTrue:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.supportsvideocall.videocallingsupported", nil, [PPBaseModel bundle], @"Video calling supported", @"Device Parameter - Video calling supported");
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
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumemuted", nil, [PPBaseModel bundle], @"Camera speaker volume is muted.", @"Camera - Label describing this camera is muted");
            }
            else if (value.integerValue >= PPDeviceParametersOutputVolumeMax) {
                returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumemaxed", nil, [PPBaseModel bundle], @"Camera speaker volume is maxed.", @"Camera - Label describing this camera's volume is maxed");
            }
            else {
                returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.outputvolume.cameraspeakervolumelevel", nil, [PPBaseModel bundle], @"Camera speaker volume is at %.0f%%.", @"Device Parameter - Camera speaker volume is at {number}{percent %}"),(float)(value.floatValue / PPDeviceParametersOutputVolumeMax) * 100];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmisactive", nil, [PPBaseModel bundle], @"Alarm is active", @"Device Parameter - Alarm is active");
                    break;
                case PPDeviceParametersAlarmOff:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmisoff", nil, [PPBaseModel bundle], @"Alarm is off", @"Device Parameter - Alarm is off");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmwillbeep.count", nil, [PPBaseModel bundle], @"Alarm will beep %@ times", @"Device Parameter - Alarm will beep %@ times"), value];
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.alarm.alarmwillbeep.count", nil, [PPBaseModel bundle], @"Alarm will beep %@ times", @"Device Parameter - Alarm will beep %@ times"), value];
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
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.soundalarm", nil, [PPBaseModel bundle], @"Sound alarm when motion is detected", @"Device Parameter - Sound alarm when motion is detected");
                    break;
                case PPDeviceParametersAlarmOff:
                    
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.disabled", nil, [PPBaseModel bundle], @"Disabled", @"Device Parameter - Disabled");
                    break;
                case PPDeviceParametersAlarmBeep1:
                    returnString = NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.beep.single", nil, [PPBaseModel bundle], @"Beep 1 time when motion is detected", @"Device Parameter - Beep 1 time when motion is detected");
                    break;
                case PPDeviceParametersAlarmBeep2:
                case PPDeviceParametersAlarmBeep3:
                    returnString = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"device.parameter.motionalarm.beep.multiple", nil, [PPBaseModel bundle], @"Beep %@ times when motion is detected", @"Device Parameter - Beep 2 times when motion is detected"), value];
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
