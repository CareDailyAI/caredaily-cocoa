//
//  PPTCAdminUsersAndLocations.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminUsersAndLocations";

class PPTCAdminUsersAndLocations: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Get Users
    
    func testGetUsers() throws {
        let methodName = "GetUsers";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.getUsers(.none, groupId: .none, locationId: .none, searchBy: nil, searchAddress: nil, servicePlanId: .none, searchTag: nil, limit: nil, getTags: nil) { users, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Locations in an Organization
    
    func testGetLocations() throws {
        let methodName = "GetLocations";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.getLocations(.none, groupId: .none, locationId: .none, tree: nil, searchBy: nil, locationType: nil, searchTags: nil, searchDeviceTags: nil, deviceTypes: nil, servicePlanId: .none, stateId: .none, countryId: .none, priorityCategory: nil, getTags: nil, limit: nil) { locations, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCreateLocation() throws {
        let methodName = "CreateLocation";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.createLocation(.none, groupId: .none, parentId: .none, userId: .none, location: PPLocation()) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testEditLocation() throws {
        let methodName = "EditLocation";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.editLocation(.none, locationId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteLocation() throws {
        let methodName = "DeleteLocation";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.deleteLocation(.none, locationId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Manage Locations
    
    func testAddOrUpdateOrRemovelocations() throws {
        let methodName = "AddOrUpdateOrRemovelocations";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.addOrUpdateOrRemoveLocations(.none, locationIds: [], groupId: .none, notes: nil) { narratives, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Narratives
    
    func testGetOrganizationNarratives() throws {
        let methodName = "GetOrganizationNarratives";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.getOrganizationNarratives(.none, groupId: .none, searchTags: nil, locationIds: nil, narrativeTime: nil, narrativeId: .none, narrativeTypes: nil, priority: .none, toPriority: .none, status: nil, searchBy: nil, startDate: nil, endDate: nil, rowCount: 0, pageMarker: nil) { narratives, pageMarker, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Invite Users
    
    func testPostInvitation() throws {
        let methodName = "PostInvitation";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.postInvitiation(.none, reinvite: nil, emails: nil, userIds: nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Groups of Locations
    
    func testCreateAGroup() throws {
        let methodName = "CreateAGroup";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.createAGroup(.none, groupType: .none, hidden: false, name: "") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetGroups() throws {
        let methodName = "GetGroups";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.getGroups(.none, subOrg: nil, groupId: .none, searchBy: nil, type: .none, locationTotals: nil) { groups, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Manage Groups
    
    func testUpdateAGroup() throws {
        let methodName = "UpdateAGroup";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.updateAGroup(.none, groupId: .none, groupType: .none, hidden: false, name: "") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteAGroup() throws {
        let methodName = "DeleteAGroup";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminUsersAndLocations.deleteAGroup(.none, groupId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
