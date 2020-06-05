//
//  PPNotificationToken.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/23/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationToken.h"

@implementation PPNotificationToken

- (id)initWithToken:(NSString *)token badges:(PPNotificationSubscriptionSupportsBadgeIcons)badges {
    self = [super init];
    if(self) {
        self.token = token;
        self.badges = badges;
    }
    return self;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToToken:(PPNotificationToken *)token {
    BOOL isEqual = NO;
    if([_token isEqualToString:token.token]) {
        isEqual = YES;
    }
    
    return isEqual;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.token = [decoder decodeObjectForKey:@"token"];
        self.badges = (PPNotificationSubscriptionSupportsBadgeIcons)((NSNumber *)[decoder decodeObjectForKey:@"badges"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_token forKey:@"token"];
    [encoder encodeObject:@(_badges) forKey:@"badges"];
}


@end
