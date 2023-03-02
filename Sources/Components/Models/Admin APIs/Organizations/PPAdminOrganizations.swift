//
//  PPAdminOrganizations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminOrganizations : NSObject {
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
    @objc public class func getOrganizations(_ organizationId: PPOrganizationId, domainName: String?, name: String?, callback: @escaping (([PPOrganization]?, Error?) -> (Void))) {
        let components = NSURLComponents(string: "organizations")
        
        var queryItems = [URLQueryItem]()
        
        if organizationId != .none {
            queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        }
        if let domainName = domainName {
            queryItems.append(URLQueryItem(name: "domainName", value: domainName))
        }
        if let name = name {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.getOrganizations()")
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
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(nil, PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Create an Organization
     */
    @objc public class func createAnOrganization(_ organizationId: PPOrganizationId,
                                                 name: String?,
                                                 domainName: String?,
                                                 brand: String?,
                                                 features: String?,
                                                 deviceTypes: String?,
                                                 termsOfService: String?,
                                                 contactName1: String?,
                                                 contactEmail1: String?,
                                                 contactPhone1: String?,
                                                 contactName2: String?,
                                                 contactEmail2: String?,
                                                 contactPhone: String?,
                                                 officePhone: String?,
                                                 addrStreet1: String?,
                                                 addrStreet2: String?,
                                                 addrCitry: String?,
                                                 stateId: PPStateId,
                                                 countryId: PPCountryId,
                                                 zip: String?,
                                                 callback: @escaping ((PPOrganizationId, Error?) -> (Void))) {
        let components = NSURLComponents(string: "organizations")
        
        var queryItems = [URLQueryItem]()
        
        if organizationId != .none {
            queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        }
        components?.queryItems = queryItems;
        
        var json: [String: Any] = [:]
        json["name"] = name
        json["domainName"] = domainName
        json["brand"] = brand
        json["features"] = features
        json["deviceTypes"] = deviceTypes
        json["termsOfService"] = termsOfService
        json["contactName1"] = contactName1
        json["contactEmail1"] = contactEmail1
        json["contactPhone1"] = contactPhone1
        json["contactName2"] = contactName2
        json["contactEmail2"] = contactEmail2
        json["contactPhone"] = contactPhone
        json["officePhone"] = officePhone
        json["addrStreet1"] = addrStreet1
        json["addrStreet2"] = addrStreet2
        json["addrCitry"] = addrCitry
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
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "POST", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(.none, PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.createAnOrganization()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _organizationId: PPOrganizationId = .none
                var _error: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    if let organizationId = root["organizationId"] as? Int {
                        _organizationId = PPOrganizationId(rawValue: organizationId)
                    }
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(_organizationId, _error)
                }
            }
        } failure: { error in
            PPLogAPIs(#file, message: "< \(queue.label)")
            DispatchQueue.main.async {
                callback(.none, PPBaseModel.resultCode(toNSError: 10003, originatingClass: NSStringFromClass(self), argument: error == nil ? nil : "Error domain: \((error! as NSError).domain), code: \((error! as NSError).code), userInfo: \((error! as NSError).userInfo)"))
            }
        }
    }

    /**
     Update Organization
     */
    @objc public class func updateOrganization(_ organizationId: PPOrganizationId,
                                               name: String?,
                                               domainName: String?,
                                               brand: String?,
                                               features: String?,
                                               deviceTypes: String?,
                                               termsOfService: String?,
                                               contactName1: String?,
                                               contactEmail1: String?,
                                               contactPhone1: String?,
                                               contactName2: String?,
                                               contactEmail2: String?,
                                               contactPhone: String?,
                                               officePhone: String?,
                                               addrStreet1: String?,
                                               addrStreet2: String?,
                                               addrCitry: String?,
                                               stateId: PPStateId,
                                               countryId: PPCountryId,
                                               zip: String?,
                                               callback: @escaping ((Error?) -> (Void))) {
        let components = NSURLComponents(string: "organizations")
      
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "organizationId", value: "\(organizationId.rawValue)"))
        components?.queryItems = queryItems;
        
        var json: [String: Any] = [:]
        json["name"] = name
        json["domainName"] = domainName
        json["brand"] = brand
        json["features"] = features
        json["deviceTypes"] = deviceTypes
        json["termsOfService"] = termsOfService
        json["contactName1"] = contactName1
        json["contactEmail1"] = contactEmail1
        json["contactPhone1"] = contactPhone1
        json["contactName2"] = contactName2
        json["contactEmail2"] = contactEmail2
        json["contactPhone"] = contactPhone
        json["officePhone"] = officePhone
        json["addrStreet1"] = addrStreet1
        json["addrStreet2"] = addrStreet2
        json["addrCitry"] = addrCitry
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
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "PUT", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
      
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.updateOrganization()")
      
        PPLogAPIs(#file, message: "> \(queue.label)")
      
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { responseData in
            queue.async {
                var _error: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
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
     Delete Organization
     */
    @objc public class func deleteOrganization(_ organizationId: PPOrganizationId,
                                               callback: @escaping ((Error?) -> (Void))) {
        let components = NSURLComponents(string: "organizations")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.deleteOrganization()")
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

    // MARK: - Organization Large Objects
    /**
     These API's allow to store large binary or text objects like images, videos and email templates for an organization.
     */


    /**
     Upload Large Object
     This API is only available to Organization Administrators.The Content-Type header must be like video/ *, image/ *, text/plain, application/octet-stream or application/json (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values). For example: video/mp4, image/jpeg, audio/mp3. The object content gets uploaded as a binary stream.
     */
    @objc public class func uploadLargeObject(_ organizationId: PPOrganizationId,
                                              objectName: String,
                                              private privateObject: PPOrganizationObjectPrivateContent,
                                              data: Data,
                                              contentType: String,
                                              progressBlock: ((Progress?) -> (Void))?,
                                              callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) != nil)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/objects/\(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
        
        var queryItems = [URLQueryItem]()
        if privateObject != .none {
            queryItems.append(URLQueryItem(name: "private", value: "\(privateObject.rawValue)"))
        }
        components?.queryItems = queryItems;
        
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "PUT", urlString: urlString, parameters: nil)
            request.setValue(contentType, forHTTPHeaderField: HTTP_HEADER_CONTENT_TYPE)
            request.httpBody = data
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.uploadLargeObject()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().operation(with: request as URLRequest?) { progress in
            
            PPLogAPIs(#file, message: "> \(queue.label) \(String(describing: progress))")
            DispatchQueue.main.async {
                if let progressBlock = progressBlock {
                    progressBlock(progress)
                }
            }
        } success: { responseData, response in
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
     Get Object Conten
     Return the previously uploaded object content.Private objects content is available only for organization administrators. Public objects content is available for any user.
     */
    @objc public class func getObjectContent(_ organizationId: PPOrganizationId,
                                             objectName: String,
                                             isPublic: PPApplicationFilePublicAccess,
                                             callback: @escaping ((Data?, Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) != nil)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/objects/\(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
        
        let cloudEngine: PPCloudEngine = (isPublic == .true) ? PPCloudEngine.init(singleton: .admin) : PPCloudEngine.sharedAdmin()
        var request: NSMutableURLRequest!
        
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            request = try cloudEngine.getRequestSerializer().request(withMethod: "GET", urlString: urlString, parameters: nil)
        }
        catch {
            callback(nil, PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.getObjectContent()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        cloudEngine.operationWithRequest(includingResponse: request as URLRequest?) { responseData, response in
            queue.async {
                var _error: Error?
                do {
                    let _ = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    let responseHeaders = (response as? HTTPURLResponse)?.allHeaderFields
                    
                    let contentType = responseHeaders?["Content-Type"] as? String
                    let contentRange = responseHeaders?["Content-Range"] as? String
                    let acceptRanges = responseHeaders?["Accept-Ranges"] as? String
                    let contentDisposition = responseHeaders?["Content-Disposition"] as? String
                }
                catch {
                    _error = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(responseData, _error)
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
     Delete Object
     */
    @objc public class func deleteObject(_ organizationId: PPOrganizationId,
                                          objectName: String,
                                          callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) != nil)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/objects/\(objectName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.deleteObject()")
        
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

    // MARK: - Organization Objects and Properties

    /**
     List Objects and Properties
     Retrieve all large objects and small properties by the organization. Anyone can call it.Private records are turned only for administrators.
     */
    @objc public class func listObjectsAndProperties(_ organizationId: PPOrganizationId,
                                                     callback: @escaping (([PPOrganizationObject]?, Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/objects")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.listObjectsAndProperties()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPOrganizationObject]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["organizations"] as? [Dictionary<String, Any>] ?? [] {
                        let m = PPOrganizationObject.initWith(d)
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
     Set Properties
     Update organization property values. Only administrator can call it.
     */
    @objc public class func setProperties(_ organizationId: PPOrganizationId,
                                          properties: [PPOrganizationObject],
                                          callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/objects")
        
        var organizationObjects: [[String: Any]] = []
        for property in properties {
            organizationObjects.append([
                "name": property.name,
                "value": property.value,
                "privateContent": property.privateContent == .true
            ])
        }
        let json: [String: Any] = [
            "organizationObjects": organizationObjects
        ]
        var request: NSMutableURLRequest!
        do {
            guard
                let componentsString = components?.string,
                let urlString = URL(string: componentsString, relativeTo: PPCloudEngine.sharedAdmin().getBaseURL())?.absoluteString else {
                throw PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "Invalid endpoint")!
            }
            let body = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request = try PPCloudEngine.sharedAdmin().getRequestSerializer().request(withMethod: "GET", urlString: urlString, parameters: nil)
            request.httpBody = body
        }
        catch {
            callback(PPBaseModel.resultCode(toNSError: 14, originatingClass: NSStringFromClass(self), argument: "\(error.localizedDescription)"))
            return
        }
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.setProperties()")
      
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

    // MARK: - Get Organization Administrators

    /**
     Get Administrators
     */
    @objc public class func getAdministrators(_ organizationId: PPOrganizationId,
                                              callback: @escaping (([PPUser]?, Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/admins")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.getAdministrators()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [PPUser]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["organizations"] as? [Dictionary<String, Any>] ?? [] {
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

    // MARK: - Manage Organization Administrators

    /**
     Add an Administrator
     */
    @objc public class func addAnAdministrator(_ organizationId: PPOrganizationId,
                                               userId: PPUserId,
                                               brand: String?,
                                               callback: @escaping (( Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(userId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/admins/\(userId.rawValue)")
        
        var queryItems = [URLQueryItem]()
        
        if let brand = brand {
            queryItems.append(URLQueryItem(name: "brand", value: brand))
        }
        components?.queryItems = queryItems
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.addAnAdministrator()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().put(components?.string) { responseData in
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

    /**
     Remove Administrator
     */
    @objc public class func removeAdministrator(_ organizationId: PPOrganizationId,
                                                userId: PPUserId,
                                                callback: @escaping (( Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(userId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/admins/\(userId.rawValue)")
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.removeAdministrator()")
        
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
    @objc public class func getOrganizationTotals(_ organizationId: PPOrganizationId,
                                                  locations: Bool,
                                                  groupLocations: Bool,
                                                  userDevices: Bool,
                                                  groupDevices: Bool,
                                                  groupId: PPOrganizationGroupId,
                                                  locationId: PPLocationId,
                                                  callback: @escaping ((Dictionary<String, Any>?, Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/totals")
        
        var queryItems = [URLQueryItem]()
        
        if locations == true {
            queryItems.append(URLQueryItem(name: "locations", value: "true"))
        }
        if groupLocations == true {
            queryItems.append(URLQueryItem(name: "groupLocations", value: "true"))
        }
        if userDevices == true {
            queryItems.append(URLQueryItem(name: "userDevices", value: "true"))
        }
        if groupDevices == true {
            queryItems.append(URLQueryItem(name: "groupDevices", value: "true"))
        }
        if groupId != .none {
            queryItems.append(URLQueryItem(name: "groupId", value: "\(groupId.rawValue)"))
        }
        if locationId != .none {
            queryItems.append(URLQueryItem(name: "locationId", value: "\(locationId.rawValue)"))
        }
        components?.queryItems = queryItems
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.organizations.getOrganizationTotals()")
        
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var totals: Dictionary<String, Any>?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    totals = root["totals"] as? Dictionary<String,Any>
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(totals, err)
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
