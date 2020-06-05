//
//  PPOrganizations.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOrganization.h"
#import "PPOrganizationGroup.h"
#import "PPUser.h"

typedef void (^PPOrganizationsBlock)(NSArray * _Nullable orgs, NSError * _Nullable error);
typedef void (^PPOrganizationsGroupsBlock)(NSArray * _Nullable groups, NSError * _Nullable error);
typedef void (^PPOrganizationsUpdateUserBlock)(PPOrganizationStatus status, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPOrganizationUserTotals) {
    PPOrganizationUserTotalsNone = -1,
    PPOrganizationUserTotalsFalse = 0,
    PPOrganizationUserTotalsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationAverageBills) {
    PPOrganizationAverageBillsNone = -1,
    PPOrganizationAverageBillsFalse = 0,
    PPOrganizationAverageBillsTrue = 1
};
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


@end

