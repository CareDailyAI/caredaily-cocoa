//
//  PPDateUtilities.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPDateUtilities.h"

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
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.now", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"just now", @"just now");
    } else if (secondsAgo < 60) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.sec.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld seconds ago", @"{number} seconds ago"), (long)secondsAgo];
    } else if (minutesAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.min.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a minute ago", @"a minute ago");
    } else if (minutesAgo < 60) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.min.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld minutes ago", @"{number} minutes ago"), (long)minutesAgo];
    } else if (hoursAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.hour.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"an hour ago", @"an hour ago");
    } else if (hoursAgo < 24) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.hour.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld hours ago", @"{number} hours ago"), (long)hoursAgo];
    } else if (daysAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"yesterday", @"yesterday");
    } else if (daysAgo < 7) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld days ago", @"{number} days ago"), (long)daysAgo];
    } else if (weeksAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a week ago", @"a week ago");
    } else if (weeksAgo < 4) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld weeks ago", @"{number} weeks ago"), (long)weeksAgo];
    } else if (monthsAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a month ago", @"a month ago");
    } else if (monthsAgo < 12) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld months ago", @"{number} months ago"), (long)monthsAgo];
    } else if (yearsAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"last year", @"last year");
    } else {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld years ago", @"{number} years ago"), (long)yearsAgo];
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
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.now.alt", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"today", @"today");
    }
    else if (daysAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"yesterday", @"yesterday");
    } else if (daysAgo < 7) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld days ago", @"{number} days ago"), (long)daysAgo];
    } else if (weeksAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a week ago", @"a week ago");
    } else if (weeksAgo < 4) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld weeks ago", @"{number} weeks ago"), (long)weeksAgo];
    } else if (monthsAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a month ago", @"a month ago");
    } else if (monthsAgo < 12) {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld months ago", @"{number} months ago"), (long)monthsAgo];
    } else if (yearsAgo == 1) {
        return NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"last year", @"last year");
    } else {
        return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld years ago", @"{number} years ago"), (long)yearsAgo];
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
    NSString *atString = NSLocalizedStringWithDefaultValue(@"date.utilities.join.at", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"at", @"at");
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
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth;
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}

+ (NSDate *)getDays:(NSDate *)date {
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}

+ (NSDate *)getHours:(NSDate *)date {
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:flags fromDate:date];
	return [cal dateFromComponents:components];
}


+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    unsigned int dayUnit = NSCalendarUnitDay;
    unsigned int monthUnit = NSCalendarUnitMonth;
    
    [calendar rangeOfUnit:dayUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:dayUnit startDate:&toDate interval:NULL forDate:toDateTime];
    NSDateComponents *difference = [calendar components:monthUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference month];
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    unsigned int dayUnit = NSCalendarUnitDay;
    
    [calendar rangeOfUnit:dayUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:dayUnit startDate:&toDate interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:dayUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference day];
}

+ (NSInteger)hoursBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    unsigned int hourUnit = NSCalendarUnitHour;
    [calendar rangeOfUnit:hourUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:hourUnit startDate:&toDate interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:hourUnit fromDate:fromDate toDate:toDate options:0];
	
    return [difference hour];
}

+ (NSInteger)minutesBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int minuteUnit = NSCalendarUnitMinute;
    
    [calendar rangeOfUnit:minuteUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:minuteUnit startDate:&toDate interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:minuteUnit fromDate:fromDate toDate:toDate options:0];
    
    return [difference minute];
}

@end
