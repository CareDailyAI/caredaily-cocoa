//
//  PPDeviceFirmwareUpdates.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A user can approve or decline an update of his devices with new firmware.
//
// TODO: Define errors for missing fwupdate parameters

#import "PPBaseModel.h"
#import "PPDeviceFirmwareUpdateJob.h"

@interface PPDeviceFirmwareUpdates : PPBaseModel

@property (nonatomic, strong) PPDeviceFirmwareUpdateJob *currentFirmwareUpdate;
@property (nonatomic, strong) NSMutableDictionary *firmwareUpdates;

/**
 * Shared firmware updates across the entire application
 */
+ (PPDeviceFirmwareUpdates *)sharedFirmwareUpdates;

- (id)initWithFirmwareUpdates:(NSMutableDictionary *)firmwareUpdates currentUpdate:(PPDeviceFirmwareUpdateJob *)currentFirmwareUpdate;

@end
