//
//  PPCommunityComment.m
//  Peoplepower
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCommunityComment.h"

@implementation PPCommunityComment
- (id)initWithId:(PPCommunityCommentId)commentId
  replyCommentId:(PPCommunityCommentId)replyCommentId
     commentText:(NSString *)commentText
            user:(PPCommunityUser *)user
    commentDate:(nonnull NSDate *)commentDate
       reactions:(NSArray *)reactions {
    self = [super init];
    if (self) {
        self.commentId = commentId;
        self.replyCommentId = replyCommentId;
        self.commentText = commentText;
        self.user = user;
        self.commentDate = commentDate;
        self.reactions = reactions;
    }
    return self;
}

+ (PPCommunityComment *)initWithDictionary:(NSDictionary *)commentDict {
    
    PPCommunityCommentId commentId = PPCommunityCommentIdNone;
    if ([commentDict objectForKey:@"commentId"]) {
        commentId = ((NSNumber *)[commentDict objectForKey:@"commentId"]).integerValue;
    }
    PPCommunityCommentId replyCommentId = PPCommunityCommentIdNone;
    if ([commentDict objectForKey:@"replyCommentId"]) {
        replyCommentId = ((NSNumber *)[commentDict objectForKey:@"replyCommentId"]).integerValue;
    }
    NSString *commentText = [commentDict objectForKey:@"commentText"];
    
    PPCommunityUser *user;
    if ([commentDict objectForKey:@"user"]) {
        user = [PPCommunityUser initWithDictionary:[commentDict objectForKey:@"user"]];
    }
    
    NSString *commentDateString = [commentDict objectForKey:@"commentDate"];
    NSDate *commentDate;
    
    if(commentDateString != nil) {
        if(![commentDateString isEqualToString:@""]) {
            commentDate = [PPNSDate parseDateTime:commentDateString];
        }
    }
    
    NSMutableArray * reactions;
    if ([commentDict objectForKey:@"reactions"]) {
        reactions = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *reactionDict in [commentDict objectForKey:@"reactions"]) {
            PPCommunityReaction *reaction = [PPCommunityReaction initWithDictionary:reactionDict];
            [reactions addObject:reaction];
        }
    }
    
    PPCommunityComment *comment = [[PPCommunityComment alloc] initWithId:commentId replyCommentId:replyCommentId commentText:commentText user:user commentDate:commentDate reactions:reactions];
    return comment;
}

@end
