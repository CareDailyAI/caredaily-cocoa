//
//  PPCallCenterContact.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCallCenterContact.h"

@implementation PPCallCenterContact

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPCallCenterContactPhoneType)phoneType userId:(PPUserId)userId {
    self = [super init];
    if(self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.phone = phone;
        self.phoneType = phoneType;
        self.userId = userId;
    }
    return self;
}

+ (PPCallCenterContact *)initWithDictionary:(NSDictionary *)contactDict {
    NSString *firstName = [contactDict objectForKey:@"firstName"];
    NSString *lastName = [contactDict objectForKey:@"lastName"];
    NSString *phone = [contactDict objectForKey:@"phone"];
    PPCallCenterContactPhoneType phoneType = PPCallCenterContactPhoneTypeNone;
    if([contactDict objectForKey:@"phoneType"]) {
        phoneType = (PPCallCenterContactPhoneType)((NSString *)[contactDict objectForKey:@"phoneType"]).integerValue;
    }
    PPUserId userId = PPUserIdNone;
    if([contactDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[contactDict objectForKey:@"userId"]).integerValue;
    }
    
    PPCallCenterContact *contact = [[PPCallCenterContact alloc] initWithFirstName:firstName lastName:lastName phone:phone phoneType:phoneType userId:userId];
    return contact;
}

+ (NSString *)stringify:(PPCallCenterContact *)contact {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    if(contact.userId != PPUserIdNone) {
        [JSONString appendFormat:@"\"userId\": \"%li\"", (long)contact.userId];
    }
    else {
        BOOL appendComma = NO;
        
        if(contact.firstName) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"firstName\":\"%@\"", contact.firstName];
            appendComma = YES;
        }
        
        if(contact.lastName) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"lastName\":\"%@\"", contact.lastName];
            appendComma = YES;
        }
        
        if(contact.phone) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"phone\":\"%@\"", contact.phone];
            appendComma = YES;
        }
        
        if(contact.phoneType != PPCallCenterContactPhoneTypeNone) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"phoneType\":\"%li\"", (long)contact.phoneType];
            appendComma = YES;
        }
    }
    [JSONString appendString:@"}"];
    return JSONString;
}
@end
