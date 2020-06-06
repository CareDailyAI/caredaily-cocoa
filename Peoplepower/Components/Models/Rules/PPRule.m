//
//  PPRule.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRule.h"

@implementation PPRule

+ (NSString *)primaryKey {
    return @"ruleId";
}

- (id)initWithId:(PPRuleId)ruleId name:(NSString *)name status:(PPRuleStatus)status timezone:(PPTimezone *)timezone hidden:(PPRuleHidden)hidden defaultRule:(PPRuleDefault)defaultRule goalId:(PPDeviceTypeGoalId)goalId trigger:(PPRuleComponentTrigger *)trigger states:(RLMArray *)states actions:(RLMArray *)actions calendars:(RLMArray *)calendars {
    self = [super init];
    if(self) {
        self.ruleId = ruleId;
        self.name = name;
        self.status = status;
        self.timezone = timezone;
        self.hidden = hidden;
        self.defaultRule = defaultRule;
        self.goalId = goalId;
        self.trigger = trigger;
        self.states = (RLMArray<PPRuleComponentState *><PPRuleComponentState> *)states;
        self.actions = (RLMArray<PPRuleComponentAction *><PPRuleComponentAction> *)actions;
        self.calendars = (RLMArray<PPRuleCalendar *><PPRuleCalendar> *)calendars;
    }
    return self;
}

+ (PPRule *)initWithDictionary:(NSDictionary *)ruleDict {
    
    PPRuleId ruleId = PPRuleIdNone;
    if([ruleDict objectForKey:@"id"]) {
        ruleId = (PPRuleId)((NSString *)[ruleDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [ruleDict objectForKey:@"name"];
    PPRuleStatus status = PPRuleStatusNone;
    if([ruleDict objectForKey:@"status"]) {
        status = (PPRuleStatus)((NSString *)[ruleDict objectForKey:@"status"]).integerValue;
    }
    PPTimezone *timezone = [[PPTimezone alloc] initWithTimezoneId:[ruleDict objectForKey:@"timeZone"] offset:PPTimezoneOffsetNone dst:PPDaylightSavingsTimeNone name:nil];
    PPRuleHidden hidden = PPRuleHiddenNone;
    if([ruleDict objectForKey:@"hidden"]) {
        hidden = (PPRuleHidden)((NSString *)[ruleDict objectForKey:@"hidden"]).integerValue;
    }
    PPRuleDefault defaultRule = PPRuleDefaultNone;
    if([ruleDict objectForKey:@"defaultRule"]) {
        defaultRule = (PPRuleDefault)((NSString *)[ruleDict objectForKey:@"defaultRule"]).integerValue;
    }
    PPDeviceTypeGoalId goalId = PPDeviceTypeGoalIdNone;
    if([ruleDict objectForKey:@"goalId"]) {
        goalId = (PPDeviceTypeGoalId)((NSString *)[ruleDict objectForKey:@"goalId"]).integerValue;
    }
    PPRuleComponentTrigger *trigger = (PPRuleComponentTrigger *)[PPRuleComponent initWithDictionary:[ruleDict objectForKey:@"trigger"] subclass:NSStringFromClass([PPRuleComponentTrigger class])];
    
    NSMutableArray *states = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *stateDictKey in [ruleDict objectForKey:@"states"]) {
        if([stateDictKey isEqualToString:@"state"]) {
            NSMutableArray *stateArray;
            if([[ruleDict objectForKey:@"states"] objectForKey:stateDictKey]) {
                stateArray = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *stateDict in [[ruleDict objectForKey:@"states"] objectForKey:stateDictKey]) {
                    PPRuleComponentState *state = (PPRuleComponentState *)[PPRuleComponent initWithDictionary:stateDict subclass:NSStringFromClass([PPRuleComponentState class])];
                    state.stateType = PPRuleComponentStateTypeState;
                    [stateArray addObject:state];
                }
            }
            [states addObjectsFromArray:stateArray];
        }
        else {
            if([stateDictKey isEqualToString:@"and"]) {
                NSMutableArray *andArray;
                if([[[ruleDict objectForKey:@"states"] objectForKey:stateDictKey] objectForKey:@"state"]) {
                    andArray = [[NSMutableArray alloc] initWithCapacity:0];
                    for(NSDictionary *stateDict in [[[ruleDict objectForKey:@"states"] objectForKey:stateDictKey] objectForKey:@"state"]) {
                        PPRuleComponentState *state = (PPRuleComponentState *)[PPRuleComponent initWithDictionary:stateDict subclass:NSStringFromClass([PPRuleComponentState class])];
                        state.stateType = PPRuleComponentStateTypeAnd;
                        [andArray addObject:state];
                    }
                }
                [states addObjectsFromArray:andArray];
            }
            else if([stateDictKey isEqualToString:@"or"]) {
                NSMutableArray *orArray;
                if([[[ruleDict objectForKey:@"states"] objectForKey:stateDictKey] objectForKey:@"state"]) {
                    orArray = [[NSMutableArray alloc] initWithCapacity:0];
                    for(NSDictionary *stateDict in [[[ruleDict objectForKey:@"states"] objectForKey:stateDictKey] objectForKey:@"state"]) {
                        PPRuleComponentState *state = (PPRuleComponentState *)[PPRuleComponent initWithDictionary:stateDict subclass:NSStringFromClass([PPRuleComponentState class])];
                        state.stateType = PPRuleComponentStateTypeOr;
                        [orArray addObject:state];
                    }
                }
                [states addObject:orArray];
            }
        }
    }
    
    NSMutableArray *actions;
    if([ruleDict objectForKey:@"actions"]) {
        actions = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *actionDict in [ruleDict objectForKey:@"actions"]) {
            PPRuleComponentAction *action = (PPRuleComponentAction *)[PPRuleComponent initWithDictionary:actionDict subclass:NSStringFromClass([PPRuleComponentAction class])];
            [actions addObject:action];
        }
    }
    
    NSMutableArray *calendars;
    if([ruleDict objectForKey:@"calendars"]) {
        calendars = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *calendarDict in [ruleDict objectForKey:@"calendars"]) {
            PPRuleCalendar *calendar = [PPRuleCalendar initWithDictionary:calendarDict];
            [calendars addObject:calendar];
        }
    }
    
    PPRule *rule = [[PPRule alloc] initWithId:ruleId name:name status:status timezone:timezone hidden:hidden defaultRule:defaultRule goalId:goalId trigger:trigger states:(RLMArray *)states actions:(RLMArray *)actions calendars:(RLMArray *)calendars];
    return rule;
}

+ (NSString *)stringify:(PPRule *)rule {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(rule.status != PPRuleStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\":%li", (long)rule.status];
        appendComma = YES;
    }
    
    if(rule.timezone.timezoneId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"timeZone\":\"%@\"", rule.timezone.timezoneId];
        appendComma = YES;
    }
    
    if(rule.hidden != PPRuleHiddenNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"hidden\":%li", (long)rule.hidden];
        appendComma = YES;
    }
    
    
    if(rule.trigger) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"trigger\": %@", [PPRuleComponent stringify:rule.trigger]];
        appendComma = YES;
    }
    
    if(rule.states) {
        
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendFormat:@"\"states\": {"];
        
        BOOL appendStatesAndOrComma = NO;
        
        NSMutableArray *states = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *andStates = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *orStates = [[NSMutableArray alloc] initWithCapacity:0];
        for(PPRuleComponentState *state in rule.states) {
            switch (state.stateType) {
                case PPRuleComponentStateTypeState:
                    [states addObject:state];
                    break;
                case PPRuleComponentStateTypeAnd:
                    [andStates addObject:state];
                    break;
                case PPRuleComponentStateTypeOr:
                    [orStates addObject:state];
                    break;
                    
                default:
                    break;
            }
        }
        
        NSMutableDictionary *statesDict = [[NSMutableDictionary alloc] initWithCapacity:3];
        if([states count]) {
            [statesDict setObject:states forKey:@"state"];
        }
        if([andStates count]) {
            [statesDict setObject:andStates forKey:@"and"];
        }
        if([orStates count]) {
            [statesDict setObject:orStates forKey:@"or"];
        }
        
        for(NSString *stateKey in statesDict.allKeys) {
            if(appendStatesAndOrComma) {
                [JSONString appendString:@","];
            }
            
            [JSONString appendFormat:@"\"%@\": [", stateKey];
            
            if(![stateKey isEqualToString:@"state"]) {
                [JSONString appendString:@"{"];
            }
            
            BOOL appendStateComma = NO;
            
            for(PPRuleComponentState *component in [statesDict objectForKey:stateKey]) {
                if(appendStateComma) {
                    
                    if(![stateKey isEqualToString:@"state"]) {
                        [JSONString appendString:@"}"];
                    }
                    
                    [JSONString appendString:@","];
                    
                    if(![stateKey isEqualToString:@"state"]) {
                        [JSONString appendString:@"{"];
                    }
                }
                
                if(![stateKey isEqualToString:@"state"]) {
                    [JSONString appendString:@"\"state\": ["];
                }
                
                [JSONString appendString:[PPRuleComponent stringify:component]];
                
                if(![stateKey isEqualToString:@"state"]) {
                    [JSONString appendString:@"]"];
                }
                
                appendStateComma = YES;
            }
            
            if(![stateKey isEqualToString:@"state"]) {
                [JSONString appendString:@"}"];
            }
            
            [JSONString appendString:@"]"];
            
            appendStatesAndOrComma = YES;
        }

        [JSONString appendFormat:@"}"];
        
        appendComma = YES;
    }
    
    if(rule.actions) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"actions\": {\"action\": ["];
        BOOL appendStatesComma = NO;
        
        for(PPRuleComponentState *component in rule.actions) {
            if(appendStatesComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPRuleComponent stringify:component]];
            appendStatesComma = YES;
        }
        [JSONString appendString:@"]}"];
        appendComma = YES;
    }
    
    if([rule.calendars count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"calendar\": ["];
        BOOL appendStatesComma = NO;
        
        for(PPRuleCalendar *calendar in rule.calendars) {
            if(appendStatesComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPRuleCalendar stringify:calendar]];
            appendStatesComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPRule *)rule {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(rule.status != PPRuleStatusNone) {
        data[@"status"] = @(rule.status);
    }
    
    if(rule.timezone.timezoneId) {
        data[@"timeZone"] = rule.timezone.timezoneId;
    }
    
    if(rule.hidden != PPRuleHiddenNone) {
        data[@"hidden"] = @(rule.hidden);
    }
    
    
    if(rule.trigger) {
        data[@"trigger"] = [PPRuleComponent data:rule.trigger];
    }
    
    if(rule.states) {
        
        NSMutableDictionary *statesData = @{}.mutableCopy;
        
        NSMutableArray *state = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *andStates = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *orStates = [[NSMutableArray alloc] initWithCapacity:0];
        for(PPRuleComponentState *component in rule.states) {
            switch (component.stateType) {
                case PPRuleComponentStateTypeState:
                    [state addObject:[PPRuleComponent data:component]];
                    break;
                case PPRuleComponentStateTypeAnd:
                    [andStates addObject:@{@"state": @[[PPRuleComponent data:component]]}];
                    break;
                case PPRuleComponentStateTypeOr:
                    [orStates addObject:@{@"state": @[[PPRuleComponent data:component]]}];
                    break;
                    
                default:
                    break;
            }
        }
        
        statesData[@"state"] = state;
        if ([andStates count] > 0) {
            statesData[@"and"] = andStates;
        }
        if ([orStates count] > 0) {
            statesData[@"or"] = orStates;
        }
        data[@"states"] = statesData;
    }
    
    if(rule.actions) {
        NSMutableArray *actionsData = @[].mutableCopy;
        
        for(PPRuleComponentState *component in rule.actions) {
            [actionsData addObject:[PPRuleComponent data:component]];
        }
        
        data[@"actions"] = @{@"action": actionsData};
    }
    
    if([rule.calendars count]) {
        NSMutableArray *calendarData = @[].mutableCopy;
        
        for(PPRuleCalendar *calendar in rule.calendars) {
            [calendarData addObject:[PPRuleCalendar data:calendar]];
        }
        
        data[@"calendar"] = calendarData;
    }
    
    return data;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToRule:(PPRule *)rule {
    BOOL equal = NO;
    
    if(rule.ruleId != PPRuleIdNone) {
        if(rule.ruleId == _ruleId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPRule *)rule {
    
    if(rule.ruleId != PPRuleIdNone) {
        _ruleId = rule.ruleId;
    }
    if(rule.name) {
        _name = rule.name;
    }
    if(rule.status != PPRuleStatusNone) {
        _status = rule.status;
    }
    if(rule.timezone) {
        [_timezone sync:rule.timezone];
    }
    if(rule.hidden != PPRuleHiddenNone) {
        _hidden = rule.hidden;
    }
    if(rule.defaultRule != PPRuleDefaultNone) {
        _defaultRule = rule.defaultRule;
    }
    if(rule.goalId != PPDeviceTypeGoalIdNone) {
        _goalId = rule.goalId;
    }
    if(rule.trigger) {
        [_trigger sync:rule.trigger];
    }
    if(rule.states) {
        _states = rule.states;
    }
    if(rule.actions) {
        _actions = rule.actions;
    }
    if(rule.calendars) {
        _calendars = rule.calendars;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRule *rule = [[[self class] allocWithZone:zone] init];
    
    rule.ruleId = self.ruleId;
    rule.name = [self.name copyWithZone:zone];
    rule.status = self.status;
    rule.timezone = [self.timezone copyWithZone:zone];
    rule.hidden = self.hidden;
    rule.defaultRule = self.defaultRule;
    rule.goalId = self.goalId;
    rule.trigger = [self.trigger copyWithZone:zone];
    NSMutableArray *states = [[NSMutableArray alloc] initWithCapacity:self.states.count];
    for (PPRuleComponentState *state in self.states) {
        [states addObject:[state copyWithZone:zone]];
    }
    rule.states = states;
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:self.actions.count];
    for (PPRuleComponentAction *action in self.actions) {
        [actions addObject:[action copyWithZone:zone]];
    }
    rule.actions = actions;
    NSMutableArray *calendars = [[NSMutableArray alloc] initWithCapacity:self.calendars.count];
    for (PPRuleCalendar *calendar in self.calendars) {
        [calendars addObject:[calendar copyWithZone:zone]];
    }
    rule.calendars = calendars;
    
    return rule;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.ruleId = (PPRuleId)((NSNumber *)[decoder decodeObjectForKey:@"ruleId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.status = (PPRuleStatus)((NSNumber *)[decoder decodeObjectForKey:@"status"]).integerValue;
        self.timezone = [decoder decodeObjectForKey:@"timezone"];
        self.hidden = (PPRuleHidden)((NSNumber *)[decoder decodeObjectForKey:@"hidden"]).integerValue;
        self.defaultRule = (PPRuleDefault)((NSNumber *)[decoder decodeObjectForKey:@"defaultRule"]).integerValue;
        self.goalId = (PPDeviceTypeGoalId)((NSNumber *)[decoder decodeObjectForKey:@"goalId"]).integerValue;
        self.trigger = [decoder decodeObjectForKey:@"trigger"];
        self.states = [decoder decodeObjectForKey:@"states"];
        self.actions = [decoder decodeObjectForKey:@"actions"];
        self.calendars = [decoder decodeObjectForKey:@"calendars"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_ruleId) forKey:@"ruleId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_status) forKey:@"status"];
    [encoder encodeObject:_timezone forKey:@"timezone"];
    [encoder encodeObject:@(_hidden) forKey:@"hidden"];
    [encoder encodeObject:@(_defaultRule) forKey:@"defaultRule"];
    [encoder encodeObject:@(_goalId) forKey:@"goalId"];
    [encoder encodeObject:_trigger forKey:@"trigger"];
    [encoder encodeObject:_states forKey:@"states"];
    [encoder encodeObject:_actions forKey:@"actions"];
    [encoder encodeObject:_calendars forKey:@"calendars"];
}
     
@end
