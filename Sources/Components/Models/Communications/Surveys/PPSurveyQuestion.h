//
//  PPSurveyQuestion.h
//  Peoplepower
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPSurveyQuestion: PPBaseModel <NSCopying>

@property (nonatomic) PPSurveyQuestionId questionId;
@property (nonatomic, strong) NSString * _Nullable key;
@property (nonatomic, strong) NSString * _Nonnull title;
@property (nonatomic, strong) NSString * _Nonnull question;
@property (nonatomic, strong) NSString * _Nullable answer;
@property (nonatomic) NSNumber * _Nonnull sliderMin;
@property (nonatomic) NSNumber * _Nonnull sliderMax;
@property (nonatomic) NSNumber * _Nullable sliderValue;

- (id)initWithQuestionId:(PPSurveyQuestionId)questionId
                     key:(NSString * _Nullable )key
                   title:(NSString * _Nonnull )title
                question:(NSString * _Nonnull )question
                  answer:(NSString * _Nullable )answer
               sliderMin:(NSNumber * _Nonnull )sliderMin
               sliderMax:(NSNumber * _Nonnull )sliderMax
             sliderValue:(NSNumber * _Nullable )sliderValue;

+ (PPSurveyQuestion *)initWithDictionary:(NSDictionary *)questionDict;

@end

NS_ASSUME_NONNULL_END
