//
//  PPAdminOrganizations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminOrganizations : PPBaseModel {
    // MARK: - Organizations
    /**
     The IoT Software Suite is a role-based access control system.
     - A "System Administrator" is allowed access to manage the entire system.
     - An "Organization Administrator" can manage users within their own organization. They do not have access to users or data from other organizations.
     - A "User" can only manage and see their own account. If they belong to a group or organization, users can retrieve limited data about the organization to which they belong.
     */

    // MARK: - Manage an Organization
    /**
     Organizations can be created inside other organizations by users with "organization administrator" permission in the parent organization. Users with both "access all" and "organization administrator" permissions can create top level organizations.The following are optional fields to describe an organization:
     | Name | Type | Description |
     | ---- | ---- | ---- |
     | ID |integer | Unique organization ID |
     | name |string | Name of the organization |
     | domainName |string | Unique short name |
     | brand |string | Brand name |
     | parentId |integer | ID of the parent organization |
     | organizationAdmin |boolean | If the user is an administrator of this organization |
     | parentAdmin |boolean | If the user is an administrator of the parent organization |
     | organizationEditor |boolean | If the user can update this organization |
     | features |string | Available features for this organization: g - groups; m - messages; c - challenges |
     | deviceTypes | string | Types of devices managed in this organization |
     | termOfService | string | Terms of Service agreement signature ID |
     | contactName1 | string | Contact name 1 |
     | contactEmail1 | string | Contact email 1 |
     | contactPhone1 | string | Contact phone 1 |
     | contactName2 | string | Contact name 2 |
     | contactEmail2 | string | Contact email 2 |
     | contactPhone2 | string | Contact phone 2 |
     | officePhone | string | Office phone |
     | addrStreet1 | string | Street address 1 |
     | addrStreet2 | string | Street address 2 |
     | addrCity | string | City |
     | state | integer | State ID number, gathered from the Countries, states, and time zones API |
     | country | integer | Country ID number, gathered from the Countries, states, and time zones API |
     | zip | string | Zip / Postal Code |
     */

    /**
     Get Organizations
     Retrieve organizations information by administrator.
     */
    @objc public class func getOrganizations(_ callback: @escaping (([PPOrganization]?, Error?) -> (Void))) {
        let components = NSURLComponents(string: "organizations")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sgetOrganizations()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPOrganization]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["organizations"] as? [Dictionary<String, Any>] ?? [] {
                        guard let m = PPOrganization.initWith(d) else { continue }
                        models?.append(m)
                    }
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(models, err)
                }
            }
        } failure: { error in
            queue.async {
                callback(nil, error)
            }
        }
    }

    /**
     Create an Organization
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func createAnOrganization(_ organizationId: PPOrganizationId,
                                                 organization: PPOrganization,
                                                 callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.screateAnOrganization()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    /**
     Update Organization
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateOrganization(_ organizationId: PPOrganizationId,
                                               organization: PPOrganization,
                                               callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.supdateOrganization()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    /**
     Delete Organization
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteOrganization(_ organizationId: PPOrganizationId,
                                               callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sdeleteOrganization()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Organization Large Objects
    /**
     These API's allow to store large binary or text objects like images, videos and email templates for an organization.
     */


    /**
     Upload Large Object
     This API is only available to Organization Administrators.The Content-Type header must be like video/ *, image/ *, text/plain, application/octet-stream or application/json (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values). For example: video/mp4, image/jpeg, audio/mp3. The object content gets uploaded as a binary stream.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func uploadLargeObject(_ organizationId: PPOrganizationId,
                                              objectName: String,
                                              private: PPOrganizationObjectPrivateContent,
                                              data: Data,
                                              callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.suploadLargeObject()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    /**
     Get Object Conten
     Return the previously uploaded object content.Private objects content is available only for organization administrators. Public objects content is available for any user.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getObjectContent(_ organizationId: PPOrganizationId,
                                             objectName: String,
                                             callback: @escaping ((Data?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sgetObjectContent()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    /**
     Delete Object
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteContent(_ organizationId: PPOrganizationId,
                                          objectName: String,
                                          callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sdeleteContent()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Organization Objects and Properties

    /**
     List Objects and Properties
     Retrieve all large objects and small properties by the organization. Anyone can call it.Private records are turned only for administrators.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func listObjectsAndProperties(_ organizationId: PPOrganizationId,
                                                     callback: @escaping (([PPOrganizationObject]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.slistObjectsAndProperties()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    /**
     Set Properties
     Update organization property values. Only administrator can call it.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func setProperties(_ organizationId: PPOrganizationId,
                                          properties: [PPOrganizationObject],
                                          callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.ssetProperties()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Get Organization Administrators

    /**
     Get Administrators
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getAdministrators(_ organizationId: PPOrganizationId,
                                              callback: @escaping (([PPUser]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sgetAdministrators()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    // MARK: - Manage Organization Administrators

    /**
     Add an Administrator
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func addAnAdministrator(_ organizationId: PPOrganizationId,
                                               userId: PPUserId,
                                               brand: String?,
                                               callback: @escaping (( Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.saddAnAdministrator()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    /**
     Remove Administrator
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func removeAdministrator(_ organizationId: PPOrganizationId,
                                                userId: PPUserId,
                                                callback: @escaping (( Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sremoveAdministrator()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Organization Totals
    /**
     Get total numbers of locations and devices in the organization.
     | Name | Description |
     | ---- | ---- |
     | locationsCount | Total number of locations |
     | groupLocations | Numbers of locations by groups |
     | organizationDevices | Number of active and inactive devices |
     | groupDevices | Numbers of devices groups |
     */

    /**
     Get Organization Totals
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getOrganizationTotals(_ organizationId: PPOrganizationId,
                                                  locations: Bool,
                                                  groupLocations: Bool,
                                                  userDevices: Bool,
                                                  groupDevices: Bool,
                                                  groupId: PPOrganizationGroupId,
                                                  locationId: PPLocationId,
                                                  callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organization.sgetOrganizationTotals()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

}
