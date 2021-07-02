//
//  PPVayyarRoom.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 7/1/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

/**
 * # Vayyar Room
 *
 * Parameters
 * - `deviceId` String Device ID to apply these room boundaries to.
 * - `xMin` Float Looking into the room from the device, this is the distance from the center of the device to the left wall of the room in meters. This is a negative number, and if a positive number is given, then it will be turned into a negative number.
 * - `xMax` Float Looking into the room from the device, this is the distance from the center of the device to the right wall of the room in meters. This is a positive number, and if a negative number is given, then it will be turned into a positive number.
 * - `yMin` Float Distance from the Vayyar Home to the opposite wall.
 */
@objc
open class PPVayyarRoom: PPBaseModel {
    
    open override class func primaryKey() -> String? {
        return "deviceId"
    }
    @objc open var deviceId: String!
    
    @objc open var xMin: Double = 1.9
    @objc open var xMax: Double = 1.9
    @objc open var yMin: Double = 0.3
    @objc open var yMax: Double = 3.9
    @objc open var zMin: Double = 0
    @objc open var zMax: Double = 2.5
    
    @objc public convenience init(_ deviceId: String, data: Dictionary<String, Any>) {
        self.init()
        self.deviceId = deviceId
        if let xMin = data["x_min"] as? Double {
            self.xMin = xMin
        }
        if let xMax = data["x_max"] as? Double {
            self.xMax = xMax
        }
        if let yMin = data["y_min"] as? Double {
            self.yMin = yMin
        }
        if let yMax = data["y_max"] as? Double {
            self.yMax = yMax
        }
        if let zMin = data["z_min"] as? Double {
            self.zMin = zMin
        }
        if let zMax = data["z_max"] as? Double {
            self.zMax = zMax
        }
    }
}
