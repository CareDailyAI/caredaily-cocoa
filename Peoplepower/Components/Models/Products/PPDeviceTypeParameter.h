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

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterEditable) {
    PPDeviceTypeParameterEditableNone = -1,
    PPDeviceTypeParameterEditableFalse = 0,
    PPDeviceTypeParameterEditableTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterNumeric) {
    PPDeviceTypeParameterNumericNone = -1,
    PPDeviceTypeParameterNumericFalse = 0,
    PPDeviceTypeParameterNumericTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterProfiled) {
    PPDeviceTypeParameterProfiledNone = -1,
    PPDeviceTypeParameterProfiledFalse = 0,
    PPDeviceTypeParameterProfiledTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterConfigured) {
    PPDeviceTypeParameterConfiguredNone = -1,
    PPDeviceTypeParameterConfiguredFalse = 0,
    PPDeviceTypeParameterConfiguredTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterHistorical) {
    PPDeviceTypeParameterHistoricalNone = -1,
    PPDeviceTypeParameterHistoricalCurrentStateOnly = 0,
    PPDeviceTypeParameterHistoricalEvery15Minutes = 1,
    PPDeviceTypeParameterHistoricalAllValues = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterScale) {
    PPDeviceTypeParameterScaleNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterAdjustment) {
    PPDeviceTypeParameterAdjustmentNone = -1,
    PPDeviceTypeParameterAdjustmentFalse = 0,
    PPDeviceTypeParameterAdjustmentTrue = 1,
};

/**
 * For displayType we're using the same structure as at Questions API (exception is a text box). It's combination of the IDs for general type of the element and it's sub-function.
 * Example: "10" (same as "1") - on/off switch, "91" - single date picker...
 **/
typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterDisplayType) {
    PPDeviceTypeParameterDisplayTypeNone                    = -1,
    PPDeviceTypeParameterDisplayTypeBoolean                 = 1,  // - Boolean (for parameters with 0/1 values only)
    PPDeviceTypeParameterDisplayTypeBooleanOnOff            = 10, // - on/off switch (default)
    PPDeviceTypeParameterDisplayTypeBooleanYesNo            = 11, // - yes/no checkbox
    PPDeviceTypeParameterDisplayTypeBooleanYes              = 12, // - single "yes" button only as a button
    PPDeviceTypeParameterDisplayTypeSelect                  = 2,  // - Select
    PPDeviceTypeParameterDisplayTypeSelectRadio             = 20, // - radio buttons (default)
    PPDeviceTypeParameterDisplayTypeSelectDropDown          = 21, // - dropdown with options
    PPDeviceTypeParameterDisplayTypeMultiSelect             = 4,  // - Select with multiple choices
    PPDeviceTypeParameterDisplayTypeMultiSelectRadio        = 40, // - checkboxes or multiple-able radio buttons (default)
    PPDeviceTypeParameterDisplayTypeMultiSelectDropDown     = 41, // - dropdown with multiple selection enabled
    PPDeviceTypeParameterDisplayTypeTextbox                 = 5,  // - Textbox (text input)
    PPDeviceTypeParameterDisplayTypeDayOfWeek               = 6,  // - Day of the week
    PPDeviceTypeParameterDisplayTypeDayOfWeekMulti          = 60, // - choose multiple days simultaneously (default)
    PPDeviceTypeParameterDisplayTypeDayOfWeekSingle         = 61, // - pick a single day only
    PPDeviceTypeParameterDisplayTypeSlider                  = 7,  // - Slider (range)
    PPDeviceTypeParameterDisplayTypeSliderInteger           = 70, // - integer selection between min and max (default is 0 to 100, default)
    PPDeviceTypeParameterDisplayTypeSliderFloat             = 71, // - floating point selector (e.g. in a range from 0 to 1)
    PPDeviceTypeParameterDisplayTypeSliderMinutesSeconds    = 72, // - as a minutes:seconds format between a min and max (e.g. from 0 to 5 minutes)
    PPDeviceTypeParameterDisplayTypeTime                    = 8,  // - Time (in seconds)
    PPDeviceTypeParameterDisplayTypeTimeHoursMinutesSeconds = 80, // - as hours:minutes:seconds (am/pm, default)
    PPDeviceTypeParameterDisplayTypeTimeHoursMinutes        = 81, // - as hours:minutes (am/pm)
    PPDeviceTypeParameterDisplayTypeDateTime                = 9,  // - Datetime
    PPDeviceTypeParameterDisplayTypeDateTimePicker          = 90, // - date and time picker (default)
    PPDeviceTypeParameterDisplayTypeDateTimeDateOnly        = 91, // - date only
};

/**
 * Property called valueType is only for frontend specific logic to give an idea how that parameter values should be calculated/processed at UI level.
 **/
typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterValueType) {
    PPDeviceTypeParameterValueTypeNone          = -1,
    PPDeviceTypeParameterValueTypeAny           = 1, // - Any
    PPDeviceTypeParameterValueTypeNumber        = 2, // - Number
    PPDeviceTypeParameterValueTypeBoolean       = 3, // - Boolean
    PPDeviceTypeParameterValueTypeString        = 4, // - String
    PPDeviceTypeParameterValueTypeArray         = 5, // - Array of any, e.g. [1, "string", 45, true ]
    PPDeviceTypeParameterValueTypeArrayNumeric  = 6, // - Array of numbers, e.g. [1, 3, 77]
    PPDeviceTypeParameterValueTypeArrayString   = 7, // - Array of strings, e.g. ["horn", "bull", "rose"]
    PPDeviceTypeParameterValueTypeObject        = 8, // - Object
};

@interface PPDeviceTypeParameter : RLMObject


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

RLM_ARRAY_TYPE(PPDeviceTypeParameter);
