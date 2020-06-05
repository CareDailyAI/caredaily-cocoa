//
//  PPNotificationPushMessage.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"

typedef NS_OPTIONS(NSInteger, PPNotificationPushMessageType) {
    PPNotificationPushMessageTypeNone = -1,
    PPNotificationPushMessageTypeDefault = 0
};

@interface PPNotificationPushMessage : PPNotificationMessage

@property (nonatomic) PPNotificationPushMessageType type;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSDictionary *info;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model type:(PPNotificationPushMessageType)type sound:(NSString *)sound info:(NSDictionary *)info;

+ (PPNotificationPushMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationPushMessage *)message;
+ (NSDictionary *)data:(PPNotificationPushMessage *)message;

@end
