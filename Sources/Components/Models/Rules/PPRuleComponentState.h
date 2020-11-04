//
//  PPRuleComponentState.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponent.h"

@interface PPRuleComponentState : PPRuleComponent

@property (nonatomic) PPRuleComponentStateType stateType;

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name stateType:(PPRuleComponentStateType)stateType displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(RLMArray *)parameters serviceName:(NSString *)serviceName;

+ (PPRuleComponentState *)initScheduleStateComponent:(PPRuleComponentStateType)stateType;

+ (NSString *)stringifyScheduleComponent:(PPRuleComponentState *)component;

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentState *)ruleComponent;

- (void)sync:(PPRuleComponentState *)ruleComponent;

@end
