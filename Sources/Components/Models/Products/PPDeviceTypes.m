//
//  PPDeviceTypes.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// The IoT Software Suite allows developers to create and manage new products. Each product defines a category to help organize UI's and groups of devices.
// On the developer platform, only the creator of a product may see its existence. When the product is ready to move to a production the IoT Software Suite instance for commercial deployment, we migrate the product and parameter definitions to the production server.
// 

#import "PPDeviceTypes.h"
#import "PPCloudEngine.h"

@implementation PPDeviceTypes

#pragma mark - Session Management

#pragma mark Device types

__strong static NSMutableDictionary *_sharedDeviceTypes = nil;

/**
 * Shared deviceTypes across the entire application
 */
+ (NSArray *)sharedDeviceTypesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypes) {
        [PPDeviceTypes initializeSharedDeviceTypes];
    }
    NSMutableArray *sharedDeviceTypes = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypes.allKeys) {
        for(PPDeviceType *deviceType in [_sharedDeviceTypes objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeIdentifiers setValue:@(deviceType.typeId) forKey:@"typeId"];
            if(deviceType.name) {
                [deviceTypeIdentifiers setValue:deviceType.name forKey:@"name"];
            }
            [deviceTypesArray addObject:deviceTypeIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypes addObject:deviceType];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypes=%@", __PRETTY_FUNCTION__, deviceTypesArray);
#endif
#endif
    return sharedDeviceTypes;
}

+ (void)initializeSharedDeviceTypes {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypes = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypesData = [defaults objectForKey:@"user.notificationDeviceTypes"];
//    if(storedDeviceTypesData) {
//        _sharedDeviceTypes = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add deviceTypes.
 * Add deviceTypes to local reference.
 *
 * @param deviceTypes NSArray Array of deviceTypes to add.
 * @param userId Required PPUserId User Id to associate these device type attributes with
 **/
+ (void)addDeviceTypes:(NSArray *)deviceTypes userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypes=%@", __PRETTY_FUNCTION__, deviceTypes);
#endif
#endif
    if(!_sharedDeviceTypes) {
        [PPDeviceTypes initializeSharedDeviceTypes];
    }

    NSMutableArray *deviceTypesArray = [_sharedDeviceTypes objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypesArray) {
        deviceTypesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceType *deviceType in deviceTypes) {

        BOOL found = NO;
        for(PPDeviceType *sharedDeviceType in deviceTypesArray) {
            if([sharedDeviceType isEqualToDeviceType:deviceType]) {
                [sharedDeviceType sync:deviceType];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypes indexOfObject:deviceType]];
        }
    }

    [deviceTypesArray addObjectsFromArray:[deviceTypes objectsAtIndexes:indexSet]];
    [_sharedDeviceTypes setObject:deviceTypesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypes];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeData forKey:@"user.notificationDeviceTypes"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove deviceTypes.
 * Remove deviceTypes from local reference.
 *
 * @param deviceTypes NSArray Array of deviceTypes to remove.
 * @param userId Required PPUserId User Id to associate these device type attributes with
 **/
+ (void)removeDeviceTypes:(NSArray *)deviceTypes userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypes=%@", __PRETTY_FUNCTION__, deviceTypes);
#endif
#endif
    if(!_sharedDeviceTypes) {
        [PPDeviceTypes initializeSharedDeviceTypes];
    }

    NSMutableArray *deviceTypesArray = [_sharedDeviceTypes objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypesArray) {
        deviceTypesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceType *deviceType in deviceTypes) {

        BOOL found = NO;
        for(PPDeviceType *sharedDeviceType in deviceTypesArray) {
            if([sharedDeviceType isEqualToDeviceType:deviceType]) {
                [sharedDeviceType sync:deviceType];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypes indexOfObject:deviceType]];
        }
    }

    [deviceTypesArray addObjectsFromArray:[deviceTypes objectsAtIndexes:indexSet]];
    [_sharedDeviceTypes setObject:deviceTypesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypes];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeData forKey:@"user.notificationDeviceTypes"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Device type Attributes

__strong static NSMutableDictionary*_sharedDeviceTypeAttributes = nil;

/**
 * Shared device type attribtues across the entire application
 */
+ (NSArray *)sharedDeviceTypeAttributesForUser:(PPUserId)userId {
    if(!_sharedDeviceTypeAttributes) {
        [PPDeviceTypes initializeSharedDeviceTypeAttributes];
    }
    NSMutableArray *sharedDeviceTypeAttributes = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeAttributes.allKeys) {
        for(PPDeviceTypeAttribute *deviceTypeAttribute in [_sharedDeviceTypeAttributes objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeAttributeIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeAttributeIdentifiers setValue:deviceTypeAttribute.name forKey:@"name"];
            [deviceTypeAttributesArray addObject:deviceTypeAttributeIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeAttributes addObject:deviceTypeAttribute];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"%s sharedDeviceTypeAttributes=%@", __PRETTY_FUNCTION__, deviceTypeAttributesArray);
#endif
#endif
    return sharedDeviceTypeAttributes;
}


+ (void)initializeSharedDeviceTypeAttributes {
    _sharedDeviceTypeAttributes = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypeAttributesData = [defaults objectForKey:@"user.notificationDeviceTypeAttributes"];
//    if(storedDeviceTypeAttributesData) {
//        _sharedDeviceTypeAttributes = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypeAttributesData];
//    }
}

/**
 * Add deviceTypeAttributes.
 * Add deviceTypeAttributes to local reference.
 *
 * @param deviceTypeAttributes NSArray Array of deviceTypeAttributes to add.
 * @param userId Required PPUserId User Id to associate these device types with
 **/
+ (void)addDeviceTypeAttributes:(NSArray *)deviceTypeAttributes userId:(PPUserId)userId {
    if(!_sharedDeviceTypeAttributes) {
        [PPDeviceTypes initializeSharedDeviceTypeAttributes];
    }

    NSMutableArray *deviceTypeAttributesArray = [_sharedDeviceTypeAttributes objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeAttributesArray) {
        deviceTypeAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeAttribute *deviceTypeAttribute in deviceTypeAttributes) {

        BOOL found = NO;
        for(PPDeviceTypeAttribute *sharedDeviceTypeAttribute in deviceTypeAttributesArray) {
            if([sharedDeviceTypeAttribute isEqualToAttribute:deviceTypeAttribute]) {
                [sharedDeviceTypeAttribute sync:deviceTypeAttribute];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypeAttributes indexOfObject:deviceTypeAttribute]];
        }
    }

    [deviceTypeAttributesArray addObjectsFromArray:[deviceTypeAttributes objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeAttributes setObject:deviceTypeAttributesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeAttributeData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeAttributes];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeAttributeData forKey:@"user.notificationDeviceTypeAttributes"];
//    [defaults synchronize];
}

/**
 * Remove deviceTypeAttributes.
 * Remove deviceTypeAttributes from local reference.
 *
 * @param deviceTypeAttributes NSArray Array of deviceTypeAttributes to remove.
 * @param userId Required PPUserId User Id to associate these device types with
 **/
+ (void)removeDeviceTypeAttributes:(NSArray *)deviceTypeAttributes userId:(PPUserId)userId {
    if(!_sharedDeviceTypeAttributes) {
        [PPDeviceTypes initializeSharedDeviceTypeAttributes];
    }

    NSMutableArray *deviceTypeAttributesArray = [_sharedDeviceTypeAttributes objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeAttributesArray) {
        deviceTypeAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeAttribute *deviceTypeAttribute in deviceTypeAttributes) {
        for(PPDeviceTypeAttribute *sharedDeviceTypeAttribute in deviceTypeAttributesArray) {
            if([sharedDeviceTypeAttribute isEqualToAttribute:deviceTypeAttribute]) {
                [indexSet addIndex:[deviceTypeAttributesArray indexOfObject:sharedDeviceTypeAttribute]];
                break;
            }
        }
    }

    [deviceTypeAttributesArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeAttributes setObject:deviceTypeAttributesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeAttributeData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeAttributes];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeAttributeData forKey:@"user.notificationDeviceTypeAttributes"];
//    [defaults synchronize];
}

#pragma mark Device type Parameters

__strong static NSMutableDictionary*_sharedDeviceTypeParameters = nil;

/**
 * Shared deviceTypeParameters across the entire application
 */
+ (NSArray *)sharedDeviceTypeParametersForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypeParameters) {
        [PPDeviceTypes initializeSharedDeviceTypeParameters];
    }
    NSMutableArray *sharedDeviceTypeParameters = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeParametersArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeParameters.allKeys) {
        for(PPDeviceTypeParameter *deviceTypeParameter in [_sharedDeviceTypeParameters objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeParameterIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeParameterIdentifiers setValue:deviceTypeParameter.name forKey:@"name"];
            [deviceTypeParametersArray addObject:deviceTypeParameterIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeParameters addObject:deviceTypeParameter];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeParameters=%@", __PRETTY_FUNCTION__, deviceTypeParametersArray);
#endif
#endif
    return sharedDeviceTypeParameters;
}

+ (void)initializeSharedDeviceTypeParameters {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypeParameters = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypeParametersData = [defaults objectForKey:@"user.notificationDeviceTypeParameters"];
//    if(storedDeviceTypeParametersData) {
//        _sharedDeviceTypeParameters = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypeParametersData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}


/**
 * Add deviceTypeParameters.
 * Add deviceTypeParameters to local reference.
 *
 * @param deviceTypeParameters NSArray Array of deviceTypeParameters to add.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)addDeviceTypeParameters:(NSArray *)deviceTypeParameters userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeParameters=%@", __PRETTY_FUNCTION__, deviceTypeParameters);
#endif
#endif
    if(!_sharedDeviceTypeParameters) {
        [PPDeviceTypes initializeSharedDeviceTypeParameters];
    }

    NSMutableArray *deviceTypeParametersArray = [_sharedDeviceTypeParameters objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeParametersArray) {
        deviceTypeParametersArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeParameter *deviceTypeParameter in deviceTypeParameters) {

        BOOL found = NO;
        for(PPDeviceTypeParameter *sharedDeviceTypeParameter in deviceTypeParametersArray) {
            if([sharedDeviceTypeParameter isEqualToParameter:deviceTypeParameter]) {
                [sharedDeviceTypeParameter sync:deviceTypeParameter];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypeParameters indexOfObject:deviceTypeParameter]];
        }
    }

    [deviceTypeParametersArray addObjectsFromArray:[deviceTypeParameters objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeParameters setObject:deviceTypeParametersArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeParameterData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeParameters];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeParameterData forKey:@"user.notificationDeviceTypeParameters"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeParametersArray=%@", __PRETTY_FUNCTION__, deviceTypeParametersArray);
#endif
#endif
}


/**
 * Remove deviceTypeParameters.
 * Remove deviceTypeParameters from local reference.
 *
 * @param deviceTypeParameters NSArray Array of deviceTypeParameters to remove.
 * @param userId Required PPUserId User Id to associate these device type parameters with
 **/
+ (void)removeDeviceTypeParameters:(NSArray *)deviceTypeParameters userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeParameters=%@", __PRETTY_FUNCTION__, deviceTypeParameters);
#endif
#endif

    if(!_sharedDeviceTypeParameters) {
        [PPDeviceTypes initializeSharedDeviceTypeParameters];
    }

    NSMutableArray *deviceTypeParametersArray = [_sharedDeviceTypeParameters objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeParametersArray) {
        deviceTypeParametersArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeParameter *deviceTypeParameter in deviceTypeParameters) {
        for(PPDeviceTypeParameter *sharedDeviceTypeParameter in deviceTypeParametersArray) {
            if([sharedDeviceTypeParameter isEqualToParameter:deviceTypeParameter]) {
                [indexSet addIndex:[deviceTypeParametersArray indexOfObject:sharedDeviceTypeParameter]];
                break;
            }
        }
    }

    [deviceTypeParametersArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeParameters setObject:deviceTypeParametersArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeParameterData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeParameters];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeParameterData forKey:@"user.notificationDeviceTypeParameters"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeParametersArray=%@", __PRETTY_FUNCTION__, deviceTypeParametersArray);
#endif
#endif
}

#pragma mark Device type Rule Component Templates

__strong static NSMutableDictionary*_sharedDeviceTypeRuleComponentTemplates = nil;

/**
 * Shared deviceTypeRuleComponentTemplates across the entire application
 */
+ (NSArray *)sharedDeviceTypeRuleComponentTemplatesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    NSArray *sharedDeviceTypeRuleComponentTemplates = @[];
    
    NSMutableArray *sharedDeviceTypeRuleComponentTemplatesArray = [[NSMutableArray alloc] initWithCapacity:[sharedDeviceTypeRuleComponentTemplates count]];
    NSMutableArray *deviceTypeRuleComponentTemplatesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPDeviceTypeRuleComponentTemplate *deviceTypeRuleComponentTemplate in sharedDeviceTypeRuleComponentTemplates) {
        [sharedDeviceTypeRuleComponentTemplatesArray addObject:deviceTypeRuleComponentTemplate];
        
        [deviceTypeRuleComponentTemplatesArrayDebug addObject:@{@"componentTemplateId": @(deviceTypeRuleComponentTemplate.templateId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeRuleComponentTemplates=%@", __PRETTY_FUNCTION__, deviceTypeRuleComponentTemplatesArrayDebug);
#endif
#endif
    return sharedDeviceTypeRuleComponentTemplatesArray;
}

/**
 * Add deviceTypeRuleComponentTemplates.
 * Add deviceTypeRuleComponentTemplates to local reference.
 *
 * @param deviceTypeRuleComponentTemplates NSArray Array of deviceTypeRuleComponentTemplates to add.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)addDeviceTypeRuleComponentTemplates:(NSArray *)deviceTypeRuleComponentTemplates userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeRuleComponentTemplates=%@", __PRETTY_FUNCTION__, deviceTypeRuleComponentTemplates);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove deviceTypeRuleComponentTemplates.
 * Remove deviceTypeRuleComponentTemplates from local reference.
 *
 * @param deviceTypeRuleComponentTemplates NSArray Array of deviceTypeRuleComponentTemplates to remove.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)removeDeviceTypeRuleComponentTemplates:(NSArray *)deviceTypeRuleComponentTemplates userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeRuleComponentTemplates=%@", __PRETTY_FUNCTION__, deviceTypeRuleComponentTemplates);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Device type Goals

__strong static NSMutableDictionary*_sharedDeviceTypeGoals = nil;

/**
 * Shared deviceTypeGoals across the entire application
 */
+ (NSArray *)sharedDeviceTypeGoalsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypeGoals) {
        [PPDeviceTypes initializeSharedDeviceTypeGoals];
    }
    NSMutableArray *sharedDeviceTypeGoals = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeGoalsArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeGoals.allKeys) {
        for(PPDeviceTypeGoal *deviceTypeGoal in [_sharedDeviceTypeGoals objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeGoalIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeGoalIdentifiers setValue:@(deviceTypeGoal.goalId) forKey:@"ID"];
            if(deviceTypeGoal.name) {
                [deviceTypeGoalIdentifiers setValue:deviceTypeGoal.name forKey:@"name"];
            }
            [deviceTypeGoalsArray addObject:deviceTypeGoalIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeGoals addObject:deviceTypeGoal];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeGoals=%@", __PRETTY_FUNCTION__, deviceTypeGoalsArray);
#endif
#endif
    return sharedDeviceTypeGoals;
}

+ (void)initializeSharedDeviceTypeGoals {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypeGoals = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypeGoalsData = [defaults objectForKey:@"user.notificationDeviceTypeGoals"];
//    if(storedDeviceTypeGoalsData) {
//        _sharedDeviceTypeGoals = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypeGoalsData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add deviceTypeGoals.
 * Add deviceTypeGoals to local reference.
 *
 * @param deviceTypeGoals NSArray Array of deviceTypeGoals to add.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)addDeviceTypeGoals:(NSArray *)deviceTypeGoals userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeGoals=%@", __PRETTY_FUNCTION__, deviceTypeGoals);
#endif
#endif
    if(!_sharedDeviceTypeGoals) {
        [PPDeviceTypes initializeSharedDeviceTypeGoals];
    }

    NSMutableArray *deviceTypeGoalsArray = [_sharedDeviceTypeGoals objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeGoalsArray) {
        deviceTypeGoalsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeGoal *deviceTypeGoal in deviceTypeGoals) {

        BOOL found = NO;
        for(PPDeviceTypeGoal *sharedDeviceTypeGoal in deviceTypeGoalsArray) {
            if([sharedDeviceTypeGoal isEqualToGoal:deviceTypeGoal]) {
                [sharedDeviceTypeGoal sync:deviceTypeGoal];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypeGoals indexOfObject:deviceTypeGoal]];
        }
    }

    [deviceTypeGoalsArray addObjectsFromArray:[deviceTypeGoals objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeGoals setObject:deviceTypeGoalsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeGoalData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeGoals];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeGoalData forKey:@"user.notificationDeviceTypeGoals"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeGoalsArray=%@", __PRETTY_FUNCTION__, deviceTypeGoalsArray);
#endif
#endif
}

/**
 * Remove deviceTypeGoals.
 * Remove deviceTypeGoals from local reference.
 *
 * @param deviceTypeGoals NSArray Array of deviceTypeGoals to remove.
 * @param userId Required PPUserId User Id to associate these device typeGoals with
 **/
+ (void)removeDeviceTypeGoals:(NSArray *)deviceTypeGoals userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeGoals=%@", __PRETTY_FUNCTION__, deviceTypeGoals);
#endif
#endif

    if(!_sharedDeviceTypeGoals) {
        [PPDeviceTypes initializeSharedDeviceTypeGoals];
    }

    NSMutableArray *deviceTypeGoalsArray = [_sharedDeviceTypeGoals objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeGoalsArray) {
        deviceTypeGoalsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeGoal *deviceTypeGoal in deviceTypeGoals) {
        for(PPDeviceTypeGoal *sharedDeviceTypeGoal in deviceTypeGoalsArray) {
            if([sharedDeviceTypeGoal isEqualToGoal:deviceTypeGoal]) {
                [indexSet addIndex:[deviceTypeGoalsArray indexOfObject:sharedDeviceTypeGoal]];
                break;
            }
        }
    }

    [deviceTypeGoalsArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeGoals setObject:deviceTypeGoalsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeGoalData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeGoals];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeGoalData forKey:@"user.notificationDeviceTypeGoals"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeGoalsArray=%@", __PRETTY_FUNCTION__, deviceTypeGoalsArray);
#endif
#endif
}

#pragma mark Device type installation instructions

__strong static NSMutableDictionary*_sharedDeviceTypeGoalInstallations = nil;

/**
 * Shared deviceTypeInstallationInstructions across the entire application
 */
+ (NSArray *)sharedDeviceTypeInstallationInstructionsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    NSArray *sharedDeviceTypeInstallationInstructions = @[];
    
    NSMutableArray *sharedDeviceTypeInstallationInstructionsArray = [[NSMutableArray alloc] initWithCapacity:[sharedDeviceTypeInstallationInstructions count]];
    NSMutableArray *deviceTypeInstallationInstructionsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPDeviceTypeInstallationInstructions *deviceTypeInstallationInstruction in sharedDeviceTypeInstallationInstructions) {
        [sharedDeviceTypeInstallationInstructionsArray addObject:deviceTypeInstallationInstruction];
        
        [deviceTypeInstallationInstructionsArrayDebug addObject:@{@"goalId": @(deviceTypeInstallationInstruction.goalId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeInstallationInstructions=%@", __PRETTY_FUNCTION__, deviceTypeInstallationInstructionsArrayDebug);
#endif
#endif
    return sharedDeviceTypeInstallationInstructionsArray;
}

/**
 * Add deviceTypeInstallationInstructions.
 * Add deviceTypeInstallationInstructions to local reference.
 *
 * @param deviceTypeInstallationInstructions NSArray Array of deviceTypeInstallationInstructions to add.
 * @param userId Required PPUserId User Id to associate these deviceTypeInstallationInstructions with
 **/
+ (void)addDeviceTypeInstallationInstructions:(NSArray *)deviceTypeInstallationInstructions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeInstallationInstructions=%@", __PRETTY_FUNCTION__, deviceTypeInstallationInstructions);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove deviceTypeInstallationInstructions.
 * Remove deviceTypeInstallationInstructions from local reference.
 *
 * @param deviceTypeInstallationInstructions NSArray Array of deviceTypeInstallationInstructions to remove.
 * @param userId Required PPUserId User Id to associate these deviceTypeInstallationInstructions with
 **/
+ (void)removeDeviceTypeInstallationInstructions:(NSArray *)deviceTypeInstallationInstructions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeInstallationInstructions=%@", __PRETTY_FUNCTION__, deviceTypeInstallationInstructions);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Device type Media

__strong static NSMutableDictionary*_sharedDeviceTypeMedia = nil;

/**
 * Shared device type media across the entire application
 */
+ (NSArray *)sharedDeviceTypeMediaForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypeMedia) {
        [PPDeviceTypes initializeSharedDeviceTypeMedia];
    }
    NSMutableArray *sharedDeviceTypeMedia = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeMediaArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeMedia.allKeys) {
        for(PPDeviceTypeMedia *deviceTypeMediaFile in [_sharedDeviceTypeMedia objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeMediaIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeMediaIdentifiers setValue:deviceTypeMediaFile.mediaId forKey:@"ID"];
            if(deviceTypeMediaFile.desc) {
                [deviceTypeMediaIdentifiers setValue:deviceTypeMediaFile.desc forKey:@"desc"];
            }
            [deviceTypeMediaArray addObject:deviceTypeMediaIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeMedia addObject:deviceTypeMediaFile];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeMedia=%@", __PRETTY_FUNCTION__, deviceTypeMediaArray);
#endif
#endif
    return sharedDeviceTypeMedia;
}


+ (void)initializeSharedDeviceTypeMedia {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypeMedia = [[NSMutableDictionary alloc] initWithCapacity:0];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSData *storedDeviceTypesData = [defaults objectForKey:@"user.notificationDeviceTypes"];
    //    if(storedDeviceTypesData) {
    //        _sharedDeviceTypes = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypesData];
    //    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add device type media.
 * Add device type media to local reference.
 *
 * @param deviceTypeMedia NSArray Array of deviceTypeMedia to add.
 * @param userId Required PPUserId User Id to associate these device typeMedia with
 **/
+ (void)addDeviceTypeMedia:(NSArray *)deviceTypeMedia userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeMedia=%@", __PRETTY_FUNCTION__, deviceTypeMedia);
#endif
#endif
    if(!_sharedDeviceTypeMedia) {
        [PPDeviceTypes initializeSharedDeviceTypeMedia];
    }

    NSMutableArray *deviceTypeMediaArray = [_sharedDeviceTypeMedia objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeMediaArray) {
        deviceTypeMediaArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(NSInteger i = 0; i < [deviceTypeMedia count]; i++) {
        PPDeviceTypeMedia *deviceTypeMediaFile = [deviceTypeMedia objectAtIndex:i];
        BOOL found = NO;
        for(PPDeviceTypeMedia *sharedDeviceTypeMediaFile in deviceTypeMediaArray) {
            if([sharedDeviceTypeMediaFile isEqualToMedia:deviceTypeMediaFile]) {
                [sharedDeviceTypeMediaFile sync:deviceTypeMediaFile];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:i];
        }
    }

    [deviceTypeMediaArray addObjectsFromArray:[deviceTypeMedia objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeMedia setObject:deviceTypeMediaArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

    //    NSData *sharedDeviceTypeGoalData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeMedia];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:sharedDeviceTypeGoalData forKey:@"user.notificationDeviceTypeMedia"];
    //    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeMediaArray=%@", __PRETTY_FUNCTION__, deviceTypeMediaArray);
#endif
#endif
}

/**
 * Remove device type media.
 * Remove device type media from local reference.
 *
 * @param deviceTypeMedia NSArray Array of deviceTypeMedia to remove.
 * @param userId Required PPUserId User Id to associate these device typeMedia with
 **/
+ (void)removeDeviceTypeMedia:(NSArray *)deviceTypeMedia userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeMedia=%@", __PRETTY_FUNCTION__, deviceTypeMedia);
#endif
#endif

    if(!_sharedDeviceTypeMedia) {
        [PPDeviceTypes initializeSharedDeviceTypeMedia];
    }

    NSMutableArray *deviceTypeMediaArray = [_sharedDeviceTypeMedia objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeMediaArray) {
        deviceTypeMediaArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeMedia *deviceTypeMediaFile in deviceTypeMedia) {
        for(PPDeviceTypeMedia *sharedDeviceTypeMediaFile in deviceTypeMediaArray) {
            if([sharedDeviceTypeMediaFile isEqualToMedia:deviceTypeMediaFile]) {
                [indexSet addIndex:[deviceTypeMediaArray indexOfObject:sharedDeviceTypeMediaFile]];
                break;
            }
        }
    }

    [deviceTypeMediaArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeMedia setObject:deviceTypeMediaArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

    //    NSData *sharedDeviceTypeGoalData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeMedia];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:sharedDeviceTypeGoalData forKey:@"user.notificationDeviceTypeMedia"];
    //    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeMediaArray=%@", __PRETTY_FUNCTION__, deviceTypeMediaArray);
#endif
#endif
}

#pragma mark Device type model categories

__strong static NSMutableDictionary*_sharedDeviceTypeModelCategories = nil;

/**
 * Shared device type model categories across the entire application
 */
+ (NSArray *)sharedDeviceTypeModelCategoriesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypeModelCategories) {
        [PPDeviceTypes initializeSharedDeviceTypeModelCategories];
    }
    NSMutableArray *sharedDeviceTypeModelCategories = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeModelCategoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeModelCategories.allKeys) {
        for(PPDeviceTypeDeviceModelCategory *deviceTypeModelCategory in [_sharedDeviceTypeModelCategories objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeModelIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeModelIdentifiers setValue:deviceTypeModelCategory.categoryId forKey:@"ID"];
            if(deviceTypeModelCategory.name) {
                [deviceTypeModelIdentifiers setValue:deviceTypeModelCategory.name forKey:@"name"];
            }
            [deviceTypeModelCategoriesArray addObject:deviceTypeModelIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeModelCategories addObject:deviceTypeModelCategory];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeModelCategories=%@", __PRETTY_FUNCTION__, deviceTypeModelCategoriesArray);
#endif
#endif
    return sharedDeviceTypeModelCategories;
}

+ (void)initializeSharedDeviceTypeModelCategories {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypeModelCategories = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypeModelCategoriesData = [defaults objectForKey:@"user.notificationDeviceTypeModelCategories"];
//    if(storedDeviceTypeModelCategoriesData) {
//        _sharedDeviceTypeModelCategories = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypeModelCategoriesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add device type model categories.
 * Add device type model categories to local reference.
 *
 * @param deviceTypeModels NSArray Array of deviceTypeModels to add.
 * @param userId Required PPUserId User Id to associate these device type models with
 **/
+ (void)addDeviceTypeModelCategories:(NSArray *)deviceTypeModels userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeModels=%@", __PRETTY_FUNCTION__, deviceTypeModels);
#endif
#endif
    if(!_sharedDeviceTypeModelCategories) {
        [PPDeviceTypes initializeSharedDeviceTypeModelCategories];
    }

    NSMutableArray *deviceTypeModelCategoriesArray = [_sharedDeviceTypeModelCategories objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeModelCategoriesArray) {
        deviceTypeModelCategoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeDeviceModelCategory *deviceTypeModel in deviceTypeModels) {

        BOOL found = NO;
        for(PPDeviceTypeDeviceModelCategory *sharedDeviceTypeModel in deviceTypeModelCategoriesArray) {
            if([sharedDeviceTypeModel isEqualToCategory:deviceTypeModel]) {
                [sharedDeviceTypeModel sync:deviceTypeModel];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[deviceTypeModels indexOfObject:deviceTypeModel]];
        }
    }

    [deviceTypeModelCategoriesArray addObjectsFromArray:[deviceTypeModels objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeModelCategories setObject:deviceTypeModelCategoriesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeModelData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeModelCategories];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeModelData forKey:@"user.notificationDeviceTypeModelCategories"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeModelCategoriesArray=%@", __PRETTY_FUNCTION__, deviceTypeModelCategoriesArray);
#endif
#endif
}

/**
 * Remove device type model categories.
 * Remove device type model categories from local reference.
 *
 * @param deviceTypeModels NSArray Array of deviceTypeModels to remove.
 * @param userId Required PPUserId User Id to associate these device type models with
 **/
+ (void)removeDeviceTypeModelCategories:(NSArray *)deviceTypeModels userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeModels=%@", __PRETTY_FUNCTION__, deviceTypeModels);
#endif
#endif

    if(!_sharedDeviceTypeModelCategories) {
        [PPDeviceTypes initializeSharedDeviceTypeModelCategories];
    }

    NSMutableArray *deviceTypeModelCategoriesArray = [_sharedDeviceTypeModelCategories objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeModelCategoriesArray) {
        deviceTypeModelCategoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeDeviceModelCategory *deviceTypeModelCategory in deviceTypeModels) {
        for(PPDeviceTypeDeviceModelCategory *sharedDeviceTypeModelCategory in deviceTypeModelCategoriesArray) {
            if([sharedDeviceTypeModelCategory isEqualToCategory:deviceTypeModelCategory]) {
                [indexSet addIndex:[deviceTypeModelCategoriesArray indexOfObject:sharedDeviceTypeModelCategory]];
                break;
            }
        }
    }

    [deviceTypeModelCategoriesArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeModelCategories setObject:deviceTypeModelCategoriesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeModelData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeModelCategories];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeModelData forKey:@"user.notificationDeviceTypeModelCategories"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeModelCategoriesArray=%@", __PRETTY_FUNCTION__, deviceTypeModelCategoriesArray);
#endif
#endif
}

#pragma mark Device type Stories

__strong static NSMutableDictionary*_sharedDeviceTypeStories = nil;

/**
 * Shared deviceTypeStories across the entire application
 */
+ (NSArray *)sharedDeviceTypeStoriesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedDeviceTypeStories) {
        [PPDeviceTypes initializeSharedDeviceTypeStories];
    }
    NSMutableArray *sharedDeviceTypeStories = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *deviceTypeStoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedDeviceTypeStories.allKeys) {
        for(PPDeviceTypeStory *deviceTypeStory in [_sharedDeviceTypeStories objectForKey:userIdKey]) {
            NSMutableDictionary *deviceTypeStoriesIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [deviceTypeStoriesIdentifiers setValue:deviceTypeStory.storyId forKey:@"ID"];
            [deviceTypeStoriesIdentifiers setValue:@(deviceTypeStory.storyType) forKey:@"type"];
            [deviceTypeStoriesArray addObject:deviceTypeStoriesIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedDeviceTypeStories addObject:deviceTypeStory];
            }
        }
    }

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDeviceTypeStories=%@", __PRETTY_FUNCTION__, deviceTypeStoriesArray);
#endif
#endif
    return sharedDeviceTypeStories;
}

+ (void)initializeSharedDeviceTypeStories {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedDeviceTypeStories = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedDeviceTypeStoriesData = [defaults objectForKey:@"user.notificationDeviceTypeStories"];
//    if(storedDeviceTypeStoriesData) {
//        _sharedDeviceTypeStories = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedDeviceTypeStoriesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add deviceType Stories.
 * Add deviceType Stories to local reference.
 *
 * @param deviceTypeStories NSArray Array of deviceTypeStories to add.
 * @param userId Required PPUserId User Id to associate these device type Stories with
 **/
+ (void)addDeviceTypeStories:(NSArray *)deviceTypeStories userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeStories=%@", __PRETTY_FUNCTION__, deviceTypeStories);
#endif
#endif
    if(!_sharedDeviceTypeStories) {
        [PPDeviceTypes initializeSharedDeviceTypeStories];
    }

    NSMutableArray *deviceTypeStoriesArray = [_sharedDeviceTypeStories objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeStoriesArray) {
        deviceTypeStoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(NSInteger i = 0; i < [deviceTypeStories count]; i++) {
        PPDeviceTypeStory *deviceTypeStory = [deviceTypeStories objectAtIndex:i];
        BOOL found = NO;
        for(PPDeviceTypeStory *sharedDeviceTypeStory in deviceTypeStoriesArray) {
            if([sharedDeviceTypeStory isEqualToStory:deviceTypeStory]) {
                [sharedDeviceTypeStory sync:deviceTypeStory];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:i];
        }
    }

    [deviceTypeStoriesArray addObjectsFromArray:[deviceTypeStories objectsAtIndexes:indexSet]];
    [_sharedDeviceTypeStories setObject:deviceTypeStoriesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeStoriesData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeStories];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeStoriesData forKey:@"user.notificationDeviceTypeStories"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeStoriesArray=%@", __PRETTY_FUNCTION__, deviceTypeStoriesArray);
#endif
#endif
}

/**
 * Remove deviceType Stories.
 * Remove deviceType Stories from local reference.
 *
 * @param deviceTypeStories NSArray Array of deviceTypeStories to remove.
 * @param userId Required PPUserId User Id to associate these device type Stories with
 **/
+ (void)removeDeviceTypeStories:(NSArray *)deviceTypeStories userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s deviceTypeStories=%@", __PRETTY_FUNCTION__, deviceTypeStories);
#endif
#endif

    if(!_sharedDeviceTypeStories) {
        [PPDeviceTypes initializeSharedDeviceTypeStories];
    }

    NSMutableArray *deviceTypeStoriesArray = [_sharedDeviceTypeStories objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!deviceTypeStoriesArray) {
        deviceTypeStoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDeviceTypeStory *deviceTypeStory in deviceTypeStories) {
        for(PPDeviceTypeStory *sharedDeviceTypeStory in deviceTypeStoriesArray) {
            if([sharedDeviceTypeStory isEqualToStory:deviceTypeStory]) {
                [indexSet addIndex:[deviceTypeStoriesArray indexOfObject:sharedDeviceTypeStory]];
                break;
            }
        }
    }

    [deviceTypeStoriesArray removeObjectsAtIndexes:indexSet];
    [_sharedDeviceTypeStories setObject:deviceTypeStoriesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];

//    NSData *sharedDeviceTypeStoriesData = [NSKeyedArchiver archivedDataWithRootObject:_sharedDeviceTypeStories];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedDeviceTypeStoriesData forKey:@"user.notificationDeviceTypeStories"];
//    [defaults synchronize];

#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s deviceTypeStoriesArray=%@", __PRETTY_FUNCTION__, deviceTypeStoriesArray);
#endif
#endif
}

#pragma mark - Supported Products

/**
 * Get supported products.
 * Product attributes are documented in the Supported Product Attributes API call.
 *
 * @param deviceTypeId PPDeviceTypeId Specific device type to look up details on
 * @param attrName NSString Return device types, which have an attribute with this name
 * @param attrValue NSString Also filter the response by the attribute value
 * @param own Boolean PPDeviceTypesOwn only products created by this user
 * @param simple Simple Return only product fields without user and attributes information
 * @param organizationId PPOrganizationId Return only device types related to the specific organization
 * @param callback PPDeviceTypesBlock Device types callback block
 **/
+ (void)getSupportedProducts:(PPDeviceTypeId)deviceTypeId attrName:(NSString *)attrName attrValue:(NSString *)attrValue own:(PPDeviceTypesOwn)own simple:(PPDeviceTypesSimple)simple organizationId:(PPOrganizationId)organizationId callback:(PPDeviceTypesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"deviceTypes?"];


    if(deviceTypeId != PPDeviceTypeIdNone) {
        [requestString appendFormat:@"deviceTypeId=%li&", (long)deviceTypeId];
    }
    if(attrName) {
        [requestString appendFormat:@"attrName=%@&", attrName];
    }
    if(attrValue) {
        [requestString appendFormat:@"attrValue=%@&", attrValue];
    }
    if(own != PPDeviceTypesOwnNone) {
        [requestString appendFormat:@"own=%@&", (own) ? @"true" : @"false"];
    }
    if(simple != PPDeviceTypesSimpleNone) {
        [requestString appendFormat:@"simple=%@&", (simple) ? @"true" : @"false"];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getSupportedProducts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *deviceTypes;
            
            if(!error) {
                deviceTypes = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *deviceTypeDict in [root objectForKey:@"deviceTypes"]) {
                    PPDeviceType *deviceType = [PPDeviceType initWithDictionary:deviceTypeDict];
                    [deviceTypes addObject:deviceType];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(deviceTypes, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Supported Product Attribtues

/**
 * Get supported product attributes.
 * Each product can have a set of attributes associated with it, to optimize its performance on the IoT Software Suite. This API will provide access to every supported attribute and attribute values.
 *
 * @param callback PPDeviceTypeAttributesBlock Attributes callback block
 **/
+ (void)getSupportedProductAttributes:(PPDeviceTypeAttributesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"deviceTypeAttrs?"];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getSupportedProductAttribrutes()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *deviceTypeAttributes;
            
            if(!error) {
                deviceTypeAttributes = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *deviceTypeAttributeDict in [root objectForKey:@"deviceTypeAttributes"]) {
                    PPDeviceTypeAttribute *deviceTypeAttribute = [PPDeviceTypeAttribute initWithDictionary:deviceTypeAttributeDict];
                    [deviceTypeAttributes addObject:deviceTypeAttribute];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(deviceTypeAttributes, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Create a Product

/**
 * Creat a Product.
 * Each product / "device type" is created with a default name and a set of attributes to define the behavior of the product. See the Product Attributes API for more details on available attributes. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @param deviceType required PPDeviceType Device type to create
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createProduct:(PPDeviceType *)deviceType callback:(PPErrorBlock)callback {
    NSAssert1(deviceType != nil, @"%s missing deviceType", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"deviceType?"];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"deviceType\": %@", [PPDeviceType stringify:deviceType]];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.createProduct()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Update a Product

/**
 * Update a Product.
 * You must be the owner of the product in order to update it. For attributes, use the number '1' to indicate true, '0' to indicate false.
 *
 * @param deviceTypeId required PPDeviceTypeId The product ID / device type ID to update
 * @param deviceType required PPDeviceType Device type to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateProduct:(PPDeviceTypeId)deviceTypeId deviceType:(PPDeviceType *)deviceType callback:(PPErrorBlock)callback {
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    NSAssert1(deviceType != nil, @"%s missing deviceType", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceType/%li?", (long)deviceTypeId];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"deviceType\": %@", [PPDeviceType stringify:deviceType]];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.updateProduct()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage Parameters

/**
 * Get Parameters.
 *
 * @param name NSString Get a specific parameter name (no spaces)
 * @param callback PPDeviceTypeDeviceParamsBlock Device params callback block
 **/
+ (void)getParameters:(NSString *)name callback:(PPDeviceTypeDeviceParamsBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"deviceParameters?"];
    if(name) {
        [requestString appendFormat:@"name=%@&", name];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getParameters()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *deviceTypeParameters;
            
            if(!error) {
                deviceTypeParameters = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *deviceTypeParameterDict in [root objectForKey:@"deviceParams"]) {
                    PPDeviceTypeParameter *deviceTypeParameter = [PPDeviceTypeParameter initWithDictionary:deviceTypeParameterDict];
                    [deviceTypeParameters addObject:deviceTypeParameter];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(deviceTypeParameters, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Create and Update a Parameter.
 * A normal developer can update only their own parameters. A system administrator can edit any parameter.
 *
 * @param deviceTypeParameter required PPDeviceTypeParameter Parameter to create or update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createAndUpdateParameter:(PPDeviceTypeParameter *)deviceTypeParameter callback:(PPErrorBlock)callback {
    NSAssert1(deviceTypeParameter != nil, @"%s missing deviceTypeParameter", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"deviceParameters?"];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"deviceParam\": %@", [PPDeviceTypeParameter stringify:deviceTypeParameter]];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.createAndUpdateParameter()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Delete a Parameter

/**
 * Delete a parameter.
 * A normal developer can delete only their own parameters. A system administrator can delete any parameter.
 *
 * @param parameterName required NSString Name of your parameter to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteParameter:(NSString *)parameterName callback:(PPErrorBlock)callback {
    NSAssert1(parameterName != nil, @"%s missing parameterName", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceParameters/%@", parameterName];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteParameter()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage Rule Phrases

/**
 * Get existing rule phrases
 *
 * @param callback PPDeviceTypeRulePhrasesBlock Rule phrases callback block
 **/
+ (void)getExistingRulePhrases:(PPDeviceTypeRulePhrasesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"ruleTemplates?"];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getExistingRulePhrases()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *ruleTemplates;
            
            if(!error) {
                ruleTemplates = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *ruleTemplateDict in [root objectForKey:@"ruleTemplates"]) {
                    PPDeviceTypeRuleComponentTemplate *ruleTemplate = [PPDeviceTypeRuleComponentTemplate initWithDictionary:ruleTemplateDict];
                    [ruleTemplates addObject:ruleTemplate];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ruleTemplates, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Create a Rule Phrase.
 *
 * @param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to create
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)createRulePhrase:(PPDeviceTypeRuleComponentTemplate *)rulePhrase callback:(PPDeviceTypeRulePhraseBlock)callback {
    NSAssert1(rulePhrase != nil, @"%s missing rulePhrase", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"ruleTemplates?"];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"ruleTemplate\": %@", [PPDeviceTypeRuleComponentTemplate stringify:rulePhrase]];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.createRulePhrase()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceTypeRuleComponentTemplate *template;
            
            if(!error) {
                template = [PPDeviceTypeRuleComponentTemplate initWithDictionary:[root objectForKey:@"ruleTemplate"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(template, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Rule Phrase

/**
 * Get the rule phrase by ID.
 *
 * @param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)getRulePhraseById:(PPDeviceTypeRuleComponentTemplateId)templateId callback:(PPDeviceTypeRulePhraseBlock)callback {
    NSAssert1(templateId != PPDeviceTypeRuleComponentTemplateIdNone, @"%s missing templateId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"ruleTemplates/%li", (long)templateId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getRulePhraseById()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceTypeRuleComponentTemplate *ruleTemplate;
            
            if(!error) {
                ruleTemplate = [PPDeviceTypeRuleComponentTemplate initWithDictionary:[root objectForKey:@"ruleTemplate"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ruleTemplate, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Update Rule Phrase.
 *
 * @param templateId required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @param rulePhrase required PPDeviceTypeRuleComponentTemplate Template to update
 * @param callback PPDeviceTypeRulePhraseBlock Rule phrase block
 **/
+ (void)updateRulePhrase:(PPDeviceTypeRuleComponentTemplateId)templateId rulePhrase:(PPDeviceTypeRuleComponentTemplate *)rulePhrase callback:(PPDeviceTypeRulePhraseBlock)callback {
    NSAssert1(templateId != PPDeviceTypeRuleComponentTemplateIdNone, @"%s missing templateId", __FUNCTION__);
    NSAssert1(rulePhrase != nil, @"%s missing rulePhrase", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"ruleTemplates/%li?", (long)templateId];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"ruleTemplate\": %@", [PPDeviceTypeRuleComponentTemplate stringify:rulePhrase]];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.updateRulePhrase()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceTypeRuleComponentTemplate *template;
            
            if(!error) {
                template = [PPDeviceTypeRuleComponentTemplate initWithDictionary:[root objectForKey:@"ruleTemplate"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(template, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete Rule Phrase.
 *
 * @param templateId Required PPDeviceTypeRuleComponentTemplateId The rule phrase template ID to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRulePhrase:(PPDeviceTypeRuleComponentTemplateId)templateId callback:(PPErrorBlock)callback {
    NSAssert1(templateId != PPDeviceTypeRuleComponentTemplateIdNone, @"%s missing templateId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"ruleTemplates/%li", (long)templateId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteRulePhrase()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Default Rules

/**
 * Get product default rules.
 * This API will allow you to get default rules by device type ID. You must be the owner of the product in order to retrieve them.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param details PPDeviceTypesDetails True - Return details for these rules, including all the triggers, states, and actions that compose the rule. False - Only return the high level information about the rule, including the id, description text, on/off status, whether the rule is a default rule, and whether the rule is hidden and not editable, default
 * @param callback PPDeviceTypeDefaultRulesBlock Default rules callback block
 **/
+ (void)getProductDefaultRules:(PPDeviceTypeId)deviceTypeId details:(PPDeviceTypesDetails)details callback:(PPDeviceTypeDefaultRulesBlock)callback {
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceType/%li/rules?", (long)deviceTypeId];
    if(details != PPDeviceTypesDetailsNone) {
        [requestString appendFormat:@"details=%@&", (details) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getProductDefaultRules()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *rules;
            
            if(!error) {
                rules = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *ruleDict in [root objectForKey:@"rules"]) {
                    PPRule *rule = [PPRule initWithDictionary:ruleDict];
                    [rules addObject:rule];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(rules, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage default rules

/**
 * Add default rule.
 * Assign a rule as default for a specific product. When a user register a new device of this type, the system will automatically create a new rule based on this default rule.
 * You must be the owner of the product and the rule. The rule cannot be deleted after that.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param ruleId Required PPRuleId The rule ID
 * @param hidden PPRuleHidden Hidden status for default rule
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addDefaultRule:(PPDeviceTypeId)deviceTypeId ruleId:(PPRuleId)ruleId hidden:(PPRuleHidden)hidden callback:(PPErrorBlock)callback {
    NSAssert1(ruleId != PPRuleIdNone, @"%s missing ruleId", __FUNCTION__);
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceType/%li/rules/%li?", (long)deviceTypeId, (long)ruleId];
    if(hidden != PPRuleHiddenNone) {
        [requestString appendFormat:@"hidden=%@&", (hidden) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.addDefaultRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] POST:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete default rule.
 * Delete an association of the default rule and the specific product. You must be the owner of the product and the rule.
 *
 * @param deviceTypeId Required PPDeviceTypeId The product / device type ID
 * @param ruleId Required PPRuleId The rule ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDefaultRule:(PPDeviceTypeId)deviceTypeId ruleId:(PPRuleId)ruleId callback:(PPErrorBlock)callback {
    NSAssert1(ruleId != PPRuleIdNone, @"%s missing ruleId", __FUNCTION__);
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceType/%li/rules/%li?", (long)deviceTypeId, (long)ruleId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteDefaultRule()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Device goals

/**
 * Get device goals by type.
 * Retrieve device goals by device type.
 *
 * @param deviceTypeId Required PPDeviceTypeId The device type ID
 * @param appName NSString Specific app name
 * @param callback PPDeviceTypeGoalsBlock Goals callback block
 **/
+ (void)getDeviceGoalsByType:(PPDeviceTypeId)deviceTypeId appName:(NSString *)appName callback:(PPDeviceTypeGoalsBlock)callback {
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"deviceType/%li/goals?", (long)deviceTypeId];
    if(appName) {
        [requestString appendFormat:@"appName=%@&", appName.lowercaseString];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getDeviceGoalsByType()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *goals;
            
            if(!error) {
                goals = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *goalDict in [root objectForKey:@"goals"]) {
                    PPDeviceTypeGoal *goal = [PPDeviceTypeGoal initWithDictionary:goalDict];
                    [goals addObject:goal];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(goals, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Device goal installation instructions

/**
 * Get installation instructions.
 * Device installation instructions by goal ID.
 *
 * @param goalId Required PPDeviceTypeGoalId The device goal ID
 * @param callback PPDeviceTypeInstallationInstructionsBlock Installation instructions callback block
 **/
+ (void)getInstallationInstructions:(PPDeviceTypeGoalId)goalId callback:(PPDeviceTypeInstallationInstructionsBlock)callback {
    NSAssert1(goalId != PPDeviceTypeGoalIdNone, @"%s missing goalId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"goals/%li/installation?", (long)goalId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getInstallationInstructions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceTypeInstallationInstructions *installation;
            if(!error) {
                installation = [[PPDeviceTypeInstallationInstructions alloc] initWithGoalId:goalId installation:[root objectForKey:@"installation"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(installation, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Media

/**
 * Get media.
 * Get available medias.
 *
 * @param mediaId NSString Search by ID
 * @param callback PPDeviceTypeMediaBlock Media callback block
 **/
+ (void)getMedia:(NSString *)mediaId callback:(PPDeviceTypeMediaBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"media?"];
    if(mediaId) {
        [requestString appendFormat:@"mediaId=%@&", mediaId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getMedia()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *medias;
            
            if(!error) {
                medias = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *mediaDict in [root objectForKey:@"media"]) {
                    PPDeviceTypeMedia *media = [PPDeviceTypeMedia initWithDictionary:mediaDict];
                    [medias addObject:media];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(medias, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Put media.
 * Put multiple medias.
 *
 * @param medias Required NSArray Media objects to be uploaded
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putMedias:(NSArray *)medias callback:(PPErrorBlock)callback {
    NSAssert1(medias != nil && [medias count] > 0, @"%s missing medias", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"media?"];

    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];

    [JSONString appendString:@"\"media\": ["];
    BOOL appendComma = NO;
    for(PPDeviceTypeMedia *media in medias) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:[PPDeviceTypeMedia stringify:media]];
        appendComma = YES;
    }
    [JSONString appendString:@"]"];
    [JSONString appendString:@"}"];

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.putMedia()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete media.
 * Delete media. A media record can be deleted only, if it is not used in any device model description or story.
 *
 * @param medias NSArray Media to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteMedias:(NSArray *)medias callback:(PPErrorBlock)callback {
    NSAssert1(medias != nil && [medias count] > 0, @"%s missing medias", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"media?"];
    if(medias) {
        for(PPDeviceTypeMedia *media in medias) {
            [requestString appendFormat:@"mediaId=%@&", media.mediaId];
        }
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteMedias()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Device models

/**
 * Get device models.
 * The API returns device categories and models for specific brand.
 *
 * @param brand NSString Get text data for specific brand, otherwise data for default brand returned.
 * @param lang NSString Get text data for specific languages (support for multiple values), otherwise data for all languages returned.
 * @param hidden PPDeviceTypeDeviceModelHidden Request hidden categories and brand, which are not returned by default.
 * @param searchBy NSString Search criterion
 * @param includePairingType PPDeviceTypeDeviceModelPairingType Filter models by pairing type bitmask.
 * @param excludePairingType PPDeviceTypeDeviceModelPairingType Exclude models by pairing type bitmask.
 * @param modelId NSString Return single model
 * @param callback PPDeviceTypeDeviceModelsBlock Device Models callback block
 **/
+ (void)getDeviceModels:(NSString *)brand lang:(NSString *)lang hidden:(PPDeviceTypeDeviceModelHidden)hidden searchBy:(NSString *)searchBy includingPairingType:(PPDeviceTypeDeviceModelPairingType)includePairingType excludePairingType:(PPDeviceTypeDeviceModelPairingType)excludePairingType modelId:(NSString *)modelId callback:(PPDeviceTypeDeviceModelsBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"devicemodels?"];
    if(brand) {
        [requestString appendFormat:@"brand=%@&", brand];
    }
    if(lang) {
        [requestString appendFormat:@"lang=%@&", lang];
    }
    if(hidden != PPDeviceTypeDeviceModelHiddenNone) {
        [requestString appendFormat:@"hidden=%@&", (hidden) ? @"true" : @"false"];
    }
    if(searchBy) {
        [requestString appendFormat:@"searchBy=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:searchBy]];
    }
    if(includePairingType != PPDeviceTypeDeviceModelPairingTypeNone) {
        [requestString appendFormat:@"includePairingType=%li&", (long)includePairingType];
    }
    if(excludePairingType != PPDeviceTypeDeviceModelPairingTypeNone) {
        [requestString appendFormat:@"excludePairingType=%li&", (long)excludePairingType];
    }
    if(modelId) {
        [requestString appendFormat:@"modelId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:modelId]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getDeviceModels()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *categories;
            
            if(!error) {
                categories = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *categoryDict in [root objectForKey:@"categories"]) {
                    PPDeviceTypeDeviceModelCategory *category = [PPDeviceTypeDeviceModelCategory initWithDictionary:categoryDict];
                    [categories addObject:category];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(categories, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getDeviceModels:(NSString *)brand lang:(NSString *)lang hidden:(PPDeviceTypeDeviceModelHidden)hidden searchBy:(NSString *)searchBy callback:(PPDeviceTypeDeviceModelsBlock)callback {
    NSLog(@"%s deprecated. Use +getDeviceModels:lang:hidden:searchBy:includingPairingType:excludingPairingType:modelId:callback:", __FUNCTION__);
    [PPDeviceTypes getDeviceModels:brand lang:lang hidden:hidden searchBy:searchBy includingPairingType:PPDeviceTypeDeviceModelPairingTypeNone excludePairingType:PPDeviceTypeDeviceModelPairingTypeNone modelId:nil callback:callback];
}

/**
 * Upload device models.
 * Upload a catalog of device models and categories.
 * Data can be updated only for specific brand(s), while other brands data will not be affected.
 *
 * @param categories NSArray Categories to upload
 * @param models NSArray Models to upload
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadDeviceModels:(NSArray *)categories models:(NSArray *)models callback:(PPErrorBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"devicemodels?"];

    NSMutableString *JSONString;
    if([models count] > 0 || [categories count] > 0) {
        JSONString = [[NSMutableString alloc] init];
        [JSONString appendString:@"{"];

        BOOL appendComma = NO;

        if([models count] > 0) {

            [JSONString appendString:@"\"models\": ["];

            BOOL appendModelComma = NO;
            for(PPDeviceTypeDeviceModel *model in models) {
                if(appendModelComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendString:[PPDeviceTypeDeviceModel stringify:model]];
                appendModelComma = YES;
            }
            [JSONString appendString:@"]"];

            appendComma = YES;
        }
        if(appendComma) {
            [JSONString appendString:@","];
        }

        if([categories count] > 0) {

            [JSONString appendString:@"\"categories\": ["];

            BOOL appendModelComma = NO;
            for(PPDeviceTypeDeviceModelCategory *category in categories) {
                if(appendModelComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendString:[PPDeviceTypeDeviceModelCategory stringify:category]];
                appendModelComma = YES;
            }
            [JSONString appendString:@"]"];

            appendComma = YES;
        }

        [JSONString appendString:@"}"];

    }

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(JSONString) {
        [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.uploadDeviceModels()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete device models
 * Delete data for specific device model, category and brand.
 * Either modelId or categoryId parameters are mandatory.
 *
 * @param modelId NSString Remove data for specific device model
 * @param categoryId NSString Remove data for specific cateogry
 * @param brand NSString Remove model or category only to this brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDeviceModels:(NSString *)modelId categoryId:(NSString *)categoryId brand:(NSString *)brand callback:(PPErrorBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"devicemodels?"];

    if(modelId) {
        [requestString appendFormat:@"modelId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:modelId]];
    }
    if(categoryId) {
        [requestString appendFormat:@"categoryId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:categoryId]];
    }
    if(brand) {
        [requestString appendFormat:@"brand=%@&", brand];
    }

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteDeviceModels()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Stories

/**
 * Put stories
 * Insert new stories or update existing stories.
 *
 * @param stories NSArray Story objects to update or create
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putStories:(NSArray *)stories callback:(PPErrorBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"stories?"];

    NSMutableString *JSONString;
    if([stories count] > 0) {
        JSONString = [[NSMutableString alloc] init];
        [JSONString appendString:@"{"];

        [JSONString appendString:@"\"stories\": ["];

        BOOL appendModelComma = NO;
        for(PPDeviceTypeStory *story in stories) {
            if(appendModelComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeStory stringify:story]];
            appendModelComma = YES;
        }
        [JSONString appendString:@"]"];

        [JSONString appendString:@"}"];
    }

    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(JSONString) {
        [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.putStories()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Get stories.
 *
 * @param storyId NSString Get specific story by ID
 * @param modelId NSString Filter stories by device model
 * @param brand NSString Filter stories by brand
 * @param storyType PPDeviceTypeStoryType Filter stories by type
 * @param searchBy NSString Search criterion
 * @param hidden PPDeviceTypeStoryPageHidden Request hidden pages, which are not returned by default.
 * @param lang NSString Get stories for specific language, otherwise stories for all languages returned.
 * @param callback PPDeviceTypeStoriesBlock Stories callback block
 **/
+ (void)getStories:(NSString *)storyId modelId:(NSString *)modelId brand:(NSString *)brand storyType:(PPDeviceTypeStoryType)storyType searchBy:(NSString *)searchBy hidden:(PPDeviceTypeStoryPageHidden)hidden lang:(NSString *)lang callback:(PPDeviceTypeStoriesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"stories?"];
    if(storyId) {
        [requestString appendFormat:@"storyId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:storyId]];
    }
    if(modelId) {
        [requestString appendFormat:@"modelId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:modelId]];
    }
    if(brand) {
        [requestString appendFormat:@"brand=%@&", brand];
    }
    if(storyType != PPDeviceTypeDeviceModelHiddenNone) {
        [requestString appendFormat:@"storyType=%li&", (long)storyType];
    }
    if(searchBy) {
        [requestString appendFormat:@"searchBy=%@&", searchBy];
    }
    if(hidden != PPDeviceTypeDeviceModelHiddenNone) {
        [requestString appendFormat:@"hidden=%@&", (hidden) ? @"true" : @"false"];
    }
    if(lang) {
        [requestString appendFormat:@"lang=%@&", lang];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.getStories()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *stories;
            
            if(!error) {
                stories = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *storyDict in [root objectForKey:@"stories"]) {
                    PPDeviceTypeStory *story = [PPDeviceTypeStory initWithDictionary:storyDict];
                    [stories addObject:story];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(stories, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete story
 * Delete an existing story.
 *
 * @param storyId NSString Story ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteStory:(NSString *)storyId callback:(PPErrorBlock)callback {
    NSString *requestString = [NSString stringWithFormat:@"stories?storyId=%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:storyId]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.products.deleteStory()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end


