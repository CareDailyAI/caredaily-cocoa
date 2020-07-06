//
//  PPRule.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPTimezone.h"
#import "PPDeviceTypeGoal.h"
#import "PPRuleComponentTrigger.h"
#import "PPRuleComponentState.h"
#import "PPRuleComponentAction.h"
#import "PPRuleCalendar.h"

typedef NS_OPTIONS(NSInteger, PPRuleId) {
    PPRuleIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleStatus) {
    PPRuleStatusNone = -1,
    PPRuleStatusIncomplete = 0,
    PPRuleStatusActive = 1,
    PPRuleStatusInactive = 2
};

typedef NS_OPTIONS(NSInteger, PPRuleHidden) {
    PPRuleHiddenNone = -1,
    PPRuleHiddenFalse = 0,
    PPRuleHiddenTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleDefault) {
    PPRuleDefaultNone = -1,
    PPRuleDefaultFalse = 0,
    PPRuleDefaultTrue = 1,
};

@interface PPRule : NSObject <NSCopying>

@property (nonatomic) PPRuleId ruleId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPRuleStatus status;
@property (nonatomic, strong) PPTimezone *timezone;
@property (nonatomic) PPRuleHidden hidden;
@property (nonatomic) PPRuleDefault defaultRule;
@property (nonatomic) PPDeviceTypeGoalId goalId;
@property (nonatomic, strong) PPRuleComponentTrigger *trigger;
@property (nonatomic, strong) NSArray *states;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSArray *calendars;

- (id)initWithId:(PPRuleId)ruleId name:(NSString *)name status:(PPRuleStatus)status timezone:(PPTimezone *)timezone hidden:(PPRuleHidden)hidden defaultRule:(PPRuleDefault)defaultRule goalId:(PPDeviceTypeGoalId)goalId trigger:(PPRuleComponentTrigger *)trigger states:(NSArray *)states actions:(NSArray *)actions calendars:(NSArray *)calendars;

+ (PPRule *)initWithDictionary:(NSDictionary *)ruleDict;

+ (NSString *)stringify:(PPRule *)rule;
+ (NSDictionary *)data:(PPRule *)rule;

#pragma marker - Helper Methods

- (BOOL)isEqualToRule:(PPRule *)rule;

- (void)sync:(PPRule *)rule;

@end
