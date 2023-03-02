//
//  PPOrganizations.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOrganization.h"
#import "PPOrganizationGroup.h"
#import "PPOrganizationObject.h"

@interface PPOrganizations : PPBaseModel

@property (nonatomic, strong) NSArray *organizations;

/**
 * Shared organizations across the entire application
 */
+ (PPOrganizations *)sharedOrganizations;

- (id)initWithOrganizations:(NSArray *)organizations;

/**
 * Get Organizations
 * Retrieve all organizations that match the given criteria
 *
 * @param organizationId PPOrganizationId Search field - Specific organization ID  to get information about
 * @param domainName NSString Search field - Exact domain name
 * @param name NSString Search field - First characters of organization name
 * @param callback PPOrganizationsBlock Array of available organizations
 **/
+ (void)getOrganizations:(PPOrganizationId)organizationId domainName:(NSString * _Nullable )domainName name:(NSString * _Nullable )name callback:(PPOrganizationsBlock _Nonnull )callback;

/**
 * Get Organization groups.
 * Retrieve all organization groups that match the given criteria
 *
 * @param organizationId Required PPOrganizationId Organization ID or domain name
 * @param groupId PPOrganizationGroupId Search field - Group ID
 * @param name NSString Search field - First characters of group name
 * @param type PPOrganizationGroupType Search field - Group type
 * @param userTotals PPOrganizationUserTotals Request approved, applied and rejected group users
 * @param averageBills PPOrganizationAverageBills Request average monthly energy bill information (for specific group ID)
 * @param billsStartDate NSDate Monthly bill selected start date. By default it is the current date minus 400 days.
 * @param callback PPOrganizationGroupsBlock Array of available organization groups
 **/
+ (void)getGroups:(PPOrganizationId)organizationId groupId:(PPOrganizationGroupId)groupId name:(NSString * _Nullable )name type:(PPOrganizationGroupType)type userTotals:(PPOrganizationUserTotals)userTotals averageBills:(PPOrganizationAverageBills)averageBills billsStartDate:(NSDate * _Nullable )billsStartDate callback:(PPOrganizationsGroupsBlock _Nonnull )callback;

/**
 * Add or Update user
 *
 * @param organizationId Required PPOrganizationId Organization to join
 * @param groupId PPOrganizationGroupId Organization group to join
 * @param status PPOrganizationStatus New status for these users
 * @param userId PPUserId User Id to add or update
 * @param notes NSString Notes to include
 *
 * @param callback PPOrganizationsUpdateUserBlock Update users callback block
 */
+ (void)joinOrganization:(PPOrganizationId)organizationId groupId:(PPOrganizationGroupId)groupId status:(PPOrganizationStatus)status userId:(PPUserId)userId notes:(NSString * _Nullable )notes callback:(PPOrganizationsUpdateUserBlock _Nonnull )callback;

/**
 * List Objects and Properties
 * Retrieve all large objects and small properties by the organization. Anyone can call it.Private records are turned only for administrators.
 *
 * @param organizationId Required Organization ID
 *
 * @param callback PPOrganizationsObjectsAndPropertiesBlock Callback block
 */
+ (void)listObjectsAndProperties:(PPOrganizationId)organizationId callback:(PPOrganizationsObjectsAndPropertiesBlock _Nonnull )callback;

@end

