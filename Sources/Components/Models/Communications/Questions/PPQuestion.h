//
//  PPQuestion.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPQuestionSlider.h"
#import "PPQuestionCollection.h"
#import "PPQuestionResponseOption.h"
#import "PPQuestionAnswer.h"

@interface PPQuestion : PPBaseModel

/* Question ID assigned by the system */
@property (nonatomic) PPQuestionId questionId;

/* Optional unique key to identify this context of this question later */
@property (nonatomic, strong) NSString * _Nullable key;

/* Creation timestamp */
@property (nonatomic, strong) NSDate * _Nonnull creationDate;

/* Group like questions together on a list by this category. */
@property (nonatomic, strong) PPQuestionCollection * _Nullable collection;

/* The actual text of the question to ask. */
@property (nonatomic, strong) NSString * _Nonnull question;

/* A placeholder for this question. */
@property (nonatomic, strong) NSString * _Nullable placeholder;

/* If true, the results of this question will be made publicly available at an aggregate level, so individual users can see how others voted on the question. */
@property (nonatomic) PPQuestionAggregatePublicly aggregatePublicly;

/* "false" - not urgent, queue it up to notify the user later based on the notification settings (in-app question, push, sms, email, etc.); "true" - very urgent, ask the user this question right away, after the user answers any other pending urgent questions. */
@property (nonatomic) PPQuestionUrgent urgent;

/* "false" - do not ask the question on the front page of the app; "true" - ask the question on the front page of the app. */
@property (nonatomic) PPQuestionFront front;

/* If the message is editable, then that means it will show up in a place in the app where the user can reconfigure the question later. This is typically used by Composer Apps to enable a UI for settings to configure the app through questions. */
@property (nonatomic) PPQuestionEditable editable;

/* The total number of responses to this question */
@property (nonatomic) PPQuestionTotalResponses totalResponses;

/* The type of question */
@property (nonatomic) PPQuestionResponseOptionType responseType;

/* Response options */
@property (nonatomic, strong) NSArray * _Nullable responseOptions;

/* Application-layer display type for each type of question (for example, yes/no vs. on/off switch, or a slider that shows integers vs. a slider that shows minutes:seconds) */
@property (nonatomic) PPQuestionDisplayType displayType;

/* Name of the device ID referenced by this question, if any. */
@property (nonatomic, strong) NSString * _Nullable deviceId;

/* Icon to show next to the question, if any. */
@property (nonatomic, strong) NSString * _Nullable icon;

/* Pre-populated default values for question responses, or force-change the user's response. */
@property (nonatomic, strong) NSString * _Nullable defaultAnswer;

/* Regular expression to validate answer format in UI. */
@property (nonatomic, strong) NSString * _Nullable answerFormat;

/* Slider question minimum value */
@property (nonatomic, strong) NSNumber * _Nullable sliderMin;

/* Slider question maximum value */
@property (nonatomic, strong) NSNumber * _Nullable sliderMax;

/* Slider question incremental slider value */
@property (nonatomic, strong) NSNumber * _Nullable sliderInc;

/* Slider question object */
@property (nonatomic) PPQuestionSlider * _Nonnull slider;

/* The title of a group of questions */
@property (nonatomic, strong) NSString * _Nullable sectionTitle;

/* The ID of a group of questions, and the order in which to display this group */
@property (nonatomic) PPQuestionSectionId sectionId;

/* The position of a single question within a group. The higher the weight, the lower down on the list the question appears relative to other questions */
@property (nonatomic) PPQuestionWeight questionWeight;

/* Number of points the user will earn, if the answer is valid. */
@property (nonatomic) PPQuestionPoints points;

/* Answer */
@property (nonatomic, strong) PPQuestionAnswer * _Nonnull answer;

- (id)initWithId:(PPQuestionId)questionId
             key:(NSString * _Nullable )key
    creationDate:(NSDate * _Nonnull )creationDate
      collection:(PPQuestionCollection * _Nullable )collection
        question:(NSString * _Nonnull )question
     placeholder:(NSString * _Nullable )placeholder
aggregatePublicly:(PPQuestionAggregatePublicly)aggregatePublicly
          urgent:(PPQuestionUrgent)urgent
           front:(PPQuestionFront)front
        editable:(PPQuestionEditable)editable
  totalResponses:(PPQuestionTotalResponses)totalResponses
    responseType:(PPQuestionResponseOptionType)responseType
 responseOptions:(NSArray * _Nullable )responseOptions
     displayType:(PPQuestionDisplayType)displayType
        deviceId:(NSString * _Nullable )deviceId
            icon:(NSString * _Nullable )icon
   defaultAnswer:(NSString * _Nullable )defaultAnswer
    answerFormat:(NSString * _Nullable )answerFormat
       sliderMin:(NSNumber * _Nullable )sliderMin
       sliderMax:(NSNumber * _Nullable )sliderMax
       sliderInc:(NSNumber * _Nullable )sliderInc
          slider:(PPQuestionSlider * _Nonnull )slider
    sectionTitle:(NSString * _Nullable )sectionTitle
       sectionId:(PPQuestionSectionId)sectionId
  questionWeight:(PPQuestionWeight)questionWeight
          points:(PPQuestionPoints)points
          answer:(PPQuestionAnswer * _Nonnull )answer;

+ (PPQuestion * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )questionDict;

+ (NSString * _Nonnull )stringify:(PPQuestion * _Nonnull )question;
+ (NSDictionary * _Nonnull )data:(PPQuestion * _Nonnull )question;

#pragma mark - Helper methods

- (BOOL)isEqualToQuestion:(PPQuestion * _Nonnull)question;

- (void)sync:(PPQuestion * _Nonnull )question;

@end
