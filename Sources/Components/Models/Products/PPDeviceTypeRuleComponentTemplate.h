//
//  PPDeviceTypeRuleComponentTemplate.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPRuleComponent.h"
#import "PPRuleComponentParameter.h"
#import "PPDeviceTypeRuleComponentTemplateProduct.h"

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateId) {
    PPDeviceTypeRuleComponentTemplateIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateSourceType) {
    PPDeviceTypeRuleComponentTemplateSourceTypeNone = -1,
    PPDeviceTypeRuleComponentTemplateSourceTypeDrools = 0,
    PPDeviceTypeRuleComponentTemplateSourceTypePython = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateConditionData) {
    PPDeviceTypeRuleComponentTemplateConditionDataNone = -1,
    PPDeviceTypeRuleComponentTemplateConditionDataLocationData = 1 << 0, // Location data, like "HOME" and "AWAY" states.
    PPDeviceTypeRuleComponentTemplateConditionDataDeviceStatus = 1 << 1, // Device status, including the last update date, the last measurement date, the registration date, and whether the device is connected or not.
    PPDeviceTypeRuleComponentTemplateConditionDataDeviceMeasurements = 1 << 2, // Measurements from the device
    PPDeviceTypeRuleComponentTemplateConditionDataLastAlertData = 1 << 3 // The last alert information sent from the device is needed to check the condition of this rule phrase.
};

@interface PPDeviceTypeRuleComponentTemplate : NSObject

/* Template ID. The ID of this specific rule phrase. */
@property (nonatomic) PPDeviceTypeRuleComponentTemplateId templateId;

/* Developer-friendly name to remember what the phrase represents */
@property (nonatomic, strong) NSString *name;

/* This is the type of rule phrase from the perspective of the IoT Software Suite in terms of how to execute the phrase. This may be different than the perspective of the app, which uses the 'display' attribute to specify how the user would think about this phrase. */
@property (nonatomic) PPRuleComponentType type;

/* This is the type of rule phrase from the perspective of the user, who doesn't know or care how the IoT Software Suite actually interprets and executes the phrase on the backend. */
@property (nonatomic) PPRuleComponentDisplayType display;

/* true - We require the user to confirm the timezone, so we execute the rule on time.
   false - We do not require the user to confirm the timezone. */
@property (nonatomic) PPRuleComponentTimezone timezone;

/* The actual rule phrase. Use $parameterNameReferences with '$' characters within the text, to replace a part of the sentence with the value from an input parameter that is associated with this phrase. */
@property (nonatomic, strong) NSString *desc;

/* Past tense of the rule phrase. Used for notifications that will come to the user just after the event happened. */
@property (nonatomic, strong) NSString *past;

/* This is the Drools or Python language script. Please refer to existing examples when creating or customizing your own rules. We opened up all the rule templates so you can peruse existing rules. */
@property (nonatomic, strong) NSString *source;

/* Source code type: 0 - Drools, 1 - Python. */
@property (nonatomic) PPDeviceTypeRuleComponentTemplateSourceType sourceType;

/* This is a bitmap that describes what kind of data is needed from the database to check the rule's condition. It is used in optimizing the performance of the rule and the IoT Software Suite.
 
   1 - Location data, like "HOME" and "AWAY" states.
   2 - Device status, including the last update date, the last measurement date, the registration date, and whether the device is connected or not.
   4 - Measurements from the device
   8 - The last alert information sent from the device is needed to check the condition of this rule phrase. */
@property (nonatomic) PPDeviceTypeRuleComponentTemplateConditionData conditionData;

/* Update date */
@property (nonatomic, strong) NSDate *updateDate;

/* List of product ID's / device types that are compatible with this rule phrase. */
@property (nonatomic, strong) NSArray *products;

/* List of user input parameters to specify and fill out this rule phrase. */
@property (nonatomic, strong) NSArray *parameters;

- (id)initWithTemplateId:(PPDeviceTypeRuleComponentTemplateId )templateId name:(NSString *)name type:(PPRuleComponentType )type display:(PPRuleComponentDisplayType )display timezone:(PPRuleComponentTimezone )timezone desc:(NSString *)desc past:(NSString *)past source:(NSString *)source sourceType:(PPDeviceTypeRuleComponentTemplateSourceType )sourceType conditionData:(PPDeviceTypeRuleComponentTemplateConditionData )conditionData updateDate:(NSDate *)updateDate products:(NSArray *)products parameters:(NSArray *)parameters;

+ (PPDeviceTypeRuleComponentTemplate *)initWithDictionary:(NSDictionary *)componentDict;

+ (NSString *)stringify:(PPDeviceTypeRuleComponentTemplate *)component;

@end
