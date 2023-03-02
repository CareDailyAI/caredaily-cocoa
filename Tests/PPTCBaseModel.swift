//
//  PPTCBaseModel.swift
//  Tests
//
//  Created by Destry Teeter on 6/21/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import XCTest

class PPTCBaseModel_swift: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrorCodes() throws {
        let error = PPBaseModel.resultCode(toNSError: 0)
        XCTAssertNil(error)
            
        let lockTimeout = 300
        let lockTime: Date = Date(timeIntervalSinceNow: TimeInterval(lockTimeout))
        let lockedErrorResponse = "{\"lockTime\": \(lockTime.timeIntervalSince1970 * 1000), \"lockTimeout\": \(lockTimeout * 1000), \"resultCode\": 19, \"resultCodeDesc\": \"This operation is temporary locked\"}"
        XCTAssertThrowsError(try PPBaseModel.processJSONResponse(lockedErrorResponse.data(using: .utf8)))
    }

}
