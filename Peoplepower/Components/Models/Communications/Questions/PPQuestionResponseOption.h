//
//  PPQuestionResponseOption.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPResponseOptionId) {
    PPResponseOptionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPResponseOptionTotal) {
    PPResponseOptionTotalNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionResponseOptionType) {
    PPQuestionResponseOptionTypeNone = -1, // Not set
    PPQuestionResponseOptionTypeBoolean = 1, // The answer is a 0 or 1.
    PPQuestionResponseOptionTypeMulitpleChoiceSingleSelect = 2, // Requires the "responses" array to list the possible responses. Users can only select one response. Available for anonymous aggregated public reporting. The answer is the ID of the response option.
    PPQuestionResponseOptionTypeMulitpleChoiceMultipleSelect = 4, // A list of checkbox options. Requires the "response" array to list the possible response. Users can select multiple responses. Available for anonymous aggregated public reporting. The answer is a bitmask of selected choices.
    PPQuestionResponseOptionTypeDayOfTheWeek = 6, // Day of the week input. The UI can optimize itself for selecting days of the week [Sun][XXX][Tue][Wed][Thu][XXX][Sat]. The answer is a bitmasked value, days can be logically-OR'd together to specify multiple days of the week, ranging from SUN=0x1 to SAT=0x40.
    PPQuestionResponseOptionTypeSlider = 7, // Answer is the number selected. Slider, with a defined minimum and maximum. By default, minimum = 0 and maximum = 100. For time, the answer is in integer seconds.
    PPQuestionResponseOptionTypeTimeInSecondsSinceMidnight = 8, // This accesses the native UI method of declaring a time. The answer is in integer seconds since midnight.
    PPQuestionResponseOptionTypeDateAndTime = 9, // The answer is in xsd:dateTime format, `YYYY-MM-DDThh:mm:ss[Z|(+|-)hh:mm]`
    PPQuestionResponseOptionTypeTextBox = 10 // Open-ended question. For example, if you were to ask, "Who just walked by the camera?". The answer is a string of text.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayType) {
    PPQuestionDisplayTypeNone = -1,
    PPQuestionDisplayTypeDefault = 0 // Display type dependent upon response type.  This is used for placeholder purposes only
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeBoolean) {
    PPQuestionDisplayTypeBooleanNone = -1,
    PPQuestionDisplayTypeBooleanOnOff = 0, // On/Off Switch, default
    PPQuestionDisplayTypeBooleanYesNo = 1, // Yes/No Switch
    PPQuestionDisplayTypeBooleanYes = 2, // Single 'Yes' button only, the question's default value is applied to the button's text. Used to trigger bot actions from the UI
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeMultipleChoiceSingleSelect) {
    PPQuestionDisplayTypeMultipleChoiceSingleSelectNone = -1,
    PPQuestionDisplayTypeMultipleChoiceSingleSelectRadio = 0, // Radio buttons, default. A list of radio buttons.
    PPQuestionDisplayTypeMultipleChoiceSingleSelectDropDown = 1 // Drop-down list / picker. A drop down list. Same as radio buttons, but can contain more items.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeMultipleChoiceMultiSelect) {
    PPQuestionDisplayTypeMultipleChoiceMultiSelectNone = -1,
    PPQuestionDisplayTypeMultipleChoiceMultiSelectDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeDayOfTheWeek) {
    PPQuestionDisplayTypeDayOfTheWeekNone = -1,
    PPQuestionDisplayTypeDayOfTheWeekMultiDay = 0, // Select mulitple days simultaneously.
    PPQuestionDisplayTypeDayOfTheWeekSingleDay = 1, // Pick a single day only.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeSlider) {
    PPQuestionDisplayTypeSliderNone = -1,
    PPQuestionDisplayTypeSliderInteger = 0, // Integer select, default.
    PPQuestionDisplayTypeSliderFloat = 1, // Floating point select.
    PPQuestionDisplayTypeSliderMinutesSeconds = 2, // Minutes:Seconds
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeTimeInSecondsSinceMidnight) {
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightNone = -1,
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightHoursMinutesSeconds = 0, // Hours:Minutes:Seconds (am|pm), default.
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightHoursMinutes = 1 // Hours:Minutes (am|pm)
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeDateAndTime) {
    PPQuestionDisplayTypeDateAndTimeNone = -1,
    PPQuestionDisplayTypeDateAndTimeDateTime = 0, // Date and time, default.
    PPQuestionDisplayTypeDateAndTimeTime = 1 // Time only.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeTextBox) {
    PPQuestionDisplayTypeTextBoxNone = -1,
    PPQuestionDisplayTypeTextBoxDefault = 0
};

@interface PPQuestionResponseOption : NSObject

@property (nonatomic) PPResponseOptionId responseOptionId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) PPResponseOptionTotal total;

- (id)initWithId:(PPResponseOptionId)responseOptionId text:(NSString *)text total:(PPResponseOptionTotal)total;

+ (PPQuestionResponseOption *)initWithDictionary:(NSDictionary *)responseOptionDict;

@end
