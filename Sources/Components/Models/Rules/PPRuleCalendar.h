//
//  PPRuleCalendar.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPRuleCalendar : PPBaseModel <NSCopying>

@property (nonatomic) PPRuleCalendarInclude include;
@property (nonatomic) PPRuleCalendarTime startTime;
@property (nonatomic) PPRuleCalendarTime endTime;
@property (nonatomic) PPRuleCalendarDaysOfWeek daysOfWeek;

- (id)initWithStartTime:(PPRuleCalendarTime)startTime endTime:(PPRuleCalendarTime)endTime daysOfWeek:(PPRuleCalendarDaysOfWeek)daysOfWeek include:(PPRuleCalendarInclude)include;

+ (PPRuleCalendar *)initWithDictionary:(NSDictionary *)calendarDict;

+ (NSString *)stringify:(PPRuleCalendar *)calendar;
+ (NSDictionary *)data:(PPRuleCalendar *)calendar;

@end
