//
//  PPAdminUsersAndLocations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminUsersAndLocations : PPBaseModel {

    // MARK: - Users and Locations
    /**
     | Field | Type | Description |
     | ---- | ---- | ---- |
     | groupId | integer | Optional. Supply a non-zero group ID to add the user to that group. Use 0 to remove the user from the current group. |
     | notes | string | Notes on this user, available only to Organizational or System Administrators. |
     */

    // MARK: - Get Users

    /**
     Get Users
     Retrieve a list of users and their information based on the search criteria. System administrators can access all users, while Organization administrators can access users from within the organization they manage.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getUsers(_ organizationId: PPOrganizationId,
                                     groupId: PPOrganizationGroupId,
                                     locationId: PPLocationId,
                                     searchBy: String?,
                                     searchAddress: String?,
                                     servicePlanId: PPServicePlanId,
                                     searchTag: String?,
                                     limit: NSNumber?,
                                     getTags: NSNumber?,
                                     callback: @escaping (([PPUser]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getUsers()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    // MARK: - Locations in an Organization
    /**
     These API's allows to manage device locations withing an organization.Location fields are described in user account API's documentation http://docs.iotapps.apiary.io/#reference/user-accounts .
     */

    /**
     Get Locations
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getLocations(_ organizationId: PPOrganizationId,
                                         groupId: PPOrganizationGroupId,
                                         locationId: PPLocationId,
                                         tree: NSNumber?,
                                         searchBy: String?,
                                         locationType: NSNumber?,
                                         searchTags: [String]?,
                                         searchDeviceTags: [String]?,
                                         deviceTypes: [Int]?,
                                         servicePlanId: PPServicePlanId,
                                         stateId: PPStateId,
                                         countryId: PPCountryId,
                                         priorityCategory: NSNumber?,
                                         getTags: NSNumber?,
                                         limit: NSNumber?,
                                         callback: @escaping (([PPLocation]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getLocations()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    /**
     Create Location
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func createLocation(_ organizationId: PPOrganizationId,
                                           groupId: PPOrganizationGroupId,
                                           parentId: PPOrganizationGroupId,
                                           userId: PPUserId,
                                           location: PPLocation,
                                           callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.createLocation()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    /**
     Edit Location
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func editLocation(_ organizationId: PPOrganizationId,
                                         locationId: PPLocationId,
                                         callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.editLocation()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    /**
     Delete Location
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteLocation(_ organizationId: PPOrganizationId,
                                           locationId: PPLocationId,
                                           callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteLocation()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    // MARK: - Manage Locations

    /**
     Add or Update or Remove locations
     Batch API to manage locations in an organization.Locations will be added or moved to the organization automatically, if they are not there.To remove locations from a group set the groupId field to 0.To remove locations from the organization set the delete field to true.This API does not guaranty that the request will be performed for all locations. The error code may not be returned in this case.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func addOrUpdateOrRemoveLocations(_ organizationId: PPOrganizationId,
                                                         locationIds: [Int],
                                                         groupId: PPOrganizationGroupId,
                                                         notes: String?,
                                                         callback: @escaping (([PPLocationNarrative]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.addOrUpdateOrRemoveLocations()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    // MARK: - Narratives

    /**
     Get Organization Narratives
     Organization narratives for the specified organization and the child organizations.The search results are organized by "pages". Each page contains a set of elements sorted by the 'narrativeTime' in descending order. The pages follow one another in reverse chronological order.The rowCount parameter specifies the maximum number of elements per page. The result may include the "nextMarker" property - this means that there are more pages for the current search criteria. To get the next page, the value of "nextMarker" must be passed to the "pageMarker" parameter on the next API call.
    */
    @available(*, deprecated, message: "Not available")
    @objc public class func getOrganizationNarratives(_ organizationId: PPOrganizationId,
                                                      groupId: PPOrganizationGroupId,
                                                      searchTags: [String]?,
                                                      locationIds: [Int]?,
                                                      narrativeTime: NSNumber?,
                                                      narrativeId: PPLocationNarrativeId,
                                                      narrativeTypes: [Int]?,
                                                      priority: PPLocationNarrativePriority,
                                                      toPriority: PPLocationNarrativePriority,
                                                      status: NSNumber?,
                                                      searchBy: String?,
                                                      startDate: Date?,
                                                      endDate: Date?,
                                                      rowCount: Int,
                                                      pageMarker: String?,
                                                      callback: @escaping (([PPLocationNarrative]?, String?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getOrganizationNarratives()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, nil, resultCode(toNSError: 29))
    }

    // MARK: - Invite Users
    /**
     Invite users to the organization by email addresses or user ID's.
     */

    /**
     Post Invitation
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func postInvitiation(_ organizationId: PPOrganizationId,
                                            reinvite: NSNumber?,
                                            emails: [String]?,
                                            userIds: [Int]?,
                                            callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.postInvitiation()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    // MARK: - Groups of Locations
    /**
     Groups can only be created by an administrator.
     | Request | Description | Details |
     | ---- | ---- | ---- |
     | name | string | Name of the group |
     | type | integer | 0 - Residential; 1 - Business |
     | hidden |boolean |true - This group will be hidden to normal users.; false - Default. This group is visible to all users. |
     */

    /**
     Create a Group
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func createAGroup(_ organizationId: PPOrganizationId,
                                         groupType: PPOrganizationGroupType,
                                         hidden: Bool,
                                         name: String,
                                         callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.createAGroup()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    /**
     Get Groups
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getGroups(_ organizationId: PPOrganizationId,
                                      subOrg: NSNumber?,
                                      groupId: PPOrganizationGroupId,
                                      searchBy: String?,
                                      type: PPOrganizationGroupType,
                                      locationTotals: NSNumber?,
                                      callback: @escaping (([PPOrganizationGroup]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getGroups()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    // MARK: - Manage Groups

    /**
     Update a Group
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateAGroup(_ organizationId: PPOrganizationId,
                                         groupId: PPOrganizationGroupId,
                                         groupType: PPOrganizationGroupType,
                                         hidden: Bool,
                                         name: String,
                                         callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.updateAGroup()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    /**
     Delete a Group
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteAGroup(_ organizationId: PPOrganizationId,
                                         groupId: PPOrganizationGroupId,
                                         callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteAGroup()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

}
