//
//  PPVayyarHome.swift
//  Peoplepower
//
//  Created by Destry Teeter on 7/1/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc public class PPVayyarHome: PPBaseModel {
    
    /**
     * # Get the room boundaries
     *
     * State Variable : vayyar_room
     *
     * vayyar_room Example
     *
     * ```
     * {
     *     "device_id": {
     *         "x_min": x_min,
     *         "x_max": x_max,
     *         "y_min": y_min,
     *         "y_max": y_max,
     *         "z_min": z_min,
     *         "z_max": z_max,
     *         "update_ms": update_ms
     *     },
     *     ...
     * }
     * ```
     */
    @objc public class func getRoomBoundaries(_ locationId: PPLocationId,
                                          callback: @escaping (([PPVayyarRoom]?, Error?) -> (Void))) {
        let stateName = "vayyar_room"
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.synthetic.vayyarHome.getRoomBoundaries()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        PPUserAccounts.getState(locationId, name: stateName) { stateData, error in
            queue.async {
                guard error == nil,
                      let stateData = stateData as? [String:Any]
                else {
                    callback(nil, error)
                    return
                }
                var rooms: [PPVayyarRoom] = []
                for deviceId in stateData.keys {
                    guard
                        let data = stateData[deviceId] as? [String:Any]
                    else {
                        continue
                    }
                    rooms.append(PPVayyarRoom.initWithDeviceId(deviceId, data: data))
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(rooms, nil)
                }
            }
        }
    }
    
    /**
     * # Get the defined subregions
     *
     * State Variable:` vayyar_subregions`
     *
     * # vayyar_subregions Example
     *
     * ```
     * {
     *     "device_id": [
     *         {
     *             "context_id": context_id,
     *             "unique_id": unique_id,
     *             "detect_falls": detect_falls,
     *             "detect_presence": detect_presence,
     *             "enter_duration_s": enter_duration_s,
     *             "exit_duration_s": exit_duration_s,
     *             "name": name,
     *             "subregion_id": subregion_id,
     *             "x_max_meters": x_max_meters,
     *             "x_min_meters": x_min_meters,
     *             "y_max_meters": y_max_meters,
     *             "y_min_meters": y_min_meters
     *         },
     *         ...
     *     ],
     *     ...
     * }
     * ```
     */
    @objc public class func getSubregions(_ locationId: PPLocationId,
                                          callback: @escaping (([PPVayyarSubregion]?, Error?) -> (Void))) {
        let stateName = "vayyar_subregions"
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.synthetic.vayyarHome.getSubregions()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        PPUserAccounts.getState(locationId, name: stateName) { stateData, error in
            queue.async {
                guard error == nil,
                      let stateData = stateData as? [String:Any]
                else {
                    callback(nil, error)
                    return
                }
                var subregions: [PPVayyarSubregion] = []
                for deviceId in stateData.keys {
                    PPLog(#file, message: "DeviceID: \(deviceId)")
                    guard
                        let deviceStateData = stateData[deviceId] as? [[String:Any]]
                    else {
                        continue
                    }
                    
                    for data in deviceStateData {
                        subregions.append(PPVayyarSubregion.initWithDeviceId(deviceId, data: data))
                    }
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(subregions, nil)
                }
            }
        }
    }
    
    /**
     * # Get the available Subregion Behaviors
     *
     * State Variable : `vayyar_subregion_behaviors`
     *
     * # Discussion
     *
     * The device has to be associated with the correct location before you set the subregion, because the subregion requires context to be stored in non-volatile memory that is only associated with the location. If you move the device to a different location, you need to set the subregions again.
     *
     * vayyar_subregion_behaviors Example
     *
     * ```
     * [
     *    {
     *      "compatible_behaviors": [
     *        behaviorId
     *      ],
     *      "context_id": contextId,
     *      "detect_falls": detectFalls,
     *      "detect_presence": detectPresence,
     *      "edit_falls": editFalls,
     *      "edit_presence": editPresence,
     *      "enter_duration_s": enterDuration,
     *      "exit_duration_s": exitDuration,
     *      "flexible_cm": flexible,
     *      "icon": icon,
     *      "icon_font": iconFont,
     *      "length_cm": length,
     *      "title": title,
     *      "width_cm": width
     *    },
     * ```
     */
    @objc public class func getSubregionBehaviors(_ locationId: PPLocationId,
                                                   callback: @escaping (([PPVayyarSubregionBehavior]?, Error?) -> (Void))) {
        let stateName = "vayyar_subregion_behaviors"
        
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.synthetic.vayyarHome.getSubregionBehaviors()")
        PPLogAPIs(#file, message: "> \(queue.label)")
        PPUserAccounts.getState(locationId, name: stateName) { stateData, error in
            queue.async {
                guard error == nil,
                      let stateData = stateData as? [[String:Any]]
                else {
                    callback(nil, error)
                    return
                }

                var behaviors: [PPVayyarSubregionBehavior] = []
                for data in stateData {
                    behaviors.append(PPVayyarSubregionBehavior.initWithData(data))
                }
                
                PPLogAPIs(#file, message: "< \(queue.label)")
                
                DispatchQueue.main.async {
                    callback(behaviors, nil)
                }
            }
        }
    }
    
    /**
     * # Set the Room Boundaries
     *
     * Data Stream Address : `set_vayyar_room`
     *
     * # Set Room Boundary Properties
     *
     * Parameters:
     * - `deviceId` String Device ID to apply these room boundaries to.
     * - `xMin` Double Looking into the room from the device, this is the distance from the center of the device to the left wall of the room in meters. This is a negative number, and if a positive number is given, then it will be turned into a negative number.
     * - `xMax` Double Looking into the room from the device, this is the distance from the center of the device to the right wall of the room in meters. This is a positive number, and if a negative number is given, then it will be turned into a positive number.
     * - `yMax` Double Distance from the Vayyar Home to the opposite wall.
     *
     * # Set Room Boundary Example
     *
     * ```
     * {
     *     "device_id": deviceId,
     *     "x_left_meters": xMin,
     *     "x_right_meters": xMax,
     *     "y_max_meters": yMax
     * }
     * ```
     */
    @objc public class func setRoom(_ deviceId: String,
                                    xMin: Double,
                                    xMax: Double,
                                    yMax: Double,
                                    locationId: PPLocationId,
                                    callback: @escaping ((Error?) -> (Void))) {
        let address = "set_vayyar_room"
        let feed: [String: Any] = [
            "device_id": deviceId,
            "x_left_meters": xMin,
            "x_right_meters": xMax,
            "y_max_meters": yMax
        ]
        
        PPBotengine.postDataStream(.invdividual, address: address, locationId: locationId, organizationId: .none, feed: feed, appInstanceId: PPBotengineAppInstanceId.none.rawValue, callback: callback)
    }
    
    /**
     * # Set a Subregion
     *
     * Data Stream Address : `set_vayyar_subregion`
     *
     * There can be only 4 subregions maximum. Their ID's are 0, 1, 2, or 3.
     *
     * # Set Subregion Properties
     *
     * Parameters:
     * - `deviceId` String Device ID to apply this subregion to
     * - `subregionId` NSNumber Optional Used primarily for modifying or deleting. 0, 1, 2, or 3 and nothing else. You can specify the next valid integer to insert a new subregion, but out-of-bounds values are ignored.
     * - `contextId` Int Context / behavior of this subregion
     * - `xMin` Double Looking into the room from the device, this is the left-most side of the sub-region. Remember to the left of Vayyar Home is negative numbers on the x-axis.
     * - `xMax` Double Looking into the room from the device, this is the right-most side of the sub-region.
     * - `yMin` Double Distance from the Vayyar Home to the nearest side of the sub-region.
     * - `yMax` Double Distance from the Vayyar Home to the farthest side of the sub-region.
     * - `detectFalls` NSNumber Optional True to detect falls in this room, False to avoid detecting fall (default is True).
     * - `detectPresence` NSNumber Optional True to detect people, False to not detect people (default is True).
     * - `enterDuration` NSNumber Optional Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
     * - `exitDuration` NSNumber Optional Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
     *
     * # Set Subregion Example
     *
     * ```
     * {
     *     "device_id": deviceId,
     *     "subregion_id": subregionId,
     *     "context_id": contextId,
     *     "x_min_meters": xMin,
     *     "x_max_meters": xMax,
     *     "y_min_meters": yMin,
     *     "y_max_meters": yMax,
     *     "detect_falls": detectFalls,
     *     "detect_presence": detectPresence,
     *     "enter_duration_s": enterDuration,
     *     "exit_duration_s": exitDuration
     * }
     * ```
     */
    @objc public class func setSubregion(_ deviceId: String,
                                         subregionId: NSNumber?,
                                         contextId: Int,
                                         xMin: Double,
                                         xMax: Double,
                                         yMin: Double,
                                         yMax: Double,
                                         detectFalls: NSNumber?,
                                         detectPresence: NSNumber?,
                                         enterDuration: NSNumber?,
                                         exitDuration: NSNumber?,
                                         locationId: PPLocationId,
                                         callback: @escaping ((Error?) -> (Void))) {
        let address = "set_vayyar_subregion"
        var feed: [String: Any] = [
            "device_id": deviceId,
            "context_id": contextId,
            "x_min_meters": xMin,
            "x_max_meters": xMax,
            "y_min_meters": yMax,
            "y_min_meters": yMax
        ]
        feed["subregion_id"] = subregionId?.intValue
        feed["detect_falls"] = detectFalls?.boolValue
        feed["detect_presence"] = detectPresence?.boolValue
        feed["enter_duration_s"] = enterDuration?.intValue
        feed["exit_duration_s"] = exitDuration?.intValue
        
        PPBotengine.postDataStream(.invdividual, address: address, locationId: locationId, organizationId: .none, feed: feed, appInstanceId: PPBotengineAppInstanceId.none.rawValue, callback: callback)
    }

    
    /**
     * # Delete a Subregion
     *
     * Data Stream Address : `delete_vayyar_subregion`
     *
     * If you want to delete all subregions for a given device, simply do not pass in a `subregion_id`.
     *
     * # Delete a Subregion Properties
     *
     * Parameters:
     * - `deviceId` String Device ID to apply this subregion to
     * - `subregionId` NSNumber Optional Used primarily for modifying or deleting. 0, 1, 2, or 3 and nothing else. You can specify the next valid integer to insert a new subregion, but out-of-bounds values are ignored.
     *
     * # Delete a Subregion example
     *
     * ```
     * {
     *     "device_id": deviceId,
     *     "subregion_id": subregionId
     * }
     * ```
     */
    @objc public class func deleteSubregion(_ deviceId: String,
                                            subregionId: String?,
                                            locationId: PPLocationId,
                                            callback: @escaping ((Error?) -> (Void))) {
        let address = "delete_vayyar_subregion"
        var feed: [String: Any] = [
            "device_id": deviceId,
        ]
        feed["subregion_id"] = subregionId

        PPBotengine.postDataStream(.invdividual, address: address, locationId: locationId, organizationId: .none, feed: feed, appInstanceId: PPBotengineAppInstanceId.none.rawValue, callback: callback)
    }
    
    /**
     *
     * # Set Configuration
     *
     * Data Stream Address : `set_vayyar_config`
     *
     * Parameters
     * - `deviceId` String Device ID to apply this configuration
     * - `fallSensitivity` NSNumber Optional Fall sensitivity: 1 = low; 2 = normal
     * - `alertDelay` NSNumber Optional Alert delay in seconds
     * - `ledMode` NSNumber Optional LED mode on/off
     * - `telementryPolicy` NSNumber Optional Telementry Policy: 0 = off; 1 = on; 2 = falls only
     * - `volume` NSNumber Optional Volume
     * - `reportingRate` NSNumber Optional Reporting rate in milliseconds
     * - `silentMode` NSNumber Optional Silent mode on/off
     * - `targetChangeThreshold` NSNumber Optional Target change threshold in meters
     *
     * # set_vayyar_config Example
     *
     * All fields are optional except for device_id.
     * ```
     * {
     *     "device_id": deviceId,
     *     "fall_sensitivity": fallSensitivity,
     *     "alert_delay_s": alertDelay,
     *     "led_mode": ledMode,
     *     "telemetry_policy": telementryPolicy,
     *     "volume": volume,
     *     "reporting_rate_ms": reportingRate,
     *     "silent_mode": silentMode,
     *     "target_change_threshold_m": targetChangeThreshold
     * }
     * ```
     */
    
    @objc public class func setConfiguration(_ deviceId: String,
                                             fallSensitivity: NSNumber?,
                                             alertDelay: NSNumber?,
                                             ledMode: NSNumber?,
                                             telementryPolicy: NSNumber?,
                                             volume: NSNumber?,
                                             reportingRate: NSNumber?,
                                             silentMode: NSNumber?,
                                             targetChangeThreshold: NSNumber?,
                                             locationId: PPLocationId,
                                             callback: @escaping ((Error?) -> (Void))) {
        let address = "set_vayyar_config"
        var feed: [String: Any] = [
            "device_id": deviceId,
        ]
        feed["fall_sensitivity"] = fallSensitivity?.intValue
        feed["alert_delay_s"] = alertDelay?.intValue
        feed["led_mode"] = ledMode?.boolValue
        feed["volume"] = volume?.intValue
        feed["telemetry_policy"] = telementryPolicy?.intValue
        feed["reporting_rate_ms"] = reportingRate?.intValue
        feed["silent_mode"] = silentMode?.boolValue
        feed["target_change_threshold_m"] = targetChangeThreshold?.doubleValue

        PPBotengine.postDataStream(.invdividual, address: address, locationId: locationId, organizationId: .none, feed: feed, appInstanceId: PPBotengineAppInstanceId.none.rawValue, callback: callback)
    }
}

extension PPVayyarRoom {
    
}
