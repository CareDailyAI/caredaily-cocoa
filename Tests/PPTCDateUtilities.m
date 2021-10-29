//
//  PPTCDateUtilities.m
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 3/25/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDateUtilities.h>

@interface PPTCDateUtilities : PPBaseTestCase

@end

@implementation PPTCDateUtilities

- (void)setUp {
}

- (void)tearDown {
}

- (void)testTimeAgo {
    NSDate *date;
    NSString *timeAgo;
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier: @"com.peoplepowerco.lib.Peoplepower.iOS"];
    XCTAssert(bundle != nil);
    
    // None
    NSInteger secondsAgo = 0;
    date = [NSDate dateWithTimeIntervalSinceNow:10];
    timeAgo = [PPDateUtilities timeAgo:date];
    NSString *expectedResult = @"";
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Just now
    secondsAgo = 1;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.now", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"just now", @"just now");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Seconds
    secondsAgo = 31;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.sec.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld seconds ago", @"{number} seconds ago"), (long)secondsAgo];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Minute
    secondsAgo = 60;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.min.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a minute ago", @"a minute ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Minutes
    secondsAgo = 120;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.min.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld minutes ago", @"{number} minutes ago"), (long)secondsAgo / 60];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Hour
    secondsAgo = 3600;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.hour.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"an hour ago", @"an hour ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Hours
    secondsAgo = 7200;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.hour.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld hours ago", @"{number} hours ago"), (long)secondsAgo / 60 / 60];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Day
    secondsAgo = 86400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"yesterday", @"yesterday");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Days
    secondsAgo = 172800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld days ago", @"{number} days ago"), (long)secondsAgo / 60 / 60 / 24];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Week
    secondsAgo = 604800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a week ago", @"a week ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Weeks
    secondsAgo = 1209600;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld weeks ago", @"{number} weeks ago"), (long)secondsAgo / 60 / 60 / 24 / 7];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Month
    secondsAgo = 2419200;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a month ago", @"a month ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Months
    secondsAgo = 4838400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld months ago", @"{number} months ago"), (long)secondsAgo / 60 / 60 / 24 / 7 / 4];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Year
    secondsAgo = 29030400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"last year", @"last year");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Years
    secondsAgo = 58060800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgo:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld years ago", @"{number} years ago"), (long)secondsAgo / 60 / 60 / 24 / 7 / 4 / 12];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
}

- (void)testTimeAgoOlderThanToday {
    NSDate *date;
    NSString *timeAgo;
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier: @"com.peoplepowerco.lib.Peoplepower.iOS"];
    XCTAssert(bundle != nil);
    
    // Today
    NSInteger secondsAgo = 0;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    NSString *expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.now.alt", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"today", @"today");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Yesterday
    secondsAgo = 86400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"yesterday", @"yesterday");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Days
    secondsAgo = 172800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.day.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld days ago", @"{number} days ago"), (long)secondsAgo / 60 / 60 / 24];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Week
    secondsAgo = 604800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a week ago", @"a week ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Weeks
    secondsAgo = 1209600;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.week.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld weeks ago", @"{number} weeks ago"), (long)secondsAgo / 60 / 60 / 24 / 7];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Month
    secondsAgo = 2419200;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"a month ago", @"a month ago");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Months
    secondsAgo = 4838400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.month.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld months ago", @"{number} months ago"), (long)secondsAgo / 60 / 60 / 24 / 7 / 4];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Year
    secondsAgo = 29030400;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.single", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"last year", @"last year");
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
    
    // Years
    secondsAgo = 58060800;
    date = [NSDate dateWithTimeIntervalSinceNow:-secondsAgo];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    expectedResult = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"date.utilities.timeago.year.multiple", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"%ld years ago", @"{number} years ago"), (long)secondsAgo / 60 / 60 / 24 / 7 / 4 / 12];
    XCTAssertTrue([timeAgo isEqualToString:expectedResult]);
}

- (void)testDateInTimeZone {
    
    NSDate *date = [NSDate date];
    NSString *dateString;
    
    dateString = [PPDateUtilities dateInLocalTimezoneFormattedForLandingPage:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 3);
    
    dateString = [PPDateUtilities dateInLocalTimezoneFormattedForLandingPage:date use24HourTimeFormat:NO];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 4);
    
    dateString = [PPDateUtilities dateInTimezone:[NSTimeZone localTimeZone] formattedForLandingPage:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 3);
    
    dateString = [PPDateUtilities dateInLocalTimezoneFormattedForDeviceHistory:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 1);
    
    dateString = [PPDateUtilities dateInLocalTimezoneFormattedForDeviceHistory:date use24HourTimeFormat:NO];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 2);
    
    dateString = [PPDateUtilities dateInTimezone:[NSTimeZone localTimeZone] formattedForDeviceHistory:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 1);
    
    dateString = [PPDateUtilities dateInLocalTimezone:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 4);
    
    dateString = [PPDateUtilities dateInLocalTimezone:date use24HourTimeFormat:NO];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 5);
    
    dateString = [PPDateUtilities dateInTimezone:[NSTimeZone localTimeZone] referenceDate:date use24HourTimeFormat:YES];
    XCTAssertTrue([[dateString componentsSeparatedByString:@" "] count] == 4);
    
    dateString = [PPDateUtilities dateWithMonthOnly:date];
    XCTAssertTrue([[dateString componentsSeparatedByString:@"."] count] == 2);
    
    dateString = [PPDateUtilities dateInTimezone:[NSTimeZone localTimeZone] withMonthOnly:date];
    XCTAssertTrue([[dateString componentsSeparatedByString:@"."] count] == 2);
    
    dateString = [PPDateUtilities dateWithMonthAndDaysOnly:date];
    XCTAssertTrue([[dateString componentsSeparatedByString:@"."] count] == 3);
    
    dateString = [PPDateUtilities dateInTimezone:[NSTimeZone localTimeZone] withMonthAndDaysOnly:date];
    XCTAssertTrue([[dateString componentsSeparatedByString:@"."] count] == 3);
}

- (void)testDateComponents {
    
    NSDate *date = [NSDate date];
    NSDate *outDate;
    
    outDate = [PPDateUtilities getMonths:date];
    XCTAssertNotNil(outDate);
    
    outDate = [PPDateUtilities getDays:date];
    XCTAssertNotNil(outDate);
    
    outDate = [PPDateUtilities getHours:date];
    XCTAssertNotNil(outDate);
}

- (void)testDeltaComponents {
    
    NSDate *date = [NSDate date];
    NSInteger delta = 0;
    
    delta = [PPDateUtilities monthsBetweenDate:date andDate:[NSDate dateWithTimeIntervalSinceNow:2678400]];
    XCTAssertTrue(delta == 1);
    
    delta = [PPDateUtilities daysBetweenDate:date andDate:[NSDate dateWithTimeIntervalSinceNow:86400]];
    XCTAssertTrue(delta == 1);
    
    delta = [PPDateUtilities hoursBetweenDate:date andDate:[NSDate dateWithTimeIntervalSinceNow:3600]];
    XCTAssertTrue(delta == 1);
    
    delta = [PPDateUtilities minutesBetweenDate:date andDate:[NSDate dateWithTimeIntervalSinceNow:60]];
    XCTAssertTrue(delta == 1);
}

@end
