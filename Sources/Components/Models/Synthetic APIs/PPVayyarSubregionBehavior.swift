//
//  PPVayyarSubregionBehavior.swift
//  Peoplepower
//
//  Created by Destry Teeter on 7/1/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

/**
 * # Subregion Behavior
 * Parameters:
 * - `context_id` int Subregion Context ID to apply to this subregion.
 * - `title` String Title of the subregion
 * - `detail` String Optional detail description if it helps - usually the title is enough, but there were a few that deserved a bit more explanation.
 * - `icon` String Icon name
 * - `icon_font` String Icon font to apply
 * - `width_cm` int Recommended width of the subregion, in centimeters
 * - `length_cm` int Recommended length of the subregion, in centimeters
 * - `flexible_cm` Boolean True if the subregion size is flexible from our recommendations, False if this is a standard size
 * - `detect_falls` True to detect falls in this room, False to avoid detecting fall (default is True).
 * - `edit_falls` True to show UI controls for editing fall detection
 * - `detect_presence` True to detect people, False to not detect people (default is True).
 * - `edit_presence` True to show UI controls for editing presence detection
 * - `enter_duration_s` Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
 * - `exit_duration_s` Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
 * - `compatible_behaviors` List List of compatible behavior ID's, as defined in the `behaviors` state
 */
@objc open class PPVayyarSubregionBehavior: PPBaseModel {
    
    @objc open var contextId: PPVayyarContextId = .none
    @objc open var title: String = NSLocalizedString("Ignore this area", comment: "location.device.vayyar.subregion.behavior.ignore");
    @objc open var detail: String? = NSLocalizedString("Select this to prevent false alarms in this area of the room.", comment: "location.device.vayyar.subregion.behavior.ignore.detail")
    @objc open var icon: String = "eye-slash"
    @objc open var iconFont: String = "far"
    @objc open var width: Int = 50
    @objc open var length: Int = 50
    @objc open var flexible: Bool = true
    @objc open var detectFalls: Bool = true
    @objc open var editFalls: Bool = true
    @objc open var detectPresence: Bool = true
    @objc open var editPresence: Bool = true
    @objc open var enterDuration: Int = 3
    @objc open var exitDuration: Int = 3
    @objc open var compatibleBehaviors: RLMArray<PPVayyarCompatibleBehavior> = RLMArray.init(objectClassName: "PPVayyarCompatibleBehavior")
    
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
    
    @objc public convenience init(_ data: Dictionary<String, Any>?) {
        self.init()
        if let contextId = data?["context_id"] as? Int {
            self.contextId = PPVayyarContextId(rawValue: contextId) ?? .none
        }
        if let title = data?["title"] as? String {
            self.title = title
        }
        self.detail = data?["detail"] as? String
        if let icon = data?["icon"] as? String {
            self.icon = icon
        }
        if let iconFont = data?["icon_font"] as? String {
            self.iconFont = iconFont
        }
        if let width = data?["width_cm"] as? Int {
            self.width = width
        }
        if let length = data?["length_cm"] as? Int {
            self.length = length
        }
        if let flexible = data?["flexible_cm"] as? Bool {
            self.flexible = flexible
        }
        if let detectFalls = data?["detect_falls"] as? Bool {
            self.detectFalls = detectFalls
        }
        if let editFalls = data?["edit_falls"] as? Bool {
            self.editFalls = editFalls
        }
        if let detectPresence = data?["detect_presence"] as? Bool {
            self.detectPresence = detectPresence
        }
        if let editPresence = data?["edit_presence"] as? Bool {
            self.editPresence = editPresence
        }
        if let enterDuration = data?["enter_duration_s"] as? Int {
            self.enterDuration = enterDuration
        }
        if let exitDuration = data?["exit_duration_s"] as? Int {
            self.exitDuration = exitDuration
        }
        if let compatibleBehaviors = data?["compatible_behaviors"] as? [Int] {
            let array: RLMArray<PPVayyarCompatibleBehavior> = RLMArray.init(objectClassName: "PPVayyarCompatibleBehavior")
            array.addObjects(compatibleBehaviors.map { PPVayyarCompatibleBehavior($0) } as NSFastEnumeration)
            self.compatibleBehaviors = array
        }
    }
}

@objc public class PPVayyarCompatibleBehavior : PPBaseModel {
    @objc public var behaviorId: Int = 0
    @objc public convenience init(_ behaviorId: Int) {
        self.init()
        self.behaviorId = behaviorId
    }
}
