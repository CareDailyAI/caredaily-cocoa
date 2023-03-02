//
//  PPCallCenter.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCallCenter.h"

@implementation PPCallCenter

+ (NSString *)primaryKey {
    return @"identifier";
}

- (NSString *)identifier {
    return @"callCenter"; // Only ever maintain one call center object
}

- (id)initWithStatus:(PPCallCenterStatus)status userId:(PPUserId)userId missingFields:(RLMArray *)missingFields contacts:(RLMArray *)contacts codeword:(NSString *)codeword permit:(NSString *)permit alertStatus:(PPCallCenterAlertStatus)alertStatus alertDate:(NSDate *)alertDate alertStatusDate:(NSDate *)alertStatusDate {
    self = [super init];
    if(self) {
        self.status = status;
        self.userId = userId;
        self.missingFields = (RLMArray<RLMString> *)missingFields;
        self.contacts = (RLMArray<PPCallCenterContact *><PPCallCenterContact> *)contacts;
        self.codeword = codeword;
        self.permit = permit;
        self.alertStatus = alertStatus;
        self.alertDate = alertDate;
        self.alertStatusDate = alertStatusDate;
    }
    return self;
}

+ (PPCallCenter *)initWithDictionary:(NSDictionary *)callCenterDict {
    PPCallCenterStatus status = PPCallCenterStatusNone;
    if([callCenterDict objectForKey:@"status"]) {
        status = (PPCallCenterStatus)((NSString *)[callCenterDict objectForKey:@"status"]).integerValue;
    }
    PPUserId userId = PPUserIdNone;
    if([callCenterDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[callCenterDict objectForKey:@"userId"]).integerValue;
    }
    NSArray *missingFields = [callCenterDict objectForKey:@"missingFields"];
    
    NSMutableArray *contacts;
    if([callCenterDict objectForKey:@"contacts"]) {
        contacts = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *contactDict in [callCenterDict objectForKey:@"contacts"]) {
            PPCallCenterContact *contact = [PPCallCenterContact initWithDictionary:contactDict];
            [contacts addObject:contact];
        }
    }
    
    NSString *codeword = [callCenterDict objectForKey:@"codeword"];
    NSString *permit = [callCenterDict objectForKey:@"permit"];
    PPCallCenterAlertStatus alertStatus = PPCallCenterAlertStatusNone;
    if([callCenterDict objectForKey:@"alertStatus"]) {
        alertStatus = (PPCallCenterAlertStatus)((NSString *)[callCenterDict objectForKey:@"alertStatus"]).integerValue;
    }
    
    NSString *alertDateString = [callCenterDict objectForKey:@"alertDate"];
    NSDate *alertDate = [NSDate date];
    if(alertDateString != nil) {
        if(![alertDateString isEqualToString:@""]) {
            alertDate = [PPNSDate parseDateTime:alertDateString];
        }
    }
    
    NSString *alertStatusDateString = [callCenterDict objectForKey:@"alertStatusDate"];
    NSDate *alertStatusDate = [NSDate date];
    if(alertStatusDateString != nil) {
        if(![alertStatusDateString isEqualToString:@""]) {
            alertStatusDate = [PPNSDate parseDateTime:alertStatusDateString];
        }
    }
    
    PPCallCenter *callCenter = [[PPCallCenter alloc] initWithStatus:status userId:userId missingFields:(RLMArray *)missingFields contacts:(RLMArray *)contacts codeword:codeword permit:permit alertStatus:alertStatus alertDate:alertDate alertStatusDate:alertStatusDate];
    
    return callCenter;
}

+ (NSString *)stringify:(PPCallCenter *)callCenter {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(callCenter.status != PPCallCenterStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\":\"%li\"", (long)callCenter.status];
        appendComma = YES;
    }
    
    if(callCenter.userId != PPUserIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"userId\":%li", (long)callCenter.userId];
        appendComma = YES;
    }
    
    if(callCenter.contacts) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"contacts\": ["];
        
        BOOL appendContactComma = NO;
        for(PPCallCenterContact *contact in callCenter.contacts) {
            if(appendContactComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPCallCenterContact stringify:contact]];
            appendContactComma = YES;
        }
        
        [JSONString appendString:@"]"];
        
        appendComma = YES;
    }
    
    if(callCenter.codeword) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"codeword\":\"%@\"", callCenter.codeword];
        appendComma = YES;
    }
    
    if(callCenter.permit) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"permit\":\"%@\"", callCenter.permit];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
