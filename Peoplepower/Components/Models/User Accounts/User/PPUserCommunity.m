//
//  PPUserCommunity.m
//  PPiOSCore
//
//  Created by Destry Teeter on 12/31/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPUserCommunity.h"

@implementation PPUserCommunity

- (id)initWithCommunityId:(PPCommunityId)communityId communityName:(NSString *)communityName {
    self = [super init];
    if(self) {
        self.communityId = communityId;
        self.communityName = communityName;
    }
    return self;
}

+ (PPUserCommunity *)initWithDictionary:(NSDictionary *)communityDict {
    
    PPCommunityId communityId = PPCommunityIdNone;
    if([communityDict objectForKey:@"communityId"]) {
        communityId = (PPCommunityId)((NSString *)[communityDict objectForKey:@"communityId"]).integerValue;
    }
    NSString *communityName = [communityDict objectForKey:@"communityName"];
    
    PPUserCommunity *userCommunity = [[PPUserCommunity alloc] initWithCommunityId:communityId communityName:communityName];
    return userCommunity;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUserCommunity *community = [[[self class] allocWithZone:zone] init];
    
    community.communityId = self.communityId;
    community.communityName = [self.communityName copyWithZone:zone];
    
    return community;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.communityId = (PPCommunityId)((NSNumber *)[decoder decodeObjectForKey:@"communityId"]).integerValue;
        self.communityName = [decoder decodeObjectForKey:@"communityName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(self.communityId) forKey:@"communityId"];
    [encoder encodeObject:self.communityName forKey:@"communityName"];
}


@end
