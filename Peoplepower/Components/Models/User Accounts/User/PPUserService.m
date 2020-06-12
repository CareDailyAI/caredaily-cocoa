//
//  PPUserService.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserService.h"

@implementation PPUserService

- (id)initWithName:(NSString *)name desc:(NSString *)desc amount:(PPUserServiceAmount)amount startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];
    if(self) {
        self.name = name;
        self.desc = desc;
        self.amount = amount;
        self.startDate = startDate;
        self.endDate = endDate;
    }
    return self;
}

+ (PPUserService *)initWithDictionary:(NSDictionary *)serviceDict {
    NSString *name = [serviceDict objectForKey:@"name"];
    NSString *desc = [serviceDict objectForKey:@"desc"];
    PPUserServiceAmount amount = PPUserServiceAmountNone;
    if([serviceDict objectForKey:@"amount"]) {
        amount = (PPUserServiceAmount)((NSString *)[serviceDict objectForKey:@"amount"]).integerValue;
    }
    
    NSString *startDateString = [serviceDict objectForKey:@"startDate"];
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSString *endDateString = [serviceDict objectForKey:@"endDate"];
    NSDate *endDate = [NSDate date];
    if(endDateString != nil) {
        if(![endDateString isEqualToString:@""]) {
            endDate = [PPNSDate parseDateTime:endDateString];
        }
    }
    
    PPUserService *servicePlan = [[PPUserService alloc] initWithName:name desc:desc amount:amount startDate:startDate endDate:endDate];
    return servicePlan;
}

#pragma mark - Helper methods

- (void)sync:(PPUserService *)userService {
    if(userService.name) {
        _name = userService.name;
    }
    if(userService.desc) {
        _desc = userService.desc;
    }
    if(userService.amount != PPUserServiceAmountNone) {
        _amount = userService.amount;
    }
    if(userService.startDate) {
        _startDate = userService.startDate;
    }
    if(userService.endDate) {
        _endDate = userService.endDate;
    }
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.amount = (PPUserServiceAmount)((NSNumber *)[decoder decodeObjectForKey:@"amount"]).integerValue;
        self.startDate = [decoder decodeObjectForKey:@"startDate"];
        self.endDate = [decoder decodeObjectForKey:@"endDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_desc forKey:@"desc"];
    [encoder encodeObject:@(_amount) forKey:@"amount"];
    [encoder encodeObject:_startDate forKey:@"startDate"];
    [encoder encodeObject:_endDate forKey:@"endDate"];
}

@end
