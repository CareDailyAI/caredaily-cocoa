//
//  PPSurveyQuestion.m
//  PPiOSCore
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPSurveyQuestion.h"

@implementation PPSurveyQuestion

- (id)initWithQuestionId:(PPSurveyQuestionId)questionId
                     key:(NSString *)key
                   title:(NSString *)title
                question:(NSString *)question
               sliderMin:(NSInteger)sliderMin
               sliderMax:(NSInteger)sliderMax {
    self = [super init];
    if (self) {
        self.key = key;
        self.title = title;
        self.question = question;
        self.sliderMin = sliderMin;
        self.sliderMax = sliderMax;
    }
    return self;
}

+ (PPSurveyQuestion *)initWithDictionary:(NSDictionary *)questionDict {
    PPSurveyQuestionId questionId = PPSurveyQuestionIdNone;
    if([questionDict objectForKey:@"id"]) {
        questionId = (PPSurveyQuestionId)((NSString *)[questionDict objectForKey:@"id"]).integerValue;
    }
    NSString *key = [questionDict objectForKey:@"key"];
    NSString *title = [questionDict objectForKey:@"title"];
    NSString *question = [questionDict objectForKey:@"question"];
    NSInteger sliderMin = 0;
    if([questionDict objectForKey:@"sliderMin"]) {
        sliderMin = ((NSString *)[questionDict objectForKey:@"sliderMin"]).integerValue;
    }
    NSInteger sliderMax = 10;
    if([questionDict objectForKey:@"sliderMax"]) {
        sliderMax = ((NSString *)[questionDict objectForKey:@"sliderMax"]).integerValue;
    }
    
    PPSurveyQuestion *surveyQuestion = [[PPSurveyQuestion alloc] initWithQuestionId:questionId key:key title:title question:question sliderMin:sliderMin sliderMax:sliderMax];
    return surveyQuestion;
}

@end
