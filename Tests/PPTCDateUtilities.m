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
    date = [NSDate dateWithTimeIntervalSinceNow:10];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo isEqualToString:@""]);
    
    // Just now
    date = [NSDate date];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"just now", nil, bundle, @"")].location != NSNotFound);
    
    // Seconds
    date = [NSDate dateWithTimeIntervalSinceNow:-31];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"seconds ago", nil, bundle, @"")].location != NSNotFound);
    
    // Minute
    date = [NSDate dateWithTimeIntervalSinceNow:-60];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"a minute ago", nil, bundle, @"")].location != NSNotFound);
    
    // Minutes
    date = [NSDate dateWithTimeIntervalSinceNow:-120];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"minutes ago", nil, bundle, @"")].location != NSNotFound);
    
    // Hour
    date = [NSDate dateWithTimeIntervalSinceNow:-3600];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"an hour ago", nil, bundle, @"")].location != NSNotFound);
    
    // Hours
    date = [NSDate dateWithTimeIntervalSinceNow:-7200];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"hours ago", nil, bundle, @"")].location != NSNotFound);
    
    // Day
    date = [NSDate dateWithTimeIntervalSinceNow:-86400];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"yesterday", nil, bundle, @"")].location != NSNotFound);
    
    // Days
    date = [NSDate dateWithTimeIntervalSinceNow:-172800];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"days ago", nil, bundle, @"")].location != NSNotFound);
    
    // Week
    date = [NSDate dateWithTimeIntervalSinceNow:-604800];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"a week ago", nil, bundle, @"")].location != NSNotFound);
    
    // Weeks
    date = [NSDate dateWithTimeIntervalSinceNow:-1209600];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"weeks ago", nil, bundle, @"")].location != NSNotFound);
    
    // Month
    date = [NSDate dateWithTimeIntervalSinceNow:-2419200];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"a month ago", nil, bundle, @"")].location != NSNotFound);
    
    // Months
    date = [NSDate dateWithTimeIntervalSinceNow:-4838400];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"months ago", nil, bundle, @"")].location != NSNotFound);
    
    // Year
    date = [NSDate dateWithTimeIntervalSinceNow:-29030400];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"last year", nil, bundle, @"")].location != NSNotFound);
    
    // Years
    date = [NSDate dateWithTimeIntervalSinceNow:-58060800];
    timeAgo = [PPDateUtilities timeAgo:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"years ago", nil, bundle, @"")].location != NSNotFound);
}

- (void)testTimeAgoOlderThanToday {
    NSDate *date;
    NSString *timeAgo;
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier: @"com.peoplepowerco.lib.Peoplepower.iOS"];
    XCTAssert(bundle != nil);
    
    // Today
    date = [NSDate date];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"today", nil, bundle, @"")].location != NSNotFound);
    
    // Yesterday
    date = [NSDate dateWithTimeIntervalSinceNow:-86400];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"yesterday", nil, bundle, @"")].location != NSNotFound);
    
    // Days
    date = [NSDate dateWithTimeIntervalSinceNow:-172800];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"days ago", nil, bundle, @"")].location != NSNotFound);
    
    // Week
    date = [NSDate dateWithTimeIntervalSinceNow:-604800];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"a week ago", nil, bundle, @"")].location != NSNotFound);
    
    // Weeks
    date = [NSDate dateWithTimeIntervalSinceNow:-1209600];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"weeks ago", nil, bundle, @"")].location != NSNotFound);
    
    // Month
    date = [NSDate dateWithTimeIntervalSinceNow:-2419200];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"a month ago", nil, bundle, @"")].location != NSNotFound);
    
    // Months
    date = [NSDate dateWithTimeIntervalSinceNow:-4838400];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"months ago", nil, bundle, @"")].location != NSNotFound);
    
    // Year
    date = [NSDate dateWithTimeIntervalSinceNow:-29030400];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"last year", nil, bundle, @"")].location != NSNotFound);
    
    // Years
    date = [NSDate dateWithTimeIntervalSinceNow:-58060800];
    timeAgo = [PPDateUtilities timeAgoOlderThanToday:date];
    XCTAssertTrue([timeAgo rangeOfString:NSLocalizedStringFromTableInBundle(@"years ago", nil, bundle, @"")].location != NSNotFound);
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
