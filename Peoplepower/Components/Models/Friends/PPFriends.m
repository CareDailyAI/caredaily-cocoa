//
//  PPFriends.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPFriends.h"
#import "PPUserAccounts.h"
#import "PPCloudEngine.h"

@implementation PPFriends

#pragma mark - Session Management

/**
 * Shared friendships across the entire application
 */
+ (NSArray *)sharedFriendshipsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPFriendship *> *sharedFriends = [PPFriendship allObjects];

    NSMutableArray *sharedFriendsArray = [[NSMutableArray alloc] initWithCapacity:[sharedFriends count]];
    NSMutableArray *friendsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPFriendship *friend in sharedFriends) {
        [sharedFriendsArray addObject:friend];
        
        [friendsArrayDebug addObject:@{@"friendshipId": @(friend.friendshipId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFriendships=%@", __PRETTY_FUNCTION__, friendsArrayDebug);
#endif
#endif
    return sharedFriendsArray;
}

/**
 * Add friendships.
 * Add friendships from local reference.
 *
 * @param friendships NSArray Array of friendships to remove.
 * @param userId Required PPUserId User Id to associate these friendships with
 **/
+ (void)addFriendships:(NSArray *)friendships userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s friendships=%@", __PRETTY_FUNCTION__, friendships);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPFriendship *friend in friendships) {
        [PPFriendship createOrUpdateInDefaultRealmWithValue:friend];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove friendships.
 * Remove friendships from local reference.
 *
 * @param friendships NSArray Array of friendships to remove.
 * @param userId Required PPUserId User Id to associate these friendships with
 **/
+ (void)removeFriendships:(NSArray *)friendships userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s friendships=%@", __PRETTY_FUNCTION__, friendships);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPFriendship *friend in friendships) {
            [[PPRealm defaultRealm] deleteObject:[PPFriendship objectForPrimaryKey:@(friend.friendshipId)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Friends

#pragma mark Add Friends

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
+ (void)addFriends:(NSArray *)friends callback:(PPErrorBlock)callback {
    NSString *requestString = @"friends?";
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"friends\": ["];
    
    BOOL appendComma = NO;
    for(PPFriendshipFriend *friend in friends) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"{"];
        
        BOOL appendFriendComma = NO;
        if(friend.friendId != PPUserIdNone) {
            if(appendFriendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"userId\":\"%li\"", (long)friend.friendId];
            appendFriendComma = YES;
        }
        
        if(friend.email.email) {
            if(appendFriendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"email\":\"%@\"", friend.email.email];
            appendFriendComma = YES;
        }
        [JSONString appendString:@"}"];
        appendComma = YES;
    }
    [JSONString appendString:@"]}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.fiends.addFriends()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Get friends.
 * Provides a list of friendships.
 *
 * @param friendshipId PPFriendshipId Filter friendship records by ID.
 * @param deviceId NSString Filter friends, who share this device with the user or the user shares this device with friends.
 * @param checkConnected PPDeviceConnected Check, if friend devices are connected.
 * @param callback PPFriendsFriendshipBlock Friendship callback block
 **/
+ (void)getFriends:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId checkConnected:(PPDeviceConnected)checkConnected callback:(PPFriendsFriendshipBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"friends?"];
    
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    
    if(checkConnected != PPDeviceConnectedNone) {
        [requestString appendFormat:@"checkConnected=%@&", (checkConnected) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.fiends.getFriends()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *friendships;
            
            if(!error) {
                friendships = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *friendshipDict in [root objectForKey:@"friends"]) {
                    PPFriendship *friendship = [PPFriendship initWithDictionary:friendshipDict];
                    [friendships addObject:friendship];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(friendships, error);
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

#pragma mark - Manage Friends

#pragma mark Update friendship

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
+ (void)updateFriendship:(PPFriendshipId)friendshipId block:(PPFriendshipBlocked)block ownDevices:(NSArray *)ownDevices friendDevices:(NSArray *)friendDevices callback:(PPErrorBlock)callback {
    
    NSString *requestString = [NSString stringWithFormat:@"friends/%li?", (long)friendshipId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    PPFriendship *friendship = [[PPFriendship alloc] initWithFriendshipId:friendshipId friendshipFriend:nil email:nil blocked:block ownDevices:(RLMArray *)ownDevices friendDevices:(RLMArray *)friendDevices];
    
    [JSONString appendFormat:@"\"friend\": %@", [PPFriendship JSONStringForFriendship:friendship]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.fiends.updateFriendship()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark Delete friendship

/**
 * Delete friendship
 * This API deletes the friend connection in both accounts. The only way to reconnect is to go through the "Add Friends" process again.
 *
 * @param friendshipId PPFriendshipId Friendship record ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteFriendship:(PPFriendshipId)friendshipId callback:(PPErrorBlock)callback {
    NSString *requestString = [NSString stringWithFormat:@"friends/%lu",(long)friendshipId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.fiends.deleteFriendship()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage shared devices

#pragma mark Delete shared device

/*
 * Delete shared device
 * Stop sharing own device.
 *
 * @param friendshipId PPFriendshipId Friendship record ID
 * @param deviceId NSString Device record ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteSharedDevice:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId callback:(PPErrorBlock)callback {
    NSString *requestString = [NSString stringWithFormat:@"friends/%lu/devices/%@",(long)friendshipId, deviceId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.fiends.deleteSharedDevice()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

@end
