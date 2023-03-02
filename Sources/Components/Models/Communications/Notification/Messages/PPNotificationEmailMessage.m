//
//  PPNotificationEmailMessage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPNotificationEmailMessage.h"

@implementation PPNotificationEmailMessage

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model subject:(NSString *)subject html:(PPNotificationEmailMessageHTML)html attachments:(NSArray *)attachments {
    self = [super initWithTemplate:notificationTemplate content:content model:model];
    if(self) {
        self.subject = subject;
        self.html = html;
        self.attachments = attachments;
    }
    return self;
}

+ (PPNotificationEmailMessage *)initWithDictionary:(NSDictionary *)messageDict {
    PPNotificationMessage *message = [super initWithDictionary:messageDict];
    PPNotificationEmailMessageHTML html = PPNotificationEmailMessageHTMLNone;
    if([messageDict objectForKey:@"html"]) {
        html = (PPNotificationEmailMessageHTML)((NSString *)[messageDict objectForKey:@"html"]).integerValue;
    }
    NSString *subject = [messageDict objectForKey:@"subject"];
    
    NSMutableArray *attachments;
    if([messageDict objectForKey:@"attachments"]) {
        attachments = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *attachmentsDict in [messageDict objectForKey:@"attachments"]) {
            NSString *content = [attachmentsDict objectForKey:@"content"];
            NSString *contentId = [attachmentsDict objectForKey:@"contentId"];
            NSString *contentType = [attachmentsDict objectForKey:@"contentType"];
            NSString *name = [attachmentsDict objectForKey:@"name"];
            PPNotificationEmailMessageAttachment *attachment = [[PPNotificationEmailMessageAttachment alloc] initWithName:name content:content contentType:contentType contentId:contentId];
            [attachments addObject:attachment];
        }
    }
    
    PPNotificationEmailMessage *emailMessage = [[PPNotificationEmailMessage alloc] initWithTemplate:message.notificationTemplate content:message.content model:message.model subject:subject html:html attachments:attachments];
    return emailMessage;
}

+ (NSString *)stringify:(PPNotificationEmailMessage *)message {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    [JSONString appendString:[super stringify:message]];
    appendComma = YES;
    
    if(message.subject) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subject\":\"%@\"", message.subject];
        appendComma = YES;
    }
    if(message.html != PPNotificationEmailMessageHTMLNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"html\":\"%@\"", (message.html) ? @"true" : @"false"];
        appendComma = YES;
    }
    if(message.attachments) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendString:@"\"attachments\": ["];
        BOOL appendAttatchmentComma = NO;
        for(PPNotificationEmailMessageAttachment *attachment in message.attachments) {
            if(appendAttatchmentComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPNotificationEmailMessageAttachment stringify:attachment]];
            appendAttatchmentComma = YES;
        }
        [JSONString appendString:@"]"];
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPNotificationEmailMessage *)emailMessage {
    NSMutableDictionary *data = [super data:emailMessage].mutableCopy;
    if(emailMessage.subject) {
        data[@"subject"] = emailMessage.subject;
    }
    if(emailMessage.html != PPNotificationEmailMessageHTMLNone) {
        data[@"html"] = (emailMessage.html) ? @"true" : @"false";
    }
    if(emailMessage.attachments) {
        NSMutableArray *attachments = @[].mutableCopy;
        for(PPNotificationEmailMessageAttachment *attachment in emailMessage.attachments) {
            [attachments addObject:[PPNotificationEmailMessageAttachment data:attachment]];
        }
        data[@"attachments"] = attachments;
    }
    
    return data;
}

@end
