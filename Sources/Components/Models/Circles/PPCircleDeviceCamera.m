//
//  PPCircleDeviceCamera.m
//  Peoplepower
//
//  Created by Destry Teeter on 8/30/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCircleDeviceCamera.h"
#import <AVFoundation/AVFoundation.h>

@interface PPCircleDeviceCamera ()
@property (nonatomic) BOOL settingUpCameraSessionAndPublisher;
@end

@implementation PPCircleDeviceCamera
@synthesize selectedCamera;
@synthesize selectedFlash;
@synthesize motionStatus;
@synthesize recordSeconds;
@synthesize motionSensitivity;
@synthesize motionActivity;
@synthesize rapidMotionStatus;
@synthesize motionCountDownTime;
@synthesize recordFullDuration;
@synthesize recordStatus;
@synthesize audioStatus;
@synthesize audioSensitivity;
@synthesize audioActivity;
@synthesize audioStreaming;
@synthesize videoStreaming;
@synthesize accessCameraSettings;
@synthesize streamId;
@synthesize warningStatus;
@synthesize warningText;
@synthesize supportsVideoCall;
@synthesize recordStream;
@synthesize robotConnected;
@synthesize robotMotionDirection;
@synthesize robotVantagePoints;
@synthesize robotVantageTimers;
@synthesize robotVantageNames;
@synthesize robotVantageSequence;
@synthesize robotVantageConfigurationStatus;
@synthesize robotVantageMoveToIndex;
@synthesize robotOrientation;
@synthesize twitterReminder;
@synthesize twitterAutoShare;
@synthesize twitterDescription;
@synthesize twitterStatus;
@synthesize HDStatus;
@synthesize batteryLevel;
@synthesize charging;
@synthesize version;
@synthesize availableBytes;
@synthesize blackoutScreenOn;
@synthesize autoFocus;
@synthesize outputVolume;
@synthesize captureImage;
@synthesize alarm;
@synthesize playSound;
@synthesize countdown;
@synthesize visualCountdown;
@synthesize keypadStatus;
@synthesize motionAlarm;
@synthesize mode;

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId {
    self = [super initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes locationId:location.locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId];
    if(self) {
        self.circleId = circleId;
        self.user = user;
        self.location = location;
        
        for(PPDeviceParameter *defaultParam in [PPDeviceCamera defaultParameters]) {
            BOOL found = NO;
            for(PPDeviceParameter *param in [parameters copy]) {
                if([defaultParam isEqual:param]) {
                    found = YES;
                    break;
                }
            }
            if(!found) {
                [self setParameter:defaultParam.name value:defaultParam.value index:defaultParam.index lastUpdateDate:defaultParam.lastUpdateDate];
            }
        }
        
        for(PPDeviceParameter *param in [parameters copy]) {
            [self setParameter:param.name value:param.value index:param.index lastUpdateDate:param.lastUpdateDate];
        }
        
    }
    return self;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}

+ (PPCircleDeviceCamera *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    PPCircleMember *user;
    if([deviceDict objectForKey:@"user"]) {
        user = [PPCircleMember initWithDictionary:[deviceDict objectForKey:@"user"]];
    }
    
    PPLocation *location;
    if([deviceDict objectForKey:@"location"]) {
        location = [PPLocation initWithDictionary:[deviceDict objectForKey:@"location"]];
    }
    return [[PPCircleDeviceCamera alloc] initWithCircleId:PPCircleIdNone user:user location:location deviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId];
}

- (void)setProperties:(NSMutableArray *)properties {
    [super setProperties:properties];
    for(PPDeviceProperty *property in properties) {
        if([property.name isEqualToString:TWITTER_AUTO_SHARE]
           || [property.name isEqualToString:TWITTER_DESCRIPTION]) {
            [self setParameter:property.name value:property.content index:property.index lastUpdateDate:[NSDate date]];
        }
    }
}

- (void)setParameter:(NSString *)paramName value:(NSString *)paramValue index:(NSString *)paramIndex lastUpdateDate:(NSDate *)paramLastUpdateDate {
    [super setParameter:paramName value:paramValue index:paramIndex lastUpdateDate:paramLastUpdateDate];
    
    // Camera
    if([paramName isEqualToString:SELECTED_CAMERA]) {
        if(selectedCamera != (PPDeviceParametersSelectedCamera)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(selectedCamera))];
            selectedCamera = (PPDeviceParametersSelectedCamera)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(selectedCamera))];
            if(paramValue.integerValue == PPDeviceParametersSelectedCameraFront && selectedFlash == PPDeviceParametersSelectedFlashOn) {
                [self willChangeValueForKey:NSStringFromSelector(@selector(selectedFlash))];
                selectedFlash = PPDeviceParametersSelectedFlashWasOn;
                [self didChangeValueForKey:NSStringFromSelector(@selector(selectedFlash))];
            }
        }
    }
    
    // Flash
    else if([paramName isEqualToString:FLASH_ON]) {
        if(selectedCamera == PPDeviceParametersSelectedCameraFront && paramValue.integerValue == PPDeviceParametersSelectedFlashOn) {
            paramValue = [NSString stringWithFormat:@"%li", (long)PPDeviceParametersSelectedFlashWasOn];
        }
        if(selectedFlash != (PPDeviceParametersSelectedFlash)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(selectedFlash))];
            selectedFlash = (PPDeviceParametersSelectedFlash)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(selectedFlash))];
        }
    }
    
    // Motion Detection/Recording
    else if([paramName isEqualToString:MOTION_STATUS]) {
        if(motionStatus != (PPDeviceParametersCameraMotionStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(motionStatus))];
            motionStatus = (PPDeviceParametersCameraMotionStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(motionStatus))];
        }
    }
    else if([paramName isEqualToString:RECORD_SECONDS]) {
        if(recordSeconds != (PPDeviceParametersRecordSeconds)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(recordSeconds))];
            recordSeconds = (PPDeviceParametersRecordSeconds)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(recordSeconds))];
        }
    }
    else if([paramName isEqualToString:MOTION_SENSITIVITY]) {
        if(motionSensitivity != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(motionSensitivity))];
            motionSensitivity = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(motionSensitivity))];
        }
    }
    else if([paramName isEqualToString:MOTION_ACTIVITY]) {
        if(motionActivity != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(motionActivity))];
            motionActivity = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(motionActivity))];
        }
    }
    else if([paramName isEqualToString:RAPID_MOTION_STATUS]) {
        if(rapidMotionStatus != (PPDeviceParametersRapidMotionStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(rapidMotionStatus))];
            rapidMotionStatus = (PPDeviceParametersRapidMotionStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(rapidMotionStatus))];
        }
    }
    else if([paramName isEqualToString:MOTION_COUNTDOWN_TIME]) {
        if(motionCountDownTime != (PPDeviceParametersMotionCountDownTime)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(motionCountDownTime))];
            motionCountDownTime = (PPDeviceParametersMotionCountDownTime)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(motionCountDownTime))];
        }
    }
    else if([paramName isEqualToString:RECORD_FULL_DURATION]) {
        if(recordFullDuration != (PPDeviceParametersRecordFullDuration)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(recordFullDuration))];
            recordFullDuration = (PPDeviceParametersRecordFullDuration)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(recordFullDuration))];
        }
    }
    else if([paramName isEqualToString:RECORD_STATUS]) {
        if(recordStatus != (PPDeviceParametersRecordStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(recordStatus))];
            recordStatus = (PPDeviceParametersRecordStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(recordStatus))];
        }
    }
    
    // Audio Detection/Recording
    else if([paramName isEqualToString:AUDIO_STATUS]) {
        if(audioStatus != (PPDeviceParametersAudioStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioStatus))];
            audioStatus = (PPDeviceParametersAudioStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioStatus))];
        }
    }
    else if([paramName isEqualToString:AUDIO_SENSITIVITY]) {
        if(audioSensitivity != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioSensitivity))];
            audioSensitivity = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioSensitivity))];
        }
    }
    else if([paramName isEqualToString:AUDIO_ACTIVITY]) {
        if(audioActivity != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioActivity))];
            audioActivity = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioActivity))];
        }
    }
    
    // Streaming
    else if([paramName isEqualToString:AUDIO_STREAMING]) {
        if(audioStreaming != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioStreaming))];
            audioStreaming = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioStreaming))];
        }
    }
    else if([paramName isEqualToString:VIDEO_STREAMING]) {
        if(videoStreaming != (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(videoStreaming))];
            videoStreaming = (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(videoStreaming))];
        }
    }
    else if([paramName isEqualToString:ACCESS_CAMERA_SETTINGS]) {
        if(accessCameraSettings != (PPDeviceParametersAccessCameraSettings)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(accessCameraSettings))];
            accessCameraSettings = (PPDeviceParametersAccessCameraSettings)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(accessCameraSettings))];
        }
    }
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:STREAM_ID]) {
        if(![streamId isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(streamId))];
            streamId = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(streamId))];
        }
    }
#endif
    else if([paramName isEqualToString:WARNING_STATUS]) {
        if(warningStatus != (PPDeviceParametersWarningStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(warningStatus))];
            warningStatus = (PPDeviceParametersWarningStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(warningStatus))];
        }
    }
    else if([paramName isEqualToString:WARNING_TEXT]) {
        if(![warningText isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(warningText))];
            warningText = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(warningText))];
        }
    }
    else if([paramName isEqualToString:SUPPORTS_VIDEO_CALL]) {
        if(supportsVideoCall != paramValue.boolValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(supportsVideoCall))];
            supportsVideoCall = paramValue.boolValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(supportsVideoCall))];
        }
    }
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:RECORD_STREAM]) {
        if(recordStream != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(recordStream))];
            recordStream = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(recordStream))];
        }
    }
#endif
    else if([paramName isEqualToString:MOTION_ALARM]) {
        if(motionAlarm != (PPDeviceParametersAlarm)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(motionAlarm))];
            motionAlarm = (PPDeviceParametersAlarm)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(motionAlarm))];
        }
    }
    
    // Robot
    else if([paramName isEqualToString:ROBOT_CONNECTED]) {
        if(robotConnected != (PPDeviceParametersRobotConnected)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(robotConnected))];
            robotConnected = (PPDeviceParametersRobotConnected)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(robotConnected))];
        }
    }
    else if([paramName isEqualToString:ROBOT_MOTION_DIRECTION]) {
        if(robotMotionDirection != (PPDeviceParametersRobotMotionDirection)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(robotMotionDirection))];
            robotMotionDirection = (PPDeviceParametersRobotMotionDirection)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(robotMotionDirection))];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_SPHERICAL_COORDINATES]) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantagePoints))];
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        paramValue = [paramValue stringByReplacingOccurrencesOfString:@"[" withString:@""];
        paramValue = [paramValue stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSArray *vantagePointArray = [paramValue componentsSeparatedByString:@","];
        PPDeviceParameterRobotVantagePoint *vantagePoint = [[PPDeviceParameterRobotVantagePoint alloc] initWithZoomLevel:[vantagePointArray objectAtIndex:0] horizontalRotation:[vantagePointArray objectAtIndex:1] verticalRotation:[vantagePointArray objectAtIndex:2]];
        if(robotVantagePoints.count > vantageIndex) {
            [robotVantagePoints replaceObjectAtIndex:vantageIndex withObject:vantagePoint];
        }
        else {
            [robotVantagePoints addObject:vantagePoint];
        }
        [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantagePoints))];
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_TIME]) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantageTimers))];
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        if(robotVantageTimers.count > vantageIndex) {
            [robotVantageTimers replaceObjectAtIndex:vantageIndex withObject:paramValue];
        }
        else {
            // Set every index below our current to -1 so we can maintain our current indexed value
            while(robotVantageTimers.count < vantageIndex) {
                [robotVantageTimers addObject:@"-1"];
            }
            [robotVantageTimers addObject:paramValue];
        }
        [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantageTimers))];
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_NAME]) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantageNames))];
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        if(robotVantageNames.count > vantageIndex) {
            [robotVantageNames replaceObjectAtIndex:vantageIndex withObject:paramValue];
        }
        else {
            // Set every index below our current to -1 so we can maintain our current indexed value
            while(robotVantageNames.count < vantageIndex) {
                [robotVantageNames addObject:@" "];
            }
            [robotVantageNames addObject:paramValue];
        }
        [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantageNames))];
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_SEQUENCE]) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantageSequence))];
        if([paramValue isEqualToString:@"-1"]) {
            robotVantageSequence = [[NSMutableArray alloc] init];
        }
        else {
            NSArray *vantageIndexes = [paramValue componentsSeparatedByString:@","];
            robotVantageSequence = [[NSMutableArray alloc] initWithArray:vantageIndexes];
        }
        [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantageNames))];
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_CONFIGURATION_STATUS]) {
        if(robotVantageConfigurationStatus != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantageConfigurationStatus))];
            robotVantageConfigurationStatus = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantageConfigurationStatus))];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_MOVE_TO_INDEX]) {
        if(robotVantageMoveToIndex != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(robotVantageMoveToIndex))];
            robotVantageMoveToIndex = paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(robotVantageMoveToIndex))];
        }
    }
    else if([paramName isEqualToString:ROBOT_ORIENTATION]) {
        if(robotOrientation != paramValue.boolValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(robotOrientation))];
            robotOrientation = paramValue.boolValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(robotOrientation))];
        }
    }
    
    // Twitter
    else if([paramName isEqualToString:TWITTER_AUTO_SHARE]) {
        if(twitterAutoShare != (PPDeviceParametersTwitterAutoShare)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(twitterAutoShare))];
            twitterAutoShare = (PPDeviceParametersTwitterAutoShare)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(twitterAutoShare))];
        }
    }
    else if([paramName isEqualToString:TWITTER_DESCRIPTION]) {
        if(![twitterDescription isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(twitterDescription))];
            twitterDescription = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(twitterDescription))];
        }
    }
    else if([paramName isEqualToString:TWITTER_REMINDER]) {
        if(twitterReminder != (PPDeviceParametersTwitterReminder)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(twitterReminder))];
            twitterReminder = (PPDeviceParametersTwitterReminder)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(twitterReminder))];
        }
    }
    else if([paramName isEqualToString:TWITTER_STATUS]) {
        if(twitterStatus != (PPDeviceParametersTwitterStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(twitterStatus))];
            twitterStatus = (PPDeviceParametersTwitterStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(twitterStatus))];
        }
        
        if(twitterAutoShare != paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(twitterAutoShare))];
            twitterAutoShare = (PPDeviceParametersTwitterAutoShare)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(twitterAutoShare))];
        }
    }
    
    // Various
    else if([paramName isEqualToString:HD_STATUS]) {
        if(HDStatus != (PPDeviceParametersHDStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(HDStatus))];
            // Pro features need an extra check
            HDStatus = (PPDeviceParametersHDStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(HDStatus))];
        }
    }
    else if ([paramName isEqualToString:BATTERY_LEVEL]) {
        if(batteryLevel != (PPDeviceParametersBatteryLevel)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(batteryLevel))];
            batteryLevel = (PPDeviceParametersBatteryLevel)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(batteryLevel))];
        }
    }
    else if([paramName isEqualToString:CHARGING]) {
        if(charging != (PPDeviceParametersCharging)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(charging))];
            charging = (PPDeviceParametersCharging)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(charging))];
        }
    }
    else if([paramName isEqualToString:VERSION]) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(version))];
        version = [[PPVersion alloc] initWithVersion:paramValue];
        [self didChangeValueForKey:NSStringFromSelector(@selector(version))];
    }
    else if([paramName isEqualToString:AVAILABLE_BYTES]) {
        if(availableBytes != [[[[NSNumberFormatter alloc] init] numberFromString:paramValue] unsignedLongValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(availableBytes))];
            availableBytes = [[[[NSNumberFormatter alloc] init] numberFromString:paramValue] unsignedLongValue];
            [self didChangeValueForKey:NSStringFromSelector(@selector(availableBytes))];
        }
    }
    else if([paramName isEqualToString:BLACKOUT_SCREEN_ON]) {
        if(blackoutScreenOn != (PPDeviceParametersBlackoutScreenOn)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(blackoutScreenOn))];
            blackoutScreenOn = (PPDeviceParametersBlackoutScreenOn)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(blackoutScreenOn))];
        }
    }
    else if([paramName isEqualToString:AUTO_FOCUS]) {
        if(autoFocus != (PPDeviceParametersAutoFocus)paramValue.boolValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(autoFocus))];
            autoFocus = (PPDeviceParametersAutoFocus)paramValue.boolValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(autoFocus))];
        }
    }
    else if([paramName isEqualToString:OUTPUT_VOLUME]) {
        if(outputVolume != (PPDeviceParametersOutputVolume)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(outputVolume))];
            outputVolume = (PPDeviceParametersOutputVolume)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(outputVolume))];
        }
    }
    else if([paramName isEqualToString:CAPTURE_IMAGE]) {
        if(captureImage != (PPDeviceParametersCaptureImage)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(captureImage))];
            captureImage = (PPDeviceParametersCaptureImage)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(captureImage))];
        }
    }
    
    // Security
    else if([paramName isEqualToString:ALARM]) {
        if(alarm != (PPDeviceParametersAlarm)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alarm))];
            alarm = (PPDeviceParametersAlarm)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alarm))];
        }
    }
    else if([paramName isEqualToString:PLAY_SOUND]) {
        if(![playSound isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(playSound))];
            playSound = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(playSound))];
        }
    }
    else if([paramName isEqualToString:COUNTDOWN]) {
        if(countdown != (PPDeviceParametersCountdown)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(countdown))];
            countdown = (PPDeviceParametersCountdown)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(countdown))];
        }
    }
    else if([paramName isEqualToString:VISUAL_COUNTDOWN]) {
        if(visualCountdown != (PPDeviceParametersVisualCountdown)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(visualCountdown))];
            visualCountdown = (PPDeviceParametersVisualCountdown)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(visualCountdown))];
        }
    }
    else if([paramName isEqualToString:KEYPAD_STATUS]) {
        if(![keypadStatus isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(keypadStatus))];
            keypadStatus = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(keypadStatus))];
        }
    }
    else if([paramName isEqualToString:MODE]) {
        if(![mode isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(mode))];
            mode = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(mode))];
        }
    }
}
#if !TARGET_OS_WATCH
+ (BOOL)supportsVideo {
    return [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count > 0;
}
#endif
- (void)syncSelectedCamera {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    // TODO: Update robot about camera position so that robot code flips controls based on it
}

#pragma mark - Setters

- (void)setSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera {
    if(self.selectedCamera == selectedCamera) {
        return;
    }
    [self setParameter:SELECTED_CAMERA value:[NSString stringWithFormat:@"%li", (long)selectedCamera] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash {
    if(self.selectedFlash == selectedFlash) {
        return;
    }
    [self setParameter:FLASH_ON value:[NSString stringWithFormat:@"%li", (long)selectedFlash] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMotionStatus:(PPDeviceParametersCameraMotionStatus)motionStatus {
    if(self.motionStatus == motionStatus) {
        return;
    }
    [self setParameter:MOTION_STATUS value:[NSString stringWithFormat:@"%li", (long)motionStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRecordSeconds:(PPDeviceParametersRecordSeconds)recordSeconds {
    if(self.recordSeconds == recordSeconds) {
        return;
    }
    [self setParameter:RECORD_SECONDS value:[NSString stringWithFormat:@"%li", (long)recordSeconds] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMotionSensitivity:(PPDeviceParametersMotionSensitiviy)motionSensitivity {
    if(self.motionSensitivity == motionSensitivity) {
        return;
    }
    [self setParameter:MOTION_SENSITIVITY value:[NSString stringWithFormat:@"%li", (long)motionSensitivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMotionActivity:(PPDeviceParametersMotionActivity)motionActivity {
    if(self.motionActivity == motionActivity) {
        return;
    }
    [self setParameter:MOTION_ACTIVITY value:[NSString stringWithFormat:@"%li", (long)motionActivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRapidMotionStatus:(PPDeviceParametersRapidMotionStatus)rapidMotionStatus {
    if(self.rapidMotionStatus == rapidMotionStatus) {
        return;
    }
    [self setParameter:RAPID_MOTION_STATUS value:[NSString stringWithFormat:@"%li", (long)rapidMotionStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMotionCountDownTime:(PPDeviceParametersMotionCountDownTime)motionCountDownTime {
    if(self.motionCountDownTime == motionCountDownTime) {
        return;
    }
    [self setParameter:MOTION_COUNTDOWN_TIME value:[NSString stringWithFormat:@"%li", (long)motionCountDownTime] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRecordFullDuration:(PPDeviceParametersRecordFullDuration)recordFullDuration {
    if(self.recordFullDuration == recordFullDuration) {
        return;
    }
    [self setParameter:RECORD_FULL_DURATION value:[NSString stringWithFormat:@"%li", (long)recordFullDuration] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [self setParameter:RECORD_STATUS value:[NSString stringWithFormat:@"%li", (long)recordStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMotionAlarm:(PPDeviceParametersAlarm)motionAlarm {
    if(self.motionAlarm == motionAlarm) {
        return;
    }
    [self setParameter:MOTION_ALARM value:[NSString stringWithFormat:@"%li", (long)motionAlarm] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAudioStatus:(PPDeviceParametersAudioStatus)audioStatus {
    if(self.audioStatus == audioStatus) {
        return;
    }
    [self setParameter:AUDIO_STATUS value:[NSString stringWithFormat:@"%li", (long)audioStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity {
    if(self.audioSensitivity == audioSensitivity) {
        return;
    }
    [self setParameter:AUDIO_SENSITIVITY value:[NSString stringWithFormat:@"%li", (long)audioSensitivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAudioActivity:(PPDeviceParametersAudioActivity)audioActivity {
    if(self.audioActivity == audioActivity) {
        return;
    }
    [self setParameter:AUDIO_ACTIVITY value:[NSString stringWithFormat:@"%li", (long)audioActivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming {
    if(self.audioStreaming == audioStreaming) {
        return;
    }
    [self setParameter:AUDIO_STREAMING value:[NSString stringWithFormat:@"%li", (long)audioStreaming] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming {
    if(self.videoStreaming == videoStreaming) {
        return;
    }
    [self setParameter:VIDEO_STREAMING value:[NSString stringWithFormat:@"%li", (long)videoStreaming] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAccessCameraSettings:(PPDeviceParametersAccessCameraSettings)accessCameraSettings {
    if(self.accessCameraSettings == accessCameraSettings) {
        return;
    }
    [self setParameter:ACCESS_CAMERA_SETTINGS value:[NSString stringWithFormat:@"%li", (long)accessCameraSettings] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setWarningStatus:(PPDeviceParametersWarningStatus)warningStatus {
    if(self.warningStatus == warningStatus) {
        return;
    }
    [self setParameter:WARNING_STATUS value:[NSString stringWithFormat:@"%li", (long)warningStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setWarningText:(NSString *)warningText {
    if(self.warningText == warningText) {
        return;
    }
    [self setParameter:WARNING_TEXT value:warningText index:nil lastUpdateDate:[NSDate date]];
}

- (void)setSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [self setParameter:SUPPORTS_VIDEO_CALL value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotConnected:(PPDeviceParametersRobotConnected)robotConnected {
    if(self.robotConnected == robotConnected) {
        return;
    }
    [self setParameter:ROBOT_CONNECTED value:[NSString stringWithFormat:@"%li", (long)robotConnected] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotMotionDirection:(PPDeviceParametersRobotMotionDirection)robotMotionDirection {
    if(self.robotMotionDirection == robotMotionDirection) {
        return;
    }
    //    [self setParameter:ROBOT_CONNECTED value:[NSString stringWithFormat:@"%li", (long)robotConnected] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index {
    [self setParameter:ROBOT_VANTAGE_SPHERICAL_COORDINATES value:robotVantagePoint index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index {
    NSMutableArray *robotVantageTimers = self.robotVantageTimers;
    if(robotVantageTimers.count > index) {
        [robotVantageTimers replaceObjectAtIndex:index withObject:@(robotVantageTimer)];
    }
    else {
        while(robotVantageTimers.count < index) {
            [robotVantageTimers addObject:@"-1"];
        }
        [robotVantageTimers addObject:@(robotVantageTimer).stringValue];
    }
    [self setRobotVantageTimers:robotVantageTimers];
    
    [self setParameter:ROBOT_VANTAGE_TIME value:[NSString stringWithFormat:@"%li", (long)robotVantageTimer] index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index {
    NSMutableArray *robotVantageNames = self.robotVantageNames;
    if(robotVantageNames.count > index) {
        [robotVantageNames replaceObjectAtIndex:index withObject:robotVantageName];
    }
    else {
        while(robotVantageNames.count < index) {
            [robotVantageNames addObject:@" "];
        }
        [robotVantageNames addObject:robotVantageName];
    }
    [self setRobotVantageNames:robotVantageNames];
    [self setParameter:ROBOT_VANTAGE_NAME value:robotVantageName index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantageSequence:(NSMutableOrderedSet *)robotVantageSequence {
#ifdef DEBUG
    NSLog(@"%s current=%@; new=%@", __PRETTY_FUNCTION__, self.robotVantageSequence, robotVantageSequence);
#endif
    NSInteger maxIndex = ([self.robotVantageSequence count] > [robotVantageSequence count]) ? [self.robotVantageSequence count] : [robotVantageSequence count];
    BOOL shouldUpdate = NO;
    for(int i = 0; i < maxIndex; i++) {
        if([self.robotVantageSequence count] > i) {
            if([robotVantageSequence count] > i) {
                if([((NSString *)[self.robotVantageSequence objectAtIndex:i]) isEqualToString:((NSString *)[robotVantageSequence objectAtIndex:i])]) {
                    continue;
                }
            }
        }
        shouldUpdate = YES;
    }
    if(!shouldUpdate) {
        return;
    }
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    NSMutableString *s = [[NSMutableString alloc] init];
    for(int i = 0; i < [robotVantageSequence count]; i ++) {
        if(i > 0) {
            [s appendString:@","];
        }
        [s appendString:[robotVantageSequence objectAtIndex:i]];
    }
    
    if([s isEqualToString:@""]) {
        [s appendString:@"-1"];
    }
    [self setParameter:ROBOT_VANTAGE_SEQUENCE value:s index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantageConfigurationStatus:(PPDeviceParametersRobotVantageConfigurationStatus)robotVantageConfigurationStatus {
    if(self.robotVantageConfigurationStatus == robotVantageConfigurationStatus) {
        return;
    }
    //    [self setParameter:ROBOT_VANTAGE_CONFIGURATION_STATUS value:[NSString stringWithFormat:@"%li", (long)robotVantageConfigurationStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotVantageMoveToIndex:(NSInteger)robotVantageMoveToIndex {
    if(self.robotVantageMoveToIndex == robotVantageMoveToIndex) {
        return;
    }
    //    [self setParameter:ROBOT_VANTAGE_MOVE_TO_INDEX value:[NSString stringWithFormat:@"%li", (long)robotVantageMoveToIndex] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setRobotOrientation:(PPDeviceParametersRobotOrientation)robotOrientation {
    if(self.robotOrientation == robotOrientation) {
        return;
    }
    //    [self setParameter:ROBOT_ORIENTATION value:[NSString stringWithFormat:@"%li", (long)robotOrientation] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setTwitterReminder:(PPDeviceParametersTwitterReminder)twitterReminder {
    if(self.twitterReminder == twitterReminder) {
        return;
    }
    [self setParameter:TWITTER_REMINDER value:[NSString stringWithFormat:@"%li", (long)twitterReminder] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setTwitterAutoShare:(PPDeviceParametersTwitterAutoShare)twitterAutoShare {
    if(self.twitterAutoShare == twitterAutoShare) {
        return;
    }
    [self setParameter:TWITTER_AUTO_SHARE value:[NSString stringWithFormat:@"%li", (long)twitterAutoShare] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setTwitterDescription:(NSString *)twitterDescription {
    if([self.twitterDescription isEqualToString:twitterDescription]) {
        return;
    }
    [self setParameter:TWITTER_DESCRIPTION value:twitterDescription index:nil lastUpdateDate:[NSDate date]];
}

- (void)setTwitterStatus:(PPDeviceParametersTwitterStatus)twitterStatus {
    if(self.twitterStatus == twitterStatus) {
        return;
    }
    [self setParameter:TWITTER_STATUS value:[NSString stringWithFormat:@"%li", (long)twitterStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setHDStatus:(PPDeviceParametersHDStatus)HDStatus {
    if(self.HDStatus == HDStatus) {
        return;
    }
    [self setParameter:HD_STATUS value:[NSString stringWithFormat:@"%li", (long)HDStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel {
    if(self.batteryLevel == batteryLevel) {
        return;
    }
    [self setParameter:BATTERY_LEVEL value:[NSString stringWithFormat:@"%li", (long)batteryLevel] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setCharging:(PPDeviceParametersCharging)charging {
    if(self.charging == charging) {
        return;
    }
    [self setParameter:CHARGING value:[NSString stringWithFormat:@"%li", (long)charging] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setVersion:(PPVersion *)version {
    if([[self.version toNSString] isEqualToString:[version toNSString]]) {
        return;
    }
    [self setParameter:VERSION value:[version toNSString] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAvailableBytes:(unsigned long long)availableBytes {
    if(self.availableBytes == availableBytes) {
        return;
    }
    [self setParameter:AVAILABLE_BYTES value:[NSString stringWithFormat:@"%llu", (unsigned long long )availableBytes] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn {
    if(self.blackoutScreenOn == blackoutScreenOn) {
        return;
    }
    [self setParameter:BLACKOUT_SCREEN_ON value:[NSString stringWithFormat:@"%li", (long)blackoutScreenOn] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAutoFocus:(PPDeviceParametersAutoFocus)autoFocus {
    if(self.autoFocus == autoFocus) {
        return;
    }
    //    [self setParameter:AUTO_FOCUS value:[NSString stringWithFormat:@"%li", (long)autoFocus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [self setParameter:OUTPUT_VOLUME value:[NSString stringWithFormat:@"%li", (long)outputVolume] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setCaptureImage:(PPDeviceParametersCaptureImage)captureImage {
    if(self.captureImage == captureImage) {
        return;
    }
    [self setParameter:CAPTURE_IMAGE value:[NSString stringWithFormat:@"%li", (long)captureImage] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlarm:(PPDeviceParametersAlarm)alarm {
    if(self.alarm == alarm) {
        return;
    }
    [self setParameter:ALARM value:[NSString stringWithFormat:@"%li", (long)alarm] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setPlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    //    [self setParameter:PLAY_SOUND value:playSound index:nil lastUpdateDate:[NSDate date]];
}

- (void)setCountdown:(PPDeviceParametersCountdown)countdown {
    if(self.countdown == countdown) {
        return;
    }
    //    [self setParameter:COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)countdown] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setVisualCountdown:(PPDeviceParametersVisualCountdown)visualCountdown {
    if(self.visualCountdown == visualCountdown) {
        return;
    }
    //    [self setParameter:VISUAL_COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)visualCountdown] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setKeypadStatus:(NSString *)keypadStatus {
    if([self.keypadStatus isEqualToString:keypadStatus]) {
        return;
    }
    //    [self setParameter:KEYPAD_STATUS value:keypadStatus index:nil lastUpdateDate:[NSDate date]];
}

- (void)setMode:(NSString *)mode {
    if([self.mode isEqualToString:mode]) {
        return;
    }
    //    [self setParameter:MODE value:mode index:nil lastUpdateDate:[NSDate date]];
}



@end

