//
//  PPSMSSubscriber.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPSMSSubscriber.h"

@implementation PPSMSSubscriber

- (id)initWithPhone:(NSString *)phone categories:(NSArray *)categories status:(PPSMSSubscriberStatus)status firstName:(NSString *)firstName lastName:(NSString *)lastName initials:(NSString *)initials {
    self = [super init];
    if(self) {
        self.phone = phone;
        self.categories = categories;
        self.status = status;
        self.firstName = firstName;
        self.lastName = lastName;
        self.initials = initials;
    }
    return self;
}

+ (PPSMSSubscriber *)initWithDictionary:(NSDictionary *)subscriberDict {
    NSString *phone;
    if([[subscriberDict objectForKey:@"phone"] isKindOfClass:[NSString class]]) {
        phone = [subscriberDict objectForKey:@"phone"];
    }
    else if([[subscriberDict objectForKey:@"phone"] isKindOfClass:[NSNumber class]]) {
        phone = ((NSNumber *)[subscriberDict objectForKey:@"phone"]).stringValue;
    }
    NSArray *categories = (NSArray *)[subscriberDict objectForKey:@"categories"];
    PPSMSSubscriberStatus status = PPSMSSubscriberStatusNone;
    if([subscriberDict objectForKey:@"status"]) {
        status = (PPSMSSubscriberStatus)((NSString *)[subscriberDict objectForKey:@"status"]).integerValue;
    }
    NSString *firstName = [subscriberDict objectForKey:@"firstName"];
    NSString *lastName = [subscriberDict objectForKey:@"lastName"];
    NSString *initials = [subscriberDict objectForKey:@"initials"];
    
    PPSMSSubscriber *subscriber = [[PPSMSSubscriber alloc] initWithPhone:phone categories:categories status:status firstName:firstName lastName:lastName initials:initials];
    return subscriber;
}

+ (NSString *)stringify:(PPSMSSubscriber *)subscriber {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(subscriber.phone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"phone\":\"%@\"", subscriber.phone];
        appendComma = YES;
    }
    
    if([subscriber.categories count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"categories\":[%@]", [subscriber.categories componentsJoinedByString:@","]];
        appendComma = YES;
    }
    
    if(subscriber.status) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendFormat:@"\"status\":\"%li\"", (long)subscriber.status];
        appendComma = YES;
    }
    
    if(subscriber.firstName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"firstName\":\"%@\"", subscriber.firstName];
        appendComma = YES;
    }
    
    if(subscriber.lastName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"lastName\":\"%@\"", subscriber.lastName];
        appendComma = YES;
    }
    
    if(subscriber.initials) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"initials\":\"%@\"", subscriber.initials];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPSMSSubscriber *)subscriber {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(subscriber.phone) {
        data[@"phone"] = subscriber.phone;
    }
    if([subscriber.categories count]) {
        data[@"categories"] = subscriber.categories;
    }
    if(subscriber.status) {
        data[@"status"] = @(subscriber.status);
    }
    if(subscriber.firstName) {
        data[@"firstName"] = subscriber.firstName;
    }
    if(subscriber.lastName) {
        data[@"lastName"] = subscriber.lastName;
    }
    if(subscriber.initials) {
        data[@"initials"] = subscriber.initials;
    }
    return data;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToSubscriber:(PPSMSSubscriber *)subscriber {
    BOOL equal = NO;
    
    if(_phone == subscriber.phone) {
        equal = YES;
    }
    
    return equal;
}

- (void)sync:(PPSMSSubscriber *)subscriber {
    if(subscriber.phone) {
        _phone = subscriber.phone;
    }
    if(subscriber.categories) {
        _categories = subscriber.categories;
    }
    if(subscriber.status != PPSMSSubscriberStatusNone) {
        _status = subscriber.status;
    }
    if(subscriber.firstName) {
        _firstName = subscriber.firstName;
    }
    if(subscriber.lastName) {
        _lastName = subscriber.lastName;
    }
    if(subscriber.initials) {
        _initials = subscriber.initials;
    }
}

@end
