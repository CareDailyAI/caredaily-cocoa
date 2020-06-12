//
//  PPCommunityUser.h
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunityUser : RLMObject

@property (nonatomic) PPUserId userId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic) PPUserAvatarFileId avatarFileId;

- (id)initWithUserId:(PPUserId)userId
           firstName:(NSString *)firstName
            lastName:(NSString *)lastName
       communityName:(NSString *)communityName
        avatarFileId:(PPUserAvatarFileId)avatarFileId;

+ (PPCommunityUser *)initWithDictionary:(NSDictionary *)userDict;

@end

RLM_ARRAY_TYPE(PPCommunityUser);

NS_ASSUME_NONNULL_END
