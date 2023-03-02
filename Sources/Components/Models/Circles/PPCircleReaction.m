//
//  PPCircleReaction.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCircleReaction.h"

@implementation PPCircleReaction

- (id)initWithId:(PPUserId)userId type:(PPCircleReactionType)type {
    self = [super init];
    if(self) {
        self.userId = userId;
        self.type = type;
    }
    return self;
}

+ (PPCircleReaction *)initWithDictionary:(NSDictionary *)reactionDict {
    PPUserId userId = PPUserIdNone;
    if([reactionDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[reactionDict objectForKey:@"userId"]).integerValue;
    }
    PPCircleReactionType type = PPCircleReactionTypeNone;
    if([reactionDict objectForKey:@"type"]) {
        type = (PPCircleReactionType)((NSString *)[reactionDict objectForKey:@"type"]).integerValue;
    }
    
    PPCircleReaction *reaction = [[PPCircleReaction alloc] initWithId:userId type:type];
    return reaction;
}

@end
