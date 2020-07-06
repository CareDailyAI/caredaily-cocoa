//
//  PPRuleCalendar.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

typedef NS_OPTIONS(NSInteger, PPRuleCalendarInclude) {
    PPRuleCalendarIncludeNone = -1,
    PPRuleCalendarIncludeFalse = 0,
    PPRuleCalendarIncludeTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleCalendarTime) {
    PPRuleCalendarTimeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleCalendarDaysOfWeek) {
    PPRuleCalendarDaysOfWeekNone      = 0,
    PPRuleCalendarDaysOfWeekSunday    = 1 << 0,
    PPRuleCalendarDaysOfWeekMonday    = 1 << 1,
    PPRuleCalendarDaysOfWeekTuesday   = 1 << 2,
    PPRuleCalendarDaysOfWeekWednesday = 1 << 3,
    PPRuleCalendarDaysOfWeekThursday  = 1 << 4,
    PPRuleCalendarDaysOfWeekFriday    = 1 << 5,
    PPRuleCalendarDaysOfWeekSaturday  = 1 << 6,
};

@interface PPRuleCalendar : RLMObject <NSCopying>

@property (nonatomic) PPRuleCalendarInclude include;
@property (nonatomic) PPRuleCalendarTime startTime;
@property (nonatomic) PPRuleCalendarTime endTime;
@property (nonatomic) PPRuleCalendarDaysOfWeek daysOfWeek;

- (id)initWithStartTime:(PPRuleCalendarTime)startTime endTime:(PPRuleCalendarTime)endTime daysOfWeek:(PPRuleCalendarDaysOfWeek)daysOfWeek include:(PPRuleCalendarInclude)include;

+ (PPRuleCalendar *)initWithDictionary:(NSDictionary *)calendarDict;

+ (NSString *)stringify:(PPRuleCalendar *)calendar;
+ (NSDictionary *)data:(PPRuleCalendar *)calendar;

@end

RLM_ARRAY_TYPE(PPRuleCalendar);
