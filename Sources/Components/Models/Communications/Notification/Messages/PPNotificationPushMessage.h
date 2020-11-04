//
//  PPNotificationPushMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"

@class PPNotificationPushMessageInfo;

@interface PPNotificationPushMessage : PPNotificationMessage

@property (nonatomic) PPNotificationPushMessageType type;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) PPNotificationPushMessageInfo *info;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model type:(PPNotificationPushMessageType)type sound:(NSString *)sound info:(PPNotificationPushMessageInfo *)info;

+ (PPNotificationPushMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationPushMessage *)message;
+ (NSDictionary *)data:(PPNotificationPushMessage *)message;

@end

@interface PPNotificationPushMessageInfo : PPRLMDictionary
+ (PPNotificationPushMessageInfo *)initWithDictionary:(NSDictionary *)dict;
@end
