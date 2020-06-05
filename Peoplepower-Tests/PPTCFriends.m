//
//  PPTCFriends.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
#warning DEPRECATED APIS
#import <XCTest/XCTest.h>
#import <Peoplepower/PPAppResources.h>
#import <Peoplepower/PPFriends.h>
#import <Peoplepower/PPUserAccounts.h>
#import <Peoplepower/PPDevices.h>

@interface PPTCFriends : XCTestCase

@end

@implementation PPTCFriends

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Friends

/**
 * Add friends
 * Adds other users as friends, using their email addresses or user ID's:
 *      email = Other user's email address to be friends with.
 *      userId = Other user's user ID to be friends with.
 *
 * When user A connects with existing Presence user B, existing Presence user B is notified with a push notification that they are now connected.When user attempts to connect with a set of email addresses that don't exist, those email addresses should automatically receive an invitation email. Whenever accounts for those email addresses are created, the two users are automatically linked as friends with no further action needed on either person's part.
 *
 * @ param friends NSArray Friends to be added
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_test01AddFriends {
    
    NSDictionary *friendDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FRIENDS_FRIEND filename:PLIST_FILE_UNIT_TESTS];
    
    PPFriendshipFriend *friend = [PPFriendshipFriend initWithDictionary:friendDict];
    NSArray *friends = @[friend];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"testGetUserInformation"];
    
    [PPFriends addFriends:friends callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Refresh friends
 * Provides a list annay of friendships
 *
 * @ param friendshipId PPFriendshipId Filter friendship records by ID.
 * @ param deviceId NSString Filter friends, who share this device with the user or the user shares this device with friends.
 * @ param checkConnected PPDeviceConnected Check, if friend devices are connected.
 * @ param callback PPFriendsFriendshipBlock Friendship callback block
 **/
// + (void)getFriends:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId checkConnected:(PPDeviceConnected)checkConnected callback:(PPFriendsFriendshipBlock)callback;
- (void)test02GetFriends {
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"testGetUserInformation"];
    
    [PPFriends getFriends:PPFriendshipIdNone deviceId:nil checkConnected:PPDeviceConnectedNone callback:^(NSArray *friendships, NSError *error) {
        
        XCTAssertNil(error);
        [PPFriends addFriendships:friendships userId:[PPUserAccounts currentUser].userId];
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage Friends

/**
 * Update an existing friendship
 * Allow to update friendship properties, share own devices with a friend or configure friend devices.
 * This API only adds or update existing shared device records. Use the "Delete shared device" API to delete.
 *
 * @ param friendshipId PPFriendshipId Friendship record ID
 * @ param block PPFriendshipBlocked Block status
 * @ param ownDevices NSArray Own devices to be updated
 * @ param friendDevices NSArray Friend devices to be updated
 * @ param callback PPErrorBlock Error callback block
 **/
// + (void)updateFriendship:(PPFriendshipId)friendshipId block:(PPFriendshipBlocked)block ownDevices:(NSArray *)ownDevices friendDevices:(NSArray *)friendDevices callback:(PPErrorBlock)callback;
- (void)test03UpdateFriendship {
    
    PPFriendship *friendship = [[PPFriends sharedFriendshipsForUser:[PPUserAccounts currentUser].userId] firstObject];
    
    PPDevice *device = [[PPDevices sharedDevicesForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId] firstObject];
    PPFriendshipDevice *friendshipDevice = [PPFriendshipDevice initWithDevice:device events:@[@"HOME"] currentEvent:nil mute:PPFriendshipDeviceMuteNone shareDate:nil];
    friendshipDevice.friendshipId = friendship.friendshipId;
    
    NSArray *ownDevices = @[friendshipDevice];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"testGetUserInformation"];
    
    [PPFriends updateFriendship:friendship.friendshipId block:PPFriendshipBlockedNone ownDevices:ownDevices friendDevices:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Delete friendship
 * This API deletes the friend connection in both accounts. The only way to reconnect is to go through the "Add Friends" process again.
 *
 * @ param friendshipId PPFriendshipId Friendship record ID
 * @ param callback PPErrorBlock Error callback block
 **/
// + (void)deleteFriendship:(PPFriendshipId)friendshipId callback:(PPErrorBlock)callback;
- (void)test05DeleteFriendship {

    PPFriendship *friendship = [[PPFriends sharedFriendshipsForUser:[PPUserAccounts currentUser].userId] firstObject];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"testGetUserInformation"];
    
    [PPFriends deleteFriendship:friendship.friendshipId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        if(friendship) {
            [PPFriends removeFriendships:@[friendship] userId:[PPUserAccounts currentUser].userId];
        }
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage shared devices

/*
 * Delete shared device
 * Stop sharing own device.
 *
 * @ param friendshipId PPFriendshipId Friendship record ID
 * @ param deviceId NSString Device record ID
 * @ param callback PPErrorBlock Error callback block
 **/
// + (void)deleteSharedDevice:(PPFriendshipId)friendshipId deviceId:(NSString *)deviceId callback:(PPErrorBlock)callback;
- (void)test04DeleteSharedDevice {
    
    PPFriendship *friendship = [[PPFriends sharedFriendshipsForUser:[PPUserAccounts currentUser].userId] firstObject];
    PPFriendshipDevice *friendshipDevice = [friendship.ownDevices firstObject];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"testGetUserInformation"];
    
    [PPFriends deleteSharedDevice:friendship.friendshipId deviceId:friendshipDevice.deviceId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

@end
