//
//  PPUserEmail.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserEmail.h"

@implementation PPUserEmail

- (id)initWithEmail:(NSString *)email verified:(PPUserEmailVerified)verified status:(PPUserEmailStatus)status {
    self = [super init];
    if(self) {
        self.email = email;
        self.verified = verified;
        self.status = status;
    }
    return self;
}

+ (PPUserEmail *)initWithDictionary:(NSDictionary *)emailDict {
    NSString *email = [emailDict objectForKey:@"email"];
    PPUserEmailVerified verified = PPUserEmailVerifiedNone;
    if([emailDict objectForKey:@"verified"]) {
        verified = (PPUserEmailVerified)((NSString *)[emailDict objectForKey:@"verified"]).integerValue;
    }
    PPUserEmailStatus status = PPUserEmailStatusNone;
    if([emailDict objectForKey:@"status"]) {
        status = (PPUserEmailStatus)((NSString *)[emailDict objectForKey:@"status"]).integerValue;
    }
    
    PPUserEmail *userEmail = [[PPUserEmail alloc] initWithEmail:email verified:verified status:status];
    return userEmail;
}

+ (NSString *)stringify:(PPUserEmail *)email {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(email.email) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"email\":%@", email.email];
        appendComma = YES;
    }
    
    if(email.verified != PPUserEmailVerifiedNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"verified\":%li", (long)email.verified];
        appendComma = YES;
    }
    
    if(email.status != PPUserEmailStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\":%li", (long)email.status];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper methods

- (void)sync:(PPUserEmail *)userEmail {
    if(userEmail.email) {
        _email = userEmail.email;
    }
    if(userEmail.verified != PPUserEmailVerifiedNone) {
        _verified = userEmail.verified;
    }
    if(userEmail.status != PPUserEmailStatusNone) {
        _status = userEmail.status;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUserEmail *email = [[[self class] allocWithZone:zone] init];
    
    email.email = [self.email copyWithZone:zone];
    email.verified = self.verified;
    email.status = self.status;
    
    return email;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.email = [decoder decodeObjectForKey:@"email"];
        self.verified = (PPUserEmailVerified)((NSNumber *)[decoder decodeObjectForKey:@"verified"]).integerValue;
        self.status = (PPUserEmailStatus)((NSNumber *)[decoder decodeObjectForKey:@"status"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:@(_verified) forKey:@"verified"];
    [encoder encodeObject:@(_status) forKey:@"status"];
}


@end
