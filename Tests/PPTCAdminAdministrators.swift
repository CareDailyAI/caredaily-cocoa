//
//  PPTCAdminAdministrators.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminAdministrators";

class PPTCAdminAdministrators: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Roles    

    func testGetRoles() throws {
        let methodName = "GetRoles";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/roles", statusCode: 200, headers: nil)
        
        PPAdminAdministrators.getRoles { roles, error in
            XCTAssertNil(error)
            XCTAssertTrue(roles?.count == 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Grant Administrative Roles
    
    func testGrantAdministrativeRoles() throws {
        let methodName = "GrantAdministrativeRoles";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/users/0/roles/0", statusCode: 200, headers: nil)
        
        PPAdminAdministrators.grantAdministrativeRoles(PPUserId(rawValue: 0), roleId: 0) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // MARK: - Revoke Administrative Roles
    
    func testRevokeAdministrativeRoles() throws {
        let methodName = "RevokeAdministrativeRoles";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/users/0/roles", statusCode: 200, headers: nil)
        
        PPAdminAdministrators.revokeAdministrativeRoles(PPUserId(rawValue: 0)) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }


}
