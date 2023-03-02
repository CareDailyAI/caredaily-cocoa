//
//  PPDynamicUIs.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// The Presence Application is one example user interface framework that is natively built to expand dynamically with the addition of new devices in the user's account. But some features that a user needs might not be physical devices, and they might not be subscriptions, so we need a way to add those software features to the user's account. The Dynamic UI API allows us to do just that.
//
// For example, users that belong to a Community Social Network might have Messaging, Challenges, Groups, and Points show up in their account. Dynamic UI's allow the app to expand itself with software features for specific users.There must be a directory on the server in the products/{product} directory containing an index.html, and icons referenced by each Dynamic UI item.
//

#import "PPBaseModel.h"
#import "PPDynamicUIScreen.h"

@interface PPDynamicUIs : PPBaseModel

#pragma mark - Session Management

/**
 * Shared dynamicUIs across the entire application
 */
+ (NSArray *)sharedScreensForUser:(PPUserId)userId;


/**
 * Add dynamicUIs.
 * Add dynamicUIs to local reference.
 *
 * @param dynamicUIs NSArray Array of dynamicUIs to add.
 * @param userId Required PPUserId User Id to associate these dynamicUIs with
 **/
+ (void)addScreens:(NSArray *)dynamicUIs userId:(PPUserId)userId;

/**
 * Remove dynamicUIs.
 * Remove dynamicUIs from local reference.
 *
 * @param dynamicUIs NSArray Array of dynamicUIs to remove.
 * @param userId Required PPNotificationsUserId User Id to associate these dynamicUIs with
 **/
+ (void)removeScreens:(NSArray *)dynamicUIs userId:(PPUserId)userId;

#pragma mark - Dynamic UI

/**
 * Get Dynamic UI
 *
 * @param appName Required NSString Unique application name for which to retrieve dynamic UI's
 * @param version NSString Version number of the app, in case we need different dynamic UI's for one version vs. another
 * @param callback PPDynamicUIBlock Dynamic UI callback block
 **/
+ (void)getDynamicUI:(NSString * _Nonnull )appName version:(NSString * _Nullable )version callback:(PPDynamicUIBlock _Nonnull )callback;

#pragma mark - Location Totals

/**
 * Get location totals.
 * For the location landing page we are displaying the locations's total files, devices, rules and friends. This is a single API to request total numbers.
 *
 * @param locationId Required PPLocationId Location ID
 * @param type PPDynamicUILocationTotalsType Bitmask value of selected type(s)
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data from the specific user's account.
 * @param callback PPDynamicUILocationTotalsBlock Location totals callback block containing NSDictionary of totals and optional error
 **/
+ (void)getLocationTotals:(PPLocationId)locationId type:(PPDynamicUILocationTotalsType)type userId:(PPUserId)userId callback:(PPDynamicUILocationTotalsBlock _Nonnull )callback;
+ (void)getUserTotals:(PPDynamicUILocationTotalsType)type userId:(PPUserId)userId callback:(PPDynamicUILocationTotalsBlock _Nonnull )callback __attribute__((deprecated));

@end
