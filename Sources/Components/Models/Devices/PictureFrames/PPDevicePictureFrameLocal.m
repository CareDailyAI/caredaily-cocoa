//
//  PPDevicePictureFrameLocal.m
//  Peoplepower
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrameLocal.h"
#import "PPDeviceProxyLocalPictureFrame.h"
#import "PPDeviceProxy.h"

@implementation PPDevicePictureFrameLocal

+ (PPDevicePictureFrameLocal *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    return [[PPDevicePictureFrameLocal alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId userId:device.userId];
}

#pragma mark - Setters

- (void)setSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera {
    if(self.selectedCamera == selectedCamera) {
        return;
    }
    [super setSelectedCamera:selectedCamera];
    
    [self postMeasurement:SELECTED_CAMERA index:nil value:[NSString stringWithFormat:@"%li", (long)selectedCamera]];
}

- (void)setSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash {
    if(self.selectedFlash == selectedFlash) {
        return;
    }
    [super setSelectedFlash:selectedFlash];
    [self postMeasurement:FLASH_ON index:nil value:[NSString stringWithFormat:@"%li", (long)selectedFlash]];
}

- (void)setAudioStatus:(PPDeviceParametersAudioStatus)audioStatus {
    if(self.audioStatus == audioStatus) {
        return;
    }
    [super setAudioStatus:audioStatus];
    
    [self postMeasurement:AUDIO_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)audioStatus]];
}

- (void)setAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity {
    if(self.audioSensitivity == audioSensitivity) {
        return;
    }
    [super setAudioSensitivity:audioSensitivity];
    
    [self postMeasurement:AUDIO_SENSITIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)audioSensitivity]];
}

- (void)setAudioActivity:(PPDeviceParametersAudioActivity)audioActivity {
    if(self.audioActivity == audioActivity) {
        return;
    }
    [super setAudioActivity:audioActivity];
    
    [self postMeasurement:AUDIO_ACTIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)audioActivity]];
}

- (void)setRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [super setRecordStatus:recordStatus];
    
    [self postMeasurement:RECORD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)recordStatus]];
}

- (void)setAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming {
    if(self.audioStreaming == audioStreaming) {
        return;
    }
    [super setAudioStreaming:audioStreaming];

    [self postMeasurement:AUDIO_STREAMING index:nil value:[NSString stringWithFormat:@"%li", (long)audioStreaming]];
}

- (void)setVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming {
    if(self.videoStreaming == videoStreaming) {
        return;
    }
    [super setVideoStreaming:videoStreaming];
    
    [self postMeasurement:VIDEO_STREAMING index:nil value:[NSString stringWithFormat:@"%li", (long)videoStreaming]];
}

- (void)setSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [super setSupportsVideoCall:supportsVideoCall];
    
    [self postMeasurement:SUPPORTS_VIDEO_CALL index:nil value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall]];
}

- (void)setBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel {
    if(self.batteryLevel == batteryLevel) {
        return;
    }
    [super setBatteryLevel:batteryLevel];
    
    [self postMeasurement:BATTERY_LEVEL index:nil value:[NSString stringWithFormat:@"%li", (long)batteryLevel]];
}

- (void)setCharging:(PPDeviceParametersCharging)charging {
    if(self.charging == charging) {
        return;
    }
    [super setCharging:charging];
    
    [self postMeasurement:CHARGING index:nil value:[NSString stringWithFormat:@"%li", (long)charging]];
}

- (void)setVersion:(PPVersion *)version {
    if([[self.version toNSString] isEqualToString:[version toNSString]]) {
        return;
    }
    [super setVersion:version];
    
    [self postMeasurement:VERSION index:nil value:[version toNSString]];
}

- (void)setAvailableBytes:(unsigned long long)availableBytes {
    if(self.availableBytes == availableBytes) {
        return;
    }
    [super setAvailableBytes:availableBytes];
    
    [self postMeasurement:AVAILABLE_BYTES index:nil value:[NSString stringWithFormat:@"%li", (long)availableBytes]];
}

- (void)setBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn {
    if(self.blackoutScreenOn == blackoutScreenOn) {
        return;
    }
    [super setBlackoutScreenOn:blackoutScreenOn];
    
    [self postMeasurement:BLACKOUT_SCREEN_ON index:nil value:[NSString stringWithFormat:@"%li", (long)blackoutScreenOn]];
}

- (void)setOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [super setOutputVolume:outputVolume];
    
    [self postMeasurement:OUTPUT_VOLUME index:nil value:[NSString stringWithFormat:@"%li", (long)outputVolume]];
}

- (void)setAlertTitle:(NSString *)alertTitle {
    if([self.alertTitle isEqualToString:alertTitle]) {
        return;
    }
    [super setAlertTitle:alertTitle];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_TITLE value:alertTitle sessionID:NO];
}

- (void)setAlertSubtitle:(NSString *)alertSubtitle {
    if([self.alertSubtitle isEqualToString:alertSubtitle]) {
        return;
    }
    [super setAlertSubtitle:alertSubtitle];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_SUBTITLE value:alertSubtitle sessionID:NO];
}

- (void)setAlertQuestionId:(PPQuestionId)alertQuestionId {
    if(self.alertQuestionId == alertQuestionId) {
        return;
    }
    [super setAlertQuestionId:alertQuestionId];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_QUESTION_ID value:[NSString stringWithFormat:@"%li", (long)alertQuestionId] sessionID:NO];
}

- (void)setAlertMessage:(NSString *)alertMessage {
    if([self.alertMessage isEqualToString:alertMessage]) {
        return;
    }
    [super setAlertMessage:alertMessage];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_MESSAGE value:alertMessage sessionID:NO];
}

- (void)setAlertIcon:(NSString *)alertIcon {
    if([self.alertIcon isEqualToString:alertIcon]) {
        return;
    }
    [super setAlertIcon:alertIcon];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_ICON value:alertIcon sessionID:NO];
}

- (void)setAlertTimestamp:(NSDate *)alertTimestamp {
    if([self.alertTimestamp compare:alertTimestamp] == NSOrderedSame) {
        return;
    }
    [super setAlertTimestamp:alertTimestamp];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_TIMESTAMP_MS value:[NSString stringWithFormat:@"%li", (long)[alertTimestamp timeIntervalSince1970] * 1000] sessionID:NO];
}

- (void)setAlertDuration:(PPDeviceParametersAlertDuration)alertDuration {
    if(self.alertDuration == alertDuration) {
        return;
    }
    [super setAlertDuration:alertDuration];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_DURATION_MS value:[NSString stringWithFormat:@"%li", (long)alertDuration] sessionID:NO];
}

- (void)setAlertPriority:(PPDeviceParametersAlertPriority)alertPriority {
    if(self.alertPriority == alertPriority) {
        return;
    }
    [super setAlertPriority:alertPriority];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_PRIORITY value:[NSString stringWithFormat:@"%li", (long)alertPriority] sessionID:NO];
}

- (void)setPlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    [super setPlaySound:playSound];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:PLAY_SOUND value:playSound sessionID:NO];
}

- (void)setAlertStatus:(PPDeviceParametersAlertStatus)alertStatus {
    if(self.alertStatus == alertStatus) {
        return;
    }
    [super setAlertStatus:alertStatus];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_STATUS value:[NSString stringWithFormat:@"%li", (long)alertStatus] sessionID:NO];
}

- (void)setNotification:(NSString *)notification {
    if([self.notification isEqualToString:notification]) {
        return;
    }
    [super setNotification:notification];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:NOTIFICATION value:notification sessionID:NO];
}

#pragma mark - Private

- (PPDeviceMeasurement *)measurementWithParameterName:(NSString *)name index:(NSString *)index value:(NSString *)value {
    PPDeviceParameter *parameter = [[PPDeviceParameter alloc] initWithName:name index:index value:value lastUpdateDate:[NSDate date]];
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:self.deviceId lastDataReceivedDate:self.lastDataReceivedDate lastMeasureDate:self.lastMeasureDate params:@[parameter]];
    return measurement;
}

- (void)postMeasurement:(NSString *)name index:(NSString *)index value:(NSString *)value {
    NSString *webSocketValue = value;
    if(index) {
        webSocketValue = [NSString stringWithFormat:@"{%@:%@}", index, value];
    }
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:name value:webSocketValue sessionID:NO];
    [[PPDeviceProxy currentProxy] sendMeasurement:[self measurementWithParameterName:name index:index value:value]];
}

@end
