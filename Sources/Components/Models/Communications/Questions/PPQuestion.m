//
//  PPQuestion.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPQuestion.h"

@implementation PPQuestion

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
 responseOptions:(NSArray *)responseOptions
     displayType:(PPQuestionDisplayType)displayType
        deviceId:(NSString *)deviceId
            icon:(NSString *)icon
   defaultAnswer:(NSString *)defaultAnswer
    answerFormat:(NSString *)answerFormat
       sliderMin:(NSNumber *)sliderMin
       sliderMax:(NSNumber *)sliderMax
       sliderInc:(NSNumber *)sliderInc
          slider:(PPQuestionSlider *)slider
    sectionTitle:(NSString *)sectionTitle
       sectionId:(PPQuestionSectionId)sectionId
  questionWeight:(PPQuestionWeight)questionWeight
          points:(PPQuestionPoints)points
          answer:(PPQuestionAnswer *)answer {
    self = [super init];
    if(self) {
        self.questionId = questionId;
        self.key = key;
        self.creationDate = creationDate;
        self.collection = collection;
        self.question = question;
        self.placeholder = placeholder;
        self.aggregatePublicly = aggregatePublicly;
        self.urgent = urgent;
        self.front = front;
        self.editable = editable;
        self.totalResponses = totalResponses;
        self.responseType = responseType;
        self.responseOptions = responseOptions;
        self.displayType = displayType;
        self.deviceId = deviceId;
        self.icon = icon;
        self.defaultAnswer = defaultAnswer;
        self.answerFormat = answerFormat;
        self.sliderMin = sliderMin;
        self.sliderMax = sliderMax;
        self.sliderInc = sliderInc;
        self.slider = slider;
        self.sectionTitle = sectionTitle;
        self.sectionId = sectionId;
        self.questionWeight = questionWeight;
        self.points = points;
        self.answer = answer;
    }
    return self;
}

+ (PPQuestion *)initWithDictionary:(NSDictionary *)questionDict {
    
    PPQuestionId questionId = PPQuestionIdNone;
    if([questionDict objectForKey:@"id"]) {
        questionId = (PPQuestionId)((NSString *)[questionDict objectForKey:@"id"]).integerValue;
    }
    NSString *key = [questionDict objectForKey:@"key"];
    
    NSString *creationDateString = [questionDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    PPQuestionCollection *collection;
    if([questionDict objectForKey:@"collection"]) {
        collection = [PPQuestionCollection initWithDictionary:[questionDict objectForKey:@"collection"]];
    }
    NSString *questionString = [questionDict objectForKey:@"question"];
    NSString *placeholder = [questionDict objectForKey:@"placeholder"];
    PPQuestionAggregatePublicly aggregatePublicly = PPQuestionAggregatePubliclyNone;
    if([questionDict objectForKey:@"aggregatePublicly"]) {
        aggregatePublicly = (PPQuestionAggregatePublicly)((NSString *)[questionDict objectForKey:@"aggregatePublicly"]).integerValue;
    }
    PPQuestionUrgent urgent = PPQuestionUrgentNone;
    if([questionDict objectForKey:@"urgent"]) {
        urgent = (PPQuestionUrgent)((NSString *)[questionDict objectForKey:@"urgent"]).integerValue;
    }
    PPQuestionFront front = PPQuestionFrontNone;
    if([questionDict objectForKey:@"front"]) {
        front = (PPQuestionFront)((NSString *)[questionDict objectForKey:@"front"]).integerValue;
    }
    PPQuestionEditable editable = PPQuestionEditableNone;
    if([questionDict objectForKey:@"editable"]) {
        editable = (PPQuestionEditable)((NSString *)[questionDict objectForKey:@"editable"]).integerValue;
    }
    PPQuestionTotalResponses totalResponses = PPQuestionTotalResponsesNone;
    if([questionDict objectForKey:@"totalResponses"]) {
        totalResponses = (PPQuestionTotalResponses)((NSString *)[questionDict objectForKey:@"totalResponses"]).integerValue;
    }
    PPQuestionResponseOptionType responseType = PPQuestionResponseOptionTypeNone;
    if([questionDict objectForKey:@"responseType"]) {
        responseType = (PPQuestionResponseOptionType)((NSString *)[questionDict objectForKey:@"responseType"]).integerValue;
    }
    NSMutableArray *responseOptions;
    if([questionDict objectForKey:@"responseOptions"]) {
        responseOptions = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *responseOptionDict in [questionDict objectForKey:@"responseOptions"]) {
            PPQuestionResponseOption *responseOption = [PPQuestionResponseOption initWithDictionary:responseOptionDict];
            [responseOptions addObject:responseOption];
        }
    }
    PPQuestionDisplayType displayType = PPQuestionDisplayTypeNone;
    if([questionDict objectForKey:@"displayType"]) {
        displayType = (PPQuestionDisplayType)((NSString *)[questionDict objectForKey:@"displayType"]).integerValue;
    }
    NSString *deviceId = [questionDict objectForKey:@"deviceId"];
    NSString *icon = [questionDict objectForKey:@"icon"];
    NSString *defaultAnswer = [questionDict objectForKey:@"defaultAnswer"];
    NSString *answerFormat = [questionDict objectForKey:@"answerFormat"];
    NSNumber *sliderMin;
    if([questionDict objectForKey:@"sliderMin"]) {
        sliderMin = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderMin"]).floatValue];
    }
    NSNumber *sliderMax;
    if([questionDict objectForKey:@"sliderMax"]) {
        sliderMax = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderMax"]).floatValue];
    }
    NSNumber *sliderInc;
    if([questionDict objectForKey:@"sliderInc"]) {
        sliderInc = [[NSNumber alloc] initWithFloat:((NSString *)[questionDict objectForKey:@"sliderInc"]).floatValue];
    }
    PPQuestionSlider *slider = [PPQuestionSlider initWithDictionary:[questionDict objectForKey:@"slider"]];
    NSString *sectionTitle = [questionDict objectForKey:@"sectionTitle"];
    PPQuestionSectionId sectionId = PPQuestionSectionIdNone;
    if([questionDict objectForKey:@"sectionId"]) {
        sectionId = (PPQuestionSectionId)((NSString *)[questionDict objectForKey:@"sectionId"]).integerValue;
    }
    PPQuestionWeight questionWeight = PPQuestionWeightNone;
    if([questionDict objectForKey:@"questionWeight"]) {
        questionWeight = (PPQuestionWeight)((NSString *)[questionDict objectForKey:@"questionWeight"]).integerValue;
    }
    PPQuestionPoints points = PPQuestionPointsNone;
    if([questionDict objectForKey:@"points"]) {
        points = (PPQuestionPoints)((NSString *)[questionDict objectForKey:@"points"]).integerValue;
    }
    PPQuestionAnswer *answer = [PPQuestionAnswer initWithDictionary:questionDict];
    
    PPQuestion *question = [[PPQuestion alloc] initWithId:questionId
                                                      key:key
                                             creationDate:creationDate
                                               collection:collection
                                                 question:questionString
                                              placeholder:placeholder
                                        aggregatePublicly:aggregatePublicly
                                                   urgent:urgent
                                                    front:front
                                                 editable:editable
                                           totalResponses:totalResponses
                                             responseType:responseType
                                          responseOptions:responseOptions
                                              displayType:displayType
                                                 deviceId:deviceId
                                                     icon:icon
                                            defaultAnswer:defaultAnswer
                                             answerFormat:answerFormat
                                                sliderMin:sliderMin
                                                sliderMax:sliderMax
                                                sliderInc:sliderInc
                                                   slider:slider
                                             sectionTitle:sectionTitle
                                                sectionId:sectionId
                                           questionWeight:questionWeight
                                                   points:points
                                                   answer:answer];
    return question;
}

+ (NSString *)stringify:(PPQuestion *)question {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(question.questionId != PPQuestionIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":%li", (long)question.questionId];
        appendComma = YES;
    }
    
    if(question.answer) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        BOOL appendAnswerComma = NO;
        if(question.answer.answer) {
            if(appendAnswerComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"answer\":\"%@\"", question.answer.answer];
            appendAnswerComma = YES;
        }
        if(question.answer.status != PPQuestionAnswerStatusNone) {
            if(appendAnswerComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"answerStatus\":%li", (long)question.answer.status];
            appendAnswerComma = YES;
        }
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPQuestion *)question {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(question.questionId != PPQuestionIdNone) {
        data[@"id"] = @(question.questionId);
    }
    if(question.answer) {
        if(question.answer.answer) {
            data[@"answer"] = question.answer.answer;
        }
        if(question.answer.status != PPQuestionAnswerStatusNone) {
            data[@"answerStatus"] = @(question.answer.status);
        }
    }
    return data;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToQuestion:(PPQuestion *)question {
    BOOL equal = NO;
    
    if(_questionId != PPQuestionIdNone && question.questionId != PPQuestionIdNone) {
        if(_questionId == question.questionId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPQuestion *)question {

    if(question.questionId != PPQuestionIdNone) {
        _questionId = question.questionId;
    }
    if(question.key) {
        _key = question.key;
    }
    if(question.creationDate) {
        _creationDate = question.creationDate;
    }
    if(question.collection) {
        _collection = question.collection;
    }
    if(question.question) {
        _question = question.question;
    }
    if(question.placeholder) {
        _placeholder = question.placeholder;
    }
    if(question.aggregatePublicly != PPQuestionAggregatePubliclyNone) {
        _aggregatePublicly = question.aggregatePublicly;
    }
    if(question.urgent != PPQuestionUrgentNone) {
        _urgent = question.urgent;
    }
    if(question.front != PPQuestionFrontNone) {
        _front = question.front;
    }
    if(question.editable != PPQuestionEditableNone) {
        _editable = question.editable;
    }
    if(question.totalResponses != PPQuestionTotalResponsesNone) {
        _totalResponses = question.totalResponses;
    }
    if(question.responseType != PPQuestionResponseOptionTypeNone) {
        _responseType = question.responseType;
    }
    if(question.responseOptions) {
        _responseOptions = question.responseOptions;
    }
    if(question.displayType != PPQuestionDisplayTypeNone) {
        _displayType = question.displayType;
    }
    if(question.deviceId) {
        _deviceId = question.deviceId;
    }
    if(question.icon) {
        _icon = question.icon;
    }
    if(question.defaultAnswer) {
        _defaultAnswer = question.defaultAnswer;
    }
    if(question.answerFormat) {
        _answerFormat = question.answerFormat;
    }
    if(question.sliderMin != nil) {
        _sliderMin = question.sliderMin;
    }
    if(question.sliderMax != nil) {
        _sliderMax = question.sliderMax;
    }
    if(question.sliderInc != nil) {
        _sliderInc = question.sliderInc;
    }
    if(question.sectionTitle) {
        _sectionTitle = question.sectionTitle;
    }
    if(question.sectionId != PPQuestionSectionIdNone) {
        _sectionId = question.sectionId;
    }
    if(question.questionWeight != PPQuestionWeightNone) {
        _questionWeight = question.questionWeight;
    }
    if(question.points != PPQuestionPointsNone) {
        _points = question.points;
    }
    if(question.answer) {
        _answer = question.answer;
    }
}

@end
