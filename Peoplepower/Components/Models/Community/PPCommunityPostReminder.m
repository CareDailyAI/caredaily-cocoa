//
//  PPCommunityPostReminder.m
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPCommunityPostReminder.h"

@implementation PPCommunityPostReminder

- (id)initWithNotificationDate:(NSDate *)notificationDate
          notificationInterval:(NSNumber *)notificationInterval
              notificationText:(NSString *)notificationText {
    self = [super init];
    if (self) {
        self.notificationDate = notificationDate;
        self.notificationInterval = notificationInterval;
        self.notificationText = notificationText;
    }
    return self;
}

+ (PPCommunityPostReminder *)initWithDictionary:(NSDictionary *)reminderDict {
    
    
    NSString *notificationDateString = [reminderDict objectForKey:@"notificationDate"];
    NSDate *notificationDate;
    
    if(notificationDateString != nil) {
        if(![notificationDateString isEqualToString:@""]) {
            notificationDate = [PPNSDate parseDateTime:notificationDateString];
        }
    }
    
    NSNumber *notificationInterval = [reminderDict objectForKey:@"notificationInterval"];
    
    NSString *notificationText = [reminderDict objectForKey:@"notificationText"];
    
    PPCommunityPostReminder *postReminder = [[PPCommunityPostReminder alloc] initWithNotificationDate:notificationDate
                                                                                 notificationInterval:notificationInterval
                                                                                     notificationText:notificationText];
    return postReminder;
}

+ (NSDictionary *)dataFromPostReminder:(PPCommunityPostReminder *)postReminder {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (postReminder.notificationDate) {
        [data setValue:[PPNSDate apiFriendStringFromDate:postReminder.notificationDate] forKey:@"notificationDate"];
    }
    if (postReminder.notificationInterval) {
        [data setValue:postReminder.notificationInterval forKey:@"notificationInterval"];
    }
    if (postReminder.notificationText) {
        [data setValue:postReminder.notificationText forKey:@"notificationText"];
    }
    return data;
}

@end
