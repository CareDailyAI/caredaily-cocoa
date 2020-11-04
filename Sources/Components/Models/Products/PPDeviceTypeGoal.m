//
//  PPDeviceTypeGoal.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeGoal.h"

NSString *DEVICE_TYPE_GOAL_CATEGORY_ENERGY = @"E";
NSString *DEVICE_TYPE_GOAL_CATEGORY_SECURITY = @"S";
NSString *DEVICE_TYPE_GOAL_CATEGORY_CARE = @"C";
NSString *DEVICE_TYPE_GOAL_CATEGORY_LIFESTYLE = @"L";
NSString *DEVICE_TYPE_GOAL_CATEGORY_HEALTH = @"H";
NSString *DEVICE_TYPE_GOAL_CATEGORY_WELLNESS = @"W";

@implementation PPDeviceTypeGoal

- (id)initWithId:(PPDeviceTypeGoalId)goalId name:(NSString *)name desc:(NSString *)desc categories:(PPDeviceTypeGoalCategories)categories deviceUsage:(PPDeviceTypeGoalDeviceUsage)deviceUsage suggestions:(NSArray *)suggestions spaces:(NSArray *)spaces {
    self = [super init];
    if(self) {
        self.goalId = goalId;
        self.name = name;
        self.desc = desc;
        self.categories = categories;
        self.deviceUsage = deviceUsage;
        self.suggestions = suggestions;
        self.spaces = spaces;
    }
    return self;
}

+ (PPDeviceTypeGoal *)initWithDictionary:(NSDictionary *)goalDict {
    PPDeviceTypeGoalId goalId = PPDeviceTypeGoalIdNone;
    if([goalDict objectForKey:@"id"]) {
        goalId = (PPDeviceTypeGoalId)((NSString *)[goalDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [goalDict objectForKey:@"name"];
    NSString *desc = [goalDict objectForKey:@"desc"];
    PPDeviceTypeGoalCategories categories = PPDeviceTypeGoalCategoryNone;
    if([goalDict objectForKey:@"categories"]) {
        categories = (PPDeviceTypeGoalCategories)((NSString *)[goalDict objectForKey:@"categories"]).integerValue;
    }
    PPDeviceTypeGoalDeviceUsage deviceUsage = PPDeviceTypeGoalDeviceUsageNone;
    if([goalDict objectForKey:@"deviceUsage"]) {
        deviceUsage = (PPDeviceTypeGoalDeviceUsage)((NSString *)[goalDict objectForKey:@"deviceUsage"]).integerValue;
    }
    NSMutableArray *suggestions;
    if ([goalDict objectForKey:@"suggestions"]) {
        suggestions = [[NSMutableArray alloc] init];
        for (NSString *suggestion in [goalDict objectForKey:@"suggestions"]) {
            [suggestions addObject:suggestion];
        }
    }
    NSMutableArray *spaces;
    if ([goalDict objectForKey:@"spaces"]) {
        spaces = [[NSMutableArray alloc] init];
        for (NSArray *types in [goalDict objectForKey:@"spaces"]) {
            [spaces addObject:[PPDeviceTypeGoalSpaceTypes initWithArray:types]];
        }
    }
    
    PPDeviceTypeGoal *goal = [[PPDeviceTypeGoal alloc] initWithId:goalId name:name desc:desc categories:categories deviceUsage:deviceUsage suggestions:suggestions spaces:spaces];
    return goal;
}

#pragma mark - Helper methods

- (BOOL)isEqualToGoal:(PPDeviceTypeGoal *)goal {
    BOOL equal = NO;
    
    if(goal.goalId != PPDeviceTypeGoalIdNone && _goalId != PPDeviceTypeGoalIdNone) {
        if(goal.goalId == _goalId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDeviceTypeGoal *)goal {

    if(goal.goalId != PPDeviceTypeGoalIdNone) {
        _goalId = goal.goalId;
    }
    if(goal.name) {
        _name = goal.name;
    }
    if(goal.desc) {
        _desc = goal.desc;
    }
    if(goal.categories != PPDeviceTypeGoalCategoryNone) {
        _categories = goal.categories;
    }
    if(goal.deviceUsage != PPDeviceTypeGoalDeviceUsageNone) {
        _deviceUsage = goal.deviceUsage;
    }
}

@end

@implementation PPDeviceTypeGoalSpaceTypes

- (id)initWithTypes:(NSArray *)types {
    self = [super init];
    if (self) {
        self.types = types;
    }
    return self;
}

+ (PPDeviceTypeGoalSpaceTypes *)initWithArray:(NSArray *)types {
    return [[PPDeviceTypeGoalSpaceTypes alloc] initWithTypes:types];
}

@end
