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

extern NSString *DEVICE_TYPE_GOAL_CATEGORY_ENERGY;
extern NSString *DEVICE_TYPE_GOAL_CATEGORY_SECURITY;
extern NSString *DEVICE_TYPE_GOAL_CATEGORY_CARE;
extern NSString *DEVICE_TYPE_GOAL_CATEGORY_LIFESTYLE;
extern NSString *DEVICE_TYPE_GOAL_CATEGORY_HEALTH;
extern NSString *DEVICE_TYPE_GOAL_CATEGORY_WELLNESS;

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalId) {
    PPDeviceTypeGoalIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalDeviceUsage) {
    PPDeviceTypeGoalDeviceUsageNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalCategories) {
    PPDeviceTypeGoalCategoryNone      = 0,
    PPDeviceTypeGoalCategoryEnergy    = 1 << 0,
    PPDeviceTypeGoalCategorySecurity  = 1 << 1,
    PPDeviceTypeGoalCategoryCare      = 1 << 2,
    PPDeviceTypeGoalCategoryLifestyle = 1 << 3,
    PPDeviceTypeGoalCategoryHealth    = 1 << 4,
    PPDeviceTypeGoalCategoryWellness  = 1 << 5
};

@interface PPDeviceTypeGoal : NSObject

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

@interface PPDeviceTypeGoalSpaceTypes: NSObject
@property (nonatomic, strong) NSArray *types;
- (id)initWithTypes:(NSArray *)types;
+ (PPDeviceTypeGoalSpaceTypes *)initWithArray:(NSArray *)types;
@end
