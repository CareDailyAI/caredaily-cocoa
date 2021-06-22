//
//  PPTCAdminDevices.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminDevices";

class PPTCAdminDevices: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Devices

    func testGetDevices() throws {
        let methodName = "GetDevices";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/devices", statusCode: 200, headers: nil)
        
        PPAdminDevices.getDevices(.none, groupId: .none, userId: .none, locationId: .none, deviceId: nil, deviceTypes: nil, searchBy: .none, searchTag: nil, lessUpdateDate: nil, moreUpdateDate: nil, paramName: nil, paramValue: nil, limit: nil, getTags: nil) { devices, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
