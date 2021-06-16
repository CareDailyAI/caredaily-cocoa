//
//  PPTCAdminOrganizations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminOrganizations";

class PPTCAdminOrganizations: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Manage an Organization

    func testGetOrganizations() throws {
        let methodName = "GetOrganizations";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getOrganizations { organizations, error in
            XCTAssertNil(error)
            XCTAssertTrue(organizations?.count == 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCreateAnOrganization() throws {
        let methodName = "CreateAnOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.createAnOrganization(.none, organization: PPOrganization()) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateOrganization() throws {
        let methodName = "UpdateOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.updateOrganization(.none, organization: PPOrganization()) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteOrganization() throws {
        let methodName = "DeleteOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.deleteOrganization(.none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Organization Large Objects
    
    func testUploadLargeObject() throws {
        let methodName = "UploadLargeObject";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.uploadLargeObject(.none, objectName: "", private: .none, data: Data()) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetObjectContent() throws {
        let methodName = "GetObjectContent";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getObjectContent(.none, objectName: "") { data, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteContent() throws {
        let methodName = "DeleteContent";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.deleteContent(.none, objectName: "") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Organization Objects and Properties
    
    func testListObjectsAndProperties() throws {
        let methodName = "ListObjectsAndProperties";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.listObjectsAndProperties(.none) { objectsAndProperties, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSetProperties() throws {
        let methodName = "SetProperties";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.setProperties(.none, properties: []) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Get Organization Administrators
    
    func testGetAdministrators() throws {
        let methodName = "GetAdministrators";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getAdministrators(.none) { users, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Manage Organization Administrators
    
    func testAddAnAdministrator() throws {
        let methodName = "AddAnAdministrator";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.addAnAdministrator(.none, userId: .none, brand: nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRemoveAdministrator() throws {
        let methodName = "RemoveAdministrator";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.removeAdministrator(.none, userId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Organization Totals
    
    func testGetOrganizationTotals() throws {
        let methodName = "GetOrganizationTotals";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getOrganizationTotals(.none, locations: false, groupLocations: false, userDevices: false, groupDevices: false, groupId: .none, locationId: .none) { totals, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
