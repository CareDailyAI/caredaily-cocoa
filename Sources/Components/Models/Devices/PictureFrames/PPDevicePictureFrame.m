//
//  PPDevicePictureFrame.m
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrame.h"
#import <AVFoundation/AVFoundation.h>

@interface PPDevicePictureFrame ()
@property (nonatomic) BOOL settingUpPictureFrameSessionAndPublisher;
@end

@implementation PPDevicePictureFrame
@synthesize selectedCamera;
@synthesize selectedFlash;
@synthesize audioStatus;
@synthesize recordStatus;
@synthesize audioSensitivity;
@synthesize audioActivity;
@synthesize audioStreaming;
@synthesize videoStreaming;
@synthesize streamId;
@synthesize supportsVideoCall;
@synthesize batteryLevel;
@synthesize charging;
@synthesize version;
@synthesize availableBytes;
@synthesize blackoutScreenOn;
@synthesize outputVolume;
@synthesize alertTitle;
@synthesize alertSubtitle;
@synthesize alertQuestionId;
@synthesize alertMessage;
@synthesize alertIcon;
@synthesize alertTimestamp;
@synthesize alertDuration;
@synthesize alertPriority;
@synthesize playSound;
@synthesize alertStatus;
@synthesize notification;

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId userId:(PPUserId)userId {
    self = [super initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes locationId:locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:userId];
    if(self) {
        
        for(PPDeviceParameter *defaultParam in [PPDevicePictureFrame defaultParameters]) {
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
- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use -initWithDeviceId:proxyId:name:connected:restricted:shared:newDevice:goalId:typeId:category:typeAttributes:locationId:startDate:lastDataReceivedDate:lastMeasureDate:lastConnectedDate:parameters:properties:icon:spaces:modelId:userId:", __FUNCTION__);
    return [self initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes locationId:locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:PPUserIdNone];
}

+ (NSMutableArray *)defaultParameters {
    NSMutableArray *defaultParameters = [[NSMutableArray alloc] initWithCapacity:0];
    return defaultParameters;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}

+ (PPDevicePictureFrame *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    return [[PPDevicePictureFrame alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId userId:device.userId];
}

+ (NSArray *)kvoObservers {
    return @[@"name",
             @"selectedCamera",
             @"selectedFlash",
             @"audioStatus",
             @"audioSensitivity",
             @"audioActivity",
             @"recordStatus",
             @"audioStreaming",
             @"videoStreaming",
             @"streamId",
             @"supportsVideoCall",
             @"batteryLevel",
             @"charging",
             @"version",
             @"availableBytes",
             @"blackoutScreenOn",
             @"outputVolume",
             @"alertTitle",
             @"alertSubtitle",
             @"alertQuestionId",
             @"alertMessage",
             @"alertIcon",
             @"alertTimestamp",
             @"alertDuration",
             @"alertPriority",
             @"playSound",
             @"alertStatus",
             @"notification"];
}

- (void)setProperties:(NSMutableArray *)properties {
    [super setProperties:properties];
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
    
    // Recording
    else if([paramName isEqualToString:AUDIO_STATUS]) {
        if(audioStatus != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioStatus))];
            audioStatus = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioStatus))];
        }
    }
    else if([paramName isEqualToString:AUDIO_SENSITIVITY]) {
        if(audioSensitivity != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioSensitivity))];
            audioSensitivity = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioSensitivity))];
        }
    }
    else if([paramName isEqualToString:AUDIO_ACTIVITY]) {
        if(audioActivity != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioActivity))];
            audioActivity = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(audioActivity))];
        }
    }
    else if([paramName isEqualToString:RECORD_STATUS]) {
        if(recordStatus != (PPDeviceParametersRecordStatus)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(recordStatus))];
            recordStatus = (PPDeviceParametersRecordStatus)paramValue.integerValue > 0;
            [self didChangeValueForKey:NSStringFromSelector(@selector(recordStatus))];
        }
    }
    
    // Streaming
    else if([paramName isEqualToString:AUDIO_STREAMING]) {
        if(audioStreaming != (PPDeviceParametersAudioStreaming)paramValue.integerValue > 0) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(audioStreaming))];
            audioStreaming = (PPDeviceParametersAudioStreaming)paramValue.integerValue > 0;
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
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:STREAM_ID]) {
        if(![streamId isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(streamId))];
            streamId = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(streamId))];
        }
    }
#endif
    else if([paramName isEqualToString:SUPPORTS_VIDEO_CALL]) {
        if(supportsVideoCall != paramValue.boolValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(supportsVideoCall))];
            supportsVideoCall = paramValue.boolValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(supportsVideoCall))];
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
    else if([paramName isEqualToString:OUTPUT_VOLUME]) {
        if(outputVolume != (PPDeviceParametersOutputVolume)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(outputVolume))];
            outputVolume = (PPDeviceParametersOutputVolume)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(outputVolume))];
        }
    }
    
    // Care
    else if([paramName isEqualToString:ALERT_TITLE]) {
        if(![alertTitle isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertTitle))];
            alertTitle = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertTitle))];
        }
    }
    else if([paramName isEqualToString:ALERT_SUBTITLE]) {
        if(![alertSubtitle isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertSubtitle))];
            alertSubtitle = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertSubtitle))];
        }
    }
    else if([paramName isEqualToString:ALERT_QUESTION_ID]) {
        if(alertQuestionId != (PPQuestionId)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertQuestionId))];
            alertQuestionId = (PPQuestionId)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertQuestionId))];
        }
    }
    else if([paramName isEqualToString:ALERT_MESSAGE]) {
        if(![alertMessage isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertMessage))];
            alertMessage = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertMessage))];
        }
    }
    else if([paramName isEqualToString:ALERT_ICON]) {
        if(![alertIcon isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertIcon))];
            alertIcon = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertIcon))];
        }
    }
    else if([paramName isEqualToString:ALERT_TIMESTAMP_MS]) {
        if([alertTimestamp timeIntervalSince1970] != (NSTimeInterval)paramValue.integerValue / 1000) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertTimestamp))];
            alertTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)paramValue.integerValue / 1000];
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertTimestamp))];
        }
    }
    else if([paramName isEqualToString:ALERT_DURATION_MS]) {
        if(alertDuration != (PPDeviceParametersAlertDuration)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertDuration))];
            alertDuration = (PPDeviceParametersAlertDuration)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertDuration))];
        }
    }
    else if([paramName isEqualToString:ALERT_PRIORITY]) {
        if(alertPriority != (PPDeviceParametersAlertPriority)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertPriority))];
            alertPriority = (PPDeviceParametersAlertPriority)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertPriority))];
        }
    }
    else if([paramName isEqualToString:PLAY_SOUND]) {
        if(![playSound isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(playSound))];
            playSound = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(playSound))];
        }
    }
    else if([paramName isEqualToString:ALERT_STATUS]) {
        if(alertStatus != (PPDeviceParametersAlertStatus)paramValue.integerValue) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(alertStatus))];
            alertStatus = (PPDeviceParametersAlertStatus)paramValue.integerValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(alertStatus))];
        }
    }
    else if([paramName isEqualToString:NOTIFICATION]) {
        if(![notification isEqualToString:paramValue]) {
            [self willChangeValueForKey:NSStringFromSelector(@selector(notification))];
            notification = paramValue;
            [self didChangeValueForKey:NSStringFromSelector(@selector(notification))];
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

- (void)setRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [self setParameter:RECORD_STATUS value:[NSString stringWithFormat:@"%li", (long)recordStatus] index:nil lastUpdateDate:[NSDate date]];
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

- (void)setSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [self setParameter:SUPPORTS_VIDEO_CALL value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall] index:nil lastUpdateDate:[NSDate date]];
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

- (void)setOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [self setParameter:OUTPUT_VOLUME value:[NSString stringWithFormat:@"%li", (long)outputVolume] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertTitle:(NSString *)alertTitle {
    if([self.alertTitle isEqualToString:alertTitle]) {
        return;
    }
//    [self setParameter:ALERT_TITLE value:alertTitle index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertSubtitle:(NSString *)alertSubtitle {
    if([self.alertSubtitle isEqualToString:alertSubtitle]) {
        return;
    }
//    [self setParameter:ALERT_SUBTITLE value:alertSubtitle index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertQuestionId:(PPQuestionId)alertQuestionId {
    if(self.alertQuestionId == alertQuestionId) {
        return;
    }
//    [self setParameter:ALERT_QUESTION_ID value:alertQuestionId index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertMessage:(NSString *)alertMessage {
    if([self.alertMessage isEqualToString:alertMessage]) {
        return;
    }
//    [self setParameter:ALERT_MESSAGE value:alertMessage index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertIcon:(NSString *)alertIcon {
    if([self.alertIcon isEqualToString:alertIcon]) {
        return;
    }
//    [self setParameter:ALERT_ICON value:alertIcon index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertTimestamp:(NSDate *)alertTimestamp {
    if([self.alertTimestamp compare:alertTimestamp] == NSOrderedSame) {
        return;
    }
//    [self setParameter:ALERT_TIMESTAMP_MS value:alertTimestamp index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertDuration:(PPDeviceParametersAlertDuration)alertDuration {
    if(self.alertDuration == alertDuration) {
        return;
    }
//    [self setParameter:ALERT_DURATION_MS value:alertDuration index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertPriority:(PPDeviceParametersAlertPriority)alertPriority {
    if(self.alertPriority == alertPriority) {
        return;
    }
//    [self setParameter:ALERT_PRIORITY value:alertPriority index:nil lastUpdateDate:[NSDate date]];
}

- (void)setPlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
//    [self setParameter:PLAY_SOUND value:playSound index:nil lastUpdateDate:[NSDate date]];
}

- (void)setAlertStatus:(PPDeviceParametersAlertStatus)alertStatus {
    if(self.alertStatus == alertStatus) {
        return;
    }
    [self setParameter:ALERT_STATUS value:[NSString stringWithFormat:@"%li", (long)alertStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)setNotification:(NSString *)notification {
    if([self.notification isEqualToString:notification]) {
        return;
    }
    //    [self setParameter:NOTIFICATION value:notification index:nil lastUpdateDate:[NSDate date]];
}


@end
