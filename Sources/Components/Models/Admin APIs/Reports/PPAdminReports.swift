//
//  PPAdminReports.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminReports : NSObject {
    
    // MARK: - Reports
    /**
     The IoT Software Suite provides online reports for different purposes.
     */

    // MARK: - Report Groups
    /**
     Organization Statuses
     | Status | Description |
     | ---- | ---- |
     | 0 | Not assigned |
     | 1 | Active |
     | 2 | Inactive |
     */

    /**
     Get Groups
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getGroups(_ organizationId: PPOrganizationId,
                                      callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.reports.getGroups()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }
    
    /**
     Put Group Organization Status
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func putGroupOrganizationStatus(_ organizationId: PPOrganizationId,
                                                       groupId: NSNumber?,
                                                       status: Int,
                                                       callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.reports.putGroupOrganizationStatus()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Reports
    /**
     This API provides information about available reports and report groups.
     */
    /**
     Get Reports
     Returns the list of reports available for an organization or a list of system reports if organization is not specified.For each report, the API returns the report id, report name, description, parameters and fields. Also, each report entry contains a list of report groups to which the report is included.
     
     Data Types
     The report parameters and fields have a the attribute 'type' that designates their data type:
     | ID | Type |
     | ---- | ---- |
     | 1 | string |
     | 2 | integer |
     | 3 | date-time |
     | 4 | decimal |
     | 5 | boolean |

     Report Fields
     Each report field entry includes the attribute 'index' that is an ordinal number of the field (starting with 1).Report Datetime ParametersThe following formats for entering date and time are allowed for the datetime parameters (of type 3):
     | Format | Examples |
     | ISO-8601 extended local date format | '2020-07-17' |
     | ISO-8601 extended local date-time format | '2020-07-17T10:15:30' |
     | ISO-8601 extended offset date-time format | '2020-07-17T10:15:30+03:00' |
     | Special format for current date time | '{now}' |
     | Special format for a date several hours prior or after the current date | '{now}-6h', '{now}+1h' |
     | Special format for a date several days prior or after the current date | '{now}-7d', '{now}+2d' |
     | Special format for a date several months prior or after the current date | '{now}-3m', '{now}+1m' |
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getReports(_ reportId: NSNumber?,
                                       organizationId: PPOrganizationId,
                                       reportGroupId: NSNumber?,
                                       analytic: NSNumber?,
                                       callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.reports.getReports()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Generate Report
    /**
     Generate specific report. The result can provided in CSV or HTML format. Long generated reports can be delivered by email.All report parameters should be provided in the query string.
     */

    /**
     Generate Report
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func generateReports(_ reportId: Int,
                                            outputType: Int,
                                            deliveryType: Int,
                                            organizationId: PPOrganizationId,
                                            callback: @escaping ((String?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.reports.generateReports()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Report Execution Data
    /** The API returns the saved data of the report executions. Reports are executed according to the schedules defined for the report groups to which they belong.The output format of the report data depends on whether the report is analytical or not.For analytical reports the output is a single-row data and is returned by the API in the form of key-value pairs where key is the report field ID;For non-analytical reports the output is a set of rows of comma-separated values stored as a zip archive in AWS S3. The API returns the pre-signed URL for downloading the stored objects.
     */

    /**
     Get Report Execution Data
     In this example, the API response for both analytical and non-analytical reports is presented. Real responses will return either 'url' or 'data' and 'dictionary' element.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getReportExecutionData(_ reportId: Int,
                                                   reportGroupId: Int,
                                                   startDate: Date,
                                                   endDate: Date,
                                                   organizationId: PPOrganizationId,
                                                   callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.reports.getReportExecutionData()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }
}
