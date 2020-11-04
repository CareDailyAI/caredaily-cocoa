//
//  PPFriends.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPFriendship.h"

@interface PPFriends : PPBaseModel

#pragma mark - Session Management

/**
 * Shared friendships across the entire application
 */
+ (NSArray *)sharedFriendshipsForUser:(PPUserId)userId;

/**
 * Add friendships.
 * Add friendships to local reference.
 *
 * @param friendships NSArray Array of friendships to add.
 * @param userId Required PPUserId User Id to associate these friendships with
 **/
+ (void)addFriendships:(NSArray *)friendships userId:(PPUserId)userId;

/**
 * Remove friendships.
 * Remove friendships from local reference.
 *
 * @param friendships NSArray Array of friendships to remove.
 * @param userId Required PPUserId User Id to associate these friendships with
 **/
+ (void)removeFriendships:(NSArray *)friendships userId:(PPUserId)userId;

#pragma mark - Friends

/**
 * Add friends
 * Adds other users as friends, using their email addresses or user ID's:
 *      email = Other user's email address to be friends with.
 *      userId = Other user's user ID to be friends with.
 *
 * When user A connects with existing Presence user B, existing Presence user B is notified with a push notification that they are now connected.When user attempts to connect with a set of email addresses that don't exist, those email addresses should automatically receive an invitation email. Whenever accounts for those email addresses are created, the two users are automatically linked as friends with no further action needed on either person's part.
 *
 * @param friends NSArray Friends to be added
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addFriends:(NSArray *)friends callback:(PPErrorBlock)callback;

/**
 * Refresh friends
 * Provides a list annay of friendships
 *
 * @param friendshipId PPFriendshipId Filter friendship records by ID.
 * @param deviceId NSString Filter friends, who share this device with the user or the user shares this device with friends.
 * @param checkConnected PPDeviceConnected Check, if friend devices are connected.
 * @param callback PPFriendsFriendshipBlock Friendship callback block
 **/
+ (void)getFriends:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId checkConnected:(PPDeviceConnected)checkConnected callback:(PPFriendsFriendshipBlock)callback;

#pragma mark - Manage Friends

/**
 * Update an existing friendship
 * Allow to update friendship properties, share own devices with a friend or configure friend devices.
 * This API only adds or update existing shared device records. Use the "Delete shared device" API to delete.
 *
 * @param friendshipId PPFriendshipId Friendship record ID
 * @param block PPFriendshipBlocked Block status
 * @param ownDevices NSArray Own devices to be updated
 * @param friendDevices NSArray Friend devices to be updated
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateFriendship:(PPFriendshipId)friendshipId block:(PPFriendshipBlocked)block ownDevices:(NSArray *)ownDevices friendDevices:(NSArray *)friendDevices callback:(PPErrorBlock)callback;

/**
 * Delete friendship
 * This API deletes the friend connection in both accounts. The only way to reconnect is to go through the "Add Friends" process again.
 *
 * @param friendshipId PPFriendshipId Friendship record ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteFriendship:(PPFriendshipId)friendshipId callback:(PPErrorBlock)callback;

#pragma mark - Manage shared devices

/*
 * Delete shared device
 * Stop sharing own device.
 *
 * @param friendshipId PPFriendshipId Friendship record ID
 * @param deviceId NSString Device record ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteSharedDevice:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId callback:(PPErrorBlock)callback;

@end
