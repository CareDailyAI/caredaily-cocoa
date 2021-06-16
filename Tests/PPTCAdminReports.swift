//
//  PPTCAdminReports.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminReports";

class PPTCAdminReports: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Report Groups
    
    func testGetGroups() throws {
        let methodName = "GetGroups";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminReports.getGroups(.none) { groups, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPutGroupOrganizationStatus() throws {
        let methodName = "PutGroupOrganizationStatus";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminReports.putGroupOrganizationStatus(.none, groupId: nil, status: 0) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Reports
    
    func testGetReports() throws {
        let methodName = "GetReports";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminReports.getReports(nil, organizationId: .none, reportGroupId: nil, analytic: nil) { reports, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Generate Report
    
    func testGenerateReport() throws {
        let methodName = "GenerateReport";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminReports.generateReports(0, outputType: 0, deliveryType: 0, organizationId: .none) { report, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Report Execution Data
    
    func testGetReportExecutionData() throws {
        let methodName = "GetReportExecutionData";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminReports.getReportExecutionData(0, reportGroupId: 0, startDate: Date(), endDate: Date(), organizationId: .none) { executions, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
