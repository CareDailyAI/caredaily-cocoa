//
//  PPTCLocalization.swift
//  Tests
//
//  Created by Destry Teeter on 1/11/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import XCTest
import Peoplepower

fileprivate struct L10N {
    static func verify(_ key: String, forLocale localeIdentifier: String, inTable table: String? = nil)  -> Bool {
        guard
            let bundle = PPBaseModel.bundle(),
            let path = bundle.path(forResource: localeIdentifier, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
                return false
        }

        let string = bundle.localizedString(forKey: key, value: key, table: nil)
        debugPrint(key, string)
        return string != key
    }
}

class PPTCLocalization: PPBaseTestCase {
    func testUrl() throws {
        XCTAssertTrue(L10N.verify("language.code", forLocale: "en"))
        XCTAssertTrue(L10N.verify("language.code", forLocale: "es"))
        
    }
}
