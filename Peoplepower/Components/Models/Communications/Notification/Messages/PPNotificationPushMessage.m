//
//  PPNotificationPushMessage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationPushMessage.h"

@implementation PPNotificationPushMessage

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model type:(PPNotificationPushMessageType)type sound:(NSString *)sound info:(NSDictionary *)info {
    self = [super initWithTemplate:notificationTemplate content:content model:model];
    if(self) {
        self.type = type;
        self.sound = sound;
        self.info = info;
    }
    return self;
}

+ (PPNotificationPushMessage *)initWithDictionary:(NSDictionary *)messageDict {
    PPNotificationMessage *message = [super initWithDictionary:messageDict];
    PPNotificationPushMessageType type = PPNotificationPushMessageTypeNone;
    if([messageDict objectForKey:@"type"]) {
        type = (PPNotificationPushMessageType)((NSString *)[messageDict objectForKey:@"type"]).integerValue;
    }
    NSString *sound = [messageDict objectForKey:@"sound"];
    NSDictionary *info = [messageDict objectForKey:@"info"];
    PPNotificationPushMessage *pushMessage = [[PPNotificationPushMessage alloc] initWithTemplate:message.notificationTemplate content:message.content model:message.model type:type sound:sound info:info];
    
    return pushMessage;
}

+ (NSString *)stringify:(PPNotificationPushMessage *)message {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    [JSONString appendString:[super stringify:message]];
    appendComma = YES;
    
    if(message.type != PPNotificationPushMessageTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":\"%li\"", (long)message.type];
        appendComma = YES;
    }
    if(message.sound) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sound\":\"%@\"", message.sound];
        appendComma = YES;
    }
    if(message.info) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:message.info options:0 error:&err];
        [JSONString appendFormat:@"\"info\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPNotificationPushMessage *)message {
    NSMutableDictionary *data = [super data:message].mutableCopy;
    
    if(message.type != PPNotificationPushMessageTypeNone) {
        data[@"type"] = @(message.type);
    }
    if(message.sound) {
        data[@"sound"] = message.sound;
    }
    if(message.info) {
        data[@"info"] = message.info;
    }
    return data;
}

@end
