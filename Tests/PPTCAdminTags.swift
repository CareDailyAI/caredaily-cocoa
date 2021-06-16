//
//  PPTCAdminTags.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminTags";

class PPTCAdminTags: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Tags
    
    func testPopularTags() throws {
        let methodName = "PopularTags";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminTags.popularTags(.none, type: 0, limit: nil) { tags, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testApplyTags() throws {
        let methodName = "ApplyTags";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminTags.applyTags(.none, tags: [:]) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteTags() throws {
        let methodName = "DeleteTags";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminTags.deleteTags(.none, type: 0, id: "", tag: "", appId: nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
