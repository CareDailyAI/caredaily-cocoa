//
//  PPRuleCalendar.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleCalendar.h"

@implementation PPRuleCalendar

- (id)initWithStartTime:(PPRuleCalendarTime)startTime endTime:(PPRuleCalendarTime)endTime daysOfWeek:(PPRuleCalendarDaysOfWeek)daysOfWeek include:(PPRuleCalendarInclude)include {
    self = [super init];
    if(self) {
        self.startTime = startTime;
        self.endTime = endTime;
        self.daysOfWeek = daysOfWeek;
        self.include = include;
    }
    return self;
}

+ (PPRuleCalendar *)initWithDictionary:(NSDictionary *)calendarDict {
    PPRuleCalendarTime startTime = PPRuleCalendarTimeNone;
    if([calendarDict objectForKey:@"startTime"]) {
        startTime = (PPRuleCalendarTime)((NSString *)[calendarDict objectForKey:@"startTime"]).integerValue;
    }
    PPRuleCalendarTime endTime = PPRuleCalendarTimeNone;
    if([calendarDict objectForKey:@"endTime"]) {
        endTime = (PPRuleCalendarTime)((NSString *)[calendarDict objectForKey:@"endTime"]).integerValue;
    }
    PPRuleCalendarDaysOfWeek daysOfWeek = PPRuleCalendarDaysOfWeekNone;
    if([calendarDict objectForKey:@"daysOfWeek"]) {
        daysOfWeek = (PPRuleCalendarDaysOfWeek)((NSString *)[calendarDict objectForKey:@"daysOfWeek"]).integerValue;
    }
    PPRuleCalendarInclude include = PPRuleCalendarIncludeNone;
    if([calendarDict objectForKey:@"include"]) {
        include = (PPRuleCalendarInclude)((NSString *)[calendarDict objectForKey:@"include"]).integerValue;
    }
    
    PPRuleCalendar *calendar = [[PPRuleCalendar alloc] initWithStartTime:startTime endTime:endTime daysOfWeek:daysOfWeek include:include];
    return calendar;
}

+ (NSString *)stringify:(PPRuleCalendar *)calendar {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(calendar.include != PPRuleCalendarIncludeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"include\": %li", (long)calendar.include];
        appendComma = YES;
    }
    
    if(calendar.startTime != PPRuleCalendarTimeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"startTime\": %li", (long)calendar.startTime];
        appendComma = YES;
    }
    
    if(calendar.endTime != PPRuleCalendarTimeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"endTime\": %li", (long)calendar.endTime];
        appendComma = YES;
    }
    
    if(calendar.daysOfWeek != PPRuleCalendarDaysOfWeekNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"daysOfWeek\": %li", (long)calendar.daysOfWeek];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPRuleCalendar *)calendar {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(calendar.include != PPRuleCalendarIncludeNone) {
        data[@"include"] = @(calendar.include);
    }
    
    if(calendar.startTime != PPRuleCalendarTimeNone) {
        data[@"startTime"] = @(calendar.startTime);
    }
    
    if(calendar.endTime != PPRuleCalendarTimeNone) {
        data[@"endTime"] = @(calendar.endTime);
    }
    
    if(calendar.daysOfWeek != PPRuleCalendarDaysOfWeekNone) {
        data[@"daysOfWeek"] = @(calendar.daysOfWeek);
    }
    
    return data;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleCalendar *calendar = [[[self class] allocWithZone:zone] init];
    calendar.startTime = self.startTime;
    calendar.endTime = self.endTime;
    calendar.daysOfWeek = self.daysOfWeek;
    calendar.include = self.include;
    return calendar;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.startTime = (PPRuleCalendarTime)((NSNumber *)[decoder decodeObjectForKey:@"startTime"]).integerValue;
        self.endTime = (PPRuleCalendarTime)((NSNumber *)[decoder decodeObjectForKey:@"endTime"]).integerValue;
        self.daysOfWeek = (PPRuleCalendarDaysOfWeek)((NSNumber *)[decoder decodeObjectForKey:@"daysOfWeek"]).integerValue;
        self.include = (PPRuleCalendarInclude)((NSNumber *)[decoder decodeObjectForKey:@"include"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_startTime) forKey:@"startTime"];
    [encoder encodeObject:@(_endTime) forKey:@"endTime"];
    [encoder encodeObject:@(_daysOfWeek) forKey:@"daysOfWeek"];
    [encoder encodeObject:@(_include) forKey:@"include"];
}

@end
