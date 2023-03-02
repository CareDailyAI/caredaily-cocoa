//
//  PPRule.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPTimezone.h"
#import "PPDeviceTypeGoal.h"
#import "PPRuleComponentTrigger.h"
#import "PPRuleComponentState.h"
#import "PPRuleComponentAction.h"
#import "PPRuleCalendar.h"

@interface PPRule : PPBaseModel <NSCopying>

@property (nonatomic) PPRuleId ruleId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPRuleStatus status;
@property (nonatomic, strong) PPTimezone *timezone;
@property (nonatomic) PPRuleHidden hidden;
@property (nonatomic) PPRuleDefault defaultRule;
@property (nonatomic) PPDeviceTypeGoalId goalId;
@property (nonatomic, strong) PPRuleComponentTrigger *trigger;
@property (nonatomic, strong) RLMArray<PPRuleComponentState *><PPRuleComponentState> *states;
@property (nonatomic, strong) RLMArray<PPRuleComponentAction *><PPRuleComponentAction> *actions;
@property (nonatomic, strong) RLMArray<PPRuleCalendar *><PPRuleCalendar> *calendars;

- (id)initWithId:(PPRuleId)ruleId name:(NSString *)name status:(PPRuleStatus)status timezone:(PPTimezone *)timezone hidden:(PPRuleHidden)hidden defaultRule:(PPRuleDefault)defaultRule goalId:(PPDeviceTypeGoalId)goalId trigger:(PPRuleComponentTrigger *)trigger states:(RLMArray *)states actions:(RLMArray *)actions calendars:(RLMArray *)calendars;

+ (PPRule *)initWithDictionary:(NSDictionary *)ruleDict;

+ (NSString *)stringify:(PPRule *)rule;
+ (NSDictionary *)data:(PPRule *)rule;

#pragma marker - Helper Methods

- (BOOL)isEqualToRule:(PPRule *)rule;

- (void)sync:(PPRule *)rule;

@end
