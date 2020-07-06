//
//  PPDevicePictureFrameAlert.m
//  Peoplepower
//
//  Created by Destry Teeter on 9/18/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevicePictureFrameAlert.h"

@implementation PPDevicePictureFrameAlert

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon questionId:(PPQuestionId)questionId message:(NSString *)message timeStamp:(NSDate *)timeStamp duration:(PPDeviceParametersAlertDuration)duration priority:(PPDeviceParametersAlertPriority)priority playSound:(NSString *)playSound status:(PPDeviceParametersAlertStatus)status {
    self = [super init];
    if(self) {
        self.title = title;
        self.subTitle = subTitle;
        self.icon = icon;
        self.questionId = questionId;
        self.message = message;
        self.timestamp = timeStamp;
        self.duration = duration;
        self.priority = priority;
        self.playSound = playSound;
        self.status = status;
    }
    return self;
}

+ (PPDevicePictureFrameAlert *)initWithDictionary:(NSDictionary *)alertDict {
    NSString *title = [alertDict objectForKey:ALERT_TITLE];
    NSString *subtitle = [alertDict objectForKey:ALERT_SUBTITLE];
    NSString *icon = [alertDict objectForKey:ALERT_ICON];
    
    PPQuestionId questionId = PPQuestionIdNone;
    if([alertDict objectForKey:ALERT_QUESTION_ID]) {
        questionId = (PPQuestionId)((NSString *)[alertDict objectForKey:ALERT_QUESTION_ID]).integerValue;
    }
    
    NSString *message = [alertDict objectForKey:ALERT_MESSAGE];
    
    PPDeviceParametersAlertDuration duration = PPDeviceParametersAlertDurationNone;
    if([alertDict objectForKey:ALERT_DURATION_MS]) {
        duration = (PPDeviceParametersAlertDuration)((NSString *)[alertDict objectForKey:ALERT_DURATION_MS]).integerValue;
    }
    
    NSDate *timeStamp = [NSDate date];
    if([alertDict objectForKey:ALERT_TIMESTAMP_MS]) {
        timeStamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)((NSString *)[alertDict objectForKey:ALERT_TIMESTAMP_MS]).integerValue / 1000];
    }
    
    PPDeviceParametersAlertPriority priority = PPDeviceParametersAlertPriorityNone;
    if([alertDict objectForKey:ALERT_PRIORITY]) {
        priority = (PPDeviceParametersAlertPriority)((NSString *)[alertDict objectForKey:ALERT_PRIORITY]).integerValue;
    }
    
    NSString *playSound = [alertDict objectForKey:PLAY_SOUND];
    
    PPDeviceParametersAlertStatus status = PPDeviceParametersAlertStatusNone;
    if([alertDict objectForKey:ALERT_STATUS]) {
        status = (PPDeviceParametersAlertStatus)((NSString *)[alertDict objectForKey:ALERT_STATUS]).integerValue;
    }
    
    PPDevicePictureFrameAlert *alert = [[PPDevicePictureFrameAlert alloc] initWithTitle:title subTitle:subtitle icon:icon questionId:questionId message:message timeStamp:timeStamp duration:duration priority:priority playSound:playSound status:status];
    return alert;
}

@end
