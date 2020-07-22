//
//  PPDeviceFirmwareUpdates.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A user can approve or decline an update of his devices with new firmware.
//
// TODO: Define errors for missing fwupdate parameters

#import "PPBaseModel.h"
#import "PPDeviceFirmwareUpdateJob.h"

@class PPDeviceFirmwareUpdatesFirmwareUpdates;

@interface PPDeviceFirmwareUpdates : PPBaseModel

@property (nonatomic, strong) PPDeviceFirmwareUpdateJob *currentFirmwareUpdate;
@property (nonatomic, strong) PPDeviceFirmwareUpdatesFirmwareUpdates *firmwareUpdates;

/**
 * Shared firmware updates across the entire application
 */
+ (PPDeviceFirmwareUpdates *)sharedFirmwareUpdates;

- (id)initWithFirmwareUpdates:(PPDeviceFirmwareUpdatesFirmwareUpdates *)firmwareUpdates currentUpdate:(PPDeviceFirmwareUpdateJob *)currentFirmwareUpdate;

@end

@interface PPDeviceFirmwareUpdatesFirmwareUpdates : PPRLMDictionary
+ (PPDeviceFirmwareUpdatesFirmwareUpdates *)initWithDictionary:(NSDictionary *)dict;
@end
