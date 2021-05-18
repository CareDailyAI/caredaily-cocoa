//
//  PPTCVersion.swift
//  PeoplepowerTests
//
//  Created by Destry Teeter on 6/5/20.
//  Copyright © 2020 peoplepowerco. All rights reserved.
//

@testable import Peoplepower

class PPTCVersion: PPBaseTestCase {
    
    func testBundleVersion() throws {
        let bundleVersion = PPVersion.bundle()
        XCTAssertTrue("\(bundleVersion.major).\(bundleVersion.minor)" == "\(PeoplepowerVersionNumber)", "Failure comparing bundle versions")
    }
    
    func testComparisons() throws {
        let v1 = PPVersion(version: "1.0.0")
        let v2 = PPVersion(version: "2.0.0")
        
        XCTAssertTrue(v1.isOlderThan(v2), "Version is not older")
        XCTAssertTrue(v2.isNewerThan(v1), "Version is not newer")
        XCTAssertTrue(v2.isNewerThanOrEqual(to: v1), "Version is not newer or equal")
        XCTAssertTrue(v1.toNSString() == "1.0.0", "Version string is incorrect")
        XCTAssertTrue(v2.toNSString() == "2.0.0", "Version string is incorrect")
    }
}
