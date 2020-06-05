//
//  PPDeviceFirmwareUpdates.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceFirmwareUpdates.h"

@implementation PPDeviceFirmwareUpdates

__strong static PPDeviceFirmwareUpdates *_sharedFirmwareUpdates = nil;

/**
 * Shared user across the entire application
 * nil if no user is logged in
 */
+ (PPDeviceFirmwareUpdates *)sharedFirmwareUpdates {
    if(!_sharedFirmwareUpdates) {
        _sharedFirmwareUpdates = [[PPDeviceFirmwareUpdates alloc] initWithFirmwareUpdates:[[NSMutableDictionary alloc] initWithCapacity:0] currentUpdate:nil];
    }
    return _sharedFirmwareUpdates;
}

- (id)initWithFirmwareUpdates:(NSMutableDictionary *)firmwareUpdates currentUpdate:(PPDeviceFirmwareUpdateJob *)currentFirmwareUpdate {
    self = [super init];
    if(self) {
        _sharedFirmwareUpdates = self;
        _firmwareUpdates = firmwareUpdates;
        [self setCurrentFirmwareUpdate:currentFirmwareUpdate];
        
    }
    
    return _sharedFirmwareUpdates;
}

- (void)setCurrentFirmwareUpdate:(PPDeviceFirmwareUpdateJob *)currentFirmwareUpdate {
    _currentFirmwareUpdate = currentFirmwareUpdate;
}

@end
