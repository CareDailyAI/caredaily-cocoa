//
//  PPDateUtilities.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPDateUtilities.h"
@import UIKit;

@implementation PPDateUtilities


+ (NSString *) timeAgo:(NSDate *)referenceDate {
	NSInteger secondsAgo = (NSInteger) -[referenceDate timeIntervalSinceNow];
	NSInteger minutesAgo = secondsAgo / 60;
	NSInteger hoursAgo = minutesAgo / 60;
	NSInteger daysAgo = hoursAgo / 24;
	NSInteger weeksAgo = daysAgo / 7;
	NSInteger monthsAgo = weeksAgo / 4;
	NSInteger yearsAgo = monthsAgo / 12;
	
	if(secondsAgo < 0) {
		return @"";
    } else if (secondsAgo < 30) {
        return NSLocalizedString(@"just now", @"Label - just now");
    } else if (secondsAgo < 60) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld seconds ago", @"Label - {number} seconds ago"), (long)secondsAgo];
    } else if (minutesAgo == 1) {
        return NSLocalizedString(@"a minute ago", @"Label - a minute ago");
    } else if (minutesAgo < 60) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld minutes ago", @"Label - {number} minutes ago"), (long)minutesAgo];
    } else if (hoursAgo == 1) {
        return NSLocalizedString(@"an hour ago", @"Label - an hour ago");
    } else if (hoursAgo < 24) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld hours ago", @"Label - {number} hours ago"), (long)hoursAgo];
    } else if (daysAgo == 1) {
        return NSLocalizedString(@"yesterday", @"Label - yesterday");
    } else if (daysAgo < 7) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld days ago", @"Label - {number} days ago"), (long)daysAgo];
    } else if (weeksAgo == 1) {
        return NSLocalizedString(@"a week ago", @"Label - a week ago");
    } else if (weeksAgo < 4) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld weeks ago", @"Label - {number} weeks ago"), (long)weeksAgo];
    } else if (monthsAgo == 1) {
        return NSLocalizedString(@"a month ago", @"Label - a month ago");
    } else if (monthsAgo < 12) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld months ago", @"Label - {number} months ago"), (long)monthsAgo];
    } else if (yearsAgo == 1) {
        return NSLocalizedString(@"last year", @"Label - last year");
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld years ago", @"Label - {number} years ago"), (long)yearsAgo];
    }
}


+ (NSString *) timeAgoOlderThanToday:(NSDate *)referenceDate {
	NSInteger secondsAgo = (NSInteger) -[referenceDate timeIntervalSinceNow];
	NSInteger minutesAgo = secondsAgo / 60;
	NSInteger hoursAgo = minutesAgo / 60;
	NSInteger daysAgo = hoursAgo / 24;
	NSInteger weeksAgo = daysAgo / 7;
	NSInteger monthsAgo = weeksAgo / 4;
	NSInteger yearsAgo = monthsAgo / 12;
	
    if(daysAgo == 0) {
        return NSLocalizedString(@"today", @"Label - today");
    }
    else if (daysAgo == 1) {
        return NSLocalizedString(@"yesterday", @"Label - yesterday");
    } else if (daysAgo < 7) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld days ago", @"Label - {number} days ago"), (long)daysAgo];
    } else if (weeksAgo == 1) {
        return NSLocalizedString(@"a week ago", @"Label - a week ago");
    } else if (weeksAgo < 4) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld weeks ago", @"Label - {number} weeks ago"), (long)weeksAgo];
    } else if (monthsAgo == 1) {
        return NSLocalizedString(@"a month ago", @"Label - a month ago");
    } else if (monthsAgo < 12) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld months ago", @"Label - {number} months ago"), (long)monthsAgo];
    } else if (yearsAgo == 1) {
        return NSLocalizedString(@"last year", @"Label - last year");
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"%ld years ago", @"Label - {number} years ago"), (long)yearsAgo];
    }
}

+ (NSString *) dateInLocalTimezoneFormattedForLandingPage:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    return [PPDateUtilities dateInTimezone:nil formattedForLandingPage:referenceDate use24HourTimeFormat:use24HourTimeFormat];
}

+ (NSString *) dateInTimezone:(NSTimeZone *)timezone formattedForLandingPage:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:(timezone) ? timezone : [NSTimeZone localTimeZone]];
    if(use24HourTimeFormat) {
        [localTime setDateFormat:@"HH:mm:ss - yyyy.MM.dd"];
    }
    else {
        [localTime setDateFormat:@"hh:mm:ss a - yyyy.MM.dd"];
    }
    return [localTime stringFromDate:referenceDate];
    
}

+ (NSString *) dateInLocalTimezoneFormattedForDeviceHistory:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    return [PPDateUtilities dateInTimezone:nil formattedForDeviceHistory:referenceDate use24HourTimeFormat:use24HourTimeFormat];
}

+ (NSString *) dateInTimezone:(NSTimeZone *)timezone formattedForDeviceHistory:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:(timezone) ? timezone : [NSTimeZone localTimeZone]];
    [localTime setDateStyle:NSDateFormatterMediumStyle];
    if(use24HourTimeFormat) {
        [localTime setDateFormat:@"HH:mm:ss"];
    }
    else {
        [localTime setDateFormat:@"hh:mm:ss a"];
    }
    return [localTime stringFromDate:referenceDate];
}

+ (NSString *) dateInLocalTimezone:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    return [PPDateUtilities dateInTimezone:nil referenceDate:referenceDate use24HourTimeFormat:use24HourTimeFormat];
}

+ (NSString *) dateInTimezone:(NSTimeZone *)timezone referenceDate:(NSDate *)referenceDate use24HourTimeFormat:(BOOL)use24HourTimeFormat {
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:(timezone) ? timezone : [NSTimeZone localTimeZone]];
    NSString *atString = NSLocalizedString(@"at", @"Label - at");
    if(use24HourTimeFormat) {
        [localTime setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd '%@' HH:mm:ss zzz", atString]];
    }
    else {
        [localTime setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd '%@' hh:mm:ss a zzz", atString]];
    }
    return [localTime stringFromDate:referenceDate];
    
}

+ (NSString *) dateWithMonthOnly:(NSDate *)referenceDate {
    return [PPDateUtilities dateInTimezone:nil withMonthOnly:referenceDate];
}

+ (NSString *) dateInTimezone:(NSTimeZone *)timezone withMonthOnly:(NSDate *)referenceDate {
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:(timezone) ? timezone : [NSTimeZone localTimeZone]];
    [localTime setDateFormat:@"yyyy.MM"];
    return [localTime stringFromDate:referenceDate];
}

+ (NSString *) dateWithMonthAndDaysOnly:(NSDate *)referenceDate {
    return [PPDateUtilities dateInTimezone:nil withMonthAndDaysOnly:referenceDate];
}

+ (NSString *) dateInTimezone:(NSTimeZone *)timezone withMonthAndDaysOnly:(NSDate *)referenceDate {
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:(timezone) ? timezone : [NSTimeZone localTimeZone]];
    [localTime setDateFormat:@"yyyy.MM.dd"];
    return [localTime stringFromDate:referenceDate];
    
}

+ (NSDate *)getMonths:(NSDate *)date {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        flags = NSCalendarUnitYear | NSCalendarUnitMonth;
    }
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}

+ (NSDate *)getDays:(NSDate *)date {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    }
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}

+ (NSDate *)getHours:(NSDate *)date {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    }
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}


+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    unsigned int dayUnit = NSDayCalendarUnit;
    unsigned int monthUnit = NSMonthCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        dayUnit = NSCalendarUnitDay;
        monthUnit = NSCalendarUnitMonth;
    }
    
    [calendar rangeOfUnit:dayUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:dayUnit startDate:&toDate interval:NULL forDate:toDateTime];
    NSDateComponents *difference = [calendar components:monthUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference month];
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    unsigned int dayUnit = NSDayCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        dayUnit = NSCalendarUnitDay;
    }
    
    [calendar rangeOfUnit:dayUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:dayUnit startDate:&toDate interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:dayUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference day];
}

+ (NSInteger)hoursBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    unsigned int hourUnit = NSHourCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        hourUnit = NSCalendarUnitHour;
    }
    [calendar rangeOfUnit:hourUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:hourUnit startDate:&toDate interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:hourUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference hour];
}

+ (NSInteger)minutesBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    unsigned int minuteUnit = NSMinuteCalendarUnit;
#pragma GCC diagnostic pop
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        minuteUnit = NSCalendarUnitMinute;
    }
    
    [calendar rangeOfUnit:minuteUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:minuteUnit startDate:&toDate interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:minuteUnit fromDate:fromDate toDate:toDate options:0];
    
    return [difference minute];
}

@end
