//
//  PPQuestionAnswer.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerStatus) {
    PPQuestionAnswerStatusNone = -1,
    PPQuestionAnswerStatusDelayed = 0, // Delayed, the question will be asked in the future
    PPQuestionAnswerStatusReady = 1, // Ready to be asked, but it is queued
    PPQuestionAnswerStatusAvailable = 2, // Available
    PPQuestionAnswerStatusSkipped = 3, // Skipped, the user is going to answer it later
    PPQuestionAnswerStatusAnswered = 4, // Answered
    PPQuestionAnswerStatusNoAnswer = 5, // No answer, the user is not going to answer on it
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerValid) {
    PPQuestionAnswerValidNone = -1,
    PPQuestionAnswerValidFalse = 0,
    PPQuestionAnswerValidTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerPoints) {
    PPQuestionAnswerPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerModified) {
    PPQuestionAnswerModifiedNone = -1,
    PPQuestionAnswerModifiedFalse = 0,
    PPQuestionAnswerModifiedTrue = 1
};

@interface PPQuestionAnswer : NSObject

/* Answer Status */
@property (nonatomic) PPQuestionAnswerStatus status;

/* User's answer:
 *  Boolean:
 *      0 = No
 *      1 = Yes
 *  Multi-choice Single-select:
 *      ID of the radio button
 *  Multi-choice Multi-select:
 *      Bitmask representing response options
 *  Slider value
 *  Text entered by the user
 *  Days of the week are represented by a bitmask:
 *      1 - Sunday (1 << 0)
 *      2 - Monday (1 << 1)
 *      4 - Tuesday (1 << 2)
 *      8 - Wednesday (1 << 3)
 *      16 - Thursday (1 << 4)
 *      32 - Friday (1 << 5)
 *      64 - Saturday (1 << 6)
 */
@property (nonatomic, strong) NSString *answer;

/* When the user has answered thsi quetsion. */
@property (nonatomic, strong) NSDate *date;

/* Indicate if the answer is valid */
@property (nonatomic) PPQuestionAnswerValid valid;

/* Number of points the user has earned by answer this question */
@property (nonatomic) PPQuestionAnswerPoints points;

/* Indicate if the original answer has been modified by other user. */
@property (nonatomic) PPQuestionAnswerModified modified;

- (id)initWithStatus:(PPQuestionAnswerStatus)status answer:(NSString *)answer date:(NSDate *)date valid:(PPQuestionAnswerValid)valid points:(PPQuestionAnswerPoints)points modified:(PPQuestionAnswerModified)modified;

+ (PPQuestionAnswer *)initWithDictionary:(NSDictionary *)answerDict;

@end
