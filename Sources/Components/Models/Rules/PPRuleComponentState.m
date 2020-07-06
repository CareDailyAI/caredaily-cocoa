//
//  PPRuleComponentState.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponentState.h"
#import "PPRuleComponentParameter.h"
#import "PPRuleCalendar.h"

NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_NAME = @"schedule";
NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_1 = @"time1";
NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_2 = @"time2";

@implementation PPRuleComponentState

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name stateType:(PPRuleComponentStateType)stateType displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(RLMArray *)parameters serviceName:(NSString *)serviceName {
    self = [super initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    if(self) {
        _stateType = stateType;
    }
    return self;
}

+ (PPRuleComponentState *)initScheduleStateComponent:(PPRuleComponentStateType)stateType {
    PPRuleComponentParameter *param1 = [[PPRuleComponentParameter alloc] initWithName:RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_1 category:PPRuleComponentParameterCategoryCronExpression optional:PPRuleComponentParameterOptionalFalse desc:NSLocalizedString(@"What is the start time, and on which days?", @"Label - What is the start time, and on which days?") values:nil selectorName:nil value:nil minValue:PPRuleComponentParameterMinValueNone maxValue:PPRuleComponentParameterMaxValueNone valueType:PPRuleComponentParameterInputTypeNone unit:nil];
    
    PPRuleComponentParameter *param2 = [[PPRuleComponentParameter alloc] initWithName:RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_2 category:PPRuleComponentParameterCategoryCronExpression optional:PPRuleComponentParameterOptionalFalse desc:NSLocalizedString(@"What time should it end each day?", @"Label - What time should it end each day?") values:nil selectorName:nil value:nil minValue:PPRuleComponentParameterMinValueNone maxValue:PPRuleComponentParameterMaxValueNone valueType:PPRuleComponentParameterInputTypeNone unit:nil];
    
    PPRuleComponentState *state = [[PPRuleComponentState alloc] initWithId:PPRuleComponentIdNone name:RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_NAME stateType:stateType displayType:PPRuleComponentDisplayTypeStateGeneralCondition desc:NSLocalizedString(@"$time1 and $time2", @"Label - $time1 and $time2") past:NSLocalizedString(@"between $time1 and $time2", @"Label - between $time1 and $time2") timezone:PPRuleComponentTimezoneTrue functionGroup:nil parameters:(RLMArray *)@[param1, param2] serviceName:nil];
    return state;
}

+ (NSString *)stringifyScheduleComponent:(PPRuleComponentState *)component {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    
    NSInteger startTime = PPRuleCalendarTimeNone;
    NSInteger daysOfWeek = PPRuleCalendarDaysOfWeekNone;
    NSInteger endTime = PPRuleCalendarTimeNone;
    
    for(PPRuleComponentParameter *parameter in component.parameters) {
        if(parameter.category == PPRuleComponentParameterCategoryTime) {
            // When dealing with a cron expression, we don't look at the actualValue... we store everything in the 'time' and 'dayOfWeek' variables to be interpreted by the UI, and then convert them back into the cron expression when we finally getXML/getJSON
            NSArray *bits = [parameter.value.value componentsSeparatedByString:@" "];
            NSInteger minutes = ((NSString *)[bits objectAtIndex:1]).integerValue;
            NSInteger hours = ((NSString *)[bits objectAtIndex:2]).integerValue;
            
            endTime = hours * 3600 + minutes * 60;
        }
        else if(parameter.category == PPRuleComponentParameterCategoryCronExpression) {
            // When dealing with a cron expression, we don't look at the actualValue... we store everything in the 'time' and 'dayOfWeek' variables to be interpreted by the UI, and then convert them back into the cron expression when we finally getXML/getJSON
            NSArray *bits = [parameter.value.value componentsSeparatedByString:@" "];
            NSInteger minutes = ((NSString *)[bits objectAtIndex:1]).integerValue;
            NSInteger hours = ((NSString *)[bits objectAtIndex:2]).integerValue;
            NSString *dowString = [bits objectAtIndex:5];
            
            startTime = hours * 3600 + minutes * 60;
            
            if([dowString isEqualToString:@"*"]) {
                daysOfWeek = PPRuleCalendarDaysOfWeekSunday | PPRuleCalendarDaysOfWeekMonday | PPRuleCalendarDaysOfWeekTuesday | PPRuleCalendarDaysOfWeekWednesday | PPRuleCalendarDaysOfWeekThursday | PPRuleCalendarDaysOfWeekFriday | PPRuleCalendarDaysOfWeekSaturday;
            }
            else {
                NSArray *dowBits = [dowString componentsSeparatedByString:@","];
                if([dowBits containsObject:@"1"]) {
                    daysOfWeek |= PPRuleCalendarDaysOfWeekSunday;
                }
                if([dowBits containsObject:@"2"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekMonday;
                }
                if([dowBits containsObject:@"3"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekTuesday;
                }
                if([dowBits containsObject:@"4"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekWednesday;
                }
                if([dowBits containsObject:@"5"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekThursday;
                }
                if([dowBits containsObject:@"6"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekFriday;
                }
                if([dowBits containsObject:@"7"]) {
                    daysOfWeek |=PPRuleCalendarDaysOfWeekSaturday;
                }
            }
        }
    }
    
    if(startTime != -1 && daysOfWeek != -1 && endTime != -1) {
        if(startTime == endTime) {
            // Start time and end time cannot be the same, or the server will throw an error.
            // Take 1 minute off the end time, and the server will be happy again.
            endTime -= 60;
        }
        
        [JSONString appendFormat:@"\"calendar\": [{\"include\": \"true\",\"startTime\": \"%ld\",\"endTime\":\"%ld\",\"daysOfWeek\":\"%ld\"}]", (long)startTime, (long)endTime, (long)daysOfWeek];
    }
    
    return JSONString;
}

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentState *)ruleComponent {
    BOOL isEqual = [super isEqualToRuleComponent:ruleComponent];
    if(_stateType != ruleComponent.stateType) {
        isEqual = NO;
    }
    return isEqual;
}

- (void)sync:(PPRuleComponentState *)ruleComponent {
    [super sync:ruleComponent];
    _stateType = ruleComponent.stateType;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleComponentState *ruleComponent = [[PPRuleComponentState allocWithZone:zone] init];
    ruleComponent.componentId = self.componentId;
    ruleComponent.name = [self.name copyWithZone:zone];
    ruleComponent.stateType = self.stateType;
    ruleComponent.displayType = self.displayType;
    ruleComponent.desc = [self.desc copyWithZone:zone];
    ruleComponent.past = [self.past copyWithZone:zone];
    ruleComponent.timezone = self.timezone;
    ruleComponent.functionGroup = [self.functionGroup copyWithZone:zone];
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:self.parameters.count];
    for (PPRuleComponentParameter *parameter in self.parameters) {
        [parameters addObject:[parameter copyWithZone:zone]];
    }
    ruleComponent.parameters = parameters;
    ruleComponent.serviceName = [self.serviceName copyWithZone:zone];
    
    return ruleComponent;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        self.stateType = (PPRuleComponentStateType)((NSNumber *)[decoder decodeObjectForKey:@"stateType"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:@(_stateType) forKey:@"stateType"];
}


@end
