//
//  PPDynamicUIs.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDynamicUIs.h"
#import "PPCloudEngine.h"

@implementation PPDynamicUIs

#pragma mark - Session Management

__strong static NSMutableDictionary*_sharedScreens = nil;

/**
 * Shared screens across the entire application
 */
+ (NSArray *)sharedScreensForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedScreens) {
        [PPDynamicUIs initializeSharedScreens];
    }
    NSMutableArray *sharedScreens = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *screensArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedScreens.allKeys) {
        for(PPDynamicUIScreen *screen in [_sharedScreens objectForKey:userIdKey]) {
            NSMutableDictionary *screenIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [screenIdentifiers setValue:screen.screenId forKey:@"screenId"];
            if(screen.order != PPDynamicUIScreenSectionOrderNone) {
                [screenIdentifiers setValue:@(screen.order) forKey:@"order"];
            }
            [screensArray addObject:screenIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedScreens addObject:screen];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedScreens=%@", __PRETTY_FUNCTION__, screensArray);
#endif
#endif
    return sharedScreens;
}

+ (void)initializeSharedScreens {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedScreens = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedScreensData = [defaults objectForKey:@"user.dynamicUIs"];
//    if(storedScreensData) {
//        _sharedScreens = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedScreensData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add screens.
 * Add screens from local reference.
 *
 * @param screens NSArray Array of screens to remove.
 * @param userId Required PPUserId User Id to associate these screens with
 **/
+ (void)addScreens:(NSArray *)screens userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s screens=%@", __PRETTY_FUNCTION__, screens);
#endif
#endif
    if(!_sharedScreens) {
        [PPDynamicUIs initializeSharedScreens];
    }
    
    NSMutableArray *screensArray = [_sharedScreens objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!screensArray) {
        screensArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDynamicUIScreen *screen in screens) {
        
        BOOL found = NO;
        for(PPDynamicUIScreen *sharedScreen in screensArray) {
            if([sharedScreen isEqualToScreen:screen]) {
                [sharedScreen sync:screen];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[screens indexOfObject:screen]];
        }
    }
    
    [screensArray addObjectsFromArray:[screens objectsAtIndexes:indexSet]];
    [_sharedScreens setObject:screensArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedScreenData = [NSKeyedArchiver archivedDataWithRootObject:_sharedScreens];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedScreenData forKey:@"user.dynamicUIs"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s screensArray=%@", __PRETTY_FUNCTION__, screensArray);
#endif
#endif
}

/**
 * Remove screens.
 * Remove screens from local reference.
 *
 * @param screens NSArray Array of screens to remove.
 * @param userId Required PPUserId User Id to associate these screens with
 **/
+ (void)removeScreens:(NSArray *)screens userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s screens=%@", __PRETTY_FUNCTION__, screens);
#endif
#endif
    
    if(!_sharedScreens) {
        [PPDynamicUIs initializeSharedScreens];
    }
    
    NSMutableArray *screensArray = [_sharedScreens objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!screensArray) {
        screensArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPDynamicUIScreen *screen in screens) {
        for(PPDynamicUIScreen *sharedScreen in screensArray) {
            if([sharedScreen isEqualToScreen:screen]) {
                [indexSet addIndex:[screensArray indexOfObject:sharedScreen]];
                break;
            }
        }
    }
    
    [screensArray removeObjectsAtIndexes:indexSet];
    [_sharedScreens setObject:screensArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedScreenData = [NSKeyedArchiver archivedDataWithRootObject:_sharedScreens];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedScreenData forKey:@"user.dynamicUIs"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s screensArray=%@", __PRETTY_FUNCTION__, screensArray);
#endif
#endif
}

#pragma mark - Dynamic UI

/**
 * Get Dynamic UI
 *
 * @param appName Required NSString Unique application name for which to retrieve dynamic UI's
 * @param version NSString Version number of the app, in case we need different dynamic UI's for one version vs. another
 * @param callback PPDynamicUIBlock Dynamic UI callback block
 **/
+ (void)getDynamicUI:(NSString *)appName version:(NSString *)version callback:(PPDynamicUIBlock)callback {
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"uiscreens/%@?", appName];
    
    if(version) {
        [requestString appendFormat:@"version=%@&", version];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.dynamicuis.getDynamicUI()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *screens;
            
            if(!error) {
                screens = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *screenDict in [root objectForKey:@"screens"]) {
                    PPDynamicUIScreen *screen = [PPDynamicUIScreen initWithDictionary:screenDict];
                    [screens addObject:screen];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(screens, error);
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

#pragma mark - User Totals

/**
 * Get user totals.
 * For the location landing page we are displaying the user's total files, devices, rules and friends. This is a single API to request total numbers.
 *
 * @param locationId Required PPLocationId Location ID
 * @param type PPDynamicUILocationTotalsType Bitmask value of selected type(s)
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data from the specific user's account.
 * @param callback PPDynamicUILocationTotalsBlock Location totals callback block containing NSDictionary of totals and optional error
 **/
+ (void)getLocationTotals:(PPLocationId)locationId type:(PPDynamicUILocationTotalsType)type userId:(PPUserId)userId callback:(PPDynamicUILocationTotalsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"userTotals?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(type & PPDynamicUILocationTotalsTypeDevices) {
        [requestString appendFormat:@"devices=true&"];
    }
    if(type & PPDynamicUILocationTotalsTypeFiles) {
        [requestString appendFormat:@"files=true&"];
    }
    if(type & PPDynamicUILocationTotalsTypeRules) {
        [requestString appendFormat:@"rules=true&"];
    }
    if(type & PPDynamicUILocationTotalsTypeFriends) {
        [requestString appendFormat:@"friends=true&"];
    }
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.dynamicuis.getLocationTotals()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableDictionary *totals;
            
            if(!error) {
                totals = [[NSMutableDictionary alloc] initWithCapacity:4];
                [totals setValue:[root objectForKey:@"devicesTotal"] forKey:[NSString stringWithFormat:@"%lu",(long)PPDynamicUILocationTotalsTypeDevices]];
                [totals setValue:[root objectForKey:@"filesTotal"] forKey:[NSString stringWithFormat:@"%lu",(long)PPDynamicUILocationTotalsTypeFiles]];
                [totals setValue:[root objectForKey:@"rulesTotal"] forKey:[NSString stringWithFormat:@"%lu",(long)PPDynamicUILocationTotalsTypeRules]];
                [totals setValue:[root objectForKey:@"friendsTotal"] forKey:[NSString stringWithFormat:@"%lu",(long)PPDynamicUILocationTotalsTypeFriends]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(totals, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}
+ (void)getUserTotals:(PPDynamicUILocationTotalsType)type userId:(PPUserId)userId callback:(PPDynamicUILocationTotalsBlock)callback {
    NSLog(@"%s deprecated. Use +getLocationTotals:type:userId:callback:", __FUNCTION__);
    [PPDynamicUIs getLocationTotals:PPLocationIdNone type:type userId:userId callback:callback];
}
@end
