//
//  PPBotengineAppRating.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//


#import "PPBaseModel.h"

@interface PPBotengineAppRating : RLMObject

@property (nonatomic) NSInteger total;
@property (nonatomic) float average;
@property (nonatomic) NSInteger star1;
@property (nonatomic) NSInteger star2;
@property (nonatomic) NSInteger star3;
@property (nonatomic) NSInteger star4;
@property (nonatomic) NSInteger star5;

+ (PPBotengineAppRating *)ratingFromDict:(NSDictionary *)ratingDict;

+ (PPBotengineAppRating *)ratingWithTotal:(NSInteger)total average:(float)average star1:(NSInteger)star1 star2:(NSInteger)star2 star3:(NSInteger)star3 star4:(NSInteger)star4 star5:(NSInteger)star5;

- (id)initWithTotal:(NSInteger)total average:(float)average star1:(NSInteger)star1 star2:(NSInteger)star2 star3:(NSInteger)star3 star4:(NSInteger)star4 star5:(NSInteger)star5;

@end

RLM_ARRAY_TYPE(PPBotengineAppRating);
