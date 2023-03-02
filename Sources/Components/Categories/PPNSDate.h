//
//  PPNSDate.h
//  Peoplepower
//
//  Created by Ryan Grimm on 2/11/13.
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNSDate : NSObject
+ (NSString *)apiFriendStringFromDate:(NSDate *)date;
+ (NSDate *)parseDateTime:(NSString *)dateString;
+ (NSDate *)parseDateTime:(NSString *)dateString timeZone:(NSTimeZone *)timeZone;
+ (NSDate *)parseAWSDateTime:(NSString *)dateString;
@end
