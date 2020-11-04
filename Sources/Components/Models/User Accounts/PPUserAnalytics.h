//
//  PPUserAnalytics.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#ifndef USER_ANALYTICS_MIXPANEL_TOKEN
#define USER_ANALYTICS_MIXPANEL_TOKEN @"bc4a7522180c850cd76a2b7d5ed29c72"
#endif

@interface PPUserAnalytics : NSObject

+ (void)refresh;
+ (PPAnalyticsLoggingLevels) getLoggingLevel;

+ (void)initMixpanelSharedinstanceWithLaunchOptions:(NSDictionary *)launchOptions;
+ (void)track:(NSString *)event properties:(NSDictionary *)properties logLevel:(PPAnalyticsLoggingLevels)logLevel;
+ (void)timeEvent:(NSString *)event;
+ (void)registerSuperProperties:(NSDictionary *)superProperties;
+ (void)unregisterSuperProperty:(NSString *)superProperty;
+ (void)reset;

@end
