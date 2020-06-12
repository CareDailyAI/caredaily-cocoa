//
//  PPLocationNarrative.m
//  Peoplepower
//
//  Created by Destry Teeter on 9/25/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A way for bots to produce a narrative for a location - i.e. document someone's day, or security breaches, etc.
//Friends and family who can switch into and view your location should be able to see your narrative. Administrators should also be able to access your narrative in Maestro for debugging / understanding / explanation of "why did that happen in my home?" purposes.

#import "PPLocationNarrative.h"

@implementation PPLocationNarrative

- (id)initWithId:(PPLocationNarrativeId)narrativeId locationId:(PPLocationId)locationId narrativeDate:(NSDate *)narrativeDate priority:(PPLocationNarrativePriority)priority icon:(NSString *)icon title:(NSString *)title description:(NSString *)desc target:(NSDictionary *)target creationDate:(NSDate *)creationDate appInstanceId:(PPBotengineAppInstanceId)appInstanceId {
    self = [super init];
    if(self) {
        self.narrativeId = narrativeId;
        self.locationId = locationId;
        self.narrativeDate = narrativeDate;
        self.priority = priority;
        self.icon = icon;
        self.title = title;
        self.desc = desc;
        self.target = target;
        self.creationDate = creationDate;
        self.appInstanceId = appInstanceId;
    }
    return self;
}

+ (PPLocationNarrative *)initWithDictionary:(NSDictionary *)narrativeDict {
    PPLocationNarrativeId narrativeId = PPLocationNarrativeIdNone;
    if([narrativeDict objectForKey:@"id"]) {
        narrativeId = ((NSString *)[narrativeDict objectForKey:@"id"]).integerValue;
    }
    PPLocationId locationId = PPLocationIdNone;
    if([narrativeDict objectForKey:@"locationId"]) {
        locationId = ((NSString *)[narrativeDict objectForKey:@"locationId"]).integerValue;
    }
    
    NSString *narrativeDateString = [narrativeDict objectForKey:@"narrativeDate"];
    NSDate *narrativeDate = [NSDate date];
    if(narrativeDateString != nil) {
        if(![narrativeDateString isEqualToString:@""]) {
            narrativeDate = [PPNSDate parseDateTime:narrativeDateString];
        }
    }
    
    PPLocationNarrativePriority priority = PPLocationNarrativePriorityNone;
    if([narrativeDict objectForKey:@"priority"]) {
        priority = ((NSString *)[narrativeDict objectForKey:@"priority"]).integerValue;
    }
    NSString *icon = [narrativeDict objectForKey:@"icon"];
    NSString *title = [narrativeDict objectForKey:@"title"];
    NSString *desc = [narrativeDict objectForKey:@"description"];
    NSDictionary *target = (NSDictionary *)[narrativeDict objectForKey:@"target"];
    
    NSString *creationDateString = [narrativeDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    PPBotengineAppInstanceId appInstanceId = PPBotengineAppInstanceIdNone;
    if([narrativeDict objectForKey:@"appInstanceId"]) {
        appInstanceId = ((NSString *)[narrativeDict objectForKey:@"appInstanceId"]).integerValue;
    }
    
    return [[PPLocationNarrative alloc] initWithId:narrativeId locationId:locationId narrativeDate:narrativeDate priority:priority icon:icon title:title description:desc target:target creationDate:creationDate appInstanceId:appInstanceId];
}

+ (NSString *)stringify:(PPLocationNarrative *)narrative {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    
    [JSONString appendString:@"{"];
    BOOL appendComma = NO;
    if(narrative.narrativeDate) {
        [JSONString appendFormat:@"\"narrativeTime\":%li", (long)[narrative.narrativeDate timeIntervalSince1970] * 1000];
        appendComma = YES;
    }
    if(narrative.priority != PPLocationNarrativePriorityNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"priority\":%li", (long)narrative.priority];
        appendComma = YES;
    }
    if(narrative.icon) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"icon\":\"%@\"", narrative.icon];
        appendComma = YES;
    }
    if(narrative.title) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"title\":\"%@\"", narrative.title];
        appendComma = YES;
    }
    if(narrative.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"description\":\"%@\"", narrative.desc];
        appendComma = YES;
    }
    if(narrative.target) {
        NSError *err = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:narrative.target options:0 error:&err];
        if(!err) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            
            
            [JSONString appendFormat:@"\"target\":%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            appendComma = YES;
        }
    }
        
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPLocationNarrative *)narrative {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(narrative.narrativeDate) {
        data[@"narrativeTime"] = @([narrative.narrativeDate timeIntervalSince1970] * 1000);
    }
    if(narrative.priority != PPLocationNarrativePriorityNone) {
        data[@"priority"] = @(narrative.priority);
    }
    if(narrative.icon) {
        data[@"icon"] = narrative.icon;
    }
    if(narrative.title) {
        data[@"title"] = narrative.title;
    }
    if(narrative.desc) {
        data[@"description"] = narrative.desc;
    }
    if(narrative.target) {
        data[@"target"] = narrative.target;
    }
    
    return data;
}

@end
