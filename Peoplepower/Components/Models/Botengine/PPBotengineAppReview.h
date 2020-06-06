//
//  PPBotengineAppReview.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPBotengineAppReviewVote) {
    PPBotengineAppReviewVoteDown = -1,
    PPBotengineAppReviewVoteDelete = 0,
    PPBotengineAppReviewVoteUp = 1
};

@interface PPBotengineAppReview : RLMObject

@property (nonatomic) NSInteger reviewId;
@property (nonatomic) NSInteger userId;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger votesUp;
@property (nonatomic) NSInteger votesDown;
@property (nonatomic) BOOL ownVote;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *desc;

+ (PPBotengineAppReview *)appReviewFromDict:(NSDictionary *)dict;

- (id)initWithReviewId:(NSInteger)reviewId userId:(NSInteger)userId version:(NSString *)version creationDate:(NSDate *)creationDate rating:(NSInteger)rating votesUp:(NSInteger)votesUp votesDown:(NSInteger)votesDown ownVote:(BOOL)ownVote lang:(NSString *)lang nickname:(NSString *)nickname desc:(NSString *)desc;

@end

RLM_ARRAY_TYPE(PPBotengineAppReview);
