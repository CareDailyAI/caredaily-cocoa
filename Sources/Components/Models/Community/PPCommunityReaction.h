//
//  PPCommunityReaction.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunityReaction : PPBaseModel

@property (nonatomic, strong) PPCommunityUser *user;
@property (nonatomic) PPCommunityReactionType reaction;

- (id)initWithUser:(PPCommunityUser *)user
          reaction:(PPCommunityReactionType)reaction;

+ (PPCommunityReaction *)initWithDictionary:(NSDictionary *)reactionDict;

@end

NS_ASSUME_NONNULL_END
