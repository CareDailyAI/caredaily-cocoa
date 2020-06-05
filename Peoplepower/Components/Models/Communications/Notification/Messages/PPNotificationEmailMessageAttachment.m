//
//  PPNotificationEmailMessageAttachment.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationEmailMessageAttachment.h"

@implementation PPNotificationEmailMessageAttachment

- (id)initWithName:(NSString *)name content:(NSString *)content contentType:(NSString *)contentType contentId:(NSString *)contentId {
    self = [super init];
    if(self) {
        self.name = name;
        self.content = content;
        self.contentType = contentType;
        self.contentId = contentId;
    }
    return self;
}

+ (NSString *)stringify:(PPNotificationEmailMessageAttachment *)attachment {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    if(attachment.name) {
        [JSONString appendFormat:@"\"name\":\"%@\"", attachment.name];
        appendComma = YES;
    }
    
    if(attachment.content) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"content\":\"%@\"", attachment.content];
        appendComma = YES;
    }
    
    if(attachment.contentType) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"contentType\":\"%@\"", attachment.contentType];
        appendComma = YES;
    }
    
    if(attachment.contentId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"contentId\":\"%@\"", attachment.contentId];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSMutableDictionary *)data:(PPNotificationEmailMessageAttachment *)attachment {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(attachment.name) {
        data[@"name"] = attachment.name;
    }
    
    if(attachment.content) {
        data[@"content"] = attachment.content;
    }
    
    if(attachment.contentType) {
        data[@"contentType"] = attachment.contentType;
    }
    
    if(attachment.contentId) {
        data[@"contentId"] = attachment.contentId;
    }
    return data;
}

@end
