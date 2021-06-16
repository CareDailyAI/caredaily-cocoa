//
//  PPAdminChallenges.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminChallenges : PPBaseModel {
    // MARK: - Challenges

    // MARK: - Manage Challenges
    /**
     In a community social network setting, an Engagement Manager may issue challenges to the community, to help achieve the overall goals of the community. These challenges can be for individuals, or for entire groups of locations.Challenges are a really fun way to engage with a large population!
     | Name | Description |
     | ---- | ---- |
     | challengeType | Non-modifiable. 4 - Demand response |
     | template | Non-modifiable. Optional, default is false.; 'True' means the challenge is intended to be used as a template for creating new challenges. In this case, participants are not created. |
     | parentId | Non-modifiable, optional.A reference (challengeId) to the template that was used to create the challenge. When a challenge is created using a template, all the attributes which are not explicitly specified will be copied from the template. |
     | status | Status of the challenge; 0 - Inactive; 1 - Active; 2 - Completed |
     | recurring | Modifiable for templates.; 0 - One-time, not recurring; 3 - Recurring monthly |
     | participantType | Modifiable for templates. 1 - Individual challenge |
     | invitational | Modifiable for templates. true - Locations are invited to the challenge.; false - All locations from this organization can participate. |
     | participationStatus | Modifiable for templates. Initial participation status for invited users.; 1 - Not responded, default; 2 - Opt-In; 3 - Opt-Out |
     | deviceTypeExistance | Modifiable for templates. Optional, default is 0.; 1 - ANY listed device type must exists on the participating location; 2 - ALL device types must exist on the participating location |
     | deviceTypes | Modifiable for templates. A list of device types to filter participants. |
     | excludeDeviceTypes | Modifiable for templates. Exclude locations having any of these devices from the challenge. |
     | participantTag | Modifiable for templates. A tag value to filter participants. |
     | excludeParticipantTag | Modifiable for templates. Exclude locations having this tag. |
     | parameters | Optional. A set of name value pairs in JSON format. |
     */

    /**
     Create a Challenge
     Create a challenge from scratch or from a template.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func createAChallenge(_ organizationId: PPOrganizationId,
                                             check: NSNumber?,
                                             parentId: NSNumber?,
                                             challenge: Dictionary<String, Any>,
                                             callback: @escaping ((NSNumber?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }


    /**
     Get Challenges
     View a list of challenges selected by their parameters. Only admins can see the templates in the search results.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getChallenges(_ organizationId: PPOrganizationId,
                                             status: NSNumber?,
                                             challengeId: NSNumber?,
                                             challengeType: NSNumber?,
                                             searchBy: String?,
                                             parentId: NSNumber?,
                                             callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    // MARK: - Modify Challenges

    /**
     Update a Challenge
     An administrator can modify all template fields except `template` and `challegeType`.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateAChallenge(_ organizationId: PPOrganizationId,
                                             challengeId: Int,
                                             challenge: Dictionary<String, Any>,
                                             callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    /**
     Delete a Challenge
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteAChallenge(_ organizationId: PPOrganizationId,
                                             challengeId: Int,
                                             callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Update Challenge Status

    /**
     Update Challenge Status
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateChallengeStatus(_ organizationId: PPOrganizationId,
                                                  challengeId: Int,
                                                  status: Int,
                                                  callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Challenge Participants

    /**
     Get Participants
     Return invitational challenge participants.Only approved members of the given organization and the challenge participants can call this API.Participation statuses:
     | Status | Name |
     | ---- | ---- |
     | 1 | Not responded |
     | 2 | Opt-In |
     | 3 | Opt-Out |
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getParticipants(_ organizationId: PPOrganizationId,
                                            challengeId: Int,
                                            status: NSNumber?,
                                            locationId: PPLocationId,
                                            callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    /**
     Update Status
     Only approved members of the given organization and the challenge participants can update their participation status to Opt-In or Opt-Out.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateStatus(_ organizationId: PPOrganizationId,
                                         challengeId: Int,
                                         status: Int,
                                         locationId: PPLocationId,
                                         callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }

    // MARK: - Challenge Energy Usage

    /**
     Get Energy Usage
     Return demand response challenge participants energy usage and baseline for the challenge period. The first record contains total information for the whole challenge period. Rest records contain 5 minute interval data.Only approved members of the given organization and the challenge participants can call this API.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getEnergyUsage(_ organizationId: PPOrganizationId,
                                           challengeId: Int,
                                           locationId: PPLocationId,
                                           callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.usersandlocations.deleteUpdateJob()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }
}
