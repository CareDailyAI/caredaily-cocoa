//
//  PPCommunityComment.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/20/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPCommunityCommentId) {
    PPCommunityCommentIdNone = -1
};

@interface PPCommunityComment : NSObject

@property (nonatomic) PPCommunityCommentId commentId;
@property (nonatomic) PPCommunityCommentId replyCommentId;
@property (nonatomic, strong) NSString *commentText;
@property (nonatomic, strong) PPCommunityUser *user;
@property (nonatomic, strong) NSDate *commentDate;
@property (nonatomic, strong) NSArray *reactions;

- (id)initWithId:(PPCommunityCommentId)commentId
  replyCommentId:(PPCommunityCommentId)replyCommentId
     commentText:(NSString *)commentText
            user:(PPCommunityUser *)user
     commentDate:(NSDate *)commentDate
       reactions:(NSArray *)reactions;

+ (PPCommunityComment *)initWithDictionary:(NSDictionary *)commentDict;

@end

NS_ASSUME_NONNULL_END
