//
//  PPTCSyntheticVayyarHome.swift
//  Tests
//
//  Created by Destry Teeter on 7/1/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "SyntheticVayyarHome";

class PPTCSyntheticVayyarHome: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRoomBoundaries() throws {
        let methodName = "GetRoomBoundaries";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/cloud/json/locations/1/state", statusCode: 200, headers: nil)
        
        PPVayyarHome.getRoomBoundaries(PPLocationId(rawValue: 1)) { rooms, error in
            XCTAssertNil(error)
            XCTAssertTrue(rooms?.count == 3)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetSubregions() throws {
        let methodName = "GetSubregions";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/cloud/json/locations/1/state", statusCode: 200, headers: nil)
        
        PPVayyarHome.getSubregions(PPLocationId(rawValue: 1)) { subregions, error in
            XCTAssertNil(error)
            XCTAssertTrue(subregions?.count == 6)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetSubregionBehaviors() throws {
        let methodName = "GetSubregionBehaviors";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/cloud/json/locations/1/state", statusCode: 200, headers: nil)
        
        PPVayyarHome.getSubregionBehaviors(PPLocationId(rawValue: 1)) { behaviors, error in
            XCTAssertNil(error)
            XCTAssertTrue(behaviors?.count == 16)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
