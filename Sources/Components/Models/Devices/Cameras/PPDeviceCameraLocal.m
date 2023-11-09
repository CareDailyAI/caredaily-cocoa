//
//  PPDeviceCameraLocal.m
//  Peoplepower
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceCameraLocal.h"
#import "PPDeviceProxyLocalCamera.h"
#import "PPDeviceProxy.h"

@implementation PPDeviceCameraLocal

+ (PPDeviceCameraLocal *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    return [[PPDeviceCameraLocal alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId userId:device.userId];
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

- (void)updateMotionStatus:(PPDeviceParametersCameraMotionStatus)motionStatus {
    if(self.motionStatus == motionStatus) {
        return;
    }
    [super updateMotionStatus:motionStatus];
    
    [self postMeasurement:MOTION_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)motionStatus]];
}

- (void)updateRecordSeconds:(PPDeviceParametersRecordSeconds)recordSeconds {
    if(self.recordSeconds == recordSeconds) {
        return;
    }
    [super updateRecordSeconds:recordSeconds];
    
    [self postMeasurement:RECORD_SECONDS index:nil value:[NSString stringWithFormat:@"%li", (long)recordSeconds]];
}

- (void)updateMotionSensitivity:(PPDeviceParametersMotionSensitiviy)motionSensitivity {
    if(self.motionSensitivity == motionSensitivity) {
        return;
    }
    [super updateMotionSensitivity:motionSensitivity];
    
    [self postMeasurement:MOTION_SENSITIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)motionSensitivity]];
}

- (void)updateMotionActivity:(PPDeviceParametersMotionActivity)motionActivity {
    if(self.motionActivity == motionActivity) {
        return;
    }
    [super updateMotionActivity:motionActivity];
    
    [self postMeasurement:MOTION_ACTIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)motionActivity]];
}

- (void)updateRapidMotionStatus:(PPDeviceParametersRapidMotionStatus)rapidMotionStatus {
    if(self.rapidMotionStatus == rapidMotionStatus) {
        return;
    }
    [super updateRapidMotionStatus:rapidMotionStatus];
    
    [self postMeasurement:RAPID_MOTION_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)rapidMotionStatus]];
}

- (void)updateMotionCountDownTime:(PPDeviceParametersMotionCountDownTime)motionCountDownTime {
    if(self.motionCountDownTime == motionCountDownTime) {
        return;
    }
    [super updateMotionCountDownTime:motionCountDownTime];
    
    [self postMeasurement:MOTION_COUNTDOWN_TIME index:nil value:[NSString stringWithFormat:@"%li", (long)motionCountDownTime]];
}

- (void)updateRecordFullDuration:(PPDeviceParametersRecordFullDuration)recordFullDuration {
    if(self.recordFullDuration == recordFullDuration) {
        return;
    }
    [super updateRecordFullDuration:recordFullDuration];
    
    [self postMeasurement:RECORD_FULL_DURATION index:nil value:[NSString stringWithFormat:@"%li", (long)recordFullDuration]];
}

- (void)updateRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [super updateRecordStatus:recordStatus];
    
    [self postMeasurement:RECORD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)recordStatus]];
}

- (void)updateMotionAlarm:(PPDeviceParametersAlarm)motionAlarm {
    if(self.motionAlarm == motionAlarm) {
        return;
    }
    [super updateMotionAlarm:motionAlarm];
    
    [self postMeasurement:MOTION_ALARM index:nil value:[NSString stringWithFormat:@"%li", (long)motionAlarm]];
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

- (void)updateAccessCameraSettings:(PPDeviceParametersAccessCameraSettings)accessCameraSettings {
    if(self.accessCameraSettings == accessCameraSettings) {
        return;
    }
    [super updateAccessCameraSettings:accessCameraSettings];
    
    [self postMeasurement:ACCESS_CAMERA_SETTINGS index:nil value:[NSString stringWithFormat:@"%li", (long)accessCameraSettings]];
}

- (void)updateWarningStatus:(PPDeviceParametersWarningStatus)warningStatus {
    if(self.warningStatus == warningStatus) {
        return;
    }
    [super updateWarningStatus:warningStatus];
    
    [self postMeasurement:WARNING_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)warningStatus]];
}

- (void)updateWarningText:(NSString *)warningText {
    if(self.warningText == warningText) {
        return;
    }
    [super updateWarningText:warningText];
    
    [self postMeasurement:WARNING_TEXT index:nil value:warningText];
}

- (void)updateSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [super updateSupportsVideoCall:supportsVideoCall];
    
    [self postMeasurement:SUPPORTS_VIDEO_CALL index:nil value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall]];
}

- (void)updateRobotConnected:(PPDeviceParametersRobotConnected)robotConnected {
    if(self.robotConnected == robotConnected) {
        return;
    }
    [super updateRobotConnected:robotConnected];
    
    [self postMeasurement:ROBOT_CONNECTED index:nil value:[NSString stringWithFormat:@"%li", (long)robotConnected]];
}

- (void)updateRobotMotionDirection:(PPDeviceParametersRobotMotionDirection)robotMotionDirection {
    if(self.robotMotionDirection == robotMotionDirection) {
        return;
    }
    [super updateRobotMotionDirection:robotMotionDirection];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_MOTION_DIRECTION value:[NSString stringWithFormat:@"%li", (long)robotMotionDirection] sessionID:NO];
}

- (void)updateRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index {
    [super updateRobotVantagePoint:robotVantagePoint index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_SPHERICAL_COORDINATES index:[NSString stringWithFormat:@"%li", (long)index] value:robotVantagePoint];
}

- (void)updateRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index {
    [super updateRobotVantageTimer:robotVantageTimer index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_TIME index:[NSString stringWithFormat:@"%li", (long)index] value:[NSString stringWithFormat:@"%li", (long)robotVantageTimer]];
}

- (void)updateRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index {
    [super updateRobotVantageName:robotVantageName index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_NAME index:[NSString stringWithFormat:@"%li", (long)index] value:robotVantageName];
}

- (void)updateRobotVantageSequence:(NSMutableArray *)robotVantageSequence {
    [super updateRobotVantageSequence:robotVantageSequence];

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
    [self postMeasurement:ROBOT_VANTAGE_SEQUENCE index:nil value:s];
}

- (void)updateRobotVantageConfigurationStatus:(PPDeviceParametersRobotVantageConfigurationStatus)robotVantageConfigurationStatus {
    if(self.robotVantageConfigurationStatus == robotVantageConfigurationStatus) {
        return;
    }
    [super updateRobotVantageConfigurationStatus:robotVantageConfigurationStatus];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_VANTAGE_CONFIGURATION_STATUS value:[NSString stringWithFormat:@"%li", (long)robotVantageConfigurationStatus] sessionID:NO];
}

- (void)updateRobotVantageMoveToIndex:(NSInteger)robotVantageMoveToIndex {
    if(self.robotVantageMoveToIndex == robotVantageMoveToIndex) {
        return;
    }
    [super updateRobotVantageMoveToIndex:robotVantageMoveToIndex];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_VANTAGE_MOVE_TO_INDEX value:[NSString stringWithFormat:@"%li", (long)robotVantageMoveToIndex] sessionID:NO];
}

- (void)updateRobotOrientation:(PPDeviceParametersRobotOrientation)robotOrientation {
    if(self.robotOrientation == robotOrientation) {
        return;
    }
    [super updateRobotOrientation:robotOrientation];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_ORIENTATION value:[NSString stringWithFormat:@"%li", (long)robotOrientation] sessionID:NO];
}

- (void)updateTwitterReminder:(PPDeviceParametersTwitterReminder)twitterReminder {
    if(self.twitterReminder == twitterReminder) {
        return;
    }
    [super updateTwitterReminder:twitterReminder];
    
    [self postMeasurement:TWITTER_REMINDER index:nil value:[NSString stringWithFormat:@"%li", (long)twitterReminder]];
}

- (void)updateTwitterAutoShare:(PPDeviceParametersTwitterAutoShare)twitterAutoShare {
    if(self.twitterAutoShare == twitterAutoShare) {
        return;
    }
    [super updateTwitterAutoShare:twitterAutoShare];
    
    [self postMeasurement:TWITTER_AUTO_SHARE index:nil value:[NSString stringWithFormat:@"%li", (long)twitterAutoShare]];
}

- (void)updateTwitterDescription:(NSString *)twitterDescription {
    if([self.twitterDescription isEqualToString:twitterDescription]) {
        return;
    }
    [super updateTwitterDescription:twitterDescription];
    
    [self postMeasurement:TWITTER_DESCRIPTION index:nil value:twitterDescription];
}

- (void)updateTwitterStatus:(PPDeviceParametersTwitterStatus)twitterStatus {
    if(self.twitterStatus == twitterStatus) {
        return;
    }
    [super updateTwitterStatus:twitterStatus];
    
    [self postMeasurement:TWITTER_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)twitterStatus]];
}

- (void)updateHDStatus:(PPDeviceParametersHDStatus)HDStatus {
    if(self.HDStatus == HDStatus) {
        return;
    }
    [super updateHDStatus:HDStatus];
    
    [self postMeasurement:HD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)HDStatus]];
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

- (void)updateAutoFocus:(PPDeviceParametersAutoFocus)autoFocus {
    if(self.autoFocus == autoFocus) {
        return;
    }
    [super updateAutoFocus:autoFocus];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:AUTO_FOCUS value:[NSString stringWithFormat:@"%li", (long)autoFocus] sessionID:NO];
}

- (void)updateOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [super updateOutputVolume:outputVolume];
    
    [self postMeasurement:OUTPUT_VOLUME index:nil value:[NSString stringWithFormat:@"%li", (long)outputVolume]];
}

- (void)updateCaptureImage:(PPDeviceParametersCaptureImage)captureImage {
    if(self.captureImage == captureImage) {
        return;
    }
    [super updateCaptureImage:captureImage];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:CAPTURE_IMAGE value:[NSString stringWithFormat:@"%li", (long)captureImage] sessionID:NO];
}

- (void)updateAlarm:(PPDeviceParametersAlarm)alarm {
    if(self.alarm == alarm) {
        return;
    }
    [super updateAlarm:alarm];
    
    [self postMeasurement:ALARM index:nil value:[NSString stringWithFormat:@"%li", (long)alarm]];
}

- (void)updatePlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    [super updatePlaySound:playSound];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:PLAY_SOUND value:playSound sessionID:NO];
}

- (void)updateCountdown:(PPDeviceParametersCountdown)countdown {
    if(self.countdown == countdown) {
        return;
    }
    [super updateCountdown:countdown];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)countdown] sessionID:NO];
}

- (void)updateVisualCountdown:(PPDeviceParametersVisualCountdown)visualCountdown {
    if(self.visualCountdown == visualCountdown) {
        return;
    }
    [super updateVisualCountdown:visualCountdown];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:VISUAL_COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)visualCountdown] sessionID:NO];
}

- (void)updateKeypadStatus:(NSString *)keypadStatus {
    if([self.keypadStatus isEqualToString:keypadStatus]) {
        return;
    }
    [super updateKeypadStatus:keypadStatus];
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:KEYPAD_STATUS value:keypadStatus sessionID:NO];
}

- (void)updateMode:(NSString *)mode {
    if([self.mode isEqualToString:mode]) {
        return;
    }
    [super updateMode:mode];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:MODE value:mode sessionID:NO];
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
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:name value:webSocketValue sessionID:NO];
    [[PPDeviceProxy currentProxy] sendMeasurement:[self measurementWithParameterName:name index:index value:value]];
}

@end
