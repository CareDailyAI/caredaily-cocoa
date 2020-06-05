//
//  PPDeviceCameraLocal.m
//  PPiOSCore
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceCameraLocal.h"
#import "PPDeviceProxyLocalCamera.h"
#import "PPDeviceProxy.h"

@implementation PPDeviceCameraLocal

+ (PPDeviceCameraLocal *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    return [[PPDeviceCameraLocal alloc] initWithDeviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes locationId:device.locationId startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId];
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

- (void)setMotionStatus:(PPDeviceParametersCameraMotionStatus)motionStatus {
    if(self.motionStatus == motionStatus) {
        return;
    }
    [super setMotionStatus:motionStatus];
    
    [self postMeasurement:MOTION_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)motionStatus]];
}

- (void)setRecordSeconds:(PPDeviceParametersRecordSeconds)recordSeconds {
    if(self.recordSeconds == recordSeconds) {
        return;
    }
    [super setRecordSeconds:recordSeconds];
    
    [self postMeasurement:RECORD_SECONDS index:nil value:[NSString stringWithFormat:@"%li", (long)recordSeconds]];
}

- (void)setMotionSensitivity:(PPDeviceParametersMotionSensitiviy)motionSensitivity {
    if(self.motionSensitivity == motionSensitivity) {
        return;
    }
    [super setMotionSensitivity:motionSensitivity];
    
    [self postMeasurement:MOTION_SENSITIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)motionSensitivity]];
}

- (void)setMotionActivity:(PPDeviceParametersMotionActivity)motionActivity {
    if(self.motionActivity == motionActivity) {
        return;
    }
    [super setMotionActivity:motionActivity];
    
    [self postMeasurement:MOTION_ACTIVITY index:nil value:[NSString stringWithFormat:@"%li", (long)motionActivity]];
}

- (void)setRapidMotionStatus:(PPDeviceParametersRapidMotionStatus)rapidMotionStatus {
    if(self.rapidMotionStatus == rapidMotionStatus) {
        return;
    }
    [super setRapidMotionStatus:rapidMotionStatus];
    
    [self postMeasurement:RAPID_MOTION_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)rapidMotionStatus]];
}

- (void)setMotionCountDownTime:(PPDeviceParametersMotionCountDownTime)motionCountDownTime {
    if(self.motionCountDownTime == motionCountDownTime) {
        return;
    }
    [super setMotionCountDownTime:motionCountDownTime];
    
    [self postMeasurement:MOTION_COUNTDOWN_TIME index:nil value:[NSString stringWithFormat:@"%li", (long)motionCountDownTime]];
}

- (void)setRecordFullDuration:(PPDeviceParametersRecordFullDuration)recordFullDuration {
    if(self.recordFullDuration == recordFullDuration) {
        return;
    }
    [super setRecordFullDuration:recordFullDuration];
    
    [self postMeasurement:RECORD_FULL_DURATION index:nil value:[NSString stringWithFormat:@"%li", (long)recordFullDuration]];
}

- (void)setRecordStatus:(PPDeviceParametersRecordStatus)recordStatus {
    if(self.recordStatus == recordStatus) {
        return;
    }
    [super setRecordStatus:recordStatus];
    
    [self postMeasurement:RECORD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)recordStatus]];
}

- (void)setMotionAlarm:(PPDeviceParametersAlarm)motionAlarm {
    if(self.motionAlarm == motionAlarm) {
        return;
    }
    [super setMotionAlarm:motionAlarm];
    
    [self postMeasurement:MOTION_ALARM index:nil value:[NSString stringWithFormat:@"%li", (long)motionAlarm]];
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

- (void)setAccessCameraSettings:(PPDeviceParametersAccessCameraSettings)accessCameraSettings {
    if(self.accessCameraSettings == accessCameraSettings) {
        return;
    }
    [super setAccessCameraSettings:accessCameraSettings];
    
    [self postMeasurement:ACCESS_CAMERA_SETTINGS index:nil value:[NSString stringWithFormat:@"%li", (long)accessCameraSettings]];
}

- (void)setWarningStatus:(PPDeviceParametersWarningStatus)warningStatus {
    if(self.warningStatus == warningStatus) {
        return;
    }
    [super setWarningStatus:warningStatus];
    
    [self postMeasurement:WARNING_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)warningStatus]];
}

- (void)setWarningText:(NSString *)warningText {
    if(self.warningText == warningText) {
        return;
    }
    [super setWarningText:warningText];
    
    [self postMeasurement:WARNING_TEXT index:nil value:warningText];
}

- (void)setSupportsVideoCall:(PPDeviceParametersSupportsVideoCall)supportsVideoCall {
    if(self.supportsVideoCall == supportsVideoCall) {
        return;
    }
    [super setSupportsVideoCall:supportsVideoCall];
    
    [self postMeasurement:SUPPORTS_VIDEO_CALL index:nil value:[NSString stringWithFormat:@"%li", (long)supportsVideoCall]];
}

- (void)setRobotConnected:(PPDeviceParametersRobotConnected)robotConnected {
    if(self.robotConnected == robotConnected) {
        return;
    }
    [super setRobotConnected:robotConnected];
    
    [self postMeasurement:ROBOT_CONNECTED index:nil value:[NSString stringWithFormat:@"%li", (long)robotConnected]];
}

- (void)setRobotMotionDirection:(PPDeviceParametersRobotMotionDirection)robotMotionDirection {
    if(self.robotMotionDirection == robotMotionDirection) {
        return;
    }
    [super setRobotMotionDirection:robotMotionDirection];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_MOTION_DIRECTION value:[NSString stringWithFormat:@"%li", (long)robotMotionDirection] sessionID:NO];
}

- (void)setRobotVantagePoint:(NSString *)robotVantagePoint index:(NSInteger)index {
    [super setRobotVantagePoint:robotVantagePoint index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_SPHERICAL_COORDINATES index:[NSString stringWithFormat:@"%li", (long)index] value:robotVantagePoint];
}

- (void)setRobotVantageTimer:(NSInteger)robotVantageTimer index:(NSInteger)index {
    [super setRobotVantageTimer:robotVantageTimer index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_TIME index:[NSString stringWithFormat:@"%li", (long)index] value:[NSString stringWithFormat:@"%li", (long)robotVantageTimer]];
}

- (void)setRobotVantageName:(NSString *)robotVantageName index:(NSInteger)index {
    [super setRobotVantageName:robotVantageName index:index];
    
    [self postMeasurement:ROBOT_VANTAGE_NAME index:[NSString stringWithFormat:@"%li", (long)index] value:robotVantageName];
}

- (void)setRobotVantageSequence:(NSMutableArray *)robotVantageSequence {
    [super setRobotVantageSequence:robotVantageSequence];

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

- (void)setRobotVantageConfigurationStatus:(PPDeviceParametersRobotVantageConfigurationStatus)robotVantageConfigurationStatus {
    if(self.robotVantageConfigurationStatus == robotVantageConfigurationStatus) {
        return;
    }
    [super setRobotVantageConfigurationStatus:robotVantageConfigurationStatus];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_VANTAGE_CONFIGURATION_STATUS value:[NSString stringWithFormat:@"%li", (long)robotVantageConfigurationStatus] sessionID:NO];
}

- (void)setRobotVantageMoveToIndex:(NSInteger)robotVantageMoveToIndex {
    if(self.robotVantageMoveToIndex == robotVantageMoveToIndex) {
        return;
    }
    [super setRobotVantageMoveToIndex:robotVantageMoveToIndex];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_VANTAGE_MOVE_TO_INDEX value:[NSString stringWithFormat:@"%li", (long)robotVantageMoveToIndex] sessionID:NO];
}

- (void)setRobotOrientation:(PPDeviceParametersRobotOrientation)robotOrientation {
    if(self.robotOrientation == robotOrientation) {
        return;
    }
    [super setRobotOrientation:robotOrientation];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:ROBOT_ORIENTATION value:[NSString stringWithFormat:@"%li", (long)robotOrientation] sessionID:NO];
}

- (void)setTwitterReminder:(PPDeviceParametersTwitterReminder)twitterReminder {
    if(self.twitterReminder == twitterReminder) {
        return;
    }
    [super setTwitterReminder:twitterReminder];
    
    [self postMeasurement:TWITTER_REMINDER index:nil value:[NSString stringWithFormat:@"%li", (long)twitterReminder]];
}

- (void)setTwitterAutoShare:(PPDeviceParametersTwitterAutoShare)twitterAutoShare {
    if(self.twitterAutoShare == twitterAutoShare) {
        return;
    }
    [super setTwitterAutoShare:twitterAutoShare];
    
    [self postMeasurement:TWITTER_AUTO_SHARE index:nil value:[NSString stringWithFormat:@"%li", (long)twitterAutoShare]];
}

- (void)setTwitterDescription:(NSString *)twitterDescription {
    if([self.twitterDescription isEqualToString:twitterDescription]) {
        return;
    }
    [super setTwitterDescription:twitterDescription];
    
    [self postMeasurement:TWITTER_DESCRIPTION index:nil value:twitterDescription];
}

- (void)setTwitterStatus:(PPDeviceParametersTwitterStatus)twitterStatus {
    if(self.twitterStatus == twitterStatus) {
        return;
    }
    [super setTwitterStatus:twitterStatus];
    
    [self postMeasurement:TWITTER_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)twitterStatus]];
}

- (void)setHDStatus:(PPDeviceParametersHDStatus)HDStatus {
    if(self.HDStatus == HDStatus) {
        return;
    }
    [super setHDStatus:HDStatus];
    
    [self postMeasurement:HD_STATUS index:nil value:[NSString stringWithFormat:@"%li", (long)HDStatus]];
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

- (void)setAutoFocus:(PPDeviceParametersAutoFocus)autoFocus {
    if(self.autoFocus == autoFocus) {
        return;
    }
    [super setAutoFocus:autoFocus];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:AUTO_FOCUS value:[NSString stringWithFormat:@"%li", (long)autoFocus] sessionID:NO];
}

- (void)setOutputVolume:(PPDeviceParametersOutputVolume)outputVolume {
    if(self.outputVolume == outputVolume) {
        return;
    }
    [super setOutputVolume:outputVolume];
    
    [self postMeasurement:OUTPUT_VOLUME index:nil value:[NSString stringWithFormat:@"%li", (long)outputVolume]];
}

- (void)setCaptureImage:(PPDeviceParametersCaptureImage)captureImage {
    if(self.captureImage == captureImage) {
        return;
    }
    [super setCaptureImage:captureImage];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:CAPTURE_IMAGE value:[NSString stringWithFormat:@"%li", (long)captureImage] sessionID:NO];
}

- (void)setAlarm:(PPDeviceParametersAlarm)alarm {
    if(self.alarm == alarm) {
        return;
    }
    [super setAlarm:alarm];
    
    [self postMeasurement:ALARM index:nil value:[NSString stringWithFormat:@"%li", (long)alarm]];
}

- (void)setPlaySound:(NSString *)playSound {
    if([self.playSound isEqualToString:playSound]) {
        return;
    }
    [super setPlaySound:playSound];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:PLAY_SOUND value:playSound sessionID:NO];
}

- (void)setCountdown:(PPDeviceParametersCountdown)countdown {
    if(self.countdown == countdown) {
        return;
    }
    [super setCountdown:countdown];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)countdown] sessionID:NO];
}

- (void)setVisualCountdown:(PPDeviceParametersVisualCountdown)visualCountdown {
    if(self.visualCountdown == visualCountdown) {
        return;
    }
    [super setVisualCountdown:visualCountdown];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:VISUAL_COUNTDOWN value:[NSString stringWithFormat:@"%li", (long)visualCountdown] sessionID:NO];
}

- (void)setKeypadStatus:(NSString *)keypadStatus {
    if([self.keypadStatus isEqualToString:keypadStatus]) {
        return;
    }
    [super setKeypadStatus:keypadStatus];
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:KEYPAD_STATUS value:keypadStatus sessionID:NO];
}

- (void)setMode:(NSString *)mode {
    if([self.mode isEqualToString:mode]) {
        return;
    }
    [super setMode:mode];
    
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:MODE value:mode sessionID:NO];
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
    [((PPDeviceProxyLocalCamera *)[PPDeviceProxy currentProxy].localDevice).webSocket sendMeasurementToViewer:name value:webSocketValue sessionID:NO];
    [[PPDeviceProxy currentProxy] sendMeasurement:[self measurementWithParameterName:name index:index value:value]];
}

@end
