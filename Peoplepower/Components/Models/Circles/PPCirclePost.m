//
//  PPCirclePost.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCirclePost.h"

@implementation PPCirclePost

+ (NSString *)primaryKey {
    return @"postId";
}

- (id)initWithId:(PPCirclePostId)postId originalPostId:(PPCirclePostId)originalPostId circleId:(PPCircleId)circleId text:(NSString *)text authorId:(PPUserId)authorId creationDate:(NSDate *)creationDate updateDate:(NSDate *)updateDate deleted:(PPCirclePostDeleted)deleted file:(PPCircleFile *)file displayAt:(PPCirclePostDisplayTime)displayAt displayDuration:(PPCirclePostDisplayTime)displayDuration reactions:(RLMArray *)reactions {
    self = [super init];
    if(self) {
        self.postId = postId;
        self.originalPostId = originalPostId;
        self.circleId = circleId;
        self.text = text;
        self.authorId = authorId;
        self.creationDate = creationDate;
        self.updateDate = updateDate;
        self.deleted = deleted;
        self.file = file;
        self.displayAt = displayAt;
        self.displayDuration = displayDuration;
        self.reactions = (RLMArray<PPCircleReaction *><PPCircleReaction> *)reactions;
    }
    return self;
}

+ (PPCirclePost *)initWithDictionary:(NSDictionary *)postDict {
    
    PPCirclePostId postId = PPCirclePostIdNone;
    if([postDict objectForKey:@"postId"]) {
        postId = (PPCirclePostId)((NSString *)[postDict objectForKey:@"postId"]).integerValue;
    }
    PPCirclePostId originalPostId = PPCirclePostIdNone;
    if([postDict objectForKey:@"originalPostId"]) {
        originalPostId = (PPCirclePostId)((NSString *)[postDict objectForKey:@"originalPostId"]).integerValue;
    }
    PPCircleId circleId = PPCircleIdNone;
    if([postDict objectForKey:@"circleId"]) {
        circleId = (PPCircleId)((NSString *)[postDict objectForKey:@"circleId"]).integerValue;
    }
    NSString *text = [postDict objectForKey:@"text"];
    PPUserId authorId = PPUserIdNone;
    if([postDict objectForKey:@"authorId"]) {
        authorId = (PPUserId)((NSString *)[postDict objectForKey:@"authorId"]).integerValue;
    }
    
    NSString *creationDateString = [postDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    NSString *updateDateString = [postDict objectForKey:@"updateDate"];
    NSDate *updateDate = [NSDate date];
    if(updateDateString != nil) {
        if(![updateDateString isEqualToString:@""]) {
            updateDate = [PPNSDate parseDateTime:updateDateString];
        }
    }
    
    PPCirclePostDeleted deleted = PPCirclePostDeletedNone;
    if([postDict objectForKey:@"deleted"]) {
        deleted = (PPCirclePostDeleted)((NSString *)[postDict objectForKey:@"deleted"]).integerValue;
    }
    PPCircleFile *file;
    if([postDict objectForKey:@"file"]) {
        file = [PPCircleFile initWithDictionary:[postDict objectForKey:@"file"]];
    }
    PPCirclePostDisplayTime displayAt = PPCirclePostDisplayTimeNone;
    if([postDict objectForKey:@"displayAt"]) {
        displayAt = (PPCirclePostDisplayTime)((NSString *)[postDict objectForKey:@"displayAt"]).integerValue;
    }
    PPCirclePostDisplayTime displayDuration = PPCirclePostDisplayTimeNone;
    if([postDict objectForKey:@"displayDuration"]) {
        displayDuration = (PPCirclePostDisplayTime)((NSString *)[postDict objectForKey:@"displayDuration"]).integerValue;
    }
    
    NSMutableArray *reactions;
    if([postDict objectForKey:@"reactions"]) {
        reactions = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *reactionDict in [postDict objectForKey:@"reactions"]) {
            PPCircleReaction *reaction = [PPCircleReaction initWithDictionary:reactionDict];
            [reactions addObject:reaction];
        }
    }
    
    PPCirclePost *post = [[PPCirclePost alloc] initWithId:postId originalPostId:originalPostId circleId:circleId text:text authorId:authorId creationDate:creationDate updateDate:updateDate deleted:deleted file:file displayAt:displayAt displayDuration:displayDuration reactions:(RLMArray<PPCircleReaction *><PPCircleReaction> *)reactions];
    return post;
}

+ (NSString *)stringify:(PPCirclePost *)post {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(post.text) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"text\":\"%@\"", post.text];
        appendComma = YES;
    }
    
    if(post.file.fileId != PPFileIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"fileId\":%li", (long)post.file.fileId];
        appendComma = YES;
    }
    
    if(post.displayAt != PPCirclePostDisplayTimeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"displayAt\":%li", (long)post.displayAt];
        appendComma = YES;
    }
    
    if(post.displayDuration != PPCirclePostDisplayTimeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"displayDuration\":%li", (long)post.displayDuration];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

- (PPCircle *)circle {
    return [PPCircle objectForPrimaryKey:@(_circleId)];
}

@end
