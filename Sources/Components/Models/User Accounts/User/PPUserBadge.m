//
//  PPUserBadge.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
 
#import "PPUserBadge.h"

@implementation PPUserBadge

- (id)initWithType:(PPUserBadgeType)type count:(PPUserBadgeCount)count {
    self = [super init];
    if(self) {
        self.type = type;
        self.count = count;
    }
    return self;
}

+ (PPUserBadge *)initWithDictionary:(NSDictionary *)badgeDict {
    PPUserBadgeType type = PPUserBadgeTypeNone;
    if([badgeDict objectForKey:@"type"]) {
        type = (PPUserBadgeType)((NSString *)[badgeDict objectForKey:@"type"]).integerValue;
    }
    PPUserBadgeCount count = PPUserBadgeCountNone;
    if([badgeDict objectForKey:@"count"]) {
        count = (PPUserBadgeCount)((NSString *)[badgeDict objectForKey:@"count"]).integerValue;
    }
    
    PPUserBadge *badge = [[PPUserBadge alloc] initWithType:type count:count];
    return badge;
}

#pragma mark - Helper methods

- (void)sync:(PPUserBadge *)userBadge {
    if(userBadge.type != PPUserBadgeTypeNone) {
        _type = userBadge.type;
    }
    if(userBadge.count != PPUserBadgeCountNone) {
        _count = userBadge.count;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUserBadge *badge = [[PPUserBadge allocWithZone:zone] init];
    
    badge.type = self.type;
    badge.count = self.count;
    
    return badge;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.type = (PPUserBadgeType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
        self.count = (PPUserBadgeCount)((NSNumber *)[decoder decodeObjectForKey:@"count"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_type) forKey:@"type"];
    [encoder encodeObject:@(_count) forKey:@"count"];
}

@end
