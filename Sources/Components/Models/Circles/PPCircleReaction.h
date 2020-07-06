//
//  PPCircleReaction.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A circle user can react to any post or reply with Like, Love, Haha, Wow, Sad, and Angry.
//

#import "PPBaseModel.h"
#import "PPUser.h"

typedef NS_OPTIONS(NSInteger, PPCircleReactionType) {
    PPCircleReactionTypeNone = -1,
    PPCircleReactionTypeRemovePreviousReaction = 0,
    PPCircleReactionTypeLike = 1,
    PPCircleReactionTypeLove = 2,
    PPCircleReactionTypeHaHa = 3,
    PPCircleReactionTypeWow = 4,
    PPCircleReactionTypeSad = 5,
    PPCircleReactionTypeAngry = 6
};

@interface PPCircleReaction : NSObject

@property (nonatomic) PPUserId userId;
@property (nonatomic) PPCircleReactionType type;

- (id)initWithId:(PPUserId)userId type:(PPCircleReactionType)type;

+ (PPCircleReaction *)initWithDictionary:(NSDictionary *)reactionDict;

@end
