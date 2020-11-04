//
//  PPDeviceTypeGoal.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Device goals provide possible device usage scenarios. Depending on chosen device goal the IoT Software Suite assign default rules and suggest device installation.
//

#import "PPBaseModel.h"

@class PPDeviceTypeGoalSpaceTypes;

@interface PPDeviceTypeGoal : PPBaseModel

/* Goal ID */
@property (nonatomic) PPDeviceTypeGoalId goalId;

/* Name */
@property (nonatomic, strong) NSString *name;

/* Goal description including installation instructions */
@property (nonatomic, strong) NSString *desc;

/* A bitmask of goal categories */
@property (nonatomic) PPDeviceTypeGoalCategories categories;

/* Number of active devices, which use this goal */
@property (nonatomic) PPDeviceTypeGoalDeviceUsage deviceUsage;

/* Suggestioned device names */
@property (nonatomic, strong) NSArray *suggestions;

/* Suggestioned device spaces */
@property (nonatomic, strong) NSArray *spaces;

- (id)initWithId:(PPDeviceTypeGoalId)goalId name:(NSString *)name desc:(NSString *)desc categories:(PPDeviceTypeGoalCategories)categories deviceUsage:(PPDeviceTypeGoalDeviceUsage)deviceUsage suggestions:(NSArray *)suggestions spaces:(NSArray *)spaces;

+ (PPDeviceTypeGoal *)initWithDictionary:(NSDictionary *)goalDict;

#pragma mark - Helper methods

- (BOOL)isEqualToGoal:(PPDeviceTypeGoal *)goal;

- (void)sync:(PPDeviceTypeGoal *)goal;

@end

@interface PPDeviceTypeGoalSpaceTypes: PPBaseModel
@property (nonatomic, strong) NSArray *types;
- (id)initWithTypes:(NSArray *)types;
+ (PPDeviceTypeGoalSpaceTypes *)initWithArray:(NSArray *)types;
@end
