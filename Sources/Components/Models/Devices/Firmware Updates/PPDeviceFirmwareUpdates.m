//
//  PPDeviceFirmwareUpdates.m
//  Peoplepower
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
        _sharedFirmwareUpdates = [[PPDeviceFirmwareUpdates alloc] initWithFirmwareUpdates:[[PPDeviceFirmwareUpdatesFirmwareUpdates alloc] init] currentUpdate:nil];
    }
    return _sharedFirmwareUpdates;
}

- (id)initWithFirmwareUpdates:(PPDeviceFirmwareUpdatesFirmwareUpdates *)firmwareUpdates currentUpdate:(PPDeviceFirmwareUpdateJob *)currentFirmwareUpdate {
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

@implementation PPDeviceFirmwareUpdatesFirmwareUpdates

+ (PPDeviceFirmwareUpdatesFirmwareUpdates *)initWithDictionary:(NSDictionary *)dict {
    PPRLMDictionary *RLMDictionary = [super initWithDictionary:dict];
    return [[PPDeviceFirmwareUpdatesFirmwareUpdates alloc] initWithKeys:RLMDictionary.keys value:RLMDictionary.values];
}

@end
