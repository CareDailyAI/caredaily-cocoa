//
//  PPNotificationMessage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"

@implementation PPNotificationMessage

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model {
    self = [super init];
    if(self) {
        self.notificationTemplate = notificationTemplate;
        self.content = content;
        self.model = model;
    }
    return self;
}

+ (PPNotificationMessage *)initWithDictionary:(NSDictionary *)messageDict {
    NSString *notificationTemplate = [messageDict objectForKey:@"template"];
    NSString *content = [messageDict objectForKey:@"content"];
    NSDictionary *model = [messageDict objectForKey:@"model"];
    
    PPNotificationMessage *message = [[PPNotificationMessage alloc] initWithTemplate:notificationTemplate content:content model:model];
    return message;
}


+ (NSString *)stringify:(PPNotificationMessage *)message {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@""];
    
    BOOL appendComma = NO;
    
    if(message.notificationTemplate) {
        [JSONString appendFormat:@"\"template\":\"%@\"", message.notificationTemplate];
        appendComma = YES;
    }
    if(message.content) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"content\":\"%@\"", message.content];
        appendComma = YES;
    }
    if(message.model) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:message.model options:0 error:&err];
        [JSONString appendFormat:@"\"model\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    return JSONString;
}

+ (NSDictionary *)data:(PPNotificationMessage *)message {
    NSMutableDictionary *data = @{}.mutableCopy;
    if(message.notificationTemplate) {
        data[@"template"] = message.notificationTemplate;
    }
    if(message.content) {
        data[@"content"] = message.content;
    }
    if(message.model) {
        data[@"model"] = message.model;
    }
    
    return data;
}

@end
