//
//  PPCirclePost.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A circle member can post text content to the circle with linked multiple circle files.
// All circle members can see all circle posts and reply to them. A user cannot reply to a reply.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPCircleFile.h"
#import "PPCircleReaction.h"

typedef NS_OPTIONS(NSInteger, PPCirclePostId) {
    PPCirclePostIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCirclePostDeleted) {
    PPCirclePostDeletedNone = -1,
    PPCirclePostDeletedFalse = 0,
    PPCirclePostDeletedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCirclePostDisplayTime) {
    PPCirclePostDisplayTimeNone = 0
};

@interface PPCirclePost : RLMObject

@property (nonatomic) PPCircleId circleId;
@property (nonatomic) PPCirclePostId postId;
@property (nonatomic) PPCirclePostId originalPostId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) PPUserId authorId;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *updateDate;
@property (nonatomic) PPCirclePostDeleted deleted;
@property (nonatomic, strong) PPCircleFile *file;
@property (nonatomic) PPCirclePostDisplayTime displayAt;
@property (nonatomic) PPCirclePostDisplayTime displayDuration;
@property (nonatomic, strong) RLMArray<PPCircleReaction *><PPCircleReaction> *reactions;
@property (nonatomic) PPCircle *circle;

- (id)initWithId:(PPCirclePostId)postId originalPostId:(PPCirclePostId)originalPostId circleId:(PPCircleId)circleId text:(NSString *)text authorId:(PPUserId)authorId creationDate:(NSDate *)creationDate updateDate:(NSDate *)updateDate deleted:(PPCirclePostDeleted)deleted file:(PPCircleFile *)file displayAt:(PPCirclePostDisplayTime)displayAt displayDuration:(PPCirclePostDisplayTime)displayDuration reactions:(RLMArray *)reactions;

+ (PPCirclePost *)initWithDictionary:(NSDictionary *)postDict;

+ (NSString *)stringify:(PPCirclePost *)post;

@end

RLM_ARRAY_TYPE(PPCirclePost);
