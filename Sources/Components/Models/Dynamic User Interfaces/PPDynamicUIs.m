//
//  PPDynamicUIs.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDynamicUIs.h"
#import "PPCloudEngine.h"

@implementation PPDynamicUIs

#pragma mark - Session Management

/**
 * Shared screens across the entire application
 */
+ (NSArray *)sharedScreensForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPDynamicUIScreen *> *sharedScreens = [PPDynamicUIScreen allObjects];
    
    NSMutableArray *sharedScreensArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *screensArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPDynamicUIScreen *screen in sharedScreens) {
        [sharedScreensArray addObject:screen];
        NSMutableDictionary *screenIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [screenIdentifiers setValue:screen.screenId forKey:@"id"];
        [screensArrayDebug addObject:screenIdentifiers];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedScreens=%@", __PRETTY_FUNCTION__, screensArrayDebug);
#endif
#endif
    return sharedScreensArray;
}

/**
 * Add screens.
 * Add screens from local reference.
 *
 * @param screens NSArray Array of screens to remove.
 * @param userId Required PPUserId User Id to associate these dynamicUIs with
 **/
+ (void)addScreens:(NSArray *)screens userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s screens=%@", __PRETTY_FUNCTION__, screens);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPDynamicUIScreen *screen in screens) {
        [PPDynamicUIScreen createOrUpdateInDefaultRealmWithValue:screen];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove screens.
 * Remove screens from local reference.
 *
 * @param screens NSArray Array of screens to remove.
 * @param userId Required PPUserId User Id to associate these dynamicUIs with
 **/
+ (void)removeScreens:(NSArray *)screens userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s screens=%@", __PRETTY_FUNCTION__, screens);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPDynamicUIScreen *screen in screens) {
            [[PPRealm defaultRealm] deleteObject:[PPDynamicUIScreen objectForPrimaryKey:screen.screenId]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
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
