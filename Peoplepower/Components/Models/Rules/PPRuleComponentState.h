//
//  PPRuleComponentState.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponent.h"

typedef NS_OPTIONS(NSInteger, PPRuleComponentStateType) {
    PPRuleComponentStateTypeState = 0,
    PPRuleComponentStateTypeAnd = 1,
    PPRuleComponentStateTypeOr = 2
};

extern NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_NAME;
extern NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_1;
extern NSString *RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_2;

@interface PPRuleComponentState : PPRuleComponent

@property (nonatomic) PPRuleComponentStateType stateType;

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name stateType:(PPRuleComponentStateType)stateType displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(NSArray *)parameters serviceName:(NSString *)serviceName;

+ (PPRuleComponentState *)initScheduleStateComponent:(PPRuleComponentStateType)stateType;

+ (NSString *)stringifyScheduleComponent:(PPRuleComponentState *)component;

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentState *)ruleComponent;

- (void)sync:(PPRuleComponentState *)ruleComponent;

@end
