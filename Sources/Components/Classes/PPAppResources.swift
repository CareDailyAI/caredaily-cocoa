//
//  PPAppResources.swift
//  Peoplepower
//
//  Created by Destry Teeter on 3/15/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

import Foundation

@objc public final class PPAppResources : NSObject { }

extension PPAppResources {
    @objc public class func getPlistEntry(_ key: String, filename: String) -> NSObject? {
        
        var value: NSObject?
        
        let configurations: [[Bundle : String]] = [
            [Bundle(for: self): filename],
            [Bundle.main: filename],
            [Bundle.main: "\(filename)-Override"],
        ]
        
        for (configuration) in configurations {
            for (bundle, filename) in configuration {
                if let filePath = bundle.path(forResource: filename, ofType: "plist"),
                    let plist = NSDictionary(contentsOfFile: filePath),
                    let _value = PPAppResources.plistEntry(key: key, inPlist: plist) {
                    value = _value
                }
            }
        }
        
        return value
    }
}

fileprivate extension PPAppResources {
    class func plistEntry(key: String, inPlist plist: NSDictionary) -> NSObject? {
        for (k,v) in plist {
            if let plistKey = k as? String {
                if plistKey == key {
                    if let value = v as? NSObject {
                        return value
                    }
                }
                else if let subPlist = plist.object(forKey: plistKey) as? NSDictionary {
                    for (k2,v2) in subPlist {
                        if let subPlistKey = k2 as? String,
                            subPlistKey == key {
                            if let value = v2 as? NSObject {
                                return value
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
}
