//
//  PPCrowdFeedbackSupport.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCrowdFeedbackSupport.h"

@implementation PPCrowdFeedbackSupport

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email subject:(NSString *)subject text:(NSString *)text subscribe:(NSString *)subscribe {
    self = [super init];
    if(self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.subject = subject;
        self.text = text;
        self.subscribe = subscribe;
    }
    return self;
}

+ (PPCrowdFeedbackSupport *)initWithDictionary:(NSDictionary *)supportDict {
    NSString *firstName = [supportDict objectForKey:@"firstName"];
    NSString *lastName = [supportDict objectForKey:@"lastName"];
    NSString *email = [supportDict objectForKey:@"email"];
    NSString *subject = [supportDict objectForKey:@"subject"];
    NSString *text = [supportDict objectForKey:@"text"];
    NSString *subscribe = [supportDict objectForKey:@"subscribe"];
    
    PPCrowdFeedbackSupport *support = [[PPCrowdFeedbackSupport alloc] initWithFirstName:firstName lastName:lastName email:email subject:subject text:text subscribe:subscribe];
    return support;
}


+ (NSString *)stringify:(PPCrowdFeedbackSupport *)support {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@""];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(support.firstName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"firstName\":\"%@\"", support.firstName];
        appendComma = YES;
    }
    if(support.lastName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"lastName\":\"%@\"", support.lastName];
        appendComma = YES;
    }
    if(support.email) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"email\":\"%@\"", support.email];
        appendComma = YES;
    }
    if(support.subject) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subject\":\"%@\"", support.subject];
        appendComma = YES;
    }
    if(support.text) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"text\":\"%@\"", support.text];
        appendComma = YES;
    }
    if(support.subscribe) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subscribe\":\"%@\"", support.subscribe];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPCrowdFeedbackSupport *)support {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(support.firstName) {
        data[@"firstName"] = support.firstName;
    }
    if(support.lastName) {
        data[@"lastName"] = support.lastName;
    }
    if(support.email) {
        data[@"email"] = support.email;
    }
    if(support.subject) {
        data[@"subject"] = support.subject;
    }
    if(support.text) {
        data[@"text"] = support.text;
    }
    if(support.subscribe) {
        data[@"subscribe"] = support.subscribe;
    }
    return data;
}

@end
