//
//  PPSurveyQuestion.h
//  PPiOSCore
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPSurveyQuestionId) {
    PPSurveyQuestionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPSurveyQuestionSliderValue) {
    PPSurveyQuestionSliderValueNone = -1
};

@interface PPSurveyQuestion: NSObject

@property (nonatomic) PPSurveyQuestionId questionId;
@property (nonatomic, strong) NSString * _Nullable key;
@property (nonatomic, strong) NSString * _Nonnull title;
@property (nonatomic, strong) NSString * _Nonnull question;
@property (nonatomic, strong) NSString * _Nullable answer;
@property (nonatomic) NSInteger sliderMin;
@property (nonatomic) NSInteger sliderMax;
@property (nonatomic) PPSurveyQuestionSliderValue sliderValue;

- (id)initWithQuestionId:(PPSurveyQuestionId)questionId
                     key:(NSString * _Nullable )key
                   title:(NSString * _Nonnull )title
                question:(NSString * _Nonnull )question
                  answer:(NSString * _Nullable )answer
               sliderMin:(NSInteger)sliderMin
               sliderMax:(NSInteger)sliderMax
             sliderValue:(PPSurveyQuestionSliderValue)sliderValue;

+ (PPSurveyQuestion *)initWithDictionary:(NSDictionary *)questionDict;

@end

NS_ASSUME_NONNULL_END
