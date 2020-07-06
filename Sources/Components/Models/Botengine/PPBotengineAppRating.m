//
//  PPBotengineAppRating.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppRating.h"

@implementation PPBotengineAppRating

+ (PPBotengineAppRating *)ratingFromDict:(NSDictionary *)ratingDict {
    PPBotengineAppRating *rating = [[PPBotengineAppRating alloc] init];

    for(NSString *key in ratingDict) {
        if([key isEqualToString:@"total"]) {
            rating.total = ((NSString *)[ratingDict objectForKey:@"total"]).integerValue;
        }
        else if([key isEqualToString:@"average"]) {
            rating.average = ((NSString *)[ratingDict objectForKey:@"average"]).floatValue;
        }
        else if([key isEqualToString:@"star1"]) {
            rating.star1 = ((NSString *)[ratingDict objectForKey:@"star1"]).integerValue;
        }
        else if([key isEqualToString:@"star2"]) {
            rating.star2 = ((NSString *)[ratingDict objectForKey:@"star2"]).integerValue;
        }
        else if([key isEqualToString:@"star3"]) {
            rating.star3 = ((NSString *)[ratingDict objectForKey:@"star3"]).integerValue;
        }
        else if([key isEqualToString:@"star4"]) {
            rating.star4 = ((NSString *)[ratingDict objectForKey:@"star4"]).integerValue;
        }
        else if([key isEqualToString:@"star5"]) {
            rating.star5 = ((NSString *)[ratingDict objectForKey:@"star5"]).integerValue;
        }
    }
    
    return rating;
}

+ (PPBotengineAppRating *)ratingWithTotal:(NSInteger)total average:(float)average star1:(NSInteger)star1 star2:(NSInteger)star2 star3:(NSInteger)star3 star4:(NSInteger)star4 star5:(NSInteger)star5 {
    return [[PPBotengineAppRating alloc] initWithTotal:total average:average star1:star1 star2:star2 star3:star3 star4:star4 star5:star5];
}

- (id)initWithTotal:(NSInteger)total average:(float)average star1:(NSInteger)star1 star2:(NSInteger)star2 star3:(NSInteger)star3 star4:(NSInteger)star4 star5:(NSInteger)star5 {
    self = [super init];
    if(self) {
        self.total = total;
        self.average = average;
        self.star1 = star1;
        self.star2 = star2;
        self.star3 = star3;
        self.star4 = star4;
        self.star5 = star5;
    }
    return self;
}

@end
