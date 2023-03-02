//
//  PPSMSGroupTexting.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// Manage external subscribers for SMS Group Texting.
//

#import "PPBaseModel.h"
#import "PPSMSSubscriber.h"

@interface PPSMSGroupTexting : PPBaseModel

#pragma mark - Session Management

/**
 * Shared subscribers across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedSubscribersForUser:(PPUserId)userId;

/**
 * Add subscribers.
 * Add subscribers to local reference.
 *
 * @param subscribers NSArray Array of subscribers to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addSubscribers:(NSArray *)subscribers userId:(PPUserId)userId;

/**
 * Remove subscribers.
 * Remove subscribers from local reference.
 *
 * @param subscribers NSArray Array of subscribers to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeSubscribers:(NSArray *)subscribers userId:(PPUserId)userId;

#pragma mark - SMS Group Texting

/**
 * Get SMS Subscribers
 *
 * @param categories NSArray Communication category filter. Multiple values supported.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param callback PPSMSGroupTextingSubscribersCallback SMS Group Texting subscribers callback containing array of subscribers
 **/
+ (void)getSMSSubscribers:(NSArray * _Nullable )categories userId:(PPUserId)userId callback:(PPSMSGroupTextingSubscribersCallback _Nonnull )callback __attribute__((deprecated));

/**
 * Add / Update Subscriber
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param subscriber Required PPSMSSubscriber Subscriber object to add / update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateSubscriber:(PPUserId)userId subscriber:(PPSMSSubscriber * _Nonnull )subscriber callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete Subscriber
 *
 * @param phone Required NSString Phone number to delete
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteSubscriber:(NSString * _Nonnull )phone userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

@end
