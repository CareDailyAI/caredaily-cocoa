//
//  PPCommunityReaction.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPCommunityReactionType) {
    PPCommunityReactionTypeNone = -1,
    PPCommunityReactionTypeRemove = 0,
    PPCommunityReactionTypeLike = 1,
    PPCommunityReactionTypeLove = 2,
    PPCommunityReactionTypeHaha = 3,
    PPCommunityReactionTypeWow = 4,
    PPCommunityReactionTypeSad = 5,
    PPCommunityReactionTypeAngry = 6,
    PPCommunityReactionTypeFlagged = 7,
};

@interface PPCommunityReaction : NSObject

@property (nonatomic, strong) PPCommunityUser *user;
@property (nonatomic) PPCommunityReactionType reaction;

- (id)initWithUser:(PPCommunityUser *)user
          reaction:(PPCommunityReactionType)reaction;

+ (PPCommunityReaction *)initWithDictionary:(NSDictionary *)reactionDict;

@end

NS_ASSUME_NONNULL_END
