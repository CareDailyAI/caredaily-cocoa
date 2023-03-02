//
//  PPDeviceTypes.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceType.h"
#import "PPDeviceTypeParameter.h"
#import "PPDeviceTypeRuleComponentTemplate.h"
#import "PPOrganization.h"
#import "PPRule.h"
#import "PPDeviceTypeInstallationInstructions.h"
#import "PPDeviceTypeDeviceModel.h"
#import "PPDeviceTypeDeviceModelCategory.h"
#import "PPDeviceTypeStory.h"
#import "PPDeviceTypeStoryPage.h"
#import "PPDeviceTypeMedia.h"

@interface PPDeviceTypes : PPBaseModel


#pragma mark - Session Management

#pragma mark Device types

/**
 * Shared deviceTypes across the entire application
 */
+ (NSArray *)sharedDeviceTypesForUser:(PPUserId)userId;

/**
 * Add deviceTypes.
 * Add deviceTypes to local reference.
 *
 * @param deviceTypes NSArray Array of deviceTypes to add.
 * @param userId Required PPUserId User Id to associate these device type attributes with
 **/
+ (void)addDeviceTypes:(NSArray *)deviceTypes userId:(PPUserId)userId;

/**
 * Remove deviceTypes.
 * Remove deviceTypes from local reference.
 *
 * @param deviceTypes NSArray Array of deviceTypes to remove.
 * @param userId Required PPUserId User Id to associate these device type attributes with
 **/
+ (void)removeDeviceTypes:(NSArray *)deviceTypes userId:(PPUserId)userId;

#pragma mark Device type Attributes

/**
 * Shared device type attribtues across the entire application
 */
+ (NSArray *)sharedDeviceTypeAttributesForUser:(PPUserId)userId;

/**
 * Add deviceTypeAttributes.
 * Add deviceTypeAttributes to local reference.
 *
 * @param deviceTypeAttributes NSArray Array of deviceTypeAttributes to add.
 * @param userId Required PPUserId User Id to associate these device types with
 **/
+ (void)addDeviceTypeAttributes:(NSArray *)deviceTypeAttributes userId:(PPUserId)userId;

/**
 * Remove deviceTypeAttributes.
 * Remove deviceTypeAttributes from local reference.
 *
 * @param deviceTypeAttributes NSArray Array of deviceTypeAttributes to remove.
 * @param userId Required PPUserId User Id to associate these device types with
 **/
+ (void)removeDeviceTypeAttributes:(NSArray *)deviceTypeAttributes userId:(PPUserId)userId;

#pragma mark Device type Parameters

/**
 * Shared deviceTypeParameters across the entire application
 */
+ (NSArray *)sharedDeviceTypeParametersForUser:(PPUserId)userId;

/**
 * Add deviceTypeParameters.
 * Add deviceTypeParameters to local reference.
 *
 * @param deviceTypeParameters NSArray Array of deviceTypeParameters to add.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)addDeviceTypeParameters:(NSArray *)deviceTypeParameters userId:(PPUserId)userId;

/**
 * Remove deviceTypeParameters.
 * Remove deviceTypeParameters from local reference.
 *
 * @param deviceTypeParameters NSArray Array of deviceTypeParameters to remove.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)removeDeviceTypeParameters:(NSArray *)deviceTypeParameters userId:(PPUserId)userId;

#pragma mark Device type Rule Component Templates

/**
 * Shared deviceTypeRuleComponentTemplates across the entire application
 */
+ (NSArray *)sharedDeviceTypeRuleComponentTemplatesForUser:(PPUserId)userId;

/**
 * Add deviceTypeRuleComponentTemplates.
 * Add deviceTypeRuleComponentTemplates to local reference.
 *
 * @param deviceTypeRuleComponentTemplates NSArray Array of deviceTypeRuleComponentTemplates to add.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)addDeviceTypeRuleComponentTemplates:(NSArray *)deviceTypeRuleComponentTemplates userId:(PPUserId)userId;

/**
 * Remove deviceTypeRuleComponentTemplates.
 * Remove deviceTypeRuleComponentTemplates from local reference.
 *
 * @param deviceTypeRuleComponentTemplates NSArray Array of deviceTypeRuleComponentTemplates to remove.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)removeDeviceTypeRuleComponentTemplates:(NSArray *)deviceTypeRuleComponentTemplates userId:(PPUserId)userId;

#pragma mark Device type Goals

/**
 * Shared deviceTypeGoals across the entire application
 */
+ (NSArray *)sharedDeviceTypeGoalsForUser:(PPUserId)userId;

/**
 * Add deviceTypeGoals.
 * Add deviceTypeGoals to local reference.
 *
 * @param deviceTypeGoals NSArray Array of deviceTypeGoals to add.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)addDeviceTypeGoals:(NSArray *)deviceTypeGoals userId:(PPUserId)userId;

/**
 * Remove deviceTypeGoals.
 * Remove deviceTypeGoals from local reference.
 *
 * @param deviceTypeGoals NSArray Array of deviceTypeGoals to remove.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)removeDeviceTypeGoals:(NSArray *)deviceTypeGoals userId:(PPUserId)userId;

#pragma mark Device type installation instructions

/**
 * Shared deviceTypeInstallationInstructions across the entire application
 */
+ (NSArray *)sharedDeviceTypeInstallationInstructionsForUser:(PPUserId)userId;

/**
 * Add deviceTypeInstallationInstructions.
 * Add deviceTypeInstallationInstructions to local reference.
 *
 * @param deviceTypeInstallationInstructions NSArray Array of deviceTypeInstallationInstructions to add.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)addDeviceTypeInstallationInstructions:(NSArray *)deviceTypeInstallationInstructions userId:(PPUserId)userId;

/**
 * Remove deviceTypeInstallationInstructions.
 * Remove deviceTypeInstallationInstructions from local reference.
 *
 * @param deviceTypeInstallationInstructions NSArray Array of deviceTypeInstallationInstructions to remove.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)removeDeviceTypeInstallationInstructions:(NSArray *)deviceTypeInstallationInstructions userId:(PPUserId)userId;

#pragma mark Device type Media

/**
 * Shared device type media across the entire application
 */
+ (NSArray *)sharedDeviceTypeMediaForUser:(PPUserId)userId;

/**
 * Add device type media.
 * Add device type media to local reference.
 *
 * @param deviceTypeMedia NSArray Array of deviceTypeMedia to add.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)addDeviceTypeMedia:(NSArray *)deviceTypeMedia userId:(PPUserId)userId;

/**
 * Remove device type media.
 * Remove device type media from local reference.
 *
 * @param deviceTypeMedia NSArray Array of deviceTypeMedia to remove.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)removeDeviceTypeMedia:(NSArray *)deviceTypeMedia userId:(PPUserId)userId;

#pragma mark Device type model categories

/**
 * Shared device type model categories across the entire application
 */
+ (NSArray *)sharedDeviceTypeModelCategoriesForUser:(PPUserId)userId;

/**
 * Add device type model categories.
 * Add device type model categories to local reference.
 *
 * @param deviceTypeModels NSArray Array of deviceTypeModels to add.
 * @param userId Required PPUserId User Id to associate these device type models with
 **/
+ (void)addDeviceTypeModelCategories:(NSArray *)deviceTypeModels userId:(PPUserId)userId;

/**
 * Remove device type model categories.
 * Remove device type model categories from local reference.
 *
 * @param deviceTypeModelCategories NSArray Array of deviceTypeModelCategories to remove.
 * @param userId Required PPUserId User Id to associate these device type models with
 **/
+ (void)removeDeviceTypeModelCategories:(NSArray *)deviceTypeModelCategories userId:(PPUserId)userId;

#pragma mark Device type Stories

/**
 * Shared deviceTypeStories across the entire application
 */
+ (NSArray *)sharedDeviceTypeStoriesForUser:(PPUserId)userId;

/**
 * Add deviceType Stories.
 * Add deviceType Stories to local reference.
 *
 * @param deviceTypeStories NSArray Array of deviceTypeStories to add.
 * @param userId Required PPUserId User Id to associate these device type Stories with
 **/
+ (void)addDeviceTypeStories:(NSArray *)deviceTypeStories userId:(PPUserId)userId;

/**
 * Remove deviceType Stories.
 * Remove deviceType Stories from local reference.
 *
 * @param deviceTypeStories NSArray Array of deviceTypeStories to remove.
 * @param userId Required PPUserId User Id to associate these device type Stories with
 **/
+ (void)removeDeviceTypeStories:(NSArray *)deviceTypeStories userId:(PPUserId)userId;

#pragma mark - Supported Products

/**
 * Get supported products.
 * Product attributes are documented in the Supported Product Attributes API call.
 *
 * @param deviceTypeId PPDeviceTypeId Specific device type to look up details on
 * @param attrName NSString Return device types, which have an attribute with this name
 * @param attrValue NSString Also filter the response by the attribute value
 * @param own Boolean PPDeviceTypesOwn only products created by this user
 * @param simple Simple Return only product fields without user and attributes information
 * @param organizationId PPOrganizationId Return only device types related to the specific organization
 * @param callback PPDeviceTypesBlock Device types callback block
 **/
+ (void)getSupportedProducts:(PPDeviceTypeId)deviceTypeId attrName:(NSString * _Nullable )attrName attrValue:(NSString * _Nullable )attrValue own:(PPDeviceTypesOwn)own simple:(PPDeviceTypesSimple)simple organizationId:(PPOrganizationId)organizationId callback:(PPDeviceTypesBlock _Nonnull )callback;

#pragma mark - Supported Product Attribtues

/**
 * Get supported product attributes.
 * Each product can have a set of attributes associated with it, to optimize its performance on the IoT Software Suite. This API will provide access to every supported attribute and attribute values.
 *
 * @param callback PPDeviceTypeAttributesBlock Attributes callback block
 **/
+ (void)getSupportedProductAttributes:(PPDeviceTypeAttributesBlock _Nonnull )callback;

#pragma mark - Create a Product

/**
 * Creat a Product.
 * Each product / "device type" is created with a default name and a set of attributes to define the behavior of the product. See the Product Attributes API for more details on available attributes. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @param deviceType required PPDeviceType Device type to create
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createProduct:(PPDeviceType * _Nonnull )deviceType callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Update a Product

/**
 * Update a Product.
 * You must be the owner of the product in order to update it. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @param deviceTypeId required PPDeviceTypeId The product ID / device type ID to update
 * @param deviceType required PPDeviceType Device type to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateProduct:(PPDeviceTypeId)deviceTypeId deviceType:(PPDeviceType * _Nonnull )deviceType callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Manage Parameters

/**
 * Get Parameters.
 *
 * @param name NSString Get a specific parameter name (no spaces)
 * @param callback PPDeviceTypeDeviceParamsBlock Device params callback block
 **/
+ (void)getParameters:(NSString * _Nullable )name callback:(PPDeviceTypeDeviceParamsBlock _Nonnull )callback;

/**
 * Create and Update a Parameter.
 * A normal developer can update only their own parameters. A system administrator can edit any parameter.
 *
 * @param deviceTypeParameter required PPDeviceTypeParameter Parameter to create or update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createAndUpdateParameter:(PPDeviceTypeParameter * _Nonnull )deviceTypeParameter callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Delete a Parameter

/**
 * Delete a parameter.
 * A normal developer can delete only their own parameters. A system administrator can delete any parameter.
 *
 * @param parameterName required NSString Name of your parameter to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteParameter:(NSString * _Nonnull )parameterName callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Manage Rule Phrases

/**
 * Get existing rule phrases
 *
 * @param callback PPDeviceTypeRulePhrasesBlock Rule phrases callback block
 **/
+ (void)getExistingRulePhrases:(PPDeviceTypeRulePhrasesBlock _Nonnull )callback;

/**
 * Create a Rule Phrase.
 *
 * @param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to create
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)createRulePhrase:(PPDeviceTypeRuleComponentTemplate * _Nonnull )rulePhrase callback:(PPDeviceTypeRulePhraseBlock _Nonnull )callback;

#pragma mark - Rule Phrase

/**
 * Get the rule phrase by ID.
 *
 * @param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)getRulePhraseById:(PPDeviceTypeRuleComponentTemplateId)templateId callback:(PPDeviceTypeRulePhraseBlock _Nonnull )callback;

/**
 * Update Rule Phrase.
 *
 * @param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to update
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)updateRulePhrase:(PPDeviceTypeRuleComponentTemplateId)templateId rulePhrase:(PPDeviceTypeRuleComponentTemplate * _Nonnull )rulePhrase callback:(PPDeviceTypeRulePhraseBlock _Nonnull )callback;

/**
 * Delete Rule Phrase.
 *
 * @param templateId Required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRulePhrase:(PPDeviceTypeRuleComponentTemplateId)templateId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Default Rules

/**
 * Get product default rules.
 * This API will allow you to get default rules by device type ID. You must be the owner of the product in order to retrieve them.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param details PPDeviceTypesDetails True - Return details for these rules, including all the triggers, states, and actions that compose the rule. False - Only return the high level information about the rule, including the id, description text, on/off status, whether the rule is a default rule, and whether the rule is hidden and not editable, default
 * @param callback PPDeviceTypeDefaultRulesBlock Default rules callback block
 **/
+ (void)getProductDefaultRules:(PPDeviceTypeId)deviceTypeId details:(PPDeviceTypesDetails)details callback:(PPDeviceTypeDefaultRulesBlock _Nonnull )callback;

#pragma mark - Manage default rules

/**
 * Add default rule.
 * Assign a rule as default for a specific product. When a user register a new device of this type, the system will automatically create a new rule based on this default rule.
 * You must be the owner of the product and the rule. The rule cannot be deleted after that.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param ruleId Required PPRuleId The rule ID
 * @param hidden PPRuleHidden Hidden status for default rule
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addDefaultRule:(PPDeviceTypeId)deviceTypeId ruleId:(PPRuleId)ruleId hidden:(PPRuleHidden)hidden callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete default rule.
 * Delete an association of the default rule and the specific product. You must be the owner of the product and the rule.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param ruleId Required PPRuleId The rule ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDefaultRule:(PPDeviceTypeId)deviceTypeId ruleId:(PPRuleId)ruleId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Device goals

/**
 * Get device goals by type.
 * Retrieve device goals by device type.
 *
 * @param deviceTypeId Required PPDeviceTypeId The device type ID
 * @param appName NSString Specific app name
 * @param callback PPDeviceTypeGoalsBlock Goals callback block
 **/
+ (void)getDeviceGoalsByType:(PPDeviceTypeId)deviceTypeId appName:(NSString * _Nullable )appName callback:(PPDeviceTypeGoalsBlock _Nonnull )callback;

#pragma mark - Device goal installation instructions

/**
 * Get installation instructions.
 * Device installation instructions by goal ID.
 *
 * @param goalId Required PPDeviceTypeGoalId The device goal ID
 * @param callback PPDeviceTypeInstallationInstructionsBlock Installation instructions callback block
 **/
+ (void)getInstallationInstructions:(PPDeviceTypeGoalId)goalId callback:(PPDeviceTypeInstallationInstructionsBlock _Nonnull )callback;

#pragma mark - Media

/**
 * Get media.
 * Get available medias.
 *
 * @param mediaId NSString Search by ID
 * @param callback PPDeviceTypeMediaBlock Media callback block
 **/
+ (void)getMedia:(NSString * _Nullable )mediaId callback:(PPDeviceTypeMediaBlock _Nonnull )callback;

/**
 * Put media.
 * Put multiple medias.
 *
 * @param medias Required NSArray Media objects to be uploaded
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putMedias:(NSArray * _Nonnull )medias callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete media.
 * Delete media. A media record can be deleted only, if it is not used in any device model description or story.
 *
 * @param medias NSArray Media to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteMedias:(NSArray * _Nonnull )medias callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Device models

/**
 * Get device models.
 * The API returns device categories and models for specific brand.
 *
 * @param brand NSString Get text data for specific brand, otherwise data for default brand returned.
 * @param lang NSString Get text data for specific languages (support for multiple values), otherwise data for all languages returned.
 * @param hidden PPDeviceTypeDeviceModelHidden Request hidden categories and brand, which are not returned by default.
 * @param searchBy NSString Search criterion
 * @param includePairingType PPDeviceTypeDeviceModelPairingType Filter models by pairing type bitmask.
 * @param excludePairingType PPDeviceTypeDeviceModelPairingType Exclude models by pairing type bitmask.
 * @param modelId NSString Return single model
 * @param callback PPDeviceTypeDeviceModelsBlock Device Models callback block
 **/
+ (void)getDeviceModels:(NSString * _Nullable )brand lang:(NSString * _Nullable )lang hidden:(PPDeviceTypeDeviceModelHidden)hidden searchBy:(NSString * _Nullable )searchBy includingPairingType:(PPDeviceTypeDeviceModelPairingType)includePairingType excludePairingType:(PPDeviceTypeDeviceModelPairingType)excludePairingType modelId:(NSString * _Nullable )modelId callback:(PPDeviceTypeDeviceModelsBlock _Nonnull )callback;
+ (void)getDeviceModels:(NSString * _Nullable )brand lang:(NSString * _Nullable )lang hidden:(PPDeviceTypeDeviceModelHidden)hidden searchBy:(NSString * _Nullable )searchBy callback:(PPDeviceTypeDeviceModelsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Upload device models.
 * Upload a catalog of device models and categories.
 * Data can be updated only for specific brand(s), while other brands data will not be affected.
 *
 * @param categories NSArray Categories to upload
 * @param models NSArray Models to upload
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadDeviceModels:(NSArray * _Nonnull )categories models:(NSArray * _Nonnull )models callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete device models
 * Delete data for specific device model, category and brand.
 * Either modelId or categoryId parameters are mandatory.
 *
 * @param modelId NSString Remove data for specific device model
 * @param categoryId NSString Remove data for specific cateogry
 * @param brand NSString Remove model or category only to this brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDeviceModels:(NSString * _Nullable )modelId categoryId:(NSString * _Nullable )categoryId brand:(NSString * _Nullable )brand callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Stories

/**
 * Put stories
 * Insert new stories or update existing stories.
 *
 * @param stories NSArray Story objects to update or create
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putStories:(NSArray * _Nonnull )stories callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get stories.
 *
 * @param storyId NSString Get specific story by ID
 * @param modelId NSString Filter stories by device model
 * @param brand NSString Filter stories by brand
 * @param storyType PPDeviceTypeStoryType Filter stories by type
 * @param searchBy NSString Search criterion
 * @param hidden PPDeviceTypeStoryPageHidden Request hidden pages, which are not returned by default.
 * @param lang NSString Get stories for specific language, otherwise stories for all languages returned.
 * @param callback PPDeviceTypeStoriesBlock Stories callback block
 **/
+ (void)getStories:(NSString * _Nullable )storyId modelId:(NSString * _Nullable )modelId brand:(NSString * _Nullable )brand storyType:(PPDeviceTypeStoryType)storyType searchBy:(NSString * _Nullable )searchBy hidden:(PPDeviceTypeStoryPageHidden)hidden lang:(NSString * _Nullable )lang callback:(PPDeviceTypeStoriesBlock _Nonnull )callback;

/**
 * Delete story
 * Delete an existing story.
 *
 * @param storyId NSString Story ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteStory:(NSString * _Nonnull )storyId callback:(PPErrorBlock _Nonnull )callback;

@end
