//
//  PPSurveys.h
//  PPiOSCore
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The survey API allows to collect end user opinions.

#import "PPBaseModel.h"
#import "PPSurveyQuestion.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^PPSurveyQuestionsBlock)(NSArray * _Nullable questions, NSError * _Nullable error);

@interface PPSurveys : PPBaseModel

// MARK: - Survey Questions

/**
 * Get Survey Questions
 *
 * @param brand NSString App brand
 * @param callback required PPSurveyQuestionsBlock Surveys callback block
 */
+ (void)getSurveyQuestions:(NSString * _Nullable )brand callback:(PPSurveyQuestionsBlock _Nonnull )callback;

/**
 * Answer Question
 *
 * @param questionId required PPSurveyQuestionId Survey question id
 * @param slider required NSInteger Slider value
 * @param answerText NSString Answer text
 * @param callback required PPErrorBlock Error callback block
 */
+ (void)answerQuestion:(PPSurveyQuestionId)questionId slider:(NSInteger)slider answerText:(NSString * _Nullable )answerText callback:(PPErrorBlock _Nonnull )callback;

@end

NS_ASSUME_NONNULL_END
