//
//  PPNSDate.m
//  Peoplepower
//
//  Created by Ryan Grimm on 2/11/13.
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPNSDate.h"

@implementation PPNSDate

+ (NSString *)apiFriendStringFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)parseDateTime:(NSString *)dateString {    
    NSDate *date = [[[NSISO8601DateFormatter alloc] init] dateFromString:dateString];
    if (date == nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
        date = [dateFormatter dateFromString:dateString];
    }
    return date;
}

+ (NSDate *)parseDateTime:(NSString *)dateString timeZone:(NSTimeZone *)timeZone {
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:dateString];
    if (date == nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setTimeZone:timeZone];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
        date = [dateFormatter dateFromString:dateString];
    }
    return date;
}

/*
 Convert X-Aws-Date "yyyymmddThhmmssZ" to NSDate
 */
+ (NSDate *)parseAWSDateTime:(NSString *)dateString {
    if (dateString == nil || dateString.length < 16) {
        return nil;
    }
    NSString *yr = [dateString substringWithRange:NSMakeRange(0, 4)];
    NSString *mo = [dateString substringWithRange:NSMakeRange(4, 2)];
    NSString *dy = [dateString substringWithRange:NSMakeRange(6, 2)];
    
    NSString *hr = [dateString substringWithRange:NSMakeRange(9, 2)];
    NSString *mi = [dateString substringWithRange:NSMakeRange(11, 2)];
    NSString *sc = [dateString substringWithRange:NSMakeRange(13, 2)];
    
    NSString *tz = [dateString substringWithRange:NSMakeRange(15, 1)];
    
    return [PPNSDate parseDateTime:[NSString stringWithFormat:@"%@-%@-%@T%@:%@:%@%@", yr, mo, dy, hr, mi, sc, tz]];
}

@end
