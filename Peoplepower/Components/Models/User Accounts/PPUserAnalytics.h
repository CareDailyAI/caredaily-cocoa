//
//  PPUserAnalytics.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

typedef NS_OPTIONS(NSInteger, PPAnalyticsLoggingLevels) {
	// Only critical logging elements (open app, create account, market)
	ANALYTICS_LEVEL_CRITICAL = 0,
	
	// New features we're testing + critical logging elements
	ANALYTICS_LEVEL_ALERT = 1,
	
	// Log the normal user flow
	ANALYTICS_LEVEL_INFO = 2,
	
	// Add trace level debugging
	ANALYTICS_LEVEL_DEBUG = 3,
};

typedef NS_OPTIONS(NSInteger, PPAnalyticsLoggingLevelTimeIntevals) {
    ANALYTICS_TIME_INTERVAL_CRITICAL = 5,
    ANALYTICS_TIME_INTERVAL_ALERT    = 30,
    ANALYTICS_TIME_INTERVAL_INFO     = 120,
    ANALYTICS_TIME_INTERVAL_DEBUG    = 0,
};

@interface PPUserAnalytics : NSObject

+ (void)refresh;
+ (PPAnalyticsLoggingLevels)getLoggingLevel;
+ (NSTimeInterval)timeIntervalForLoggingLevel:(PPAnalyticsLoggingLevels)logLevel;

@end
