//
//  PPLog.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

import Foundation
import os

// Setup the PFLog function to only log items when we're in debug mode
#if DEBUG
public func PPLog(_ file: String, message: String) {
    os_log("%@", "\(URL(fileURLWithPath:file).lastPathComponent) \(message)")
}
#else
public func PPLog(_ file: String, message: String) {}
#endif

#if DEBUG_MODELS
public func PPLogModels(_ file: String, message: String) {
    PPLog(file, message: message)
}
#else
public func PPLogModels(_ file: String, message: String) {}
#endif

#if DEBUG_APIS
public func PPLogAPIs(_ file: String, message: String) {
    PPLog(file, message: message)
}
#else
public func PPLogAPIs(_ file: String, message: String) {}
#endif
