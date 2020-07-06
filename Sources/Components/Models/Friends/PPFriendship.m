//
//  PPFriendship.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPFriendship.h"

@implementation PPFriendship

+ (NSString *)primaryKey {
    return @"friendshipId";
}

- (id)initWithFriendshipId:(PPFriendshipId)friendshipId friendshipFriend:(PPFriendshipFriend *)friendshipFriend email:(NSString *)email blocked:(PPFriendshipBlocked)blocked ownDevices:(RLMArray *)ownDevices friendDevices:(RLMArray *)friendDevices {
    self = [super init];
    if(self) {
        self.friendshipId = friendshipId;
        self.friendshipFriend = friendshipFriend;
        self.email = email;
        self.blocked = blocked;
        self.ownDevices = (RLMArray<PPFriendshipDevice *><PPFriendshipDevice> *)ownDevices;
        self.friendDevices = (RLMArray<PPFriendshipDevice *><PPFriendshipDevice> *)friendDevices;
    }
    return self;
}

+ (PPFriendship *)initWithDictionary:(NSDictionary *)friendshipDict {
    
    PPFriendshipId friendshipId = PPFriendshipIdNone;
    if([friendshipDict objectForKey:@"id"]) {
        friendshipId = (PPFriendshipId)((NSString *)[friendshipDict objectForKey:@"id"]).integerValue;
    }
    
    PPFriendshipFriend *friendshipFriend = [PPFriendshipFriend initWithDictionary:[friendshipDict objectForKey:@"friend"]];
    
    NSString *email = [friendshipDict objectForKey:@"email"];
    PPFriendshipBlocked blocked = PPFriendshipBlockedNone;
    if([friendshipDict objectForKey:@"blocked"]) {
        blocked = (PPFriendshipBlocked)((NSString *)[friendshipDict objectForKey:@"blocked"]).integerValue;
    }
    
    NSMutableArray *ownDeviceArray;
    if([friendshipDict objectForKey:@"ownDevices"]) {
        ownDeviceArray = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *ownDeviceDict in [friendshipDict objectForKey:@"ownDevices"]) {
            PPFriendshipDevice *device = [PPFriendshipDevice initWithDictionary:ownDeviceDict];
            device.friendshipId = friendshipId;
            [ownDeviceArray addObject:device];
        }
    }
    
    NSMutableArray *friendDeviceArray;
    if([friendshipDict objectForKey:@"friendDevices"]) {
        friendDeviceArray = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *friendDeviceDict in [friendshipDict objectForKey:@"friendDevices"]) {
            PPFriendshipDevice *device = [PPFriendshipDevice initWithDictionary:friendDeviceDict];
            device.friendshipId = friendshipId;
            [friendDeviceArray addObject:device];
        }
    }
    
    NSArray *sortedOwnDevices;
    if(ownDeviceArray) {
        sortedOwnDevices = [ownDeviceArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            PPDevice *first = (PPDevice *)a;
            PPDevice *second = (PPDevice *)b;
            return [@(first.typeId) compare:@(second.typeId)];
        }];
    }
    
    NSArray *sortedFriendDevices;
    if(friendDeviceArray) {
        sortedFriendDevices = [friendDeviceArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            PPDevice *first = (PPDevice *)a;
            PPDevice *second = (PPDevice *)b;
            return [@(first.typeId) compare:@(second.typeId)];
        }];
    }
    
    PPFriendship *friendship = [[PPFriendship alloc] initWithFriendshipId:friendshipId friendshipFriend:friendshipFriend email:email blocked:blocked ownDevices:(RLMArray *)sortedOwnDevices friendDevices:(RLMArray *)sortedFriendDevices];
    return friendship;
}

+ (NSString *)JSONStringForFriendship:(PPFriendship *)friendship {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(friendship.friendshipFriend) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"friend\": %@", [PPFriendshipFriend stringify:friendship.friendshipFriend]];
        appendComma = YES;
    }
    
    if(friendship.blocked != PPFriendshipBlockedNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"blocked\": %li", (long)friendship.blocked];
        appendComma = YES;
    }
    
    if([friendship.ownDevices count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"ownDevices\": ["];
        
        BOOL appendDeviceComma = NO;
        for(PPFriendshipDevice *device in friendship.ownDevices) {
            if(appendDeviceComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPFriendshipDevice stringify:device]];
            appendDeviceComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }

    if([friendship.friendDevices count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"friendDevices\": ["];

        BOOL appendDeviceComma = NO;
        for(PPFriendshipDevice *device in friendship.friendDevices) {
            if(appendDeviceComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPFriendshipDevice stringify:device]];
            appendDeviceComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToFriendship:(PPFriendship *)friendship {
    BOOL equal = NO;
    
    if(friendship.friendshipId != PPFriendshipIdNone && _friendshipId != PPFriendshipIdNone) {
        if(friendship.friendshipId == _friendshipId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPFriendship *)friendship {
    
    if(friendship.friendshipId != PPFriendshipIdNone) {
        _friendshipId = friendship.friendshipId;
    }
    if(friendship.friendshipFriend) {
        _friendshipFriend = friendship.friendshipFriend;
    }
    if(friendship.email) {
        _email = friendship.email;
    }
    if(friendship.blocked != PPFriendshipBlockedNone) {
        _blocked = friendship.blocked;
    }
    if(friendship.ownDevices) {
        _ownDevices = friendship.ownDevices;
    }
    if(friendship.friendDevices) {
        _friendDevices = friendship.friendDevices;
    }
}

@end
