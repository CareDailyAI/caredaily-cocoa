//
//  PPAdminFirmware.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminFirmware : PPBaseModel {
    
    // MARK: - Firmware

    // MARK: - Firmware Version

    /**
     Upload Firmware Version
     Upload a new FW version. (binary file, version number, check sum, device type, part index). Return the version ID.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func uploadFirmwareVersion(_ deviceType: PPDeviceTypeId,
                                                  firmware: String,
                                                  fileName: String,
                                                  checkSum: String,
                                                  index: String?,
                                                  data: Data,
                                                  callback: @escaping ((NSNumber?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.uploadFirmwareVersion()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    /**
     Get Firmware Versions
     Get existing FW update versions by device type.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getFirmwareVersions(_ deviceType: PPDeviceTypeId,
                                                callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getFirmwareVersions()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(nil, resultCode(toNSError: 29))
    }

    /**
     Delete Firmware Versions
     Delete existing FW version.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteFirmwareVersions(_ versionId: Int,
                                                   callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteFirmwareVersions()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
       callback(resultCode(toNSError: 29))
    }

    // MARK: - Firmware Update Jobs
    /**
     Create Update Job
     Create a new FW update job by version ID, group ID. Previous active job will be deleted.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func createUpdateJob(_ versionId: Int,
                                            forced: NSNumber?,
                                            groupId: PPOrganizationGroupId,
                                            callback: @escaping ((PPDeviceFirmwareUpdateJobId, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.createUpdateJob()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(.none, resultCode(toNSError: 29))
    }

    /**
     Get Update Jobs
     Get active FW update jobs. Normally, no more than one job could exist.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getUpdateJobs(_ deviceType: PPDeviceTypeId,
                                            groupId: PPOrganizationGroupId,
                                            callback: @escaping (([PPDeviceFirmwareUpdateJob]?, Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.getUpdateJobs()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    /**
     Delete Update Job
     Delete existing FW update job.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteUpdateJob(_ jobId: PPDeviceFirmwareUpdateJobId,
                                            callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Firmware Group
    /**
     Update Firmware Group for Device
     Update or clear the FW update group ID for a specific device instance.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateFirmwareGroupForDevice(_ deviceId: String,
                                                         groupId: PPOrganizationGroupId,
                                                         callback: @escaping ((Error?) -> (Void))) {
       let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.updateFirmwareGroupForDevice()")
       PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }
}
