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

@interface PPCircleReaction : PPBaseModel

@property (nonatomic) PPUserId userId;
@property (nonatomic) PPCircleReactionType type;

- (id)initWithId:(PPUserId)userId type:(PPCircleReactionType)type;

+ (PPCircleReaction *)initWithDictionary:(NSDictionary *)reactionDict;

@end
