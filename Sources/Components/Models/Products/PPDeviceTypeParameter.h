//
//  PPDeviceTypeParameter.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A parameter is an individual stream of data between a device and the IoT Software Suite. The IoT Software Suite enables parameters to be optimized for performance and storage, which facilitates massive scalability of the platform.
// The IoT Software Suite has a single namespace for parameters. Each parameter name must contain no spaces, and include a prefix that is separated from the rest of the name by a period ('.'). We recommend prefixes that contain the initials of the company or organization. For example, People Power defines a custom parameter ppc.motionStatus to turn motion detection on and off on Presence cameras.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeParameterDisplayInfo.h"

@interface PPDeviceTypeParameter : PPBaseModel


/* Parameter name (no spaces) */
@property (nonatomic, strong) NSString *name;

/* true - You may edit this parameter
   false - You do not have rights to edit this parameter */
@property (nonatomic) PPDeviceTypeParameterEditable editable;

/* Default system unit if this is a numeric parameter to store measurements, how its values will be stored */
@property (nonatomic, strong) NSString *systemUnit;

/* Default multiplier if this is a numeric parameter to store measurements. Other specified measurement multipliers will be converted to this multiplier before storing. Example multipliers include 'n', 'u', 'm', 'c', '%', 'd', '1', 'Da', 'h', 'k', 'M', 'G', etc. See the device API for more details. */
@property (nonatomic, strong) NSString *systemMultiplier;

/* true - This parameter represents a number
   false - This parameter is a string */
@property (nonatomic) PPDeviceTypeParameterNumeric numeric;

/* true - Accept this parameter as a measurement from the device
   false - This parameter will never be accepted as a measurement from the device, don't allocate space for it. */
@property (nonatomic) PPDeviceTypeParameterProfiled profiled;

/* true - This parameter may be used as a command to the device
   false - This parameter will never be sent as a command to the device, don't allocate space for it. */
@property (nonatomic) PPDeviceTypeParameterConfigured configured;

/* 0 - Do not save a history of measurements, keep the current state only (least expensive).
   1 - Update the history either every 15 minutes, or when the value changes significantly (more than 25% for numeric parameters).
   2 - Update the measurement history with every value change (most expensive).
 */
@property (nonatomic) PPDeviceTypeParameterHistorical historical;

/* For numeric values, how many digits after the decimal point should we store */
@property (nonatomic) PPDeviceTypeParameterScale scale;

/* A product may define an attribute that describes a supported algorithm that will filter, adjust, and correct data. By turning this flag on, this parameter will apply the type of data correction algorithm defined by the product's attributes it is being used with.
 
   true - Enable data correction and filtered based on the product's defined attributes
   false - No data correction or filtering needed
 */
@property (nonatomic) PPDeviceTypeParameterAdjustment adjustment;

/* Display information for mapping this parameter to a UI
 */
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo *displayInfo;

- (id)initWithName:(NSString *)name editable:(PPDeviceTypeParameterEditable)editable systemUnit:(NSString *)systemUnit systemMultiplier:(NSString *)systemMultiplier numeric:(PPDeviceTypeParameterNumeric)numeric profiled:(PPDeviceTypeParameterProfiled)profiled configured:(PPDeviceTypeParameterConfigured)configured historical:(PPDeviceTypeParameterHistorical)historical scale:(PPDeviceTypeParameterScale)scale adjustment:(PPDeviceTypeParameterAdjustment)adjustment displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

+ (PPDeviceTypeParameter *)initWithDictionary:(NSDictionary *)paramDict;

+ (NSString *)stringify:(PPDeviceTypeParameter *)parameter;

#pragma mark - Helper methods

- (BOOL)isEqualToParameter:(PPDeviceTypeParameter *)parameter;

- (void)sync:(PPDeviceTypeParameter *)parameter;

@end
