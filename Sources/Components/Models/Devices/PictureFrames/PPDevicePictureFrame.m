//
//  PPDevicePictureFrame.m
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrame.h"
#import <AVFoundation/AVFoundation.h>

// PictureFrame parameter refresh interval
NSInteger PICTURE_FRAME_REFRESH_INTERVAL = 150;

// Streaming connection attemp limit
NSInteger PICTURE_FRAME_STREAMING_CONNECTION_ATTEMPT_LIMIT = 5;

// Camera output volume
PPDeviceParametersOutputVolume PICTURE_FRAME_VOLUME_OUTPUT_MAXIMUM = 16;
PPDeviceParametersOutputVolume PICTURE_FRAME_VOLUME_OUTPUT_DEFAULT = 8;

@interface PPDevicePictureFrame ()
@property (nonatomic) BOOL settingUpPictureFrameSessionAndPublisher;
@end

@implementation PPDevicePictureFrame
/*
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
 */

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId {
    self = [super initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:(RLMArray<PPDeviceTypeAttribute *><PPDeviceTypeAttribute> *)typeAttributes locationId:locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:(RLMArray<PPDeviceParameter *><PPDeviceParameter> *)parameters properties:(RLMArray<PPDeviceProperty *><PPDeviceProperty> *)properties icon:icon spaces:(RLMArray<PPLocationSpace *><PPLocationSpace> *)spaces modelId:modelId];
    if(self) {
        
        for(PPDeviceParameter *defaultParam in [PPDevicePictureFrame defaultParameters]) {
            BOOL found = NO;
            for(PPDeviceParameter *param in [[PPRLMArray arrayFromArray:parameters] copy]) {
                if([defaultParam isEqual:param]) {
                    found = YES;
                    break;
                }
            }
            if(!found) {
                [super setParameter:defaultParam.name value:defaultParam.value index:defaultParam.index lastUpdateDate:defaultParam.lastUpdateDate];
            }
        }
        
        for(PPDeviceParameter *param in [[PPRLMArray arrayFromArray:parameters] copy]) {
            [super setParameter:param.name value:param.value index:param.index lastUpdateDate:param.lastUpdateDate];
        }
    }
    return self;
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
    
    return [[PPDevicePictureFrame alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId];
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

- (void)setProperties:(RLMArray *)properties {
    [super setProperties:(RLMArray<PPDeviceProperty *><PPDeviceProperty> *)properties];
}

- (void)setParameter:(NSString *)paramName value:(NSString *)paramValue index:(NSString *)paramIndex lastUpdateDate:(NSDate *)paramLastUpdateDate {
    [super setParameter:paramName value:paramValue index:paramIndex lastUpdateDate:paramLastUpdateDate];
    
    [[PPRealm defaultRealm] beginWriteTransaction];
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
    
    // Recording
    else if([paramName isEqualToString:AUDIO_STATUS]) {
        if(self.audioStatus != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            self.audioStatus = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:AUDIO_SENSITIVITY]) {
        if(self.audioSensitivity != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            self.audioSensitivity = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:AUDIO_ACTIVITY]) {
        if(self.audioActivity != (PPDeviceParametersAudioStatus)paramValue.integerValue > 0) {
            self.audioActivity = (PPDeviceParametersAudioStatus)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:RECORD_STATUS]) {
        if(self.recordStatus != (PPDeviceParametersRecordStatus)paramValue.integerValue > 0) {
            self.recordStatus = (PPDeviceParametersRecordStatus)paramValue.integerValue > 0;
        }
    }
    
    // Streaming
    else if([paramName isEqualToString:AUDIO_STREAMING]) {
        if(self.audioStreaming != (PPDeviceParametersAudioStreaming)paramValue.integerValue > 0) {
            self.audioStreaming = (PPDeviceParametersAudioStreaming)paramValue.integerValue > 0;
        }
    }
    else if([paramName isEqualToString:VIDEO_STREAMING]) {
        if(self.videoStreaming != (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0) {
            self.videoStreaming = (PPDeviceParametersVideoStreaming)paramValue.integerValue > 0;
        }
    }
#if !TARGET_OS_WATCH
    else if([paramName isEqualToString:STREAM_ID]) {
        if(![self.streamId isEqualToString:paramValue]) {
            self.streamId = paramValue;
        }
    }
#endif
    else if([paramName isEqualToString:SUPPORTS_VIDEO_CALL]) {
        if(self.supportsVideoCall != paramValue.boolValue) {
            self.supportsVideoCall = paramValue.boolValue;
        }
    }
    else if([paramName isEqualToString:RECORD_STREAM]) {
        if(self.recordStream != paramValue.integerValue) {
            self.recordStream = paramValue.integerValue;
        }
    }
    
    // Various
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
    else if([paramName isEqualToString:OUTPUT_VOLUME]) {
        if(self.outputVolume != (PPDeviceParametersOutputVolume)paramValue.integerValue) {
            self.outputVolume = (PPDeviceParametersOutputVolume)paramValue.integerValue;
        }
    }
    
    // Care
    else if([paramName isEqualToString:ALERT_TITLE]) {
        if(![self.alertTitle isEqualToString:paramValue]) {
            self.alertTitle = paramValue;
        }
    }
    else if([paramName isEqualToString:ALERT_SUBTITLE]) {
        if(![self.alertSubtitle isEqualToString:paramValue]) {
            self.alertSubtitle = paramValue;
        }
    }
    else if([paramName isEqualToString:ALERT_QUESTION_ID]) {
        if(self.alertQuestionId != (PPQuestionId)paramValue.integerValue) {
            self.alertQuestionId = (PPQuestionId)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ALERT_MESSAGE]) {
        if(![self.alertMessage isEqualToString:paramValue]) {
            self.alertMessage = paramValue;
        }
    }
    else if([paramName isEqualToString:ALERT_ICON]) {
        if(![self.alertIcon isEqualToString:paramValue]) {
            self.alertIcon = paramValue;
        }
    }
    else if([paramName isEqualToString:ALERT_TIMESTAMP_MS]) {
        if([self.alertTimestamp timeIntervalSince1970] != (NSTimeInterval)paramValue.integerValue / 1000) {
            self.alertTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)paramValue.integerValue / 1000];
        }
    }
    else if([paramName isEqualToString:ALERT_DURATION_MS]) {
        if(self.alertDuration != (PPDeviceParametersAlertDuration)paramValue.integerValue) {
            self.alertDuration = (PPDeviceParametersAlertDuration)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:ALERT_PRIORITY]) {
        if(self.alertPriority != (PPDeviceParametersAlertPriority)paramValue.integerValue) {
            self.alertPriority = (PPDeviceParametersAlertPriority)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:PLAY_SOUND]) {
        if(![self.playSound isEqualToString:paramValue]) {
            self.playSound = paramValue;
        }
    }
    else if([paramName isEqualToString:ALERT_STATUS]) {
        if(self.alertStatus != (PPDeviceParametersAlertStatus)paramValue.integerValue) {
            self.alertStatus = (PPDeviceParametersAlertStatus)paramValue.integerValue;
        }
    }
    else if([paramName isEqualToString:NOTIFICATION]) {
        if(![self.notification isEqualToString:paramValue]) {
            self.notification = paramValue;
        }
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
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

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [self setParameter:RECORD_STATUS value:[NSString stringWithFormat:@"%li", (long)recordStatus] index:nil lastUpdateDate:[NSDate date]];
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

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [self setParameter:SUPPORTS_VIDEO_CALL value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall] index:nil lastUpdateDate:[NSDate date]];
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

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [self setParameter:OUTPUT_VOLUME value:[NSString stringWithFormat:@"%li", (long)outputVolume] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertTitle:(NSString *)alertTitle {
    if([self.alertTitle isEqualToString:alertTitle]) {
        return;
    }
    [self setParameter:ALERT_TITLE value:alertTitle index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertSubtitle:(NSString *)alertSubtitle {
    if([self.alertSubtitle isEqualToString:alertSubtitle]) {
        return;
    }
    [self setParameter:ALERT_SUBTITLE value:alertSubtitle index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertQuestionId:(PPQuestionId)alertQuestionId {
    if(self.alertQuestionId == alertQuestionId) {
        return;
    }
    [self setParameter:ALERT_QUESTION_ID value:[NSString stringWithFormat:@"%li", (long)alertQuestionId] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertMessage:(NSString *)alertMessage {
    if([self.alertMessage isEqualToString:alertMessage]) {
        return;
    }
    [self setParameter:ALERT_MESSAGE value:alertMessage index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertIcon:(NSString *)alertIcon {
    if([self.alertIcon isEqualToString:alertIcon]) {
        return;
    }
    [self setParameter:ALERT_ICON value:alertIcon index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertTimestamp:(NSDate *)alertTimestamp {
    if([self.alertTimestamp compare:alertTimestamp] == NSOrderedSame) {
        return;
    }
    [self setParameter:ALERT_TIMESTAMP_MS value:[NSString stringWithFormat:@"%f", [alertTimestamp timeIntervalSince1970] * 1000] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertDuration:(PPDeviceParametersAlertDuration)alertDuration {
    if(self.alertDuration == alertDuration) {
        return;
    }
    [self setParameter:ALERT_DURATION_MS value:[NSString stringWithFormat:@"%li", (long)alertDuration] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertPriority:(PPDeviceParametersAlertPriority)alertPriority {
    if(self.alertPriority == alertPriority) {
        return;
    }
    [self setParameter:ALERT_PRIORITY value:[NSString stringWithFormat:@"%li", (long)alertPriority] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updatePlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
//    [self setParameter:PLAY_SOUND value:playSound index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateAlertStatus:(PPDeviceParametersAlertStatus)alertStatus {
    if(self.alertStatus == alertStatus) {
        return;
    }
    [self setParameter:ALERT_STATUS value:[NSString stringWithFormat:@"%li", (long)alertStatus] index:nil lastUpdateDate:[NSDate date]];
}

- (void)updateNotification:(NSString *)notification {
    if([self.notification isEqualToString:notification]) {
        return;
    }
    //    [self setParameter:NOTIFICATION value:notification index:nil lastUpdateDate:[NSDate date]];
}


@end
