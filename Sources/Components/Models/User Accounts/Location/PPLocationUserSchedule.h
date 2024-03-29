//
//  PPLocationUserSchedule.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRuleCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPLocationUserSchedule : PPBaseModel

@property (nonatomic) PPRuleCalendarDaysOfWeek daysOfWeek;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval endTime;

- (id)initWithDaysOfWeek:(PPRuleCalendarDaysOfWeek)daysOfWeek startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

+ (PPLocationUserSchedule *)initWithDictionary:(NSDictionary *)scheduleDict;

@end

NS_ASSUME_NONNULL_END
