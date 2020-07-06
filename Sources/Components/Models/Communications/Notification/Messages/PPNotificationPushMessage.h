//
//  PPNotificationPushMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"

@class PPNotificationPushMessageInfo;
RLM_ARRAY_TYPE(PPNotificationPushMessageInfo);

typedef NS_OPTIONS(NSInteger, PPNotificationPushMessageType) {
    PPNotificationPushMessageTypeNone = -1,
    PPNotificationPushMessageTypeDefault = 0
};

@interface PPNotificationPushMessage : PPNotificationMessage

@property (nonatomic) PPNotificationPushMessageType type;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) PPNotificationPushMessageInfo *info;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model type:(PPNotificationPushMessageType)type sound:(NSString *)sound info:(PPNotificationPushMessageInfo *)info;

+ (PPNotificationPushMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationPushMessage *)message;
+ (NSDictionary *)data:(PPNotificationPushMessage *)message;

@end

RLM_ARRAY_TYPE(PPNotificationPushMessage);

@interface PPNotificationPushMessageInfo : PPRLMDictionary
+ (PPNotificationPushMessageInfo *)initWithDictionary:(NSDictionary *)dict;
@end
