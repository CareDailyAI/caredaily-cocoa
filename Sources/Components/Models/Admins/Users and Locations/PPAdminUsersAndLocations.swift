//
//  PPAdminUsersAndLocations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminUsersAndLocations : NSObject {

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
        let components = NSURLComponents(string: "users")
        
        var queryItems = [URLQueryItem]()
        
        if organizationId != .none {
            queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        }
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if locationId != .none {
            queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))
        }
        if let searchBy = searchBy {
            queryItems.append(URLQueryItem(name: "searchBy", value: "\(searchBy)"))
        }
        if let searchAddress = searchAddress {
            queryItems.append(URLQueryItem(name: "searchAddress", value: "\(searchAddress)"))
        }
        if servicePlanId != .none {
            queryItems.append(URLQueryItem(name: "servicePlanId", value: "\(servicePlanId.rawValue)"))
        }
        if let searchTag = searchTag {
            queryItems.append(URLQueryItem(name: "searchTag", value: "\(searchTag)"))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit.intValue)"))
        }
        if let getTags = getTags {
            queryItems.append(URLQueryItem(name: "getTags", value: "\(getTags.boolValue ? "true" : "false")"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getUsers()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPUser]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["users"] as? [Dictionary<String, Any>] ?? [] {
                        let m = PPUser.initWith(d)
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

    // MARK: - Locations in an Organization
    /**
     These API's allows to manage device locations withing an organization.Location fields are described in user account API's documentation http://docs.iotapps.apiary.io/#reference/user-accounts .
     */

    /**
     Get Locations
     */
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
        let components = NSURLComponents(string: "locations")
        
        var queryItems = [URLQueryItem]()
        
        if organizationId != .none {
            queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        }
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if locationId != .none {
            queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))
        }
        if let tree = tree {
            queryItems.append(URLQueryItem(name: "tree", value: "\(tree.boolValue ? "true" : "false")"))
        }
        if let searchBy = searchBy {
            queryItems.append(URLQueryItem(name: "searchBy", value: "\(searchBy)"))
        }
        if let locationType = locationType {
            queryItems.append(URLQueryItem(name: "locationType", value: "\(locationType)"))
        }
        if let searchTags = searchTags {
            for searchTag in searchTags {
                queryItems.append(URLQueryItem(name: "searchTag", value: "\(searchTag)"))
            }
        }
        if let searchDeviceTags = searchDeviceTags {
            for searchDeviceTag in searchDeviceTags {
                queryItems.append(URLQueryItem(name: "searchDeviceTag", value: "\(searchDeviceTag)"))
            }
        }
        if let deviceTypes = deviceTypes {
            for deviceType in deviceTypes {
                queryItems.append(URLQueryItem(name: "deviceType", value: "\(deviceType)"))
            }
        }
        if servicePlanId != .none {
            queryItems.append(URLQueryItem(name: "servicePlanId", value: "\(servicePlanId.rawValue)"))
        }
        if stateId != .none {
            queryItems.append(URLQueryItem(name: "stateId", value: "\(stateId.rawValue)"))
        }
        if countryId != .none {
            queryItems.append(URLQueryItem(name: "countryId", value: "\(countryId.rawValue)"))
        }
        if let priorityCategory = priorityCategory {
            queryItems.append(URLQueryItem(name: "priorityCategory", value: "\(priorityCategory.intValue)"))
        }
        if let getTags = getTags {
            queryItems.append(URLQueryItem(name: "getTags", value: "\(getTags.boolValue ? "true" : "false")"))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit.intValue)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getLocations()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPLocation]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["locations"] as? [Dictionary<String, Any>] ?? [] {
                        guard let m = PPLocation.initWith(d) else { continue }
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

    /**
     Create Location
     */
    @objc public class func createLocation(_ organizationId: PPOrganizationId,
                                           groupId: PPOrganizationGroupId,
                                           parentId: PPOrganizationGroupId,
                                           userId: PPUserId,
                                           name: String?,
                                           type: PPLocationType,
                                           utilityAccountNo: String?,
                                           timezone: PPTimezone?,
                                           addrStreet1: String?,
                                           addrStreet2: String?,
                                           addrCity: String?,
                                           stateId: PPStateId,
                                           countryId: PPCountryId,
                                           zip: String?,
                                           latitude: String?,
                                           longitude: String?,
                                           size: PPLocationSize?,
                                           storiesNumber: PPLocationStoriesNumber,
                                           roomsNumber: PPLocationRoomsNumber,
                                           bathroomsNumber: PPLocationBathroomsNumber,
                                           occupantsNumber: PPLocationOccupantsNumber,
                                           occupantsRanges: [Dictionary<String, Any>]?,
                                           usagePeriod: PPLocationUsagePeriod,
                                           heatingType: PPLocationHeatingType,
                                           coolingType: PPLocationCoolingType,
                                           waterHeaterType: PPLocationWaterHeaterType,
                                           thermostatType: PPLocationThermostatType,
                                           fileUploadPolicy: PPLocationFileUploadPolicy,
                                           callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/locations")
        
        var queryItems = [URLQueryItem]()

        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if parentId != .none {
            queryItems.append(URLQueryItem(name: "parentId", value: "\(parentId.rawValue)"))
        }
        if userId != .none {
            queryItems.append(URLQueryItem(name: "userId", value: "\(userId.rawValue)"))
        }
        components?.queryItems = queryItems;
        
        var json: [String: Any] = [:]
        json["name"] = name
        if type != .none {
            json["type"] = type.rawValue
        }
        json["utilityAccountNo"] = utilityAccountNo
        if let timezone = timezone {
            json["timezone"] = ["id": timezone.timezoneId]
        }
        json["addrStreet1"] = addrStreet1
        json["addrStreet2"] = addrStreet2
        json["addrCity"] = addrCity
        json["zip"] = zip
        json["latitude"] = latitude
        json["longitude"] = longitude
        if let size = size {
            json["size"] = [
                "unit": size.unit ?? "",
                "content": size.content
            ]
        }
        if storiesNumber != .none {
            json["storiesNumber"] = storiesNumber.rawValue
        }
        if roomsNumber != .none {
            json["roomsNumber"] = roomsNumber.rawValue
        }
        if bathroomsNumber != .none {
            json["bathroomsNumber"] = bathroomsNumber.rawValue
        }
        if occupantsNumber != .none {
            json["occupantsNumber"] = occupantsNumber.rawValue
        }
        if let occupantsRanges = occupantsRanges {
            json["occupantsRanges"] = occupantsRanges
        }
        if usagePeriod != .none {
            json["usagePeriod"] = usagePeriod.rawValue
        }
        if heatingType != PPLocationHeatingType(rawValue: 0) {
            json["heatingType"] = heatingType.rawValue
        }
        if coolingType != PPLocationCoolingType(rawValue: 0) {
            json["coolingType"] = coolingType.rawValue
        }
        if waterHeaterType != PPLocationWaterHeaterType(rawValue: 0) {
            json["waterHeaterType"] = waterHeaterType.rawValue
        }
        if thermostatType != PPLocationThermostatType(rawValue: 0) {
            json["thermostatType"] = thermostatType.rawValue
        }
        if fileUploadPolicy != .none {
            json["fileUploadPolicy"] = fileUploadPolicy.rawValue
        }
        if stateId != .none {
            json["state"] = ["id": stateId.rawValue]
        }
        if countryId != .none {
            json["country"] = ["id": countryId.rawValue]
        }
        json["zip"] = zip
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "POST", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.createLocation()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Edit Location
     */
    @objc public class func editLocation(_ organizationId: PPOrganizationId,
                                         locationId: PPLocationId,
                                         name: String?,
                                         type: PPLocationType,
                                         utilityAccountNo: String?,
                                         timezone: PPTimezone?,
                                         addrStreet1: String?,
                                         addrStreet2: String?,
                                         addrCity: String?,
                                         stateId: PPStateId,
                                         countryId: PPCountryId,
                                         zip: String?,
                                         latitude: String?,
                                         longitude: String?,
                                         size: PPLocationSize?,
                                         storiesNumber: PPLocationStoriesNumber,
                                         roomsNumber: PPLocationRoomsNumber,
                                         bathroomsNumber: PPLocationBathroomsNumber,
                                         occupantsNumber: PPLocationOccupantsNumber,
                                         occupantsRanges: [Dictionary<String, Any>]?,
                                         usagePeriod: PPLocationUsagePeriod,
                                         heatingType: PPLocationHeatingType,
                                         coolingType: PPLocationCoolingType,
                                         waterHeaterType: PPLocationWaterHeaterType,
                                         thermostatType: PPLocationThermostatType,
                                         fileUploadPolicy: PPLocationFileUploadPolicy,
                                        callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(locationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/locations")
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))

        components?.queryItems = queryItems;
        
        var json: [String: Any] = [:]
        json["name"] = name
        if type != .none {
            json["type"] = type.rawValue
        }
        json["utilityAccountNo"] = utilityAccountNo
        if let timezone = timezone {
            json["timezone"] = ["id": timezone.timezoneId]
        }
        json["addrStreet1"] = addrStreet1
        json["addrStreet2"] = addrStreet2
        json["addrCity"] = addrCity
        json["zip"] = zip
        json["latitude"] = latitude
        json["longitude"] = longitude
        if let size = size {
            json["size"] = [
                "unit": size.unit ?? "",
                "content": size.content
            ]
        }
        if storiesNumber != .none {
            json["storiesNumber"] = storiesNumber.rawValue
        }
        if roomsNumber != .none {
            json["roomsNumber"] = roomsNumber.rawValue
        }
        if bathroomsNumber != .none {
            json["bathroomsNumber"] = bathroomsNumber.rawValue
        }
        if occupantsNumber != .none {
            json["occupantsNumber"] = occupantsNumber.rawValue
        }
        if let occupantsRanges = occupantsRanges {
            json["occupantsRanges"] = occupantsRanges
        }
        if usagePeriod != .none {
            json["usagePeriod"] = usagePeriod.rawValue
        }
        if heatingType != PPLocationHeatingType(rawValue: 0) {
            json["heatingType"] = heatingType.rawValue
        }
        if coolingType != PPLocationCoolingType(rawValue: 0) {
            json["coolingType"] = coolingType.rawValue
        }
        if waterHeaterType != PPLocationWaterHeaterType(rawValue: 0) {
            json["waterHeaterType"] = waterHeaterType.rawValue
        }
        if thermostatType != PPLocationThermostatType(rawValue: 0) {
            json["thermostatType"] = thermostatType.rawValue
        }
        if fileUploadPolicy != .none {
            json["fileUploadPolicy"] = fileUploadPolicy.rawValue
        }
        if stateId != .none {
            json["state"] = ["id": stateId.rawValue]
        }
        if countryId != .none {
            json["country"] = ["id": countryId.rawValue]
        }
        json["zip"] = zip
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "PUT", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
            
            let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.editLocation()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Delete Location
     */
    @objc public class func deleteLocation(_ organizationId: PPOrganizationId,
                                           locationId: PPLocationId,
                                           callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(locationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/locations")
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))

        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteLocation()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().delete(components?.string) { responseData in
            queue.async {
                var err: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(err)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    // MARK: - Manage Locations

    /**
     Add or Update or Remove locations
     Batch API to manage locations in an organization.Locations will be added or moved to the organization automatically, if they are not there.To remove locations from a group set the groupId field to 0.To remove locations from the organization set the delete field to true.This API does not guaranty that the request will be performed for all locations. The error code may not be returned in this case.
     */
    @objc public class func addOrUpdateOrRemoveLocations(_ organizationId: PPOrganizationId,
                                                         locationIds: [Int],
                                                         groupId: PPOrganizationGroupId,
                                                         notes: String?,
                                                         delete: NSNumber?,
                                                         callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/locationStatus")
        
        var json: [String: Any] = [:]
        if locationIds.count > 0 {
            json["locationIds"] = locationIds
        }
        if groupId != .none {
            json["groupId"] = groupId.rawValue
        }
        json["notes"] = notes
        if let delete = delete?.boolValue {
            json["delete"] = delete
        }
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "PUT", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.addOrUpdateOrRemoveLocations()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    // MARK: - Narratives

    /**
     Get Organization Narratives
     Organization narratives for the specified organization and the child organizations.The search results are organized by "pages". Each page contains a set of elements sorted by the 'narrativeTime' in descending order. The pages follow one another in reverse chronological order.The rowCount parameter specifies the maximum number of elements per page. The result may include the "nextMarker" property - this means that there are more pages for the current search criteria. To get the next page, the value of "nextMarker" must be passed to the "pageMarker" parameter on the next API call.
    */
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
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/narratives")
        
        var queryItems = [URLQueryItem]()
        
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if let searchTags = searchTags {
            searchTags.forEach { searchTag in
                queryItems.append(URLQueryItem(name: "searchTag", value: "\(searchTag)"))
            }
        }
        if let locationIds = locationIds {
            locationIds.forEach { locationId in
                queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId)"))
            }
        }
        if let narrativeTime = narrativeTime {
            queryItems.append(URLQueryItem(name: "narrativeTime", value: "\(narrativeTime)"))
        }
        if narrativeId != .none {
            queryItems.append(URLQueryItem(name: "narrativeId", value: "\(narrativeId.rawValue)"))
        }
        if let narrativeTypes = narrativeTypes {
            narrativeTypes.forEach { narrativeType in
                queryItems.append(URLQueryItem(name: "narrativeType", value: "\(narrativeType)"))
            }
        }
        if priority != .none {
            queryItems.append(URLQueryItem(name: "priority", value: "\(priority.rawValue)"))
        }
        if toPriority != .none {
            queryItems.append(URLQueryItem(name: "toPriority", value: "\(toPriority.rawValue)"))
        }
        if let status = status {
            queryItems.append(URLQueryItem(name: "status", value: "\(status)"))
        }
        if let searchBy = searchBy {
            queryItems.append(URLQueryItem(name: "searchBy", value: "\(searchBy)"))
        }
        if let startDate = startDate {
            queryItems.append(URLQueryItem(name: "startDate", value: "\(startDate)"))
        }
        if let endDate = endDate {
            queryItems.append(URLQueryItem(name: "endDate", value: "\(endDate)"))
        }
        queryItems.append(URLQueryItem(name: "rowCount", value: "\(rowCount)"))
        if let pageMarker = pageMarker {
            queryItems.append(URLQueryItem(name: "pageMarker", value: "\(pageMarker)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getOrganizationNarratives()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPLocationNarrative]?
                var nextMarker: String?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["narratives"] as? [Dictionary<String, Any>] ?? [] {
                        let m = PPLocationNarrative.initWith(d)
                        models?.append(m)
                    }
                    nextMarker = root["nextMarker"] as? String
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(models, nextMarker, err)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(nil, nil, PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    // MARK: - Invite Users
    /**
     Invite users to the organization by email addresses or user ID's.
     */

    /**
     Post Invitation
     */
    @objc public class func postInvitiation(_ organizationId: PPOrganizationId,
                                            reinvite: NSNumber?,
                                            emails: [String]?,
                                            userIds: [Int]?,
                                            callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(emails?.count != 0 || userIds?.count != 0)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/invitees")
        
        var queryItems = [URLQueryItem]()
        if let reinvite = reinvite?.boolValue {
            queryItems.append(URLQueryItem(name: "reinvite", value: "\(reinvite)"))
        }

        components?.queryItems = queryItems;
        
        var json: [String: Any] = [:]
        var invitees: [[String: Any]] = []
        emails?.forEach({ email in
            invitees.append(["email": email])
        })
        userIds?.forEach({ userId in
            invitees.append(["userId": userId])
        })
        json["invitees"] = invitees
        
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "POST", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
            
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.postInvitiation()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
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
    @objc public class func createAGroup(_ organizationId: PPOrganizationId,
                                         groupType: PPOrganizationGroupType,
                                         hidden: Bool,
                                         name: String,
                                         callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(groupType != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/groups")
        
        let json: [String: Any] = [
            "group": [
                "type": groupType.rawValue,
                "hidden": hidden,
                "name": name
            ]
        ]
        
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "POST", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.createAGroup()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Get Groups
     */
    @objc public class func getGroups(_ organizationId: PPOrganizationId,
                                      subOrg: NSNumber?,
                                      groupId: PPOrganizationGroupId,
                                      searchBy: String?,
                                      type: PPOrganizationGroupType,
                                      locationTotals: NSNumber?,
                                      callback: @escaping (([PPOrganizationGroup]?, Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/groups")
        
        var queryItems = [URLQueryItem]()
        
        if let subOrg = subOrg {
            queryItems.append(URLQueryItem(name: "subOrg", value: "\(subOrg)"))
        }
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if let searchBy = searchBy {
            queryItems.append(URLQueryItem(name: "searchBy", value: "\(searchBy)"))
        }
        if type != .none {
            queryItems.append(URLQueryItem(name: "type", value: "\(type.rawValue)"))
        }
        if let locationTotals = locationTotals?.boolValue {
            queryItems.append(URLQueryItem(name: "locationTotals", value: "\(locationTotals)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getGroups()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPOrganizationGroup]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["narratives"] as? [Dictionary<String, Any>] ?? [] {
                        guard let m = PPOrganizationGroup.initWith(d) else { continue }
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
        assert(organizationId != .none)
        assert(groupId != .none)
        assert(groupType != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/groups/\(groupId.rawValue)")
        
        let json: [String: Any] = [
            "group": [
                "type": groupType.rawValue,
                "hidden": hidden,
                "name": name
            ]
        ]
        
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            print(json)
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "PUT", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.updateAGroup()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Delete a Group
     */
    @objc public class func deleteAGroup(_ organizationId: PPOrganizationId,
                                         groupId: PPOrganizationGroupId,
                                         callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(groupId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/groups/\(groupId.rawValue)")
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteAGroup()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().delete(components?.string) { responseData in
            queue.async {
                var err: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(err)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

}
