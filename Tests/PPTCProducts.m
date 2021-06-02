//
//  PPTCProducts.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDeviceTypes.h>

static NSString *moduleName = @"Products";

@interface PPTCProducts : PPBaseTestCase

@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) PPDeviceType *deviceType;
@property (strong, nonatomic) PPDeviceTypeParameter *parameter;
@property (strong, nonatomic) PPDeviceTypeRuleComponentTemplate *ruleTemplate;
@property (strong, nonatomic) PPRule *rule;
@property (strong, nonatomic) PPDeviceTypeGoal *goal;
@property (strong, nonatomic) PPDeviceTypeMedia *media;
@property (strong, nonatomic) PPDeviceTypeDeviceModel *model;
@property (strong, nonatomic) PPDeviceTypeDeviceModelCategory *category;
@property (strong, nonatomic) PPDeviceTypeStory *story;

@end

@implementation PPTCProducts

- (void)setUp {
    [super setUp];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *deviceTypeDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_DEVICE_TYPE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *parameterDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_PARAMETER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *templateDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_RULE_PHRASE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *ruleDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_RULES_RULE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *goalDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_RULES_GOAL filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *mediaDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_MEDIA filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *modelDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_MODEL filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *categoryDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_CATEGORY filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *storyDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PRODUCTS_STORY filename:PLIST_FILE_UNIT_TESTS];
    
    self.appName = appName;
    self.deviceType = [PPDeviceType initWithDictionary:deviceTypeDict];
    self.parameter = [PPDeviceTypeParameter initWithDictionary:parameterDict];
    self.ruleTemplate = [PPDeviceTypeRuleComponentTemplate initWithDictionary:templateDict];
    self.rule = [PPRule initWithDictionary:ruleDict];
    self.goal = [PPDeviceTypeGoal initWithDictionary:goalDict];
    self.media = [PPDeviceTypeMedia initWithDictionary:mediaDict];
    self.model = [PPDeviceTypeDeviceModel initWithDictionary:modelDict];
    self.category = [PPDeviceTypeDeviceModelCategory initWithDictionary:categoryDict];
    self.story = [PPDeviceTypeStory initWithDictionary:storyDict];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Supported Products

/**
 * Get supported products.
 * Product attributes are documented in the Supported Product Attributes API call.
 *
 * @ param deviceTypeId PPDeviceTypeId Specific device type to look up details on
 * @ param attrName NSString Return device types, which have an attribute with this name
 * @ param attrValue NSString Also filter the response by the attribute value
 * @ param own Boolean PPDeviceTypesOwn only products created by this user
 * @ param simple Simple Return only product fields without user and attributes information
 * @ param organizationId PPOrganizationId Return only device types related to the specific organization
 * @ param callback PPDeviceTypesBlock Device types callback block
 **/
- (void)testGetSupportedProducts {
    NSString *methodName = @"GetSupportedProducts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/deviceTypes" statusCode:200 headers:nil];
    
    [PPDeviceTypes getSupportedProducts:PPDeviceTypeIdNone attrName:nil attrValue:nil own:PPDeviceTypesOwnNone simple:PPDeviceTypesSimpleNone organizationId:PPOrganizationIdNone callback:^(NSArray *deviceTypes, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Supported Product Attribtues

/**
 * Get supported product attributes.
 * Each product can have a set of attributes associated with it, to optimize its performance on the IoT Software Suite. This API will provide access to every supported attribute and attribute values.
 *
 * @ param callback PPDeviceTypeAttributesBlock Attributes callback block
 **/
- (void)testGetSupportedProductAttributes {
    NSString *methodName = @"GetSupportedProductAttributes";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/deviceTypeAttrs" statusCode:200 headers:nil];
    
    [PPDeviceTypes getSupportedProductAttributes:^(NSArray *deviceTypeAttributes, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Create a Product

/**
 * Creat a Product.
 * Each product / "device type" is created with a default name and a set of attributes to define the behavior of the product. See the Product Attributes API for more details on available attributes. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @ param deviceType required PPDeviceType Device type to create
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testCreateProduct {
    NSString *methodName = @"CreateProduct";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/deviceType" statusCode:200 headers:nil];
    
    [PPDeviceTypes createProduct:self.deviceType callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}
#pragma mark - Update a Product

/**
 * Update a Product.
 * You must be the owner of the product in order to update it. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @ param deviceTypeId required PPDeviceTypeId The product ID / device type ID to update
 * @ param deviceType required PPDeviceType Device type to update
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateProduct {
    NSString *methodName = @"UpdateProduct";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceType/%@", @(self.deviceType.typeId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes updateProduct:self.deviceType.typeId deviceType:self.deviceType callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage Parameters

/**
 * Get Parameters.
 *
 * @ param name NSString Get a specific parameter name (no spaces)
 * @ param callback PPDeviceTypeDeviceParamsBlock Device params callback block
 **/
- (void)testGetParameters {
    NSString *methodName = @"GetParameters";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/deviceParameters" statusCode:200 headers:nil];
    
    [PPDeviceTypes getParameters:nil callback:^(NSArray *deviceParams, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Create and Update a Parameter.
 * A normal developer can update only their own parameters. A system administrator can edit any parameter.
 *
 * @ param deviceTypeParameter required PPDeviceTypeParameter Parameter to create or update
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testCreateAndUpdateParameter {
    NSString *methodName = @"CreateAndUpdateParameter";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/deviceParameters" statusCode:200 headers:nil];
    
    [PPDeviceTypes createAndUpdateParameter:self.parameter callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Delete a Parameter

/**
 * Delete a parameter.
 * A normal developer can delete only their own parameters. A system administrator can delete any parameter.
 *
 * @ param parameterName required NSString Name of your parameter to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteParameter {
    NSString *methodName = @"DeleteParameter";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceParameters/%@", self.parameter.name] statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteParameter:self.parameter.name callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage Rule Phrases

/**
 * Get existing rule phrases
 *
 * @ param callback PPDeviceTypeRulePhrasesBlock Rule phrases callback block
 **/
- (void)testGetExistingRulePhrases {
    NSString *methodName = @"GetExistingRulePhrases";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/ruleTemplates" statusCode:200 headers:nil];
    
    [PPDeviceTypes getExistingRulePhrases:^(NSArray *ruleTemplates, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Create a Rule Phrase.
 *
 * @ param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to create
 * @ param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
- (void)testCreateRulePhrase {
    NSString *methodName = @"CreateRulePhrase";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/ruleTemplates" statusCode:200 headers:nil];
    
    [PPDeviceTypes createRulePhrase:self.ruleTemplate callback:^(PPDeviceTypeRuleComponentTemplate *ruleTemplate, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Rule Phrase

/**
 * Get the rule phrase by ID.
 *
 * @ param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID
 * @ param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
- (void)testGetRulePhraseById {
    NSString *methodName = @"GetRulePhraseById";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/ruleTemplates/%@", @(self.ruleTemplate.templateId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes getRulePhraseById:self.ruleTemplate.templateId callback:^(PPDeviceTypeRuleComponentTemplate *ruleTemplate, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Update Rule Phrase.
 *
 * @ param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @ param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to update
 * @ param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
- (void)testUpdateRulePhrase {
    NSString *methodName = @"UpdateRulePhrase";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/ruleTemplates/%@", @(self.ruleTemplate.templateId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes updateRulePhrase:self.ruleTemplate.templateId rulePhrase:self.ruleTemplate callback:^(PPDeviceTypeRuleComponentTemplate *ruleTemplate, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete Rule Phrase.
 *
 * @ param templateId Required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteRulePhrase {
    NSString *methodName = @"DeleteRulePhrase";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/ruleTemplates/%@", @(self.ruleTemplate.templateId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteRulePhrase:self.ruleTemplate.templateId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Default Rules

/**
 * Get product default rules.
 * This API will allow you to get default rules by device type ID. You must be the owner of the product in order to retrieve them.
 *
 * @ param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @ param details PPDeviceTypesDetails True - Return details for these rules, including all the triggers, states, and actions that compose the rule. False - Only return the high level information about the rule, including the id, description text, on/off status, whether the rule is a default rule, and whether the rule is hidden and not editable, default
 * @ param callback PPDeviceTypeDefaultRulesBlock Default rules callback block
 **/
- (void)testGetProductDefaultRules {
    NSString *methodName = @"GetProductDefaultRules";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceType/%@/rules", @(self.deviceType.typeId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes getProductDefaultRules:self.deviceType.typeId details:PPDeviceTypesDetailsNone callback:^(NSArray *rules, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage default rules

/**
 * Add default rule.
 * Assign a rule as default for a specific product. When a user register a new device of this type, the system will automatically create a new rule based on this default rule.
 * You must be the owner of the product and the rule. The rule cannot be deleted after that.
 *
 * @ param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @ param ruleId Required PPRuleId The rule ID
 * @ param hidden PPRuleHidden Hidden status for default rule
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testAddDefaultRule {
    NSString *methodName = @"AddDefaultRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceType/%@/rules/%@", @(self.deviceType.typeId), @(self.rule.ruleId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes addDefaultRule:self.deviceType.typeId ruleId:self.rule.ruleId hidden:PPRuleHiddenNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete default rule.
 * Delete an association of the default rule and the specific product. You must be the owner of the product and the rule.
 *
 * @ param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @ param ruleId Required PPRuleId The rule ID
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteDefaultRule {
    NSString *methodName = @"DeleteDefaultRule";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceType/%@/rules/%@", @(self.deviceType.typeId), @(self.rule.ruleId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteDefaultRule:self.deviceType.typeId ruleId:self.rule.ruleId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Device goals

/**
 * Get device goals by type.
 * Retrieve device goals by device type.
 *
 * @ param deviceTypeId Required PPDeviceTypeId The device type ID
 * @ param appName NSString Specific app name
 * @ param callback PPDeviceTypeGoalsBlock Goals callback block
 **/
- (void)testGetDeviceGoalsByType {
    NSString *methodName = @"GetDeviceGoalsByType";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/deviceTypes/%@/goals", @(self.deviceType.typeId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes getDeviceGoalsByType:self.deviceType.typeId appName:self.appName callback:^(NSArray *goals, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Device goal installation instructions

/**
 * Get installation instructions.
 * Device installation instructions by goal ID.
 *
 * @ param goalId Required PPDeviceTypeGoalId The device goal ID
 * @ param callback PPDeviceTypeInstallationInstructionsBlock Installation instructions callback block
 **/
- (void)testGetInstallationInstructions {
    NSString *methodName = @"GetInstallationInstructions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/goals/%@/installation", @(self.goal.goalId)] statusCode:200 headers:nil];
    
    [PPDeviceTypes getInstallationInstructions:self.goal.goalId callback:^(PPDeviceTypeInstallationInstructions *installationInstructions, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Media

/**
 * Get media.
 * Get available medias.
 *
 * @ param mediaId NSString Search by ID
 * @ param callback PPDeviceTypeMediaBlock Media callback block
 **/
- (void)testGetMedia {
    NSString *methodName = @"GetMedia";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/media" statusCode:200 headers:nil];
    
    [PPDeviceTypes getMedia:nil callback:^(NSArray *medias, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Put media.
 * Put multiple medias.
 *
 * @ param medias Required NSArray Media objects to be uploaded
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testPutMedia {
    NSString *methodName = @"PutMedia";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/media" statusCode:200 headers:nil];
    
    [PPDeviceTypes putMedias:@[self.media] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete media.
 * Delete media. A media record can be deleted only, if it is not used in any device model description or story.
 *
 * @ param medias NSArray Media to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteMedia {
    NSString *methodName = @"DeleteMedia";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/media" statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteMedias:@[self.media] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Device models

/**
 * Get device models.
 * The API returns device categories and models for specific brand.
 *
 * @ param brand NSString Get text data for specific brand, otherwise data for default brand returned.
 * @ param lang NSString Get text data for specific languages (support for multiple values), otherwise data for all languages returned.
 * @ param hidden PPDeviceTypeDeviceModelHidden Request hidden categories and brand, which are not returned by default.
 * @ param searchBy NSString Search criterion
 * @ param includePairingType PPDeviceTypeDeviceModelPairingType Filter models by pairing type bitmask.
 * @ param excludePairingType PPDeviceTypeDeviceModelPairingType Exclude models by pairing type bitmask.
 * @ param modelId NSString Return single model
 * @ param callback PPDeviceTypeDeviceModelsBlock Device Models callback block
 **/
- (void)testGetDeviceModels {
    NSString *methodName = @"GetDeviceModels";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/devicemodels" statusCode:200 headers:nil];
    
    [PPDeviceTypes getDeviceModels:nil lang:nil hidden:PPDeviceTypeDeviceModelHiddenNone searchBy:nil includingPairingType:PPDeviceTypeDeviceModelPairingTypeNone excludePairingType:PPDeviceTypeDeviceModelPairingTypeNone modelId:nil callback:^(NSArray *categories, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Upload device models.
 * Upload a catalog of device models and categories.
 * Data can be updated only for specific brand(s), while other brands data will not be affected.
 *
 * @ param categories NSArray Categories to upload
 * @ param models NSArray Models to upload
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUploadDeviceModels {
    NSString *methodName = @"UploadDeviceModels";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/devicemodels" statusCode:200 headers:nil];
    
    [PPDeviceTypes uploadDeviceModels:@[self.category] models:@[self.model] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete device models
 * Delete data for specific device model, category and brand.
 * Either modelId or categoryId parameters are mandatory.
 *
 * @ param modelId NSString Remove data for specific device model
 * @ param categoryId NSString Remove data for specific cateogry
 * @ param brand NSString Remove model or category only to this brand
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteDeviceModels {
    NSString *methodName = @"DeleteDeviceModels";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/devicemodels" statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteDeviceModels:self.model.modelId categoryId:nil brand:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Stories

/**
 * Put stories
 * Insert new stories or update existing stories.
 *
 * @ param stories NSArray Story objects to update or create
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testPutStories {
    NSString *methodName = @"PutStories";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/stories" statusCode:200 headers:nil];
    
    [PPDeviceTypes putStories:@[self.story] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Get stories.
 *
 * @ param storyId NSString Get specific story by ID
 * @ param modelId NSString Filter stories by device model
 * @ param brand NSString Filter stories by brand
 * @ param storyType PPDeviceTypeStoryType Filter stories by type
 * @ param searchBy NSString Search criterion
 * @ param hidden PPDeviceTypeStoryPageHidden Request hidden pages, which are not returned by default.
 * @ param lang NSString Get stories for specific language, otherwise stories for all languages returned.
 * @ param callback PPDeviceTypeStoriesBlock Stories callback block
 **/
- (void)testGetStories {
    NSString *methodName = @"GetStories";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/stories" statusCode:200 headers:nil];
    
    [PPDeviceTypes getStories:nil modelId:nil brand:nil storyType:PPDeviceTypeStoryTypeNone searchBy:nil hidden:PPDeviceTypeStoryPageHiddenNone lang:nil callback:^(NSArray *stories, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete story
 * Delete an existing story.
 *
 * @ param storyId NSString Story ID to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteStory {
    NSString *methodName = @"DeleteStory";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/stories" statusCode:200 headers:nil];
    
    [PPDeviceTypes deleteStory:self.story.storyId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}
@end
