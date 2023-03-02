//
//  PPSurveyQuestion.m
//  Peoplepower
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPSurveyQuestion.h"

@implementation PPSurveyQuestion

+ (NSString *)primaryKey {
    return @"questionId";
}

- (id)initWithQuestionId:(PPSurveyQuestionId)questionId
                     key:(NSString *)key
                   title:(NSString *)title
                question:(NSString *)question
                  answer:(NSString *)answer
               sliderMin:(NSNumber *)sliderMin
               sliderMax:(NSNumber *)sliderMax
             sliderValue:(NSNumber *)sliderValue {
    self = [super init];
    if (self) {
        self.questionId = questionId;
        self.key = key;
        self.title = title;
        self.question = question;
        self.answer = answer;
        self.sliderMin = sliderMin;
        self.sliderMax = sliderMax;
        self.sliderValue = sliderValue;
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
    NSString *answer = [questionDict objectForKey:@"answer"];
    NSNumber *sliderMin = @0;
    if([questionDict objectForKey:@"sliderMin"]) {
        sliderMin = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderMin"]).floatValue];
    }
    NSNumber *sliderMax = @10;
    if([questionDict objectForKey:@"sliderMax"]) {
        sliderMax = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderMax"]).floatValue];
    }
    NSNumber *sliderValue;
    if([questionDict objectForKey:@"sliderValue"]) {
        sliderValue = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderValue"]).floatValue];
    }
    
    PPSurveyQuestion *surveyQuestion = [[PPSurveyQuestion alloc] initWithQuestionId:questionId key:key title:title question:question answer:answer sliderMin:sliderMin sliderMax:sliderMax sliderValue:sliderValue];
    return surveyQuestion;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPSurveyQuestion *surveyQuestion = [[PPSurveyQuestion allocWithZone:zone] init];
    surveyQuestion.questionId = self.questionId;
    surveyQuestion.key = [self.key copyWithZone:zone];
    surveyQuestion.title = [self.title copyWithZone:zone];
    surveyQuestion.question = [self.question copyWithZone:zone];
    surveyQuestion.answer = [self.answer copyWithZone:zone];
    surveyQuestion.sliderMin = [self.sliderMin copyWithZone:zone];
    surveyQuestion.sliderMax = [self.sliderMax copyWithZone:zone];
    surveyQuestion.sliderValue = [self.sliderValue copyWithZone:zone];
    return surveyQuestion;
}

@end
