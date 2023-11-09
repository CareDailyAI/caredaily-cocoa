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
/*
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
 */

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId userId:(PPUserId)userId {
    self = [super initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes locationId:location.locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:userId];
    if(self) {
        self.circleId = circleId;
        self.user = user;
        self.location = location;
        
        for(PPDeviceParameter *defaultParam in [PPDeviceCamera defaultParameters]) {
            BOOL found = NO;
            for(PPDeviceParameter *param in [[PPRLMArray arrayFromArray:parameters] copy]) {
                if([defaultParam isEqual:param]) {
                    found = YES;
                    break;
                }
            }
            if(!found) {
                [self setParameter:defaultParam.name value:defaultParam.value index:defaultParam.index lastUpdateDate:defaultParam.lastUpdateDate];
            }
        }
        
        for(PPDeviceParameter *param in [[PPRLMArray arrayFromArray:parameters] copy]) {
            [self setParameter:param.name value:param.value index:param.index lastUpdateDate:param.lastUpdateDate];
        }
        
    }
    return self;
}
- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId {
    NSLog(@"%s deprecated, use -initWithCircleId:user:location:deviceId:proxyId:name:connected:restricted:shared:newDevice:goalId:typeId:category:typeAttributes:startDate:lastDataReceivedDate:lastMeasureDate:lastConnectedDate:parameters:properties:icon:spaces:modelId:userId:", __FUNCTION__);
    return [self initWithCircleId:circleId user:user location:location deviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:PPUserIdNone];
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
    return [[PPCircleDeviceCamera alloc] initWithCircleId:PPCircleIdNone user:user location:location deviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId userId:device.userId];
}

- (void)setProperties:(RLMArray *)properties {
    [super setProperties:(RLMArray<PPDeviceProperty *><PPDeviceProperty> *)properties];
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
        if(self.selectedCamera != (PPDeviceParametersSelectedCamera)paramValue.integerValue) {
            self.selectedCamera = (PPDeviceParametersSelectedCamera)paramValue.integerValue;
            if(paramValue.integerValue == PPDeviceParametersSelectedCameraFront && self.selectedFlash == PPDeviceParametersSelectedFlashOn) {
                self.selectedFlash = PPDeviceParametersSelectedFlashWasOn;
            }
        }
    }
    
    // Flash
    else if([paramName isEqualToString:FLASH_ON]) {
        if(self.selectedCamera == PPDeviceParametersSelectedCameraFront && paramValue.integerValue == PPDeviceParametersSelectedFlashOn) {
            paramValue = [NSString stringWithFormat:@"%li", (long)PPDeviceParametersSelectedFlashWasOn];
        }
        if(self.selectedFlash != (PPDeviceParametersSelectedFlash)paramValue.integerValue) {
            self.selectedFlash = (PPDeviceParametersSelectedFlash)paramValue.integerValue;
        }
    }
    
    // Motion Detection/Recording
    else if([paramName isEqualToString:MOTION_STATUS]) {
        if(self.motionStatus != (PPDeviceParametersCameraMotionStatus)paramValue.integerValue) {
            self.motionStatus = (PPDeviceParametersCameraMotionStatus)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:RECORD_SECONDS]) {
        if(self.recordSeconds != (PPDeviceParametersRecordSeconds)paramValue.integerValue) {
            self.recordSeconds = (PPDeviceParametersRecordSeconds)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:MOTION_SENSITIVITY]) {
        if(self.motionSensitivity != paramValue.integerValue) {
            self.motionSensitivity = paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:MOTION_ACTIVITY]) {
        if(self.motionActivity != paramValue.integerValue) {
            self.motionActivity = paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:RAPID_MOTION_STATUS]) {
        if(self.rapidMotionStatus != (PPDeviceParametersRapidMotionStatus)paramValue.integerValue) {
            self.rapidMotionStatus = (PPDeviceParametersRapidMotionStatus)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:MOTION_COUNTDOWN_TIME]) {
        if(self.motionCountDownTime != (PPDeviceParametersMotionCountDownTime)paramValue.integerValue) {
            self.motionCountDownTime = (PPDeviceParametersMotionCountDownTime)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:RECORD_FULL_DURATION]) {
        if(self.recordFullDuration != (PPDeviceParametersRecordFullDuration)paramValue.integerValue) {
            self.recordFullDuration = (PPDeviceParametersRecordFullDuration)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:RECORD_STATUS]) {
        if(self.recordStatus != (PPDeviceParametersRecordStatus)paramValue.integerValue) {
            self.recordStatus = (PPDeviceParametersRecordStatus)paramValue.integerValue;
        }
    }
    
    // Audio Detection/Recording
    else if([paramName isEqualToString:AUDIO_STATUS]) {
        if(self.audioStatus != (PPDeviceParametersAudioStatus)paramValue.integerValue) {
            self.audioStatus = (PPDeviceParametersAudioStatus)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:AUDIO_SENSITIVITY]) {
        if(self.audioSensitivity != paramValue.integerValue) {
            self.audioSensitivity = paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:AUDIO_ACTIVITY]) {
        if(self.audioActivity != paramValue.integerValue) {
            self.audioActivity = paramValue.integerValue;
        }
    }
    
    // Streaming
    else if([paramName isEqualToString:AUDIO_STREAMING]) {
        if(self.audioStreaming != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            self.audioStreaming = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:VIDEO_STREAMING]) {
        if(self.videoStreaming != (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0) {
            self.videoStreaming = (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:ACCESS_CAMERA_SETTINGS]) {
        if(self.accessCameraSettings != (PPDeviceParametersAccessCameraSettings)paramValue.integerValue) {
            self.accessCameraSettings = (PPDeviceParametersAccessCameraSettings)paramValue.integerValue;
        }
    }
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:STREAM_ID]) {
        if(![self.streamId isEqualToString:paramValue]) {
            self.streamId = paramValue;
        }
    }
#endif
    else if([paramName isEqualToString:WARNING_STATUS]) {
        if(self.warningStatus != (PPDeviceParametersWarningStatus)paramValue.integerValue) {
            self.warningStatus = (PPDeviceParametersWarningStatus)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:WARNING_TEXT]) {
        if(![self.warningText isEqualToString:paramValue]) {
            self.warningText = paramValue;
        }
    }
    else if([paramName isEqualToString:SUPPORTS_VIDEO_CALL]) {
        if(self.supportsVideoCall != paramValue.boolValue) {
            self.supportsVideoCall = paramValue.boolValue;
        }
    }
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:RECORD_STREAM]) {
        if(self.recordStream != paramValue.integerValue) {
            self.recordStream = paramValue.integerValue;
        }
    }
#endif
    else if([paramName isEqualToString:MOTION_ALARM]) {
        if(self.motionAlarm != (PPDeviceParametersAlarm)paramValue.integerValue) {
            self.motionAlarm = (PPDeviceParametersAlarm)paramValue.integerValue;
        }
    }
    
    // Robot
    else if([paramName isEqualToString:ROBOT_CONNECTED]) {
        if(self.robotConnected != (PPDeviceParametersRobotConnected)paramValue.integerValue) {
            self.robotConnected = (PPDeviceParametersRobotConnected)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ROBOT_MOTION_DIRECTION]) {
        if(self.robotMotionDirection != (PPDeviceParametersRobotMotionDirection)paramValue.integerValue) {
            self.robotMotionDirection = (PPDeviceParametersRobotMotionDirection)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_SPHERICAL_COORDINATES]) {
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        paramValue = [paramValue stringByReplacingOccurrencesOfString:@"[" withString:@""];
        paramValue = [paramValue stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSArray *vantagePointArray = [paramValue componentsSeparatedByString:@","];
        PPDeviceParameterRobotVantagePoint *vantagePoint = [[PPDeviceParameterRobotVantagePoint alloc] initWithZoomLevel:[vantagePointArray objectAtIndex:0] horizontalRotation:[vantagePointArray objectAtIndex:1] verticalRotation:[vantagePointArray objectAtIndex:2]];
        if(self.robotVantagePoints.count > vantageIndex) {
            [self.robotVantagePoints replaceObjectAtIndex:vantageIndex withObject:vantagePoint];
        }
        else {
            [self.robotVantagePoints addObject:vantagePoint];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_TIME]) {
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        if(self.robotVantageTimers.count > vantageIndex) {
            [self.robotVantageTimers replaceObjectAtIndex:vantageIndex withObject:paramValue];
        }
        else {
            // Set every index below our current to -1 so we can maintain our current indexed value
            while(self.robotVantageTimers.count < vantageIndex) {
                [self.robotVantageTimers addObject:@"-1"];
            }
            [self.robotVantageTimers addObject:paramValue];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_NAME]) {
        NSInteger vantageIndex = 0;
        if(paramIndex) {
            vantageIndex = paramIndex.integerValue;
        }
        if(self.robotVantageNames.count > vantageIndex) {
            [self.robotVantageNames replaceObjectAtIndex:vantageIndex withObject:paramValue];
        }
        else {
            // Set every index below our current to -1 so we can maintain our current indexed value
            while(self.robotVantageNames.count < vantageIndex) {
                [self.robotVantageNames addObject:@" "];
            }
            [self.robotVantageNames addObject:paramValue];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_SEQUENCE]) {
        if([paramValue isEqualToString:@"-1"]) {
            self.robotVantageSequence = (RLMArray<RLMString> *)[[NSMutableArray alloc] init];
        }
        else {
            NSArray *vantageIndexes = [paramValue componentsSeparatedByString:@","];
            self.robotVantageSequence = (RLMArray<RLMString> *)[[NSMutableArray alloc] initWithArray:vantageIndexes];
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_CONFIGURATION_STATUS]) {
        if(self.robotVantageConfigurationStatus != paramValue.integerValue) {
            self.robotVantageConfigurationStatus = paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ROBOT_VANTAGE_MOVE_TO_INDEX]) {
        if(self.robotVantageMoveToIndex != paramValue.integerValue) {
            self.robotVantageMoveToIndex = paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ROBOT_ORIENTATION]) {
        if(self.robotOrientation != paramValue.boolValue) {
            self.robotOrientation = paramValue.boolValue;
        }
    }
    
    // Twitter
    else if([paramName isEqualToString:TWITTER_AUTO_SHARE]) {
        if(self.twitterAutoShare != (PPDeviceParametersTwitterAutoShare)paramValue.integerValue) {
            self.twitterAutoShare = (PPDeviceParametersTwitterAutoShare)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:TWITTER_DESCRIPTION]) {
        if(![self.twitterDescription isEqualToString:paramValue]) {
            self.twitterDescription = paramValue;
        }
    }
    else if([paramName isEqualToString:TWITTER_REMINDER]) {
        if(self.twitterReminder != (PPDeviceParametersTwitterReminder)paramValue.integerValue) {
            self.twitterReminder = (PPDeviceParametersTwitterReminder)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:TWITTER_STATUS]) {
        if(self.twitterStatus != (PPDeviceParametersTwitterStatus)paramValue.integerValue) {
            self.twitterStatus = (PPDeviceParametersTwitterStatus)paramValue.integerValue;
        }
        
        if(self.twitterAutoShare != paramValue.integerValue) {
            self.twitterAutoShare = (PPDeviceParametersTwitterAutoShare)paramValue.integerValue;
        }
    }
    
    // Various
    else if([paramName isEqualToString:HD_STATUS]) {
        if(self.HDStatus != (PPDeviceParametersHDStatus)paramValue.integerValue > 0) {
            // Pro features need an extra check
            self.HDStatus = (PPDeviceParametersHDStatus)paramValue.integerValue > 0;
        }
    }
    else if ([paramName isEqualToString:BATTERY_LEVEL]) {
        if(self.batteryLevel != (PPDeviceParametersBatteryLevel)paramValue.integerValue) {
            self.batteryLevel = (PPDeviceParametersBatteryLevel)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:CHARGING]) {
        if(self.charging != (PPDeviceParametersCharging)paramValue.integerValue > 0) {
            self.charging = (PPDeviceParametersCharging)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:VERSION]) {
        self.version = [[PPVersion alloc] initWithVersion:paramValue];
    }
    else if([paramName isEqualToString:AVAILABLE_BYTES]) {
        if(self.availableBytes != [[[[NSNumberFormatter alloc] init] numberFromString:paramValue] unsignedLongValue]) {
            self.availableBytes = [[[[NSNumberFormatter alloc] init] numberFromString:paramValue] unsignedLongValue];
        }
    }
    else if([paramName isEqualToString:BLACKOUT_SCREEN_ON]) {
        if(self.blackoutScreenOn != (PPDeviceParametersBlackoutScreenOn)paramValue.integerValue > 0) {
            self.blackoutScreenOn = (PPDeviceParametersBlackoutScreenOn)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:AUTO_FOCUS]) {
        if(self.autoFocus != (PPDeviceParametersAutoFocus)paramValue.boolValue) {
            self.autoFocus = (PPDeviceParametersAutoFocus)paramValue.boolValue;
        }
    }
    else if([paramName isEqualToString:OUTPUT_VOLUME]) {
        if(self.outputVolume != (PPDeviceParametersOutputVolume)paramValue.integerValue) {
            self.outputVolume = (PPDeviceParametersOutputVolume)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:CAPTURE_IMAGE]) {
        if(self.captureImage != (PPDeviceParametersCaptureImage)paramValue.integerValue) {
            self.captureImage = (PPDeviceParametersCaptureImage)paramValue.integerValue;
        }
    }
    
    // Security
    else if([paramName isEqualToString:ALARM]) {
        if(self.alarm != (PPDeviceParametersAlarm)paramValue.integerValue) {
            self.alarm = (PPDeviceParametersAlarm)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:PLAY_SOUND]) {
        if(![self.playSound isEqualToString:paramValue]) {
            self.playSound = paramValue;
        }
    }
    else if([paramName isEqualToString:COUNTDOWN]) {
        if(self.countdown != (PPDeviceParametersCountdown)paramValue.integerValue) {
            self.countdown = (PPDeviceParametersCountdown)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:VISUAL_COUNTDOWN]) {
        if(self.visualCountdown != (PPDeviceParametersVisualCountdown)paramValue.integerValue) {
            self.visualCountdown = (PPDeviceParametersVisualCountdown)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:KEYPAD_STATUS]) {
        if(![self.keypadStatus isEqualToString:paramValue]) {
            self.keypadStatus = paramValue;
        }
    }
    else if([paramName isEqualToString:MODE]) {
        if(![self.mode isEqualToString:paramValue]) {
            self.mode = paramValue;
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

- (void)updateSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera {
    if(self.selectedCamera == selectedCamera) {
        return;
    }
    [self setParameter:SELECTED_CAMERA value:[NSString stringWithFormat:@"%li", (long)selectedCamera] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash {
    if(self.selectedFlash == selectedFlash) {
        return;
    }
    [self setParameter:FLASH_ON value:[NSString stringWithFormat:@"%li", (long)selectedFlash] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMotionStatus:(PPDeviceParametersCameraMotionStatus)motionStatus {
    if(self.motionStatus == motionStatus) {
        return;
    }
    [self setParameter:MOTION_STATUS value:[NSString stringWithFormat:@"%li", (long)motionStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRecordSeconds:(PPDeviceParametersRecordSeconds)recordSeconds {
    if(self.recordSeconds == recordSeconds) {
        return;
    }
    [self setParameter:RECORD_SECONDS value:[NSString stringWithFormat:@"%li", (long)recordSeconds] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMotionSensitivity:(PPDeviceParametersMotionSensitiviy)motionSensitivity {
    if(self.motionSensitivity == motionSensitivity) {
        return;
    }
    [self setParameter:MOTION_SENSITIVITY value:[NSString stringWithFormat:@"%li", (long)motionSensitivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMotionActivity:(PPDeviceParametersMotionActivity)motionActivity {
    if(self.motionActivity == motionActivity) {
        return;
    }
    [self setParameter:MOTION_ACTIVITY value:[NSString stringWithFormat:@"%li", (long)motionActivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRapidMotionStatus:(PPDeviceParametersRapidMotionStatus)rapidMotionStatus {
    if(self.rapidMotionStatus == rapidMotionStatus) {
        return;
    }
    [self setParameter:RAPID_MOTION_STATUS value:[NSString stringWithFormat:@"%li", (long)rapidMotionStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMotionCountDownTime:(PPDeviceParametersMotionCountDownTime)motionCountDownTime {
    if(self.motionCountDownTime == motionCountDownTime) {
        return;
    }
    [self setParameter:MOTION_COUNTDOWN_TIME value:[NSString stringWithFormat:@"%li", (long)motionCountDownTime] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRecordFullDuration:(PPDeviceParametersRecordFullDuration)recordFullDuration {
    if(self.recordFullDuration == recordFullDuration) {
        return;
    }
    [self setParameter:RECORD_FULL_DURATION value:[NSString stringWithFormat:@"%li", (long)recordFullDuration] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [self setParameter:RECORD_STATUS value:[NSString stringWithFormat:@"%li", (long)recordStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMotionAlarm:(PPDeviceParametersAlarm)motionAlarm {
    if(self.motionAlarm == motionAlarm) {
        return;
    }
    [self setParameter:MOTION_ALARM value:[NSString stringWithFormat:@"%li", (long)motionAlarm] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAudioStatus:(PPDeviceParametersAudioStatus)audioStatus {
    if(self.audioStatus == audioStatus) {
        return;
    }
    [self setParameter:AUDIO_STATUS value:[NSString stringWithFormat:@"%li", (long)audioStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity {
    if(self.audioSensitivity == audioSensitivity) {
        return;
    }
    [self setParameter:AUDIO_SENSITIVITY value:[NSString stringWithFormat:@"%li", (long)audioSensitivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAudioActivity:(PPDeviceParametersAudioActivity)audioActivity {
    if(self.audioActivity == audioActivity) {
        return;
    }
    [self setParameter:AUDIO_ACTIVITY value:[NSString stringWithFormat:@"%li", (long)audioActivity] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming {
    if(self.audioStreaming == audioStreaming) {
        return;
    }
    [self setParameter:AUDIO_STREAMING value:[NSString stringWithFormat:@"%li", (long)audioStreaming] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming {
    if(self.videoStreaming == videoStreaming) {
        return;
    }
    [self setParameter:VIDEO_STREAMING value:[NSString stringWithFormat:@"%li", (long)videoStreaming] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAccessCameraSettings:(PPDeviceParametersAccessCameraSettings)accessCameraSettings {
    if(self.accessCameraSettings == accessCameraSettings) {
        return;
    }
    [self setParameter:ACCESS_CAMERA_SETTINGS value:[NSString stringWithFormat:@"%li", (long)accessCameraSettings] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateWarningStatus:(PPDeviceParametersWarningStatus)warningStatus {
    if(self.warningStatus == warningStatus) {
        return;
    }
    [self setParameter:WARNING_STATUS value:[NSString stringWithFormat:@"%li", (long)warningStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateWarningText:(NSString *)warningText {
    if(self.warningText == warningText) {
        return;
    }
    [self setParameter:WARNING_TEXT value:warningText index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [self setParameter:SUPPORTS_VIDEO_CALL value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRobotConnected:(PPDeviceParametersRobotConnected)robotConnected {
    if(self.robotConnected == robotConnected) {
        return;
    }
    [self setParameter:ROBOT_CONNECTED value:[NSString stringWithFormat:@"%li", (long)robotConnected] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRobotMotionDirection:(PPDeviceParametersRobotMotionDirection)robotMotionDirection {
    if(self.robotMotionDirection == robotMotionDirection) {
        return;
    }
    //    [self setParameter:ROBOT_CONNECTED value:[NSString stringWithFormat:@"%li", (long)robotConnected] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index {
    [self setParameter:ROBOT_VANTAGE_SPHERICAL_COORDINATES value:robotVantagePoint index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)updateRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index {
    NSMutableArray *robotVantageTimers = [NSMutableArray arrayWithArray:[PPRLMArray arrayFromArray:self.robotVantageTimers]];
    if(robotVantageTimers.count > index) {
        [robotVantageTimers replaceObjectAtIndex:index withObject:@(robotVantageTimer)];
    }
    else {
        while(robotVantageTimers.count < index) {
            [robotVantageTimers addObject:@"-1"];
        }
        [robotVantageTimers addObject:@(robotVantageTimer).stringValue];
    }
    [self setRobotVantageTimers:(RLMArray<RLMString> *)robotVantageTimers];
    
    [self setParameter:ROBOT_VANTAGE_TIME value:[NSString stringWithFormat:@"%li", (long)robotVantageTimer] index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)updateRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index {
    NSMutableArray *robotVantageNames = [NSMutableArray arrayWithArray:[PPRLMArray arrayFromArray:self.robotVantageNames]];
    if(robotVantageNames.count > index) {
        [robotVantageNames replaceObjectAtIndex:index withObject:robotVantageName];
    }
    else {
        while(robotVantageNames.count < index) {
            [robotVantageNames addObject:@" "];
        }
        [robotVantageNames addObject:robotVantageName];
    }
    [self setRobotVantageNames:(RLMArray<RLMString> *)robotVantageNames];
    [self setParameter:ROBOT_VANTAGE_NAME value:robotVantageName index:[NSString stringWithFormat:@"%li", (long)index] lastUpdateDate:[NSDate date]];
}

- (void)updateRobotVantageSequence:(NSMutableOrderedSet *)robotVantageSequence {
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

- (void)updateRobotVantageConfigurationStatus:(PPDeviceParametersRobotVantageConfigurationStatus)robotVantageConfigurationStatus {
    if(self.robotVantageConfigurationStatus == robotVantageConfigurationStatus) {
        return;
    }
    //    [self setParameter:ROBOT_VANTAGE_CONFIGURATION_STATUS value:[NSString stringWithFormat:@"%li", (long)robotVantageConfigurationStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRobotVantageMoveToIndex:(NSInteger)robotVantageMoveToIndex {
    if(self.robotVantageMoveToIndex == robotVantageMoveToIndex) {
        return;
    }
    //    [self setParameter:ROBOT_VANTAGE_MOVE_TO_INDEX value:[NSString stringWithFormat:@"%li", (long)robotVantageMoveToIndex] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateRobotOrientation:(PPDeviceParametersRobotOrientation)robotOrientation {
    if(self.robotOrientation == robotOrientation) {
        return;
    }
    //    [self setParameter:ROBOT_ORIENTATION value:[NSString stringWithFormat:@"%li", (long)robotOrientation] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateTwitterReminder:(PPDeviceParametersTwitterReminder)twitterReminder {
    if(self.twitterReminder == twitterReminder) {
        return;
    }
    [self setParameter:TWITTER_REMINDER value:[NSString stringWithFormat:@"%li", (long)twitterReminder] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateTwitterAutoShare:(PPDeviceParametersTwitterAutoShare)twitterAutoShare {
    if(self.twitterAutoShare == twitterAutoShare) {
        return;
    }
    [self setParameter:TWITTER_AUTO_SHARE value:[NSString stringWithFormat:@"%li", (long)twitterAutoShare] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateTwitterDescription:(NSString *)twitterDescription {
    if([self.twitterDescription isEqualToString:twitterDescription]) {
        return;
    }
    [self setParameter:TWITTER_DESCRIPTION value:twitterDescription index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateTwitterStatus:(PPDeviceParametersTwitterStatus)twitterStatus {
    if(self.twitterStatus == twitterStatus) {
        return;
    }
    [self setParameter:TWITTER_STATUS value:[NSString stringWithFormat:@"%li", (long)twitterStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateHDStatus:(PPDeviceParametersHDStatus)HDStatus {
    if(self.HDStatus == HDStatus) {
        return;
    }
    [self setParameter:HD_STATUS value:[NSString stringWithFormat:@"%li", (long)HDStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel {
    if(self.batteryLevel == batteryLevel) {
        return;
    }
    [self setParameter:BATTERY_LEVEL value:[NSString stringWithFormat:@"%li", (long)batteryLevel] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateCharging:(PPDeviceParametersCharging)charging {
    if(self.charging == charging) {
        return;
    }
    [self setParameter:CHARGING value:[NSString stringWithFormat:@"%li", (long)charging] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateVersion:(PPVersion *)version {
    if([[self.version toNSString] isEqualToString:[version toNSString]]) {
        return;
    }
    [self setParameter:VERSION value:[version toNSString] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAvailableBytes:(unsigned long long)availableBytes {
    if(self.availableBytes == availableBytes) {
        return;
    }
    [self setParameter:AVAILABLE_BYTES value:[NSString stringWithFormat:@"%llu", (unsigned long long )availableBytes] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn {
    if(self.blackoutScreenOn == blackoutScreenOn) {
        return;
    }
    [self setParameter:BLACKOUT_SCREEN_ON value:[NSString stringWithFormat:@"%li", (long)blackoutScreenOn] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAutoFocus:(PPDeviceParametersAutoFocus)autoFocus {
    if(self.autoFocus == autoFocus) {
        return;
    }
    //    [self setParameter:AUTO_FOCUS value:[NSString stringWithFormat:@"%li", (long)autoFocus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [self setParameter:OUTPUT_VOLUME value:[NSString stringWithFormat:@"%li", (long)outputVolume] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateCaptureImage:(PPDeviceParametersCaptureImage)captureImage {
    if(self.captureImage == captureImage) {
        return;
    }
    [self setParameter:CAPTURE_IMAGE value:[NSString stringWithFormat:@"%li", (long)captureImage] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlarm:(PPDeviceParametersAlarm)alarm {
    if(self.alarm == alarm) {
        return;
    }
    [self setParameter:ALARM value:[NSString stringWithFormat:@"%li", (long)alarm] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updatePlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    //    [self setParameter:PLAY_SOUND value:playSound index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateCountdown:(PPDeviceParametersCountdown)countdown {
    if(self.countdown == countdown) {
        return;
    }
    //    [self setParameter:COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)countdown] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateVisualCountdown:(PPDeviceParametersVisualCountdown)visualCountdown {
    if(self.visualCountdown == visualCountdown) {
        return;
    }
    //    [self setParameter:VISUAL_COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)visualCountdown] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateKeypadStatus:(NSString *)keypadStatus {
    if([self.keypadStatus isEqualToString:keypadStatus]) {
        return;
    }
    //    [self setParameter:KEYPAD_STATUS value:keypadStatus index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateMode:(NSString *)mode {
    if([self.mode isEqualToString:mode]) {
        return;
    }
    //    [self setParameter:MODE value:mode index:nil lastUpdateDate:[NSDate date]];
}



@end

