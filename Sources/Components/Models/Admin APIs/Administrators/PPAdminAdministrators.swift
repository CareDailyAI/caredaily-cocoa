//
//  PPAdminAdministrators.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminAdministrators : NSObject {
    // MARK: - Administrators
    /**
     The IoT Software Suite is a role-based access control system.
     - A "System Administrator" is allowed access to manage the entire system.
     - An "Organization Administrator" can manage users within their own organization. They do not have access to users or data from other organizations.
     - A "User" can only manage and see their own account. If they belong to a group or organization, users can retrieve limited data about the organization to which they belong.
     */

    // MARK: - Roles

    /**
     Get Roles
     Returns administrative Roles which can be granted to another user by an administrator.
     */
    @objc public class func getRoles(_ callback: @escaping (([Any]?, Error?) -> (Void))) {
        let components = NSURLComponents(string: "roles")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.administrators.getRoles()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        
        PPCloudEngine.sharedAdmin().get(components?.string) { responseData in
            queue.async {
                var roles: [Any]?
                var err: Error?
                do {
                    let root = try PPBaseModel.processJSONResponse(responseData, originatingClass: NSStringFromClass(self))
                    roles = []
                    for d in root["roles"] as? [Dictionary<String, Any>] ?? [] {
                        roles?.append(d)
                    }
                }
                catch {
                    err = error
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(roles, err)
                }
            }
        } failure: { error in
            queue.async {
                callback(nil, error)
            }
        }
    }

    // MARK: - Grant Administrative Roles
    /**
     A role can be granted or revoked only by an administrator with a corresponding privilege.
     */
    
    /**
     Grant Administrative Roles
     */
    @objc public class func grantAdministrativeRoles(_ userId: PPUserId,
                                                     roleId: Int,
                                                     callback: @escaping ((Error?) -> (Void))) {
        assert(userId != .none, "\(#function) missing userId")
        assert(roleId != -1, "\(#function) missing roleId")
        let components = NSURLComponents(string: "users/\(userId.rawValue)/roles/\(roleId)")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.administrators.grantAdministrativeRoles()")
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
            queue.async {
                callback(error)
            }
        }
    }

    // MARK: - Revoke Administrative Roles

    /**
     Revoke Administrative Roles
     */
    @objc public class func revokeAdministrativeRoles(_ userId: PPUserId,
                                                      callback: @escaping ((Error?) -> (Void))) {
        assert(userId != .none, "\(#function) missing userId")
        let components = NSURLComponents(string: "users/\(userId.rawValue)/roles")
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.administrators.revokeAdministrativeRoles()")
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
            queue.async {
                callback(error)
            }
        }
    }

}
