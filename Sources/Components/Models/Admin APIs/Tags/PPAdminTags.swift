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
    @objc public class func popularTags(_ organizationId: PPOrganizationId,
                                        type: Int,
                                        limit: NSNumber?,
                                        callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        assert(organizationId != .none)
        assert(type > 0)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/tags")
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "type", value: "\(type)"))
        if let limit = limit?.intValue {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.popularTags()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var models: [Dictionary<String, Any>]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    models = []
                    for d in root["narratives"] as? [Dictionary<String, Any>] ?? [] {
                        models?.append(d)
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
     Apply Tags
     Apply tags to users, locations, and devices.
     */
    @objc public class func applyTags(_ organizationId: PPOrganizationId,
                                           tags: [Dictionary<String, Any>],
                                           callback: @escaping ((Error?) -> (Void))) {
        assert(organizationId != .none)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/tags")
        
        var _tags: [[String: Any]] = []
        tags.forEach { tag in
            guard
                let type = tag["type"] as? Int,
                let id = tag["id"] as? String,
                let tag = tag["tag"] as? String
            else {
                return
            }
            _tags.append([
                "type": type,
                "id": id,
                "tag": tag
            ])
            
        }
        let json: [String: Any] = ["tags": _tags]
        
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
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.applyTags()")
        
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
        assert(organizationId != .none)
        assert(type > 0)
        let components = NSURLComponents(string: "organizations/\(organizationId.rawValue)/tags")
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "type", value: "\(type)"))
        queryItems.append(URLQueryItem(name: "id", value: "\(id)"))
        queryItems.append(URLQueryItem(name: "tag", value: "\(tag)"))
        if let appId = appId?.intValue {
            queryItems.append(URLQueryItem(name: "appId", value: "\(appId)"))
        }
        components?.queryItems = queryItems;
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.tags.deleteTags()")
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
