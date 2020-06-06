//
//  PPQuestion.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPQuestionCollection.h"
#import "PPQuestionResponseOption.h"
#import "PPQuestionAnswer.h"

typedef NS_OPTIONS(NSInteger, PPQuestionId) {
    PPQuestionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAggregatePublicly) {
    PPQuestionAggregatePubliclyNone = -1,
    PPQuestionAggregatePubliclyFalse = 0,
    PPQuestionAggregatePubliclyTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionUrgent) {
    PPQuestionUrgentNone = -1,
    PPQuestionUrgentFalse = 0,
    PPQuestionUrgentTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionFront) {
    PPQuestionFrontNone = -1,
    PPQuestionFrontFalse = 0,
    PPQuestionFrontTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionEditable) {
    PPQuestionEditableNone = -1,
    PPQuestionEditableFalse = 0,
    PPQuestionEditableTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionTotalResponses) {
    PPQuestionTotalResponsesNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderMin) {
    PPQuestionSliderMinNone = -1,
    PPQuestionSliderMinDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderMax) {
    PPQuestionSliderMaxNone = -1,
    PPQuestionSliderMaxDefault = 100
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderInc) {
    PPQuestionSliderIncNone = -1,
    PPQuestionSliderIncDefault = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionSectionId) {
    PPQuestionSectionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionWeight) {
    PPQuestionWeightNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionPoints) {
    PPQuestionPointsNone = -1
};

@interface PPQuestion : RLMObject

/* Question ID assigned by the system */
@property (nonatomic) PPQuestionId questionId;

/* Optional unique key to identify this context of this question later */
@property (nonatomic, strong) NSString *key;

/* Creation timestamp */
@property (nonatomic, strong) NSDate *creationDate;

/* Group like questions together on a list by this category. */
@property (nonatomic, strong) PPQuestionCollection *collection;

/* The actual text of the question to ask. */
@property (nonatomic, strong) NSString *question;

/* A placeholder for this question. */
@property (nonatomic, strong) NSString *placeholder;

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
@property (nonatomic, strong) RLMArray<PPQuestionResponseOption *><PPQuestionResponseOption> *responseOptions;

/* Application-layer display type for each type of question (for example, yes/no vs. on/off switch, or a slider that shows integers vs. a slider that shows minutes:seconds) */
@property (nonatomic) PPQuestionDisplayType displayType;

/* Name of the device ID referenced by this question, if any. */
@property (nonatomic, strong) NSString *deviceId;

/* Icon to show next to the question, if any. */
@property (nonatomic, strong) NSString *icon;

/* Pre-populated default values for question responses, or force-change the user's response. */
@property (nonatomic, strong) NSString *defaultAnswer;

/* Regular expression to validate answer format in UI. */
@property (nonatomic, strong) NSString *answerFormat;

/* Slider question minimum value */
@property (nonatomic) PPQuestionSliderMin sliderMin;

/* Slider question maximum value */
@property (nonatomic) PPQuestionSliderMax sliderMax;

/* Slider question incremental slider value */
@property (nonatomic) PPQuestionSliderInc sliderInc;

/* The title of a group of questions */
@property (nonatomic, strong) NSString *sectionTitle;

/* The ID of a group of questions, and the order in which to display this group */
@property (nonatomic) PPQuestionSectionId sectionId;

/* The position of a single question within a group. The higher the weight, the lower down on the list the question appears relative to other questions */
@property (nonatomic) PPQuestionWeight questionWeight;

/* Number of points the user will earn, if the answer is valid. */
@property (nonatomic) PPQuestionPoints points;

/* Answer */
@property (nonatomic, strong) PPQuestionAnswer *answer;

- (id)initWithId:(PPQuestionId)questionId
             key:(NSString *)key
    creationDate:(NSDate *)creationDate
      collection:(PPQuestionCollection *)collection
        question:(NSString *)question
     placeholder:(NSString *)placeholder
aggregatePublicly:(PPQuestionAggregatePublicly)aggregatePublicly
          urgent:(PPQuestionUrgent)urgent
           front:(PPQuestionFront)front
        editable:(PPQuestionEditable)editable
  totalResponses:(PPQuestionTotalResponses)totalResponses
    responseType:(PPQuestionResponseOptionType)responseType
 responseOptions:(RLMArray *)responseOptions
     displayType:(PPQuestionDisplayType)displayType
        deviceId:(NSString *)deviceId
            icon:(NSString *)icon
   defaultAnswer:(NSString *)defaultAnswer
    answerFormat:(NSString *)answerFormat
       sliderMin:(PPQuestionSliderMin)sliderMin
       sliderMax:(PPQuestionSliderMax)sliderMax
       sliderInc:(PPQuestionSliderInc)sliderInc
    sectionTitle:(NSString *)sectionTitle
       sectionId:(PPQuestionSectionId)sectionId
  questionWeight:(PPQuestionWeight)questionWeight
          points:(PPQuestionPoints)points
          answer:(PPQuestionAnswer *)answer;

+ (PPQuestion *)initWithDictionary:(NSDictionary *)questionDict;

+ (NSString *)stringify:(PPQuestion *)question;
+ (NSDictionary *)data:(PPQuestion *)question;

#pragma mark - Helper methods

- (BOOL)isEqualToQuestion:(PPQuestion *)question;

- (void)sync:(PPQuestion *)question;

@end

RLM_ARRAY_TYPE(PPQuestion);
