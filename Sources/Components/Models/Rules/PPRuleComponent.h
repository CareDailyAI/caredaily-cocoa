//
//  PPRuleComponent.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPRuleComponentParameter.h"

@interface PPRuleComponent : PPBaseModel <NSCopying, NSCoding>

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
