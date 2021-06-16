//
//  PPAdminTags.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminTags : NSObject {
    
    // MARK: - Tags
    /**
     Tags are a way to categorize sets of users, devices, or files.Tags can be generated automatically from Composer apps, or manually by the administrator.The administrator can only see device, location and user tags, but not file tags. Users can only see file tags but not other tags. File tags would be used to help them as they search for one of their private files.The in-app messaging cloud APIs have been updated to allow the administrator to send messages to users who have specific user tags, or the users who own devices that have specific device tags.Tag types:
     | ID | Name |
     | ---- | ---- |
     | 1 | User |
     | 2 | Location |
     | 3 | Device |
     | 4 | Files |
     */
    // MARK: - Tags
    /**
     Popular Tags
     Get a list of popular tags and their number of occurrences in this organization.This API call will return the top N user tags.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func popularTags(_ organizationId: PPOrganizationId,
                                        type: Int,
                                        limit: NSNumber?,
                                        callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.popularTags()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Apply Tags
     Apply tags to users, locations, and devices.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func applyTags(_ organizationId: PPOrganizationId,
                                           tags: Dictionary<String, Any>,
                                           callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.applyTags()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Delete Tags
     Deletes the given tag from the given user, location or device.An administrator can delete only tags related to his organization or to the specific app.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteTags(_ organizationId: PPOrganizationId,
                                           type: Int,
                                           id: String,
                                           tag: String,
                                           appId: NSNumber?,
                                           callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.deleteTags()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }
    
}
