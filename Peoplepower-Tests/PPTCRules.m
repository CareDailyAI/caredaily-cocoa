//
//  PPTCRules.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/20/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPRules.h>
#import <Peoplepower/PPAppResources.h>

static NSString *moduleName = @"Rules";

@interface PPTCRules : PPBaseTestCase

@property (strong, nonatomic) PPDevice *device;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPRule *rule;

@end

@implementation PPTCRules

- (void)setUp {
    [super setUp];
    
    NSDictionary *deviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *ruleDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_RULES_RULE filename:PLIST_FILE_UNIT_TESTS];
    
    self.device = [PPDevice initWithDictionary:deviceDict];
    self.location = [PPLocation initWithDictionary:locationDict];
    self.rule = [PPRule initWithDictionary:ruleDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Get Rule Components

/** Get Rule Components.
 *
 * @ param version PPRulesVersion Rules implementation version
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param callback PPRulesComponentsBlock Components callback block containing lists of triggers, states, and actions
 **/
- (void)testGetRuleComponents {
    NSString *methodName = @"GetRuleComponents";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/ruleConditions" statusCode:200 headers:nil];
    
    [PPRules getRuleComponents:self.location.locationId version:PPRulesVersionNone userId:PPUserIdNone callback:^(NSArray *triggers, NSArray *states, NSArray *actions, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Manage Rules

/**
 * Create a Rule.
 * When creating a rule, specify a single trigger, one or more states, and one or more actions, by referencing the ID's of the triggers / states / actions that are available to the user through the GET API.
 * States are OR'd together by default, unless wrapped in an AND block. This is to provide flexibility to the developer to implement, but we recommend only defining states inside AND blocks to keep the UI simple to understand.
 * If a trigger / state / action requires a parameter, the parameter must be filled out completely.
 * It is possible to save a rule that is not complete. The IoT Software Suite will not execute partial rules.
 *
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param rule PPRule Rule to save
 * @ param callback PPRulesCreationBlock Creation block containing rule reference (ID only)
 **/
- (void)testCreatRule {
    NSString *methodName = @"CreatRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/rules" statusCode:200 headers:nil];
    
    [PPRules createRule:self.location.locationId userId:PPUserIdNone rule:self.rule callback:^(PPRule *rule, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Rules.
 * This API will allow you to filter the list of rules by device ID as well.
 *
 * @ param deviceId NSString Only return rules for the given deviceId
 * @ param details PPRulesDetails Return rule details
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param callback PPRulesListBlock Rules callback block containing list of rules
 **/
- (void)testGetRules {
    NSString *methodName = @"GetRules";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/rules" statusCode:200 headers:nil];
    
    [PPRules getRules:self.location.locationId deviceId:nil details:PPRulesDetailsNone userId:PPUserIdNone callback:^(NSArray *rules, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete Rules by Criteria.
 * Delete all rules matching to selection criteria.
 *
 * @ param ruleIds NSArray Rule IDs to delete.
 * @ param status PPRuleStatus Rules status
 * @ param deviceTypes NSArray Delete rules containing devices of these types.
 * @ param deviceIds NSArray Delete rules containing these devices.
 * @ param defaultRule PPRuleDefault If set, delete only default or non-default rules.
 * @ param hidden PPRuleHidden If set, delete only hidden or non-hidden rules.
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteRulesByCriteria {
    NSString *methodName = @"DeleteRulesByCriteria";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/rules" statusCode:200 headers:nil];
    
    [PPRules deleteRulesByCriteria:self.location.locationId ruleIds:@[@(self.rule.ruleId)] status:PPRuleStatusNone deviceTypes:nil deviceIds:nil defaultRule:PPRuleDefaultNone hidden:PPRuleHiddenNone userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Manage a specific Rule

/**
 * Get a Rule
 *
 * @ param ruleId PPRuleId Rule ID to obtain
 * @ param details PPRulesDetails Return rule details
 * @ param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @ param callback PPRulesListBlock Rule callback block containing list of rules
 **/
- (void)testGetRule {
    NSString *methodName = @"GetRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/rules/%@", @(self.rule.ruleId)] statusCode:200 headers:nil];

    [PPRules getRule:self.rule.ruleId locationId:self.location.locationId details:PPRulesDetailsTrue userId:PPUserIdNone callback:^(NSArray *rules, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Update a Rule
 *
 * @ param rule PPRule Rule to update
 * @ param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateRule {
    NSString *methodName = @"UpdateRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/rules/%@", @(self.rule.ruleId)] statusCode:200 headers:nil];
    
    [PPRules updateRule:self.rule locationId:self.location.locationId userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a Rule
 *
 * @ param ruleId PPRuleId Rule ID to delete
 * @ param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteRule {
    NSString *methodName = @"DeleteRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/rules/%@", @(self.rule.ruleId)] statusCode:200 headers:nil];
    
    [PPRules deleteRule:self.rule.ruleId locationId:self.location.locationId userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Update a Rule Attribute

/**
 * Update a Rule Attribute.
 * Update the second name or status of the rule.
 *
 * @ param ruleId PPRuleId Rule ID to update
 * @ param status PPRuleStatus Rule's status
 * @ param name NSString Rule's name
 * @ param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateRuleAttribute {
    NSString *methodName = @"UpdateRuleAttribute";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/rules/%@/attrs", @(self.rule.ruleId)] statusCode:200 headers:nil];
        
    [PPRules updateRuleAttribute:self.rule.ruleId locationId:self.location.locationId status:PPRuleStatusNone name:nil userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}


#pragma mark - Update Rules Status

/**
 * Update a Rule Status.
 * Update status of all rules matching to selection criteria. The API returns ID's of updated rules.
 *
 * @ param status Required PPRuleStatus New rules status
 * @ param ruleIds NSArray Rule IDs to update.
 * @ param deviceTypes NSArray Update rules containing devices of these types.
 * @ param deviceIds NSArray Update rules containing these devices.
 * @ param defaultRule PPRuleDefault If set, update only default or non-default rules.
 * @ param hidden PPRuleHidden If set, update only hidden or non-hidden rules.
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param callback PPRulesStatusBlock Status block containing list of effected rule Ids
 **/
- (void)testUpdateRuleStatus {
    NSString *methodName = @"UpdateRuleStatus";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/rulesStatus/%@", @(PPRuleStatusActive)] statusCode:200 headers:nil];
    
    [PPRules updateRuleStatus:PPRuleStatusActive locationId:self.location.locationId ruleIds:@[@(self.rule.ruleId)] deviceTypes:nil deviceIds:nil defaultRule:PPRuleDefaultNone hidden:PPRuleHiddenNone userId:PPUserIdNone callback:^(NSArray *ruleIds, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}


#pragma mark - Create default rules for a device

/**
 * Create default rules for a device.
 * Creates all the default rules, if they do not already exist, for an individual device or for all of the user's devices.
 *
 * @ param deviceId NSArray Specific device ID to create default rules for
 * @ param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testCreateDefaultRulesForDevice {
    NSString *methodName = @"CreateDefaultRulesForDevice";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/rulesCreateDefault" statusCode:200 headers:nil];
    
    [PPRules createDefaultRulesForDevice:self.location.locationId deviceId:self.device.deviceId userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
