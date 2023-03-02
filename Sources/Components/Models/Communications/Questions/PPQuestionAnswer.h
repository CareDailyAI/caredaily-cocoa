//
//  PPQuestionAnswer.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPQuestionAnswer : PPBaseModel

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
