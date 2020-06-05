//
//  PPDeviceProxyLocalCamera.m
//  PPiOSCore
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceProxyLocalCamera.h"
#import <sys/utsname.h>

@interface PPDeviceProxyLocalCamera ()

@property (nonatomic, strong) PPWebSocketConfiguration *videoCallConfiguration;
@property (nonatomic, strong) NSString *acknowledgedVideoCallDeviceId;
@property (nonatomic, strong) NSString *acknowledgedVideoCallSessionId;

@property (nonatomic, strong) NSTimer *verifyViewerTimer;

@end

@implementation PPDeviceProxyLocalCamera
@dynamic device;
@dynamic delegate;
@dynamic webSocket;

- (id)init {
    self = [super init];
    return self;
}

- (PPDeviceCameraLocal *)device {
    PPDevice *device = [PPDevices localDeviceForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId];
    if([device isKindOfClass:[PPDeviceCamera class]]) {
        return (PPDeviceCameraLocal *)[PPDevices localDeviceForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId];
    }
    return nil;
}

#pragma mark - Public

#pragma mark Local Device device ID helpers

+ (BOOL)isLocalDeviceWithId:(NSString *)deviceId locationId:(PPLocationId)locationId {
    return [super isLocalDeviceWithId:deviceId locationId:locationId];
}

+ (NSString *)localUDID {
    return [super localUDID];
}

#pragma mark Initialization

- (void)turnOn:(NSObject<PPDeviceProxyLocalCameraDelegate> *)delegate proxyDelegate:(NSObject<PPDeviceProxyLocalWebsocketDelegate> *)proxyDelegate {
    [super turnOn:delegate proxyDelegate:proxyDelegate];
}

- (void)turnOff {
    [super turnOff];
}

+ (BOOL)wasProxyOn {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *proxyWasOn = [defaults stringForKey:@"proxy.camera.wasOn"];
    return [@"1" isEqualToString:proxyWasOn];
}

- (void)connectWebSocket {
    if(self.webSocket) {
        if(self.webSocket.webSocket.readyState == SR_OPEN) {
            return;
        }
    }
    self.webSocket = [[PPWebSocketCamera alloc] initWithURL:[self webSocketURL] resourceEndpoint:PPWebSocketResourceEndpointCamera sessionId:self.webSocketConfiguration.sessionId delegate:self];
    [self.webSocket connect];
}

- (NSString *)webSocketURL {
    return [super webSocketURL];
}

#pragma mark Streaming

- (void)startPublishing {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    if([self.delegate respondsToSelector:@selector(cameraMustStartPublishing)]) {
        [self.delegate cameraMustStartPublishing];
    }
}

- (void)hangUpVideoCall:(NSString *)sessionId {
#ifdef DEBUG
    NSLog(@"%s sessionId=%@", __PRETTY_FUNCTION__, sessionId);
#endif
    if([_videoCallConfiguration.sessionId isEqualToString:@""]) {
        // We're already hung up, dude.
        [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:_videoCallConfiguration.sessionId sessionID:NO];
        return;
    }
    
    if(![sessionId isEqualToString:@""]) {
        if(![_videoCallConfiguration.sessionId isEqualToString:sessionId]) {
            // Trying to hang up the wrong video call, dude.
            [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:_videoCallConfiguration.sessionId sessionID:NO];
            return;
        }
    }
    
    _videoCallConfiguration = nil;
    _acknowledgedVideoCallSessionId = nil;
    _acknowledgedVideoCallDeviceId = nil;
    
    [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:@"" sessionID:NO];
    
    if([self.delegate respondsToSelector:@selector(cameraHungUpVideoCall)]) {
        [self.delegate cameraHungUpVideoCall];
    }
}

- (void)attemptToAnswerVideoCall:(PPWebSocketConfiguration *)configuration deviceId:(NSString *)deviceId {
#ifdef DEBUG
    NSLog(@"%s server=%@ deviceId=%@ sessionId=%@ ssl=%d", __PRETTY_FUNCTION__, configuration.videoServerURL, deviceId, configuration.sessionId, configuration.isVideoServerSSL);
#endif
    if(!_videoCallConfiguration) {
        _videoCallConfiguration = [[PPWebSocketConfiguration alloc] init];
    }
    if(!_videoCallConfiguration.sessionId || [_videoCallConfiguration.sessionId isEqualToString:@""]) {
        _videoCallConfiguration.sessionId = configuration.sessionId;
        _videoCallConfiguration.isVideoServerSSL = configuration.isVideoServerSSL;
        
        NSString *rtmpString = (configuration.isVideoServerSSL) ? @"rtmps" : @"rtmp";
        _videoCallConfiguration.videoServerURL = [NSString stringWithFormat:@"%@://%@/ppcvideoserver?sessionId=%@&deviceId=%@/%@", rtmpString, configuration.videoServerURL, configuration.sessionId, deviceId, configuration.sessionId];
        
#ifdef DEBUG
        NSLog(@"%s VIDEO SERVER URL: %@", __PRETTY_FUNCTION__, _videoCallConfiguration.videoServerURL);
#endif
        if([self.delegate respondsToSelector:@selector(connectToVideoCall:)]) {
            [self.delegate connectToVideoCall:_videoCallConfiguration];
        }
    }
    
    if((!self.acknowledgedVideoCallDeviceId || [self.acknowledgedVideoCallDeviceId isEqualToString:@""])) {
        // Line is available, acknowledge current caller and begin video call session
        self.acknowledgedVideoCallDeviceId = deviceId;
        [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:_videoCallConfiguration.sessionId sessionID:NO];
        
        if(self.acknowledgedVideoCallSessionId && [self.acknowledgedVideoCallSessionId isEqualToString:_videoCallConfiguration.sessionId]) {
            // We've already started streaming it
            [self.webSocket sendMeasurementToViewer:VIDEO_CALL_NOW_STREAMING_SESSION_ID value:_acknowledgedVideoCallSessionId sessionID:NO];
        }
    }
    else {
        // Line is currently busy, relay message to viewers with deviceId
        [self.webSocket sendMeasurementToViewer:VIDEO_CALL_IS_BUSY value:self.acknowledgedVideoCallDeviceId sessionID:NO];
    }
}

- (void)stopPublishing {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    if([self.delegate cameraIsPublishing]) {
        [self hangUpVideoCall:@""];
        [self.delegate cameraMustStopPublishing];
    }
}

- (void)verifyViewers {
    if(self.delegate) {
        [self.webSocket requestTotalViewers];
    }
}

- (void)recordStream:(NSInteger)recordStream {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
}

- (void)sendMessageToStartPlayer {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    [self.webSocket sendMeasurementToViewer:STREAM_STATUS value:self.webSocket.sessionId sessionID:NO];
}

- (void)sendErrorMessageToPlayer:(NSString *)message {
#ifdef DEBUG
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, message);
#endif
    [self.webSocket sendMeasurementToViewer:STREAM_ERROR value:message sessionID:NO];
}


#pragma mark Execute Command

- (void)executeCommands:(NSArray *)parameters {
    
    // Update and execute any commands that need executed.  Remove any commands that can be ignored.
    NSMutableArray *updatedParameters = [[NSMutableArray alloc] initWithCapacity:[parameters count]];
    for(int i = 0; i < [parameters count]; i++) {
        PPDeviceParameter *command = [parameters objectAtIndex:i];
        if(
//           [command.name isEqualToString:SELECTED_CAMERA]
//           || [command.name isEqualToString:FLASH_ON]
           [command.name isEqualToString:MOTION_STATUS]
           || [command.name isEqualToString:RECORD_SECONDS]
           || [command.name isEqualToString:MOTION_SENSITIVITY]
           || [command.name isEqualToString:MOTION_ACTIVITY]
           || [command.name isEqualToString:RAPID_MOTION_STATUS]
           || [command.name isEqualToString:MOTION_COUNTDOWN_TIME]
           || [command.name isEqualToString:RECORD_FULL_DURATION]
           || [command.name isEqualToString:RECORD_STATUS]
           || [command.name isEqualToString:AUDIO_STATUS]
           || [command.name isEqualToString:AUDIO_SENSITIVITY]
           || [command.name isEqualToString:AUDIO_ACTIVITY]
           || [command.name isEqualToString:AUDIO_STREAMING]
           || [command.name isEqualToString:VIDEO_STREAMING]
           || [command.name isEqualToString:ACCESS_CAMERA_SETTINGS]
           || [command.name isEqualToString:STREAM_ID]
           || [command.name isEqualToString:WARNING_STATUS]
           || [command.name isEqualToString:WARNING_TEXT]
           || [command.name isEqualToString:SUPPORTS_VIDEO_CALL]
//           || [command.name isEqualToString:STREAM_STATUS]
           || [command.name isEqualToString:MOTION_ALARM]
//           || [command.name isEqualToString:ROBOT_CONNECTED]
//           || [command.name isEqualToString:ROBOT_VANTAGE_SPHERICAL_COORDINATES]
//           || [command.name isEqualToString:ROBOT_VANTAGE_TIME]
//           || [command.name isEqualToString:ROBOT_VANTAGE_NAME]
//           || [command.name isEqualToString:ROBOT_VANTAGE_SEQUENCE]
//           || [command.name isEqualToString:ROBOT_VANTAGE_CONFIGURATION_STATUS]
//           || [command.name isEqualToString:ROBOT_ORIENTATION]
//           || [command.name isEqualToString:TWITTER_AUTO_SHARE]
//           || [command.name isEqualToString:TWITTER_DESCRIPTION]
           || [command.name isEqualToString:TWITTER_REMINDER]
           || [command.name isEqualToString:TWITTER_STATUS]
           || [command.name isEqualToString:HD_STATUS]
           || [command.name isEqualToString:BATTERY_LEVEL]
           || [command.name isEqualToString:CHARGING]
           || [command.name isEqualToString:VERSION]
           || [command.name isEqualToString:AVAILABLE_BYTES]
           || [command.name isEqualToString:BLACKOUT_SCREEN_ON]
           || [command.name isEqualToString:AUTO_FOCUS]
           || [command.name isEqualToString:OUTPUT_VOLUME]
           || [command.name isEqualToString:CAPTURE_IMAGE]
           || [command.name isEqualToString:ALARM]
           
//           || [command.name isEqualToString:PLAY_SOUND]
//           || [command.name isEqualToString:COUNTDOWN]
//           || [command.name isEqualToString:VISUAL_COUNTDOWN]
           || [command.name isEqualToString:KEYPAD_STATUS]
           || [command.name isEqualToString:FIRMWARE]
           || [command.name isEqualToString:FIRMWARE_URL]
           || [command.name isEqualToString:FIRMWARE_CHECK_SUM]
           || [command.name isEqualToString:FIRMWARE_UPDATE_STATUS]
//           || [command.name isEqualToString:MODE]
           ) {

            [updatedParameters addObject:command];
            continue;
        }
        else if([command.name isEqualToString:SELECTED_CAMERA]) {
            [self.device syncSelectedCamera];
        }
        // Maintain flash status if we're on the front camera
        else if([command.name isEqualToString:FLASH_ON]) {
            if(self.device.selectedCamera == PPDeviceParametersSelectedCameraFront) {
                command.value = [NSString stringWithFormat:@"%li",(command.value.integerValue == PPDeviceParametersSelectedFlashOn) ? (long)PPDeviceParametersSelectedFlashWasOn : (long)PPDeviceParametersSelectedFlashOff];
            }
        }
        // TODO: Handle Robots
//        else if([command isEqualToString:ROBOT_MOTION_DIRECTION]) {
//            if(self.location.roboticDevice != nil) {
//                [self.location.roboticDevice setParameter:command value:value index:nil setOn:[NSDate date]];
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_MOVE_TO_INDEX]) {
//            if(self.location.roboticDevice != nil) {
//                if([self.robotVantagePoints count] > value.integerValue) {
//                    NSArray *vantagePoint = self.robotVantagePoints[value.integerValue];
//                    [self.location.roboticDevice setParameter:ROBOT_VANTAGE_SPHERICAL_COORDINATES value:[NSString stringWithFormat:@"[%@,%@,%@]", vantagePoint[0], vantagePoint[1], vantagePoint[2]] index:nil setOn:[NSDate date]];
//                }
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_SPHERICAL_COORDINATES]) {
//            if(self.location.roboticDevice != nil) {
//                [self setParameter:command value:value index:index setOn:[NSDate date]];
//                [self setRobotVantagePoint:value index:index.integerValue];
//                [self.location.myHub sendMeasurement:command value:value index:index forDevice:self];
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_CONFIGURATION_STATUS]) {
//            if(self.location.roboticDevice != nil) {
//                [self setParameter:command value:value index:index setOn:[NSDate date]];
//                [self.location.roboticDevice setParameter:ROBOT_VANTAGE_CONFIGURATION_STATUS value:value index:index setOn:[NSDate date]];
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_SEQUENCE]) {
//            if([value isEqualToString:@"-1"]) {
//                [self setRobotVantageSequence:[[NSMutableOrderedSet alloc] init]];
//            }
//            else {
//                [self setRobotVantageSequence:[[NSMutableOrderedSet alloc] initWithArray:[value componentsSeparatedByString:@","]]];
//            }
//        }
//        else if([command isEqualToString:ROBOT_ORIENTATION]) {
//            if(self.location.roboticDevice != nil) {
//                [self.location.roboticDevice toggleVerticalInversion];
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_TIME]) {
//            if(self.location.roboticDevice != nil) {
//                [self setParameter:command value:value index:index setOn:[NSDate date]];
//                [self setRobotVantageTimer:value.integerValue index:index.integerValue];
//                [self.location.myHub sendMeasurement:command value:value index:index forDevice:self];
//            }
//        }
//        else if([command isEqualToString:ROBOT_VANTAGE_NAME]) {
//            if(self.location.roboticDevice != nil) {
//                [self setParameter:command value:value index:index setOn:[NSDate date]];
//                [self setRobotVantageName:value index:index.integerValue];
//                [self.location.myHub sendMeasurement:command value:value index:index forDevice:self];
//            }
//        }
        else if([command.name isEqualToString:TWITTER_AUTO_SHARE]
                || [command.name isEqualToString:TWITTER_DESCRIPTION]) {
            [self.webSocket sendMeasurementToViewer:command.name value:command.value sessionID:NO];
            if([self.proxyDelegate respondsToSelector:@selector(localDeviceDidUpdateDeviceProperty:value:index:)]) {
                [self.proxyDelegate localDeviceDidUpdateDeviceProperty:command.name value:command.value index:nil];
            }
            continue;
        }
        else if([command.name isEqualToString:STREAM_STATUS]) {
            if([command.value isEqualToString:@"1"]) {
                [self startPublishing];
                continue;
            }
        }
        else if([command.name isEqualToString:VIDEO_CALL_HANGUP_WITH_SESSION_ID]) {
            [self hangUpVideoCall:command.value];
            continue;
        }
        else if([command.name isEqualToString:VIDEO_CALL_SESSION_DETAILS]) {
            if([command.value rangeOfString:@"sessionId"].location == NSNotFound) {
                [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:command.value sessionID:NO];
                continue;
            }
            command.value = [command.value stringByReplacingOccurrencesOfString:@"<videoCallDetails>" withString:@"{"];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"</videoCallDetails>" withString:@"}"];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"<videoServer>" withString:@"\"videoServer\":\""];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"</videoServer>" withString:@"\","];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"<sessionId>" withString:@"\"sessionId\":\""];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"</sessionId>" withString:@"\","];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"<deviceId>" withString:@"\"deviceId\":\""];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"</deviceId>" withString:@"\","];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"<videoServerSsl>" withString:@"\"videoServerSsl\":"];
            command.value = [command.value stringByReplacingOccurrencesOfString:@"</videoServerSsl>" withString:@","];
    #ifdef DEBUG
            NSLog(@"Video call details received: %@", command.value);
    #endif
            
            NSError *parsingError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:[command.value dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&parsingError];
            
            if(parsingError) {
                [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:_videoCallConfiguration.sessionId sessionID:NO];
                continue;
            }
            
            PPWebSocketConfiguration *configuration = [[PPWebSocketConfiguration alloc] init];
            configuration.videoServerURL = [parsedObject objectForKey:@"videoServer"];
            NSString *deviceId = [parsedObject objectForKey:@"deviceId"];
            configuration.sessionId = [parsedObject objectForKey:@"sessionId"];
            configuration.isVideoServerSSL = ((NSString *)[parsedObject objectForKey:@"videoServerSsl"]).boolValue;
            
            if(configuration.sessionId != nil && ![configuration.sessionId isEqualToString:@""]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self attemptToAnswerVideoCall:configuration deviceId:deviceId];
                });
                continue;
            }
        }
        else if([command.name isEqualToString:CAMERA_NAME]) {
            self.device.name = command.value;
            
            [self.webSocket sendMeasurementToViewer:command.name value:command.value sessionID:NO];
            
            if([self.proxyDelegate respondsToSelector:@selector(localDeviceDidUpdateDeviceName:)]) {
                [self.proxyDelegate localDeviceDidUpdateDeviceName:self.device.name];
            }
            continue;
        }
        else if([command.name isEqualToString:RECORD_STREAM]) {
            if(command.value == NULL) {
                return;
            }
            [self recordStream:command.value.integerValue];
            continue;
        }
        else if([command.name isEqualToString:COUNTDOWN]
                || [command.name isEqualToString:VISUAL_COUNTDOWN]) {
            // Ignore if this is an old countdown or adjust to sync
            NSInteger timeLeft = command.value.integerValue - ceil(command.lastUpdateDate.timeIntervalSinceNow);
            command.value = [NSString stringWithFormat:@"%li", (long)timeLeft];
            if(timeLeft <= 0) {
                continue;
            }
        }
        else if([command.name isEqualToString:PLAY_SOUND]) {
            // Ignore if this is an old command or adjust to sync if it is a countdown sound
            NSArray *sounds = [command.value componentsSeparatedByString:@","];
            NSMutableArray *newSounds = [[NSMutableArray alloc] initWithArray:sounds];
            
            for(NSString *sound in sounds) {
                
                if([sound rangeOfString:@"seconds"].location != NSNotFound) {
                    NSRange secondsRange = NSMakeRange([sound rangeOfString:@"seconds"].location - 2, 2);
                    
                    if(secondsRange.location != NSNotFound) {
                        
                        NSString *secondsString = [sound substringWithRange:secondsRange];
                        NSTimeInterval creationTime = command.lastUpdateDate.timeIntervalSinceNow;
                        NSInteger timeLeft = secondsString.integerValue + creationTime;
                        if(timeLeft <= 0) {
                            [newSounds removeObjectAtIndex:[sounds indexOfObject:sound]];
                        }
                        else if(timeLeft <= 20) {
                            [newSounds replaceObjectAtIndex:[sounds indexOfObject:sound] withObject:[sound stringByReplacingOccurrencesOfString:secondsString withString:@"10"]];
                        }
                        else if(timeLeft <= 45) {
                            [newSounds replaceObjectAtIndex:[sounds indexOfObject:sound] withObject:[sound stringByReplacingOccurrencesOfString:secondsString withString:@"30"]];
                        }
                    }
                }
                
            }
            
            command.value = [newSounds componentsJoinedByString:@","];
        }
        else if([command.name isEqualToString:MODE]) {
            BOOL found = NO;
            for(NSString *mode in [PPLocationSceneEvent availableEvents]) {
#ifdef DEBUG
                NSLog(@"%s compare %@<>%@", __PRETTY_FUNCTION__, command.value, mode);
#endif
                if([command.value rangeOfString:mode].location != NSNotFound) {
                    found = YES;
                    break;
                }
            }
            if(!found) {
                continue;
            }
        }
        else {
            if(command) {
#ifdef DEBUG
                NSLog(@"PPMobileCamera: Unknown command: %@[%@]=%@ (%@)", command.name, command.index, command.value, command.lastUpdateDate);
#endif
                continue;
            }
        }
        [updatedParameters addObject:command];
    }
    
    for(PPDeviceParameter *command in updatedParameters) {
        [self.webSocket sendMeasurementToViewer:command.name value:command.value sessionID:NO];
    }
    
    [super executeCommands:updatedParameters];
}

#pragma mark - PPWebSocketDelegate

/** Notification that the websocket connected */
- (void)websocketDidConnect:(SRWebSocket*)session {
    [super websocketDidConnect:session];
#ifdef DEBUG
    NSLog(@"%s session=%@", __PRETTY_FUNCTION__, session);
#endif
}

/** Notification that the websocket broke.  If you want to recreate it, you have to renew your sessionId and start over from the beginning */
- (void)websocketBroken {
    [super websocketBroken];
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
}

/** Web socket received a message */
- (void)websocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message {
#ifdef DEBUG
    NSLog(@"%s message=%@", __PRETTY_FUNCTION__, message);
#endif
    [super websocket:webSocket didReceiveMessage:message];
    
    NSError *error = nil;
    NSInteger totalViewers = -1;
    
    NSDictionary *responseJson = [PPWebSocket processResponseData:[message dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    
    if(error) {
        return;
    }
    
    NSArray *viewerJsonArray = [responseJson valueForKey:@"viewers"];
    if([viewerJsonArray count] > 0) {
        
        totalViewers = 0;
        for(NSDictionary *responseObj in viewerJsonArray) {
            switch ([[responseObj objectForKey:@"status"] integerValue]) {
                case PPWebSocketViewerConnected:
                    // Fall through
                    
                case PPWebSocketViewerNoChange:
                    totalViewers++;
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    NSString *viewerCountString = [responseJson valueForKey:@"viewersCount"];
    if(viewerCountString != nil) {
        totalViewers = [viewerCountString integerValue];
    }
    
    if(totalViewers == 0) {
        if([self.delegate respondsToSelector:@selector(cameraIsPublishing)]) {
            if([self.delegate cameraIsPublishing]) {
                [self stopPublishing];
            }
        }
    }
    else {
        if([_verifyViewerTimer isValid]) {
            [_verifyViewerTimer invalidate];
        }
        _verifyViewerTimer = [NSTimer scheduledTimerWithTimeInterval:DEVICE_CAMERA_LOCAL_VERIFY_VIEWERS_AFTER_SEC_PERIODICALLY target:self selector:@selector(verifyViewers) userInfo:nil repeats:NO];
    }
    /*
    NSArray *responseJsonArray = [responseJson valueForKey:WS_PARAMS];
    if([responseJsonArray count] > 0) {
        for(NSDictionary *responseObj in responseJsonArray) {
            NSString *name = [responseObj objectForKey:@"name"];
            NSString *value = [responseObj objectForKey:@"setValue"];
            
            if([name isEqualToString:STREAM_STATUS]) {
                if([value isEqualToString:@"1"]) {
                    [self startPublishing];
                }
            }
            else if([name isEqualToString:VIDEO_CALL_SESSION_DETAILS]) {
                NSError *error;
                DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:value options:0 error:&error];
                DDXMLElement *root = doc.rootElement;
                if(error) {
                    [_cameraWebSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:_videoCallSessionId sessionID:NO];
                    return;
                }
                
                NSString *server = ((DDXMLElement *)[root nodesForXPath:@"/videoCallDetails/videoServer" error:&error].lastObject).stringValue;
                NSString *deviceId = ((DDXMLElement *)[root nodesForXPath:@"/videoCallDetails/deviceId" error:&error].lastObject).stringValue;
                NSString *sessionId = ((DDXMLElement *)[root nodesForXPath:@"/videoCallDetails/sessionId" error:&error].lastObject).stringValue;
                BOOL ssl = ((DDXMLElement *)[root nodesForXPath:@"/videoCallDetails/videoServerSsl" error:&error].lastObject).stringValue.boolValue;
     
                NSString *server;
                NSString *deviceId;
                BOOL ssl = NO;
                NSString *sessionId;
                
                if((sessionId == nil) || [sessionId isEqualToString:@""]) {
                    [self.webSocket sendMeasurementToViewer:VIDEO_CALL_ACTIVE_SESSION_ID value:value sessionID:NO];
                    return;
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self attemptToAnswerVideoCall:server deviceId:deviceId ssl:ssl sessionId:sessionId];
                    });
                }
            }
            else if([name isEqualToString:VIDEO_CALL_HANGUP_WITH_SESSION_ID]) {
                [self hangUpVideoCall:value];
            }
        }
    }
     */
}

@end
