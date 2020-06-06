//
//  PPCommunityComment.h
//  PPiOSCore
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPCommunityCommentId) {
    PPCommunityCommentIdNone = -1
};

@interface PPCommunityComment : RLMObject

@property (nonatomic) PPCommunityCommentId commentId;
@property (nonatomic) PPCommunityCommentId replyCommentId;
@property (nonatomic, strong) NSString *commentText;
@property (nonatomic, strong) PPCommunityUser *user;
@property (nonatomic, strong) NSDate *commentDate;
@property (nonatomic, strong) RLMArray<PPCommunityReaction *><PPCommunityReaction> *reactions;

- (id)initWithId:(PPCommunityCommentId)commentId
  replyCommentId:(PPCommunityCommentId)replyCommentId
     commentText:(NSString *)commentText
            user:(PPCommunityUser *)user
     commentDate:(NSDate *)commentDate
       reactions:(RLMArray *)reactions;

+ (PPCommunityComment *)initWithDictionary:(NSDictionary *)commentDict;

@end

RLM_ARRAY_TYPE(PPCommunityComment);

NS_ASSUME_NONNULL_END
