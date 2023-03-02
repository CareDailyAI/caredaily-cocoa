//
//  PPQuestionAnswer.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPQuestionAnswer.h"

@implementation PPQuestionAnswer

- (id)initWithStatus:(PPQuestionAnswerStatus)status answer:(NSString *)answer date:(NSDate *)date valid:(PPQuestionAnswerValid)valid points:(PPQuestionAnswerPoints)points modified:(PPQuestionAnswerModified)modified {
    self = [super init];
    if(self) {
        self.status = status;
        self.answer = answer;
        self.date = date;
        self.valid = valid;
        self.points = points;
        self.modified = modified;
    }
    return self;
}

+ (PPQuestionAnswer *)initWithDictionary:(NSDictionary *)answerDict {
    PPQuestionAnswerStatus status = PPQuestionAnswerStatusNone;
    if([answerDict objectForKey:@"answerStatus"]) {
        status = (PPQuestionAnswerStatus)((NSString *)[answerDict objectForKey:@"answerStatus"]).integerValue;
    }
    NSString *answerString = [answerDict objectForKey:@"answer"];
    
    NSString *answerDateString = [answerDict objectForKey:@"answerDate"];
    NSDate *answerDate;
    if(answerDateString != nil) {
        if(![answerDateString isEqualToString:@""]) {
            answerDate = [PPNSDate parseDateTime:answerDateString];
        }
    }
    
    PPQuestionAnswerValid valid = PPQuestionAnswerValidNone;
    if([answerDict objectForKey:@"answerValid"]) {
        valid = (PPQuestionAnswerValid)((NSString *)[answerDict objectForKey:@"answerValid"]).integerValue;
    }
    PPQuestionAnswerPoints points = PPQuestionAnswerPointsNone;
    if([answerDict objectForKey:@"answerPoints"]) {
        points = (PPQuestionAnswerPoints)((NSString *)[answerDict objectForKey:@"answerPoints"]).integerValue;
    }
    PPQuestionAnswerModified modified = PPQuestionAnswerModifiedNone;
    if([answerDict objectForKey:@"answerModified"]) {
        modified = (PPQuestionAnswerModified)((NSString *)[answerDict objectForKey:@"answerModified"]).integerValue;
    }
    
    PPQuestionAnswer *answer = [[PPQuestionAnswer alloc] initWithStatus:status answer:answerString date:answerDate valid:valid points:points modified:modified];
    return answer;
}

@end
