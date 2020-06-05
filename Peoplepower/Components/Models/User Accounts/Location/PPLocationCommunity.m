//
//  PPLocationCommunity.m
//  PPiOSCore
//
//  Created by Destry Teeter on 12/18/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPLocationCommunity.h"

@implementation PPLocationCommunity

- (id)initWithCommunityId:(PPCommunityId)communityId communityName:(NSString *)communityName locationId:(PPLocationId)locationId {
    self = [super init];
    if(self) {
        self.communityId = communityId;
        self.communityName = communityName;
        self.locationId = locationId;
    }
    return self;
}

+ (PPLocationCommunity *)initWithDictionary:(NSDictionary *)communityDict {
    
    PPCommunityId communityId = PPCommunityIdNone;
    if([communityDict objectForKey:@"communityId"]) {
        communityId = (PPCommunityId)((NSString *)[communityDict objectForKey:@"communityId"]).integerValue;
    }
    NSString *communityName = [communityDict objectForKey:@"communityName"];
    PPLocationId locationId = PPLocationIdNone;
    if([communityDict objectForKey:@"locationId"]) {
        locationId = (PPLocationId)((NSString *)[communityDict objectForKey:@"locationId"]).integerValue;
    }
    
    PPLocationCommunity *locationCommunity = [[PPLocationCommunity alloc] initWithCommunityId:communityId communityName:communityName locationId:locationId];
    return locationCommunity;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPLocationCommunity *community = [[[self class] allocWithZone:zone] init];
    
    community.communityId = self.communityId;
    community.communityName = [self.communityName copyWithZone:zone];
    community.locationId = self.locationId;
    
    return community;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.communityId = (PPCommunityId)((NSNumber *)[decoder decodeObjectForKey:@"communityId"]).integerValue;
        self.communityName = [decoder decodeObjectForKey:@"communityName"];
        self.locationId = (PPLocationId)((NSNumber *)[decoder decodeObjectForKey:@"locationId"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(self.communityId) forKey:@"communityId"];
    [encoder encodeObject:self.communityName forKey:@"communityName"];
    [encoder encodeObject:@(self.locationId) forKey:@"locationId"];
}


@end
