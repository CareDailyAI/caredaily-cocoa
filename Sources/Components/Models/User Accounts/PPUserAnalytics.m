//
//  PPUserAnalytics.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserAnalytics.h"
//#import "Mixpanel.h"
//#import "PRAppDelegate.h"

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

+ (void)initMixpanelSharedinstanceWithLaunchOptions:(NSDictionary *)launchOptions {
    if(![PPUserAnalytics isUserAnalyticsAvailable]) {
        // Mixpanel crashes hard on older devices, do not attempt to track
        return;
    }
#ifdef DEBUG
    NSLog(@"%s launchOptions=%@", __PRETTY_FUNCTION__, launchOptions);
#endif
//    [Mixpanel sharedInstanceWithToken:USER_ANALYTICS_MIXPANEL_TOKEN launchOptions:launchOptions];
#ifdef DEBUG
//    [[Mixpanel sharedInstance] enableLogging];
#endif
}

+ (void)track:(NSString *)event properties:(NSDictionary *)properties logLevel:(PPAnalyticsLoggingLevels)logLevel {
    if(![PPUserAnalytics isUserAnalyticsAvailable]) {
        // Mixpanel crashes hard on older devices, do not attempt to track
        return;
    }
    if(logLevel >= [PPUserAnalytics getLoggingLevel]) {
        if(properties) {
            // Formulate our token string that we use to manage storing values to our user defaults
            // token = "userAnalytics{-?Location}{-?Description}"
            BOOL track = YES;
            NSMutableString *tokenKey = [NSMutableString stringWithString:@"userAnalytics"];
            if([properties objectForKey:@"Location"] != nil) {
                track = NO;
                [tokenKey appendFormat:@"-%@", [properties objectForKey:@"Location"]];
            }
            if([properties objectForKey:@"Description"] != nil) {
                track = NO;
                [tokenKey appendFormat:@"-%@", [properties objectForKey:@"Description"]];
            }
            
            // Extract token values
            // value = "{!timeStamp}{-?count}"
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            double lastTimestamp = 0;
            int count = 1;
            
            if([defaults objectForKey:tokenKey] != nil) {
                NSString *tokenValue = [defaults objectForKey:tokenKey];
                // This token has a count, grab it
                if([tokenValue rangeOfString:@"-"].location != NSNotFound) {
                    NSArray *tokenValueArray = [tokenValue componentsSeparatedByString:@"&"];
                    lastTimestamp = [(NSNumber *)[tokenValueArray firstObject] doubleValue];
                    count += [(NSNumber *)[tokenValueArray lastObject] intValue];
                }
                else {
                    lastTimestamp = [(NSNumber *)[defaults objectForKey:tokenKey] doubleValue];
                }
                
                // Record this event depending on the selected analytics logging level time interval
                if([[NSDate date] timeIntervalSince1970] - lastTimestamp > [PPUserAnalytics timeIntervalForLoggingLevel:logLevel]) {
                    // Track event
                    track = YES;
                    
                    // Reset token value and do not include count parameter
                    [defaults setObject:[NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]] forKey:tokenKey];
                    [defaults synchronize];
                    
                    if(count > 1) {
                        // Update our properties with this count
                        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:properties];
                        [d setObject:[NSString stringWithFormat:@"%i", count] forKey:@"Event Count"];
                        properties = d;
                    }
                }
                else {;
                    // Do not track this event but update our token value with the new count
                    [defaults setObject:[NSString stringWithFormat:@"%.f-%i",[[NSDate date] timeIntervalSince1970], count] forKey:tokenKey];
                    [defaults synchronize];
                }
            }
            else {
                // Track new event and set token value and do not include count parameter
                track = YES;
                [defaults setObject:[NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]] forKey:tokenKey];
                [defaults synchronize];
            }
            
            if(track) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[Mixpanel sharedInstance] track:event properties:properties];
                });
            }
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                [[Mixpanel sharedInstance] track:event];
            });
        }
    }
}

+ (void)timeEvent:(NSString *)event {
#ifdef DEBUG
    NSLog(@"%s event=%@", __PRETTY_FUNCTION__, event);
#endif
//    [[Mixpanel sharedInstance] timeEvent:event];
}

+ (void)registerSuperProperties:(NSDictionary *)superProperties {
    if(![PPUserAnalytics isUserAnalyticsAvailable]) {
        // Mixpanel crashes hard on older devices, do not attempt to track
        return;
    }
#ifdef DEBUG
    NSLog(@"%s superProperties=%@", __PRETTY_FUNCTION__, superProperties);
#endif
//    [[Mixpanel sharedInstance] registerSuperProperties:superProperties];
}

+ (void)unregisterSuperProperty:(NSString *)superProperty {
    if(![PPUserAnalytics isUserAnalyticsAvailable]) {
        // Mixpanel crashes hard on older devices, do not attempt to track
        return;
    }
#ifdef DEBUG
    NSLog(@"%s superProperty=%@", __PRETTY_FUNCTION__, superProperty);
#endif
//    [[Mixpanel sharedInstance] unregisterSuperProperty:superProperty];
}

+ (void)reset {
    if(![PPUserAnalytics isUserAnalyticsAvailable]) {
        // Mixpanel crashes hard on older devices, do not attempt to track
        return;
    }
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
//    [[Mixpanel sharedInstance] reset];
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

+ (BOOL)isUserAnalyticsAvailable {
#if !TARGET_OS_WATCH
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return YES;
    }
#endif
    return NO;
}

@end
