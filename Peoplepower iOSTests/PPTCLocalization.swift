//
//  PPTCLocalization.swift
//  Peoplepower iOSTests
//
//  Created by Destry Teeter on 1/11/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

class PPTCLocalization: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBundle() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let bundle = Bundle(identifier: "com.peoplepowerco.lib.Peoplepower.iOS") else {
            print("NO BUNDLE")
            return
        }
        let s = NSLocalizedString("en", tableName: nil, bundle: bundle, comment: "")
        print("\(s)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
