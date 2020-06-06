//
//  PPFriendshipFriend.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPFriendshipFriend.h"

@implementation PPFriendshipFriend

+ (NSString *)primaryKey {
    return @"friendId";
}

- (id)initWithId:(PPUserId)friendId firstName:(NSString *)firstName lastName:(NSString *)lastName email:(PPUserEmail *)email {
    self = [super init];
    if(self) {
        self.friendId = friendId;
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
    }
    return self;
}

+ (PPFriendshipFriend *)initWithDictionary:(NSDictionary *)friendDict {
    PPUserId friendId = PPUserIdNone;
    if([friendDict objectForKey:@"id"]) {
        friendId = (PPUserId)((NSString *)[friendDict objectForKey:@"id"]).integerValue;
    }
    NSString *firstName = [friendDict objectForKey:@"firstName"];
    NSString *lastName = [friendDict objectForKey:@"lastName"];
    
    PPUserEmail *email;
    if([[friendDict objectForKey:@"email"] isKindOfClass:[NSString class]]) {
        email = [PPUserEmail initWithDictionary:@{@"email":[friendDict objectForKey:@"email"]}];
    }
    else {
        email = [PPUserEmail initWithDictionary:[friendDict objectForKey:@"email"]];
    }
    
    PPFriendshipFriend *friend = [[PPFriendshipFriend alloc] initWithId:friendId firstName:firstName lastName:lastName email:email];
    return friend;
}

+ (NSString *)stringify:(PPFriendshipFriend *)friend {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(friend.friendId != PPUserIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":%li", (long)friend.friendId];
        appendComma = YES;
    }
    
    if(friend.firstName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"firstName\":%@", friend.firstName];
        appendComma = YES;
    }
    
    if(friend.lastName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"lastName\":%@", friend.lastName];
        appendComma = YES;
    }
    
    if(friend.email) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"email\":%@", [PPUserEmail stringify:friend.email]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
