//
//  PPUser.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// A user account represents a person who can use the services provided by the IoT Software Suite.
// The IoT Software Suite enables developers to capture a wide range of information on a user, as needed to add value to the application. All the user fields below are optional, except when otherwise specified by the API.
// The user's password is always transmitted inside the HTTP body or header, allowing it to be encrypted.
//

#import "PPBaseModel.h"
#import "PPUserEmail.h"
#import "PPOrganization.h"
#import "PPLocation.h"
#import "PPUserBadge.h"
#import "PPUserTag.h"

@interface PPUser : PPBaseModel <NSCopying>

@property (strong, nonatomic) NSString *sessionKey;
@property (strong, nonatomic) NSDate *sessionKeyExpiry;

/* User ID. It can be set during a new user record creation on certain clouds only. */
@property (nonatomic) PPUserId userId;

/* An email address is required when registering a new user. */
@property (nonatomic,strong) PPUserEmail *email;

/* If this is not set, then the email address will become the username. */
@property (nonatomic, strong) NSString *username;

/* Alternative (second) username. */
@property (nonatomic, strong) NSString *altUsername;

/* User's first name. Or, what do your friends call you? */
@property (nonatomic, strong) NSString *firstName;

/* User's last name(s). */
@property (nonatomic, strong) NSString *lastName;

/* User's community name(s). */
@property (nonatomic, strong) NSString *communityName;

/* Update the user with emailResetStatus = true to reset the email address status to OK. This will allow the IoT Software Suite to continue attempting to deliver emails to the user's address. If the email delivery has a problem again, the cloud will update the email status back to an error state. */
//@property (nonatomic) BOOL emailResetStatus;

/* User's preferred language. For example:
 en - English
 cn - Chinese
 fr - French
 ru - Russian
 etc */
@property (nonatomic, strong) NSString *language;

/* Phone number */
@property (nonatomic, strong) NSString *phone;

/* Phone Type */
@property (nonatomic) PPUserPhoneType phoneType;

/* SMS Status */
@property (nonatomic) PPUserSMSStatus smsStatus;

/* When the user sends messages in a community social network, enabling this flag will cause their name to be hidden when they send messages and on lists of individuals who are part of a group inside an organization, etc. Default is false. */
@property (nonatomic) PPUserAnonymousType anonymous;

/* User permissions */
@property (nonatomic, strong) NSArray *userPermissions;

/* User locations */
@property (nonatomic, strong) NSArray *locations;

/* User badges */
@property (nonatomic, strong) NSArray *badges;

/* User organizations */
@property (nonatomic, strong) NSArray *organizations;

/* User tags */
@property (nonatomic, strong) NSArray *tags;

/* Auth Clients */
@property (nonatomic, strong) NSArray *authClients;

/* User creation date */
@property (nonatomic, strong) NSDate *creationDate;

/* User temp key */
@property (nonatomic, strong) NSString *tempKey;

/* User temp key expiry date */
@property (nonatomic, strong) NSDate *tempKeyExpiry;

@property (nonatomic) PPUserAvatarFileId avatarFileId;

/* User Communities */
@property (nonatomic, strong) NSArray *userCommunities;

/* Location Communities */
@property (nonatomic, strong) NSArray *locationCommunities;

#pragma mark - Session Management

- (id)initWithCachedUser;

- (id)initWithSessionKey:(NSString *)sessionKey username:(NSString *)username;

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName communityName:(NSString *)communityName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(NSArray *)userPermissions tags:(NSArray *)tags locations:(NSArray *)locations badges:(NSArray *)badges organizations:(NSArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId creationDate:(NSDate *)creationDate authClients:(NSArray *)authClients userCommunities:(NSArray *)userCommunities locationCommunities:(NSArray *)locationCommunities;

+ (PPUser * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )root;

#pragma mark - Locations

- (PPLocation *)currentLocation;

- (void)setCurrentLocation:(PPLocation *)location;

#pragma mark - Helper methods

- (BOOL)isEqualToUser:(PPUser *)user;

- (void)sync:(PPUser *)user;

@end
