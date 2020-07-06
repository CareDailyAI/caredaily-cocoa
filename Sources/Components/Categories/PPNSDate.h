//
//  PPNSDate.h
//  Peoplepower
//
//  Created by Ryan Grimm on 2/11/13.
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNSDate : NSObject
+ (NSString *)apiFriendStringFromDate:(NSDate *)date;
+ (NSDate *)parseDateTime:(NSString *)dateString;
+ (NSDate *)parseDateTime:(NSString *)dateString timeZone:(NSTimeZone *)timeZone;
+ (NSDate *)parseAWSDateTime:(NSString *)dateString;
@end
