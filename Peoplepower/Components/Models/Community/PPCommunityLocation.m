//
//  PPCommunityLocation.m
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCommunityLocation.h"

@implementation PPCommunityLocation

- (id)initWithLocationId:(PPLocationId)locationId name:(NSString *)name timezone:(PPTimezone *)timezone latitude:(NSString *)latitude longitude:(NSString *)longitude {
    self = [super init];
    if(self) {
        self.locationId = locationId;
        self.name = name;
        self.timezone = timezone;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

+ (PPCommunityLocation *)initWithDictionary:(NSDictionary *)locationDict {
    PPLocationId locationId = PPLocationIdNone;
    if([locationDict objectForKey:@"id"]) {
        locationId = ((NSString *)[locationDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [locationDict objectForKey:@"name"];
    PPTimezone *timezone = [PPTimezone initWithDictionary:[locationDict objectForKey:@"timezone"]];
    NSString *latitude = [locationDict objectForKey:@"latitude"];
    NSString *longitude = [locationDict objectForKey:@"longitude"];
    
    PPCommunityLocation *location = [[PPCommunityLocation alloc] initWithLocationId:locationId name:name timezone:timezone latitude:latitude longitude:longitude];
    return location;
}

@end
