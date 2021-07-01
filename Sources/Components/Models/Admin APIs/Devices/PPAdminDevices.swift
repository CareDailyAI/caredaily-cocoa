//
//  PPAdminDevices.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminDevices : NSObject {
    
    
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
                                     deviceTypes: [Int]?,
                                     searchBy: String?,
                                     searchTag: String?,
                                     lessUpdateDate: Date?,
                                     moreUpdateDate: Date?,
                                     paramName: String?,
                                     paramValue: String?,
                                     limit: NSNumber?,
                                     getTags: NSNumber?,
                                     callback: @escaping (([PPDevice]?, Error?) -> (Void))) {
        let components = NSURLComponents(string: "devices")
        
        var queryItems = [URLQueryItem]()
        
        if organizationId != .none {
            queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        }
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if userId != .none {
            queryItems.append(URLQueryItem(name: "userId", value: "\(userId.rawValue)"))
        }
        if locationId != .none {
            queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))
        }
        if let deviceId = deviceId {
            queryItems.append(URLQueryItem(name: "deviceId", value: "\(deviceId)"))
        }
        if let deviceTypes = deviceTypes {
            deviceTypes.forEach { deviceType in
                queryItems.append(URLQueryItem(name: "deviceType", value: "\(deviceType)"))
            }
        }
        if let searchBy = searchBy {
            queryItems.append(URLQueryItem(name: "searchBy", value: "\(searchBy)"))
        }
        if let searchTag = searchTag {
            queryItems.append(URLQueryItem(name: "searchTag", value: "\(searchTag)"))
        }
        if let lessUpdateDate = lessUpdateDate {
            queryItems.append(URLQueryItem(name: "lessUpdateDate", value: "\(lessUpdateDate)"))
        }
        if let moreUpdateDate = moreUpdateDate {
            queryItems.append(URLQueryItem(name: "moreUpdateDate", value: "\(moreUpdateDate)"))
        }
        if let paramName = paramName {
            queryItems.append(URLQueryItem(name: "paramName", value: "\(paramName)"))
        }
        if let paramValue = paramValue {
            queryItems.append(URLQueryItem(name: "paramValue", value: "\(paramValue)"))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        if let getTags = getTags {
            queryItems.append(URLQueryItem(name: "getTags", value: "\(getTags)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getUsers()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPDevice]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["devices"] as? [Dictionary<String, Any>] ?? [] {
                        guard let m = PPDevice.initWith(d) else { continue }
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
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(nil, PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }
}
