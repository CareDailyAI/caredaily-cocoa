//
//  PPDateUtilities.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPDateUtilities : NSObject

+ (NSString *) timeAgo:(NSDate *)referenceDate;
+ (NSString *) timeAgoOlderThanToday:(NSDate *)referenceDate;
+ (NSString *) dateInLocalTimezoneFormattedForLandingPage:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateInTimezone:(NSTimeZone *)timezone formattedForLandingPage:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateInLocalTimezoneFormattedForDeviceHistory:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateInTimezone:(NSTimeZone *)timezone formattedForDeviceHistory:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateInLocalTimezone:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateInTimezone:(NSTimeZone *)timezone referenceDate:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat;
+ (NSString *) dateWithMonthOnly:(NSDate *)referenceDate;
+ (NSString *) dateInTimezone:(NSTimeZone *)timezone withMonthOnly:(NSDate *)referenceDate;
+ (NSString *) dateWithMonthAndDaysOnly:(NSDate *)referenceDate;
+ (NSString *) dateInTimezone:(NSTimeZone *)timezone withMonthAndDaysOnly:(NSDate *)referenceDate;

+ (NSDate *)getMonths:(NSDate *)date;
+ (NSDate *)getDays:(NSDate *)date;
+ (NSDate *)getHours:(NSDate *)date;
+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)hoursBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)minutesBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

@end
