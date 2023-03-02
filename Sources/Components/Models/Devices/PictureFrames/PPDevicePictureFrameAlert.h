//
//  PPDevicePictureFrameAlert.h
//  Peoplepower
//
//  Created by Destry Teeter on 9/18/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPQuestion.h"

@interface PPDevicePictureFrameAlert : PPBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic) PPQuestionId questionId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic) PPDeviceParametersAlertDuration duration;
@property (nonatomic) PPDeviceParametersAlertPriority priority;
@property (nonatomic, strong) NSString *playSound;
@property (nonatomic) PPDeviceParametersAlertStatus status;

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon questionId:(PPQuestionId)questionId message:(NSString *)message timeStamp:(NSDate *)timeStamp duration:(PPDeviceParametersAlertDuration)duration priority:(PPDeviceParametersAlertPriority)priority playSound:(NSString *)playSound status:(PPDeviceParametersAlertStatus)status;

+ (PPDevicePictureFrameAlert *)initWithDictionary:(NSDictionary *)alertDict;

@end
