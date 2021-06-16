//
//  PPAdminBilling.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminBilling : PPBaseModel {
    
    // MARK: - Billing

    // MARK: - Billing

    /**
     Generate Bill
     The API (re)generates a bill for one billing period (month). The generated bill is saved in the database and displayed in the response body. The response body also displays the input data used to calculate the bill.By default, the target billing period is the previous month. You can specify any other target period using the parameter 'date'.The API is mainly intended for testing purposes. There is a recurring background process that generates bills for all organizations on a monthly basis.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func generateBill(_ organizationId: PPOrganizationId,
                                         date: Date?,
                                         callback: @escaping ((String?, Dictionary<String, Any>?, Dictionary<String, Any>?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.billing.generateBill()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, nil, nil, resultCode(toNSError: 29))
    }

    /**
     Get Bills
     The API shows the list of bills generated for the organization for specified date range.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getBills(_ organizationId: PPOrganizationId,
                                    startDate: Date,
                                    endDate: Date?,
                                    callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.billing.getBills()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, resultCode(toNSError: 29))
    }

    /**
     Remove Billing Bot
     The API removes previously assigned specific billing bot, so that a default billing bot will be used for the organization.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func removeBillingBot(_ organizationId: PPOrganizationId,
                                             callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.billing.removeBillingBot()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(resultCode(toNSError: 29))
    }
}
