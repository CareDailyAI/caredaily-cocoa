//
//  PPFriendship.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite enables a user to add friends and share access to some aspects of their account.

#import "PPBaseModel.h"
#import "PPFriendshipFriend.h"
#import "PPFriendshipDevice.h"

typedef NS_OPTIONS(NSInteger, PPFriendshipId) {
    PPFriendshipIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPFriendshipBlocked) {
    PPFriendshipBlockedNone = -1,
    PPFriendshipBlockedFalse = 0,
    PPFriendshipBlockedTrue = 1
};

@interface PPFriendship : NSObject

/* An ID of the friendship record */
@property (nonatomic) PPFriendshipId friendshipId;

/* Friend information including user ID, name and email address */
@property (nonatomic, strong) PPFriendshipFriend *friendshipFriend;

/* Invited user email address, if he/she not registered yet */
@property (nonatomic, strong) NSString *email;

/* Indicates if this friendship is blocked by the calling user */
@property (nonatomic) PPFriendshipBlocked blocked;

/* A list of your own devices shared with the friend */
@property (nonatomic, strong) NSArray *ownDevices;

/* A list of your own devices shared with the calling user */
@property (nonatomic, strong) NSArray *friendDevices;

- (id) initWithFriendshipId:(PPFriendshipId)friendshipId friendshipFriend:(PPFriendshipFriend *)friendshipFriend email:(NSString *)email blocked:(PPFriendshipBlocked)blocked ownDevices:(NSArray *)ownDevices friendDevices:(NSArray *)friendDevices;

+ (PPFriendship *)initWithDictionary:(NSDictionary *)friendshipDict;

+ (NSString *)JSONStringForFriendship:(PPFriendship *)friendship;

#pragma mark - Helper Methods

- (BOOL)isEqualToFriendship:(PPFriendship *)friendship;

- (void)sync:(PPFriendship *)friendship;

@end
