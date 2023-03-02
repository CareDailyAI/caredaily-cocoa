//
//  PPTCAdminFirmware.swift
//  Tests
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import XCTest

private let moduleName = "AdminFirmware";

class PPTCAdminFirmware: PPBaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Firmware Version
    
    func testUploadFirmwareVersion() throws {
        let methodName = "UploadFirmwareVersion";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.uploadFirmwareVersion(PPDeviceTypeId(rawValue: 0), firmware: "", fileName: "", checkSum: "", index: nil, data: Data()) { versionId, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFirmwareVersions() throws {
        let methodName = "GetFirmwareVersions";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.getFirmwareVersions(PPDeviceTypeId(rawValue: 0)) { versions, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteFirmwareVersions() throws {
        let methodName = "DeleteFirmwareVersions";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.deleteFirmwareVersions(0) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Firmware Update Jobs
    
    func testCreateUpdateJob() throws {
        let methodName = "CreateUpdateJob";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.createUpdateJob(0, forced: nil, groupId: .none) { jobId, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetUpdateJobs() throws {
        let methodName = "GetUpdateJobs";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.getUpdateJobs(PPDeviceTypeId(rawValue: 0), groupId: .none) { jobs, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteUpdateJob() throws {
        let methodName = "DeleteUpdateJob";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.deleteUpdateJob(.none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    // MARK: - Firmware Group
    
    func testUpdateFirmwareGroupForDevice() throws {
        let methodName = "UpdateFirmwareGroupForDevice";
        let expectation = XCTestExpectation(description: methodName)
        stubRequest(forModule: moduleName, methodName: methodName, ofType: "json", path: "/admin/json/", statusCode: 200, headers: nil)
        
        PPAdminFirmware.updateFirmwareGroupForDevice("", groupId: .none) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
