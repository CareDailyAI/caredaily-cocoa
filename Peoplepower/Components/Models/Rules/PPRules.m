//
//  PPRules.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRules.h"
#import "PPCloudEngine.h"

@implementation PPRules

#pragma mark - Session Management
__strong static NSMutableDictionary*_sharedRules = nil;

/**
 * Shared rules across the entire application
 */
+ (NSArray *)sharedRulesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedRules) {
        [PPRules initializeSharedRules];
    }
    NSMutableArray *sharedRules = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *ruleArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedRules.allKeys) {
        for(PPRule *rule in [_sharedRules objectForKey:userIdKey]) {
            [ruleArray addObject:@{@"ruleId": @(rule.ruleId), @"status": @(rule.status)}];
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedRules addObject:rule];
            }
        }
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedRules=%@", __PRETTY_FUNCTION__, ruleArray);
#endif
#endif
    return sharedRules;
}

+ (void)initializeSharedRules {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedRules = [[NSMutableDictionary alloc] initWithCapacity:0];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add rules.
 * Add rules from local reference.
 *
 * @param rules Required NSArray Array of rules to remove.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)addRules:(NSArray *)rules userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s rules=%@", __PRETTY_FUNCTION__, rules);
#endif
#endif
    if(!_sharedRules) {
        [PPRules initializeSharedRules];
    }
    
    NSMutableArray *rulesArray = [_sharedRules objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!rulesArray) {
        rulesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPRule *rule in rules) {
        
        BOOL found = NO;
        for(PPRule *sharedRule in rulesArray) {
            if([sharedRule isEqualToRule:rule]) {
                [sharedRule sync:rule];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[rules indexOfObject:rule]];
        }
    }
    
    [rulesArray addObjectsFromArray:[rules objectsAtIndexes:indexSet]];
    [_sharedRules setObject:rulesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedServicePlanData = [NSKeyedArchiver archivedDataWithRootObject:_sharedRules];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedServicePlanData forKey:@"user.rules"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s indexSet=%@", __PRETTY_FUNCTION__, indexSet);
#endif
#endif
}

/**
 * Remove rules.
 * Remove rules from local reference.
 *
 * @param rules Required NSArray Array of rules to remove.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)removeRules:(NSArray *)rules userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s rules=%@", __PRETTY_FUNCTION__, rules);
#endif
#endif
    
    if(!_sharedRules) {
        [PPRules initializeSharedRules];
    }
    
    NSMutableArray *rulesArray = [_sharedRules objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!rulesArray) {
        rulesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPRule *rule in rules) {
        for(PPRule *sharedRule in rulesArray) {
            if([sharedRule isEqualToRule:rule]) {
                [indexSet addIndex:[rulesArray indexOfObject:sharedRule]];
                break;
            }
        }
    }
    
    [rulesArray removeObjectsAtIndexes:indexSet];
    [_sharedRules setObject:rulesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedServicePlanData = [NSKeyedArchiver archivedDataWithRootObject:_sharedRules];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedServicePlanData forKey:@"user.rules"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s indexSet=%@", __PRETTY_FUNCTION__, indexSet);
#endif
#endif
}

#pragma mark Rule Components

/**
 * Shared rule components across the entire application
 */
+ (NSArray *)sharedRuleComponentsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    NSArray *sharedRuleComponents = @[];
    
    NSMutableArray *sharedRuleComponentsArray = [[NSMutableArray alloc] initWithCapacity:[sharedRuleComponents count]];
    NSMutableArray *componentsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPRuleComponent *component in sharedRuleComponents) {
        [sharedRuleComponentsArray addObject:component];
        
        [componentsArrayDebug addObject:@{@"componentId": @(component.componentId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedRuleComponents=%@", __PRETTY_FUNCTION__, componentsArrayDebug);
#endif
#endif
    return sharedRuleComponentsArray;
}

/**
 * Add rule components.
 * add rule components to local reference.
 *
 * @param ruleComponents NSArray Array of rule components to add.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)addRuleComponents:(NSArray *)ruleComponents userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s components=%@", __PRETTY_FUNCTION__, ruleComponents);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove rule components.
 * Remove rule components from local reference.
 *
 * @param ruleComponents NSArray Array of rule components to remove.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)removeRuleComponents:(NSArray *)ruleComponents userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s components=%@", __PRETTY_FUNCTION__, ruleComponents);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Get Rule Phrases

/** Get Rule Phrases.
 *
 * @param locationId Required PPLocationId Location ID
 * @param version PPRulesVersion Rules implementation version
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesComponentsBlock Components callback block containing lists of triggers, states, and actions
 **/
+ (void)getRuleComponents:(PPLocationId)locationId version:(PPRulesVersion)version userId:(PPUserId)userId callback:(PPRulesComponentsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"ruleConditions"];
    NSMutableArray *queryItems = @[].mutableCopy;
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(version != PPRulesVersionNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"version" value:@(version).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.getRuleComponents()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *triggers;
            NSMutableArray *states;
            NSMutableArray *actions;
            
            if(!error) {
                triggers = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *componentDict in [root objectForKey:@"triggers"]) {
                    PPRuleComponentTrigger *component = (PPRuleComponentTrigger *)[PPRuleComponent initWithDictionary:componentDict subclass:NSStringFromClass([PPRuleComponentTrigger class])];
                    [triggers addObject:component];
                }
            
                states = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *componentDict in [root objectForKey:@"states"]) {
                    PPRuleComponentState *component = (PPRuleComponentState *)[PPRuleComponent initWithDictionary:componentDict subclass:NSStringFromClass([PPRuleComponentState class])];
                    [states addObject:component];
                }
            
                actions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *componentDict in [root objectForKey:@"actions"]) {
                    PPRuleComponentAction *component = (PPRuleComponentAction *)[PPRuleComponent initWithDictionary:componentDict subclass:NSStringFromClass([PPRuleComponentAction class])];
                    [actions addObject:component];
                }
            }

            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(triggers, states, actions, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getRuleComponents:(PPRulesVersion)version userId:(PPUserId)userId callback:(PPRulesComponentsBlock)callback {
    NSLog(@"%s deprecated. Use +getRuleComponents:version:userId:callback:", __FUNCTION__);
    [PPRules getRuleComponents:PPLocationIdNone version:version userId:userId callback:callback];
}

#pragma mark - Manage Rules

/**
 * Create a Rule.
 * When creating a rule, specify a single trigger, one or more states, and one or more actions, by referencing the ID's of the triggers / states / actions that are available to the user through the GET API.
 * States are OR'd together by default, unless wrapped in an AND block. This is to provide flexibility to the developer to implement, but we recommend only defining states inside AND blocks to keep the UI simple to understand.
 * If a trigger / state / action requires a parameter, the parameter must be filled out completely.
 * It is possible to save a rule that is not complete. The IoT Software Suite will not execute partial rules.
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param rule PPRule Rule to save
 * @param callback PPRulesCreationBlock Creation block containing rule reference (ID only)
 **/
+ (void)createRule:(PPLocationId)locationId userId:(PPUserId)userId rule:(PPRule *)rule callback:(PPRulesCreationBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(rule != nil, @"%s missing rule", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"rules"];
    NSMutableArray *queryItems = @[].mutableCopy;
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"rule": [PPRule data:rule]} options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.createRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPRule *rule;
            
            if(!error) {
                rule = [PPRule initWithDictionary:[root objectForKey:@"rule"]];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(rule, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)createRule:(PPUserId)userId rule:(PPRule *)rule callback:(PPRulesCreationBlock)callback {
    NSLog(@"%s deprecated. Use +createRule:userId:rule:callback:", __FUNCTION__);
    [PPRules createRule:PPLocationIdNone userId:userId rule:rule callback:callback];
}

/**
 * Get Rules.
 * This API will allow you to filter the list of rules by device ID as well.
 *
 * @param locationId Required PPLocationId Location ID
 * @param deviceId NSString Only return rules for the given deviceId
 * @param details PPRulesDetails Return rule details
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesListBlock Rules callback block containing list of rules
 **/
+ (void)getRules:(PPLocationId)locationId deviceId:(NSString *)deviceId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"userProperties"];
    NSMutableArray *queryItems = @[].mutableCopy;
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"deviceId" value:deviceId]];
    }
    if(details != PPRulesDetailsNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"details" value:@(details).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules?"];
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    if(details != PPRulesDetailsNone) {
        [requestString appendFormat:@"details=%@&", (details) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.getRules()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *rules;
            
            if(!error) {
                rules = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *ruleDict in [root objectForKey:@"rules"]) {
                    PPRule *rule = [PPRule initWithDictionary:ruleDict];
                    [rules addObject:rule];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(rules, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getRules:(NSString *)deviceId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock)callback {
    NSLog(@"%s deprecated. Use +getRules:deviceId:details:userId:callback:", __FUNCTION__);
    [PPRules getRules:PPLocationIdNone deviceId:deviceId details:details userId:userId callback:callback];
}

/**
 * Delete Rules by Criteria.
 * Delete all rules matching to selection criteria.
 *
 * @param locationId Required PPLocationId Location ID
 * @param ruleIds NSArray Rule IDs to delete.
 * @param status PPRuleStatus Rules status
 * @param deviceTypes NSArray Delete rules containing devices of these types.
 * @param deviceIds NSArray Delete rules containing these devices.
 * @param defaultRule PPRuleDefault If set, delete only default or non-default rules.
 * @param hidden PPRuleHidden If set, delete only hidden or non-hidden rules.
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRulesByCriteria:(PPLocationId)locationId ruleIds:(NSArray *)ruleIds status:(PPRuleStatus)status deviceTypes:(NSArray *)deviceTypes deviceIds:(NSArray *)deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(ruleIds) {
        [requestString appendFormat:@"ruleId=%@&", [ruleIds componentsJoinedByString:@"&ruleId="]];
    }
    if(status != PPRuleStatusNone) {
        [requestString appendFormat:@"status=%li&", (long)status];
    }
    if(deviceTypes) {
        [requestString appendFormat:@"deviceType=%@&", [ruleIds componentsJoinedByString:@"&deviceType="]];
    }
    if(deviceIds) {
        for(NSString *deviceId in deviceIds) {
            [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
        }
    }
    if(defaultRule != PPRuleDefaultNone) {
        [requestString appendFormat:@"default=%@&", (defaultRule) ? @"true" : @"false"];
    }
    if(hidden != PPRuleHiddenNone) {
        [requestString appendFormat:@"hidden=%@&", (hidden) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.deleteRulesByCriteria()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteRulesByCriteria:(NSArray *)ruleIds status:(PPRuleStatus)status deviceTypes:(NSArray *)deviceTypes deviceIds:(NSArray *)deviceIds default:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteRulesByCriteria:ruleIds:status:deviceTypes:deviceIds:default:hidden:userId:callback:", __FUNCTION__);
    [PPRules deleteRulesByCriteria:PPLocationIdNone ruleIds:ruleIds status:status deviceTypes:deviceTypes deviceIds:deviceIds defaultRule:defaultRule hidden:hidden userId:userId callback:callback];
}

#pragma mark - Manage a specific Rule

/**
 * Get a Rule
 *
 * @param ruleId Required PPRuleId Rule ID to obtain
 * @param locationId Required PPLocationId Location ID
 * @param details PPRulesDetails Return rule details
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPRulesListBlock Rule callback block containing list of rules
 **/
+ (void)getRule:(PPRuleId)ruleId locationId:(PPLocationId)locationId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock)callback {
    NSAssert1(ruleId != PPRuleIdNone, @"%s missing ruleId", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules/%li?", (long)ruleId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(details != PPRulesDetailsNone) {
        [requestString appendFormat:@"details=%@&", (details) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.getRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *rules;
            
            if(!error) {
                rules = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *ruleDict in [root objectForKey:@"rules"]) {
                    PPRule *rule = [PPRule initWithDictionary:ruleDict];
                    [rules addObject:rule];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(rules, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getRule:(PPRuleId)ruleId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock)callback {
    NSLog(@"%s deprecated. Use +getRule:locationId:details:userId:callback:", __FUNCTION__);
    [PPRules getRule:ruleId locationId:PPLocationIdNone details:details userId:userId callback:callback];
}

/**
 * Update a Rule
 *
 * @param rule Required PPRule Rule to update
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateRule:(PPRule *)rule locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(rule != nil, @"%s missing rule", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules/%li?", (long)rule.ruleId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"rule\": %@", [PPRule stringify:rule]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.updateRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)updateRule:(PPRule *)rule userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateRule:locationId:userId:callback:", __FUNCTION__);
    [PPRules updateRule:rule locationId:PPLocationIdNone userId:userId callback:callback];
}

/**
 * Delete a Rule
 *
 * @param ruleId Required PPRuleId Rule ID to delete
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRule:(PPRuleId)ruleId locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(ruleId != PPRuleIdNone, @"%s missing ruleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules/%li?", (long)ruleId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.deleteRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteRule:(PPRuleId)ruleId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteRule:locationId:userId:callback:", __FUNCTION__);
    [PPRules deleteRule:ruleId locationId:PPLocationIdNone userId:userId callback:callback];
}

#pragma mark - Update a Rule Attribute

/**
 * Update a Rule Attribute.
 * Update the second name or status of the rule.
 *
 * @param ruleId Required PPRuleId Rule ID to update
 * @param locationId Required PPLocationId Location ID
 * @param status PPRuleStatus Rule's status
 * @param name NSString Rule's name
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateRuleAttribute:(PPRuleId)ruleId  locationId:(PPLocationId)locationId status:(PPRuleStatus)status name:(NSString *)name userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(ruleId != PPRuleIdNone, @"%s missing ruleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rules/%li/attrs?", (long)ruleId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"rule\": {"];
    
    BOOL appendComma = NO;
    
    if(status != PPRuleStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\": %li", (long)status];
        appendComma = YES;
    }
    
    if(name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\": \"%@\"", name];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.updateRuleAttribute()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)updateRuleAttribute:(PPRuleId)ruleId status:(PPRuleStatus)status name:(NSString *)name userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateRuleAttribute:locationId:status:name:userId:callback:", __FUNCTION__);
    [PPRules updateRuleAttribute:ruleId locationId:PPLocationIdNone status:status name:name userId:userId callback:callback];
}

#pragma mark - Update Rules Status

/**
 * Update a Rule Status.
 * Update status of all rules matching to selection criteria. The API returns ID's of updated rules.
 *
 * @param status Required PPRuleStatus New rules status
 * @param locationId Required PPLocationId Location ID
 * @param ruleIds NSArray Rule IDs to update.
 * @param deviceTypes NSArray Update rules containing devices of these types.
 * @param deviceIds NSArray Update rules containing these devices.
 * @param defaultRule PPRuleDefault If set, update only default or non-default rules.
 * @param hidden PPRuleHidden If set, update only hidden or non-hidden rules.
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesStatusBlock Status block containing list of effected rule Ids
 **/
+ (void)updateRuleStatus:(PPRuleStatus)status locationId:(PPLocationId)locationId ruleIds:(NSArray *)ruleIds deviceTypes:(NSArray *)deviceTypes deviceIds:(NSArray *)deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPRulesStatusBlock)callback {
    NSAssert1(status != PPRuleStatusNone, @"%s missing status", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(ruleIds != nil && [ruleIds count] > 0, @"%s missing ruleIds", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"rulesStatus/%li?", (long)status];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(ruleIds) {
        [requestString appendFormat:@"ruleId=%@&", [ruleIds componentsJoinedByString:@"&ruleId="]];
    }
    if(deviceTypes) {
        [requestString appendFormat:@"deviceType=%@&", [ruleIds componentsJoinedByString:@"&deviceType="]];
    }
    if(deviceIds) {
        for(NSString *deviceId in deviceIds) {
            [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
        }
    }
    if(defaultRule != PPRuleDefaultNone) {
        [requestString appendFormat:@"default=%@&", (defaultRule) ? @"true" : @"false"];
    }
    if(hidden != PPRuleHiddenNone) {
        [requestString appendFormat:@"hidden=%@&", (hidden) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.updateRuleStatus()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *ruleIds;
            
            if(!error) {
                ruleIds = [root objectForKey:@"ruleIds"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ruleIds, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)updateRuleStatus:(PPRuleStatus)status ruleIds:(NSArray *)ruleIds deviceTypes:(NSArray *)deviceTypes deviceIds:(NSArray *)deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPRulesStatusBlock)callback {
    NSLog(@"%s deprecated. Use +updateRuleStatus:locationId:ruleIds:deviceTypes:deviceIds:defaultRule:hidden:userId:callback:", __FUNCTION__);
    [PPRules updateRuleStatus:status locationId:PPLocationIdNone ruleIds:ruleIds deviceTypes:deviceTypes deviceIds:deviceIds defaultRule:defaultRule hidden:hidden userId:userId callback:callback];
}
#pragma mark - Create default rules for a device

/**
 * Create default rules for a device.
 * Creates all the default rules, if they do not already exist, for an individual device or for all of the user's devices.
 *
 * @param deviceId NSArray Specific device ID to create default rules for
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createDefaultRulesForDevice:(PPLocationId)locationId deviceId:(NSString *)deviceId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"rulesCreateDefault?"];
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.rules.createDefaultRulesForDevice()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] POST:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
    });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)createDefaultRulesForDevice:(NSString *)deviceId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated, use +createDefaultRulesForDevice:deviceId:userId:callback:", __FUNCTION__);
    [PPRules createDefaultRulesForDevice:PPLocationIdNone deviceId:deviceId userId:userId callback:callback];
}
@end

