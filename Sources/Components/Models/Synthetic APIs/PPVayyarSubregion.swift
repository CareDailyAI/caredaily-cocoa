//
//  PPVayyarSubregion.swift
//  Peoplepower
//
//  Created by Destry Teeter on 7/1/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

/**
 * # Subregion Behavior
 * Parameters:
 * - `deviceId` Device ID to apply this subregion to
 * - `subregionId` Context / behavior of this subregion - see the Subregion Behavior Properties
 * - `contextId` Descriptive name of this subregion, default is the title of the subregion context that was selected.
 * - `uniqueId` UUID to uniquely identify this subregion, auto-defined by the bot.
 * - `name` Required. Looking into the room from the device, this is the left-most side of the sub-region. Remember to the left of Vayyar
 * - `xMin` Required.Looking into the room from the device, this is the right-most side of the sub-region.
 * - `xMax` Required. Distance from the Vayyar Home to the nearest side of the sub-region.
 * - `yMin` Required. Distance from the Vayyar Home to the farthest side of the sub-region.
 * - `yMax` Optional. True to detect falls in this room, False to avoid detecting fall (default is True).
 * - `detectFalls` Optional. True to detect people, False to not detect people (default is True).
 * - `detectPresence` Optional. Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
 enterDuration
 * - `exitDuration` Optional. Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
 */
@objc
open class PPVayyarSubregion: NSObject {
    /// Device ID to apply this subregion to
    @objc open var deviceId: String!
    
    /// Subregion ID of this subregion.  Optional. If provided then this is an existing subregion
    @objc open var subregionId: NSNumber?
    
    /// Context / behavior of this subregion - see the Subregion Behavior Properties
    @objc open var contextId: Int = 0
    
    /// Context / behavior of this subregion - see the Subregion Behavior Properties
    @objc open var uniqueId: String = UUID().uuidString
    
    /// Descriptive name of this subregion, default is the title of the subregion context that was selected.
    @objc open var name: String = ""
    
    /// Required. Looking into the room from the device, this is the left-most side of the sub-region. Remember to the left of Vayyar Home is negative numbers on the x-axis.
    @objc open var xMin: Double = -1.0
    
    /// Required.Looking into the room from the device, this is the right-most side of the sub-region.
    @objc open var xMax: Double = 1.0
    
    /// Required. Distance from the Vayyar Home to the nearest side of the sub-region.
    @objc open var yMin: Double = 2.0
    
    /// Required. Distance from the Vayyar Home to the farthest side of the sub-region.
    @objc open var yMax: Double = 1.0
    
    /// Optional. True to detect falls in this room, False to avoid detecting fall (default is True).
    @objc open var detectFalls: Bool = true
    
    /// Optional. True to detect people, False to not detect people (default is True).
    @objc open var detectPresence: Bool = true
    
    /// Optional. Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
    @objc open var enterDuration: Int = 3
    
    /// Optional. Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
    @objc open var exitDuration: Int = 3
    
    @objc open var detectionStatus: String {
        get {
            return detectPresence && detectFalls
                ? "Detect Presence and Falls"
                : detectPresence
                ? "Detect Presence"
                : detectFalls
                ? "Detect Falls"
                : "No Detection"
        }
    }
    @objc open var detectionStatusColor: UIColor {
        get {
            
            return detectPresence && detectFalls
                ? .green
                : detectPresence
                ? .blue
                : detectFalls
                ? .yellow
                : .gray
        }
    }
    
    @objc public convenience init(_ deviceId: String, data: Dictionary<String, Any>) {
        self.init()
        self.deviceId = deviceId
        if let subregionId = data["subregion_id"] as? Int {
            self.subregionId = NSNumber(value: subregionId)
        }
        self.uniqueId = data["unique_id"] as? String ?? UUID().uuidString
        if let name = data["name"] as? String {
            self.name = name
        }
        if let contextId = data["context_id"] as? Int {
            self.contextId = contextId
        }
        if let xMin = data["x_min_meters"] as? Double {
            self.xMin = xMin
        }
        if let xMax = data["x_max_meters"] as? Double {
            self.xMax = xMax
        }
        if let yMin = data["y_min_meters"] as? Double {
            self.yMin = yMin
        }
        if let yMax = data["y_max_meters"] as? Double {
            self.yMax = yMax
        }
        if let detectFalls = data["detect_falls"] as? Bool {
            self.detectFalls = detectFalls
        }
        if let detectPresence = data["detect_presence"] as? Bool {
            self.detectPresence = detectPresence
        }
        if let enterDuration = data["enter_duration_s"] as? Int {
            self.enterDuration = enterDuration
        }
        if let exitDuration = data["exit_duration_s"] as? Int {
            self.exitDuration = exitDuration
        }
    }
}
