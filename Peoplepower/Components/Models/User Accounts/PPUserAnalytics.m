//
//  PPUserAnalytics.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserAnalytics.h"

@implementation PPUserAnalytics

/**
 * Check with the server to see if we should capture verbose analytics, or
 * quiet the analytics logging to only the most critical events
 */
+ (void)refresh {
    [PPSystemAndUserProperties getUserOrSystemProperty:SYSTEM_PROPERTY_ANALYTICS_LEVEL isPublic:PPSystemPropertyPublicFalse callback:^(NSString *s) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:s forKey:SYSTEM_PROPERTY_ANALYTICS_LEVEL];
		[defaults synchronize];
	}];
}

/**
 * @return YES if we should capture verbose analytics
 */
+ (PPAnalyticsLoggingLevels) getLoggingLevel {
	[PPUserAnalytics refresh];
	
	// The refresh won't happen before this executes
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *analyticsLevel = [defaults stringForKey:SYSTEM_PROPERTY_ANALYTICS_LEVEL];
	
#ifdef LOGLEVEL
	NSLog(@"analytics-level (override) = %d", LOGLEVEL);
	return LOGLEVEL;
#endif
		
	// I'm doing it this way to control issues if the string isn't an integer
	if([analyticsLevel isEqualToString:@"0"]) {
		return ANALYTICS_LEVEL_CRITICAL;
	}
	else if([analyticsLevel isEqualToString:@"1"]) {
		return ANALYTICS_LEVEL_ALERT;
	}
	else if([analyticsLevel isEqualToString:@"2"]) {
		return ANALYTICS_LEVEL_INFO;
	}
	else if([analyticsLevel isEqualToString:@"3"]) {
		return ANALYTICS_LEVEL_DEBUG;
	}
	else {
		return ANALYTICS_LEVEL_CRITICAL;
	}
}

+ (NSTimeInterval)timeIntervalForLoggingLevel:(PPAnalyticsLoggingLevels)logLevel {
    switch (logLevel) {
        case ANALYTICS_LEVEL_CRITICAL:
            return ANALYTICS_TIME_INTERVAL_CRITICAL;
            break;
        case ANALYTICS_LEVEL_ALERT:
            return ANALYTICS_TIME_INTERVAL_ALERT;
            break;
        case ANALYTICS_LEVEL_INFO:
            return ANALYTICS_TIME_INTERVAL_INFO;
            break;
        case ANALYTICS_LEVEL_DEBUG:
            return ANALYTICS_TIME_INTERVAL_DEBUG;
            break;
            
        default:
            return ANALYTICS_TIME_INTERVAL_CRITICAL;
            break;
    }
}

@end
