//
//  PPAdminDevices.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminDevices : PPBaseModel {
    
    
    // MARK: - Devices

    // MARK: - Devices
    /** Retrieve device instances linked to users and/or locations inside the organization.
     */

    /**
     Get Devices
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getDevices(_ organizationId: PPOrganizationId,
                                     groupId: PPOrganizationGroupId,
                                     userId: PPUserId,
                                     locationId: PPLocationId,
                                     deviceId: String?,
                                     deviceType: [Int]?,
                                     searchBy: String?,
                                     searchTag: String?,
                                     lessUpdateDate: Date?,
                                     moreUpdateDate: Date?,
                                     paramName: String?,
                                     paramValue: String?,
                                     limit: NSNumber?,
                                     getTags: NSNumber?,
                                     callback: @escaping (([PPDevice]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getUsers()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }
}
