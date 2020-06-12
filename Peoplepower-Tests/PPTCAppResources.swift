//
//  PPTCAppResources.swift
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 6/12/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@testable import Peoplepower

class PPTCAppResources: PPBaseTestCase {
    
    var entry: Any?
    
    func testRetrieval() throws {
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_APP_NAME, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing App Name")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_APP_DESCRIPTION, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing App Description")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_COMPANY_NAME, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing Company Name")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_COMPANY_DESCRIPTION, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing Company Description")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_BRAND, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing Brand")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_CONFIG_CLOUD, filename: PP_PLIST_FILE_CONFIG)
        XCTAssertNotNil(entry, "Missing Cloud")
        
        entry = PPAppResources.getPlistEntry(PP_PLIST_KEY_ATTRIBUTIONS_ATTRIBUTIONS, filename: PP_PLIST_FILE_ATTRIBUTIONS)
        XCTAssertNotNil(entry, "Missing Attributions")
    }
    
}
