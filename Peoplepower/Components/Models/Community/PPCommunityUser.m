//
//  PPCommunityUser.m
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPCommunityUser.h"

@implementation PPCommunityUser

- (id)initWithUserId:(PPUserId)userId
           firstName:(NSString *)firstName
            lastName:(NSString *)lastName
       communityName:(NSString *)communityName
        avatarFileId:(PPUserAvatarFileId)avatarFileId {
    self = [super init];
    if (self) {
        self.userId = userId;
        self.firstName = firstName;
        self.lastName = lastName;
        self.communityName = communityName;
        self.avatarFileId = avatarFileId;
    }
    return self;
}

+ (PPCommunityUser *)initWithDictionary:(NSDictionary *)userDict {
    PPUserId userId = PPUserIdNone;
    if([userDict objectForKey:@"id"]) {
        userId = (PPUserId)((NSString *)[userDict objectForKey:@"id"]).integerValue;
    }
    NSString *firstName = [userDict objectForKey:@"firstName"];
    NSString *lastName = [userDict objectForKey:@"lastName"];
    NSString *communityName = [userDict objectForKey:@"communityName"];
    
    PPUserAvatarFileId avatarFileId = PPUserAvatarFileIdNone;
    if([userDict objectForKey:@"avatarFileId"]) {
        avatarFileId = (PPUserAvatarFileId)((NSString *)[userDict objectForKey:@"avatarFileId"]).integerValue;
    }
    
    PPCommunityUser *user = [[PPCommunityUser alloc] initWithUserId:userId firstName:firstName lastName:lastName communityName:communityName avatarFileId:avatarFileId];
    return user;
}

@end
