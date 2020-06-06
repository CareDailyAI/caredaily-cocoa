//
//  PPNotificationSMSMessage.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationSMSMessage.h"

@implementation PPNotificationSMSMessage

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model categories:(RLMArray *)categories phones:(RLMArray *)phones individual:(PPNotificationSMSMessageIndividual)individual {
    self = [super initWithTemplate:notificationTemplate content:content model:model];
    if(self) {
        self.categories = (RLMArray<RLMString> *)categories;
        self.phones = (RLMArray<RLMString> *)phones;
        self.individual = individual;
    }
    return self;
}

+ (PPNotificationMessage *)initWithDictionary:(NSDictionary *)messageDict {
    PPNotificationMessage *message = [super initWithDictionary:messageDict];
    NSArray *categories = [messageDict objectForKey:@"categories"];
    NSArray *phones = [messageDict objectForKey:@"phones"];
    PPNotificationSMSMessageIndividual individual = PPNotificationSMSMessageIndividualNone;
    if([messageDict objectForKey:@"subject"]) {
        individual = (PPNotificationSMSMessageIndividual)((NSString *)[messageDict objectForKey:@"subject"]).integerValue;
    }
    PPNotificationSMSMessage *SMSMessage = [[PPNotificationSMSMessage alloc] initWithTemplate:message.notificationTemplate content:message.content model:message.model categories:(RLMArray *)categories phones:(RLMArray *)phones individual:individual];
    
    return SMSMessage;
}

+ (NSString *)stringify:(PPNotificationSMSMessage *)message {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    [JSONString appendString:[super stringify:message]];
    appendComma = YES;
    
    if([message.categories count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"categories\":[%@]", [PPRLMArray stringArray:message.categories componentsJoinedByString:@","]];
        appendComma = YES;
    }
    if([message.phones count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"phones\":[%@]", [PPRLMArray stringArray:message.phones componentsJoinedByString:@","]];
        appendComma = YES;
    }
    if(message.individual != PPNotificationSMSMessageIndividualNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"individual\":%@", (message.individual) ? @"true" : @"false"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPNotificationSMSMessage *)message {
    NSMutableDictionary *data = [super data:message].mutableCopy;
    if([message.categories count]) {
        data[@"categories"] = [PPRLMArray arrayFromArray:message.categories];
    }
    if([message.phones count]) {
        data[@"phones"] = [PPRLMArray arrayFromArray:message.phones];
    }
    if(message.individual != PPNotificationSMSMessageIndividualNone) {
        data[@"individual"] = (message.individual) ? @"true" : @"false";
    }
    return data;
}


@end
