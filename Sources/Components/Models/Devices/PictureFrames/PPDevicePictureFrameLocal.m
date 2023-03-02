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
    
    return [[PPDevicePictureFrameLocal alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId];
}

#pragma mark - Setters

- (void)updateSelectedCamera:(PPDeviceParametersSelectedCamera)selectedCamera {
    if(self.selectedCamera == selectedCamera) {
        return;
    }
    [super updateSelectedCamera:selectedCamera];
    
    [self postMeasurement:SELECTED_CAMERA index:nil value:[NSString stringWithFormat:@"%li", (long)selectedCamera]];
}

- (void)updateSelectedFlash:(PPDeviceParametersSelectedFlash)selectedFlash {
    if(self.selectedFlash == selectedFlash) {
        return;
    }
    [super updateSelectedFlash:selectedFlash];
    [self postMeasurement:FLASH_ON index:nil value:[NSString stringWithFormat:@"%li", (long)selectedFlash]];
}

- (void)updateAudioStatus:(PPDeviceParametersAudioStatus)audioStatus {
    if(self.audioStatus == audioStatus) {
        return;
    }
    [super updateAudioStatus:audioStatus];
    
    [self postMeasurement:AUDIO_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)audioStatus]];
}

- (void)updateAudioSensitivity:(PPDeviceParametersAudioSensitiviy)audioSensitivity {
    if(self.audioSensitivity == audioSensitivity) {
        return;
    }
    [super updateAudioSensitivity:audioSensitivity];
    
    [self postMeasurement:AUDIO_SENSITIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)audioSensitivity]];
}

- (void)updateAudioActivity:(PPDeviceParametersAudioActivity)audioActivity {
    if(self.audioActivity == audioActivity) {
        return;
    }
    [super updateAudioActivity:audioActivity];
    
    [self postMeasurement:AUDIO_ACTIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)audioActivity]];
}

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [super updateRecordStatus:recordStatus];
    
    [self postMeasurement:RECORD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)recordStatus]];
}

- (void)updateAudioStreaming:(PPDeviceParametersAudioStreaming)audioStreaming {
    if(self.audioStreaming == audioStreaming) {
        return;
    }
    [super updateAudioStreaming:audioStreaming];

    [self postMeasurement:AUDIO_STREAMING index:nil value:[NSString stringWithFormat:@"%li", (long)audioStreaming]];
}

- (void)updateVideoStreaming:(PPDeviceParametersVideoStreaming)videoStreaming {
    if(self.videoStreaming == videoStreaming) {
        return;
    }
    [super updateVideoStreaming:videoStreaming];
    
    [self postMeasurement:VIDEO_STREAMING index:nil value:[NSString stringWithFormat:@"%li", (long)videoStreaming]];
}

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [super updateSupportsVideoCall:supportsVideoCall];
    
    [self postMeasurement:SUPPORTS_VIDEO_CALL index:nil value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall]];
}

- (void)updateBatteryLevel:(PPDeviceParametersBatteryLevel)batteryLevel {
    if(self.batteryLevel == batteryLevel) {
        return;
    }
    [super updateBatteryLevel:batteryLevel];
    
    [self postMeasurement:BATTERY_LEVEL index:nil value:[NSString stringWithFormat:@"%li", (long)batteryLevel]];
}

- (void)updateCharging:(PPDeviceParametersCharging)charging {
    if(self.charging == charging) {
        return;
    }
    [super updateCharging:charging];
    
    [self postMeasurement:CHARGING index:nil value:[NSString stringWithFormat:@"%li", (long)charging]];
}

- (void)updateVersion:(PPVersion *)version {
    if([[self.version toNSString] isEqualToString:[version toNSString]]) {
        return;
    }
    [super updateVersion:version];
    
    [self postMeasurement:VERSION index:nil value:[version toNSString]];
}

- (void)updateAvailableBytes:(unsigned long long)availableBytes {
    if(self.availableBytes == availableBytes) {
        return;
    }
    [super updateAvailableBytes:availableBytes];
    
    [self postMeasurement:AVAILABLE_BYTES index:nil value:[NSString stringWithFormat:@"%li", (long)availableBytes]];
}

- (void)updateBlackoutScreenOn:(PPDeviceParametersBlackoutScreenOn)blackoutScreenOn {
    if(self.blackoutScreenOn == blackoutScreenOn) {
        return;
    }
    [super updateBlackoutScreenOn:blackoutScreenOn];
    
    [self postMeasurement:BLACKOUT_SCREEN_ON index:nil value:[NSString stringWithFormat:@"%li", (long)blackoutScreenOn]];
}

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [super updateOutputVolume:outputVolume];
    
    [self postMeasurement:OUTPUT_VOLUME index:nil value:[NSString stringWithFormat:@"%li", (long)outputVolume]];
}

- (void)updateAlertTitle:(NSString *)alertTitle {
    if([self.alertTitle isEqualToString:alertTitle]) {
        return;
    }
    [super updateAlertTitle:alertTitle];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_TITLE value:alertTitle sessionID:NO];
}

- (void)updateAlertSubtitle:(NSString *)alertSubtitle {
    if([self.alertSubtitle isEqualToString:alertSubtitle]) {
        return;
    }
    [super updateAlertSubtitle:alertSubtitle];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_SUBTITLE value:alertSubtitle sessionID:NO];
}

- (void)updateAlertQuestionId:(PPQuestionId)alertQuestionId {
    if(self.alertQuestionId == alertQuestionId) {
        return;
    }
    [super updateAlertQuestionId:alertQuestionId];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_QUESTION_ID value:[NSString stringWithFormat:@"%li", (long)alertQuestionId] sessionID:NO];
}

- (void)updateAlertMessage:(NSString *)alertMessage {
    if([self.alertMessage isEqualToString:alertMessage]) {
        return;
    }
    [super updateAlertMessage:alertMessage];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_MESSAGE value:alertMessage sessionID:NO];
}

- (void)updateAlertIcon:(NSString *)alertIcon {
    if([self.alertIcon isEqualToString:alertIcon]) {
        return;
    }
    [super updateAlertIcon:alertIcon];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_ICON value:alertIcon sessionID:NO];
}

- (void)updateAlertTimestamp:(NSDate *)alertTimestamp {
    if([self.alertTimestamp compare:alertTimestamp] == NSOrderedSame) {
        return;
    }
    [super updateAlertTimestamp:alertTimestamp];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_TIMESTAMP_MS value:[NSString stringWithFormat:@"%li", (long)[alertTimestamp timeIntervalSince1970] * 1000] sessionID:NO];
}

- (void)updateAlertDuration:(PPDeviceParametersAlertDuration)alertDuration {
    if(self.alertDuration == alertDuration) {
        return;
    }
    [super updateAlertDuration:alertDuration];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_DURATION_MS value:[NSString stringWithFormat:@"%li", (long)alertDuration] sessionID:NO];
}

- (void)updateAlertPriority:(PPDeviceParametersAlertPriority)alertPriority {
    if(self.alertPriority == alertPriority) {
        return;
    }
    [super updateAlertPriority:alertPriority];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_PRIORITY value:[NSString stringWithFormat:@"%li", (long)alertPriority] sessionID:NO];
}

- (void)updatePlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    [super updatePlaySound:playSound];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:PLAY_SOUND value:playSound sessionID:NO];
}

- (void)updateAlertStatus:(PPDeviceParametersAlertStatus)alertStatus {
    if(self.alertStatus == alertStatus) {
        return;
    }
    [super updateAlertStatus:alertStatus];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ALERT_STATUS value:[NSString stringWithFormat:@"%li", (long)alertStatus] sessionID:NO];
}

- (void)updateNotification:(NSString *)notification {
    if([self.notification isEqualToString:notification]) {
        return;
    }
    [super updateNotification:notification];
    
    [((PPDeviceProxyLocalPictureFrame *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:NOTIFICATION value:notification sessionID:NO];
}

#pragma mark - Private

- (PPDeviceMeasurement *)measurementWithParameterName:(NSString *)name index:(NSString *)index value:(NSString *)value {
    PPDeviceParameter *parameter = [[PPDeviceParameter alloc] initWithName:name index:index value:value lastUpdateDate:[NSDate date]];
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:self.deviceId lastDataReceivedDate:self.lastDataReceivedDate lastMeasureDate:self.lastMeasureDate params:(RLMArray *)@[parameter]];
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
