//
//  PPBotengineAppReview.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppReview.h"

@implementation PPBotengineAppReview

+ (PPBotengineAppReview *)appReviewFromDict:(NSDictionary *)dict {
    
    NSInteger reviewId = ((NSString *)[dict objectForKey:@"reviewId"]).integerValue;
    NSInteger userId = ((NSString *)[dict objectForKey:@"userId"]).integerValue;
    NSString *version = [dict objectForKey:@"version"];
    
    NSString *creationDateString = [dict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil && ![creationDateString isEqualToString:@""]) {
        creationDate = [PPNSDate parseDateTime:creationDateString];
    }
    
    NSInteger rating = ((NSString *)[dict objectForKey:@"rating"]).integerValue;
    NSInteger votesUp = ((NSString *)[dict objectForKey:@"votesUp"]).integerValue;
    NSInteger votesDown = ((NSString *)[dict objectForKey:@"votesDown"]).integerValue;
    NSInteger ownVote = ((NSString *)[dict objectForKey:@"ownVote"]).integerValue;
    NSString *lang = [dict objectForKey:@"lang"];
    NSString *nickname = [dict objectForKey:@"nickname"];
    NSString *desc = [dict objectForKey:@"desc"];

    return [[PPBotengineAppReview alloc] initWithReviewId:reviewId userId:userId version:version creationDate:creationDate rating:rating votesUp:votesUp votesDown:votesDown ownVote:ownVote lang:lang nickname:nickname desc:desc];
}

- (id)initWithReviewId:(NSInteger)reviewId userId:(NSInteger)userId version:(NSString *)version creationDate:(NSDate *)creationDate rating:(NSInteger)rating votesUp:(NSInteger)votesUp votesDown:(NSInteger)votesDown ownVote:(BOOL)ownVote lang:(NSString *)lang nickname:(NSString *)nickname desc:(NSString *)desc {
    self = [super init];
    if(self) {
        self.reviewId = reviewId;
        self.userId = userId;
        self.version= version;
        self.creationDate = creationDate;
        self.rating = rating;
        self.votesUp = votesUp;
        self.votesDown = votesDown;
        self.ownVote = ownVote;
        self.lang = lang;
        self.nickname = nickname;
    }
    
    return self;
}

@end
