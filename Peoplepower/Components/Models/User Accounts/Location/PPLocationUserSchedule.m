//
//  PPLocationUserSchedule.m
//  PPiOSCore
//
//  Created by Destry Teeter on 12/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationUserSchedule.h"

@implementation PPLocationUserSchedule

- (id)initWithDaysOfWeek:(PPRuleCalendarDaysOfWeek)daysOfWeek startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime {
    self = [super init];
    if(self) {
        self.daysOfWeek = daysOfWeek;
        self.startTime = startTime;
        self.endTime = endTime;
    }
    return self;
}

+ (PPLocationUserSchedule *)initWithDictionary:(NSDictionary *)scheduleDict {
    PPRuleCalendarDaysOfWeek daysOfWeek = PPRuleCalendarDaysOfWeekNone;
    if([scheduleDict objectForKey:@"daysOfWeek"]) {
        daysOfWeek = (PPRuleCalendarDaysOfWeek)((NSNumber *)[scheduleDict objectForKey:@"daysOfWeek"]).integerValue;
    }
    NSTimeInterval startTime = 0.0;
    if([scheduleDict objectForKey:@"startTime"]) {
        startTime = (NSTimeInterval)((NSNumber *)[scheduleDict objectForKey:@"startTime"]).integerValue;
    }
    NSTimeInterval endTime = 0.0;
    if([scheduleDict objectForKey:@"endTime"]) {
        endTime = (NSTimeInterval)((NSNumber *)[scheduleDict objectForKey:@"endTime"]).integerValue;
    }
    
    PPLocationUserSchedule *schedule = [[PPLocationUserSchedule alloc] initWithDaysOfWeek:daysOfWeek startTime:startTime endTime:endTime];
    return schedule;
}
@end
