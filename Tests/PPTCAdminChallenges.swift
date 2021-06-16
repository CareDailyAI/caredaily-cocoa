//
//  PPTCAdminChallenges.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminChallenges";

class PPTCAdminChallenges: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Manage Challenges
    
    func testCreateAChallenge() throws {
        let methodName = "CreateAChallenge";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.createAChallenge(.none, check: nil, parentId: nil, challenge: [:]) { challengeId, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetChallenges() throws {
        let methodName = "GetChallenges";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.getChallenges(.none, status: nil, challengeId: nil, challengeType: nil, searchBy: nil, parentId: nil) { challenges, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Modify Challenges
    
    func testUpdateAChallenge() throws {
        let methodName = "UpdateAChallenge";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.updateAChallenge(.none, challengeId: 0, challenge: [:]) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteAChallenge() throws {
        let methodName = "DeleteAChallenge";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.deleteAChallenge(.none, challengeId: 0) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Update Challenge Status
    
    func testUpdateChallengeStatus() throws {
        let methodName = "UpdateChallengeStatus";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.updateChallengeStatus(.none, challengeId: 0, status: 0) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Challenge Participants
    
    func testGetParticipants() throws {
        let methodName = "GetParticipants";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.getParticipants(.none, challengeId: 0, status: nil, locationId: .none) { participants, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateStatus() throws {
        let methodName = "UpdateStatus";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.updateStatus(.none, challengeId: 0, status: 0, locationId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Challenge Energy Usage
    
    func testGetEnergyUsage() throws {
        let methodName = "GetEnergyUsage";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminChallenges.getEnergyUsage(.none, challengeId: 0, locationId: .none) { usages, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
