//
//  PPCommunityReaction.m
//  Peoplepower
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCommunityReaction.h"

@implementation PPCommunityReaction
- (id)initWithUser:(PPCommunityUser *)user
          reaction:(PPCommunityReactionType)reaction {
    self = [super init];
    if (self) {
        self.user = user;
        self.reaction = reaction;
    }
    return self;
}

+ (PPCommunityReaction *)initWithDictionary:(NSDictionary *)reactionDict {
    PPCommunityUser *user;
    if ([reactionDict objectForKey:@"user"]) {
        user = [PPCommunityUser initWithDictionary:[reactionDict objectForKey:@"user"]];
    }
    
    PPCommunityReactionType reaction = PPCommunityReactionTypeNone;
    if ([reactionDict objectForKey:@"reaction"]) {
        reaction = ((NSNumber *)[reactionDict objectForKey:@"reaction"]).integerValue;
    }
    
    PPCommunityReaction *reaction_ = [[PPCommunityReaction alloc] initWithUser:user
                                                                      reaction:reaction];
    return reaction_;
}

@end
