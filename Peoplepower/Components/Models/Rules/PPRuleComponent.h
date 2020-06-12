//
//  PPRuleComponent.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPRuleComponentParameter.h"

typedef NS_OPTIONS(NSInteger, PPRuleComponentId) {
    PPRuleComponentIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentType) {
    PPRuleComponentTypeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentDisplayType) {
    PPRuleComponentDisplayTypeNone = -1,
    PPRuleComponentDisplayTypeTriggerSchedule = 11, // This type of trigger is based on a schedule. For example, "If the time is 8:00 PM on school nights".
    PPRuleComponentDisplayTypeTriggerEvent = 12, // Location event, such as 'HOME', 'AWAY', etc.
    PPRuleComponentDisplayTypeTriggerDeviceAlert = 13, // Device alert like "motion detected"
    PPRuleComponentDisplayTypeTriggerNewDeviceData = 14, // Measurements
    PPRuleComponentDisplayTypeTriggerCountdown = 15, // Check, if something did not happen in specified period of time
    PPRuleComponentDisplayTypeStateGeneralCondition = 21, // Type 21 simply means this phrase is a state condition. This is the only 'type' field available for a state.
    PPRuleComponentDisplayTypeStateLocation = 22, // This phrase is to say "I am home" or "I am away"
    PPRuleComponentDisplayTypeStateDeviceParameter = 23, // This phrase is to specify a state for a device parameter, such as "temperature is greater than 73 degrees Fahrenheit" for example.
    PPRuleComponentDisplayTypeActionPushNotification = 31, // Send a push notification to the user
    PPRuleComponentDisplayTypeActionEmail = 32, // Send an email notification to the user
    PPRuleComponentDisplayTypeActionSendCommand = 33, // Send a command to a device
    PPRuleComponentDisplayTypeActionEvent = 34, // Set a new location event, such as 'HOME', 'AWAY', etc.
    PPRuleComponentDisplayTypeActionCallCenter = 35,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentTimezone) {
    PPRuleComponentTimezoneNone = -1,
    PPRuleComponentTimezoneFalse = 0,
    PPRuleComponentTimezoneTrue = 1,
};

@interface PPRuleComponent : NSObject <NSCopying, NSCoding>

/* Id of this component */
@property (nonatomic) PPRuleComponentId componentId;

/* A descriptive name of the rule phrase, from the developer of the phrase. Usually not displayed to the user. */
@property (nonatomic, strong) NSString *name;

/* This is the type of rule phrase from the perspective of the IoT Software Suite in terms of how to execute the phrase. This may be different than the perspective of the app, which uses the 'display' attribute to specify how the user would think about this phrase. */
@property (nonatomic) PPRuleComponentType type;

/* The type of phrase, see the triggers / states / actions 'display' value tables above */
@property (nonatomic) PPRuleComponentDisplayType displayType;

/* Present-tense description to display to the user. Any word identified with a $ character refers to a parameter that is part of the rule. Those special references should be replaced by the corresponding parameter's actual value. */
@property (nonatomic, strong) NSString *desc;

/* Past-tense phrase for use in notifications. Any word identified with a $ character refers to a parameter that is part of the rule. Those special references should be replaced by the corresponding parameter's actual value. */
@property (nonatomic, strong) NSString *past;

/* When 'true', this phrase will require the UI or user to reconfirm the timezone in which it should execute. We usually confirm the timezone when the user hits Save. */
@property (nonatomic) PPRuleComponentTimezone timezone;

/* Well known functionality name allowing to use this phrase in specific conditions */
@property (nonatomic, strong) NSString *functionGroup;

/* A parameter to complete the rule phrase */
@property (nonatomic, strong) NSMutableArray *parameters;

/* Paid service name, if this rule phrase is available only for users with this service. */
@property (nonatomic, strong) NSString *serviceName;

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(NSArray *)parameters serviceName:(NSString *)serviceName;

+ (NSObject *)initWithDictionary:(NSDictionary *)componentDict subclass:(NSString *)subclass;

+ (NSString *)stringify:(PPRuleComponent *)component;
+ (NSDictionary *)data:(PPRuleComponent *)component;

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponent *)ruleComponent;

- (void)sync:(PPRuleComponent *)ruleComponent;

@end
