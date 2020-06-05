//
//  PPBotengineAppCategory.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppCommunications.h"

@implementation PPBotengineAppCommunications

- (id)initWithCategory:(PPBotengineAppCommunicationsCategory)category email:(BOOL)email push:(BOOL)push sms:(BOOL)sms msg:(BOOL)msg {
    self = [super init];
    if(self) {
        self.category = category;
        self.email = email;
        self.push = push;
        self.sms = sms;
        self.msg = msg;
    }
    return self;
}

- (NSString *)JSONString {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    [JSONString appendFormat:@"\"category\":\"%lu\",", (long)self.category];
    [JSONString appendFormat:@"\"email\":\"%@\",", (self.email == YES) ? @"true" : @"false"];
    [JSONString appendFormat:@"\"push\":\"%@\",", (self.push == YES) ? @"true" : @"false"];
    [JSONString appendFormat:@"\"sms\":\"%@\",", (self.sms == YES) ? @"true" : @"false"];
    [JSONString appendFormat:@"\"msg\":\"%@\"", (self.msg == YES) ? @"true" : @"false"];
    [JSONString appendString:@"}"];
    
    return JSONString;
}

@end
