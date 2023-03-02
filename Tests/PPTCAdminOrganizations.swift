//
//  PPTCAdminOrganizations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2023 People Power Company. All rights reserved.
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
        
        PPAdminOrganizations.getOrganizations(.none, domainName: nil, name: nil) { organizations, error in
            XCTAssertNil(error)
            XCTAssertTrue(organizations?.count == 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCreateAnOrganization() throws {
        let methodName = "CreateAnOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.createAnOrganization(.none, name: nil, domainName: nil, brand: nil, features: nil, deviceTypes: nil, termsOfService: nil, contactName1: nil, contactEmail1: nil, contactPhone1: nil, contactName2: nil, contactEmail2: nil, contactPhone: nil, officePhone: nil, addrStreet1: nil, addrStreet2: nil, addrCitry: nil, stateId: .none, countryId: .none, zip: nil) { organizationId, error in
            print(error)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateOrganization() throws {
        let methodName = "UpdateOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.updateOrganization(.none, name: nil, domainName: nil, brand: nil, features: nil, deviceTypes: nil, termsOfService: nil, contactName1: nil, contactEmail1: nil, contactPhone1: nil, contactName2: nil, contactEmail2: nil, contactPhone: nil, officePhone: nil, addrStreet1: nil, addrStreet2: nil, addrCitry: nil, stateId: .none, countryId: .none, zip: nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteOrganization() throws {
        let methodName = "DeleteOrganization";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations", statusCode: 200, headers: nil)
        
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
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/objects/My object", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.uploadLargeObject(PPOrganizationId(rawValue: 1), objectName: "My object", private: .none, data: Data(), contentType: "image/jpeg") { progress in
            
        } callback: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetObjectContent() throws {
        let methodName = "GetObjectContent";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "data", path: "/admin/json/organizations/1/objects/My object", statusCode: 200, headers: [
            "Content-Type": "img/png",
            "Content-Range": "bytes 21010-47021/47022",
            "Accept-Ranges": "0-47022",
            "Content-Disposition": "attachment",
        ])
        
        PPAdminOrganizations.getObjectContent(PPOrganizationId(rawValue: 1), objectName: "My object", isPublic: .none) { data, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteObject() throws {
        let methodName = "DeleteObject";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/objects/My object", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.deleteObject(PPOrganizationId(rawValue: 1), objectName: "My object") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Organization Objects and Properties
    
    func testListObjectsAndProperties() throws {
        let methodName = "ListObjectsAndProperties";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/objects", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.listObjectsAndProperties(PPOrganizationId(rawValue: 1)) { objectsAndProperties, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSetProperties() throws {
        let methodName = "SetProperties";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/objects", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.setProperties(PPOrganizationId(rawValue: 1), properties: []) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Get Organization Administrators
    
    func testGetAdministrators() throws {
        let methodName = "GetAdministrators";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/admins", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getAdministrators(PPOrganizationId(rawValue: 1)) { users, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Manage Organization Administrators
    
    func testAddAnAdministrator() throws {
        let methodName = "AddAnAdministrator";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/admins/1", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.addAnAdministrator(PPOrganizationId(rawValue: 1), userId: PPUserId(rawValue: 1), brand: nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRemoveAdministrator() throws {
        let methodName = "RemoveAdministrator";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/admins/1", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.removeAdministrator(PPOrganizationId(rawValue: 1), userId: PPUserId(rawValue: 1)) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Organization Totals
    
    func testGetOrganizationTotals() throws {
        let methodName = "GetOrganizationTotals";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/organizations/1/totals", statusCode: 200, headers: nil)
        
        PPAdminOrganizations.getOrganizationTotals(PPOrganizationId(rawValue: 1), locations: false, groupLocations: false, userDevices: false, groupDevices: false, groupId: .none, locationId: .none) { totals, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
