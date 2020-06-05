//
//  PPLogin.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef void (^PPLoginBlock)(NSString * _Nullable APIKey, NSDate * _Nullable expireDate, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPLoginExpiryType) {
    PPLoginExpiryTypeNever = -1,
    PPLoginExpiryTypeNotSet = 0,
};

typedef NS_OPTIONS(NSInteger, PPLoginNotificationType) {
    PPLoginNotificationTypeNone = -1,
    PPLoginNotificationTypeEmail = 1,
    PPLoginNotificationTypeSMS = 2,
};

typedef NS_OPTIONS(NSInteger, PPLoginKeyType) {
    PPLoginKeyTypeDefault = 0,
    PPLoginKeyTypeTempKey = 1,
    PPLoginKeyTypeAnalytic = 14
};

@interface PPLogin : PPBaseModel

#pragma mark - Login

/**
 * Login by username and password or a temporary passcode.
 * Allows a user to login using their private credentials (username and password). This request returns an API key which is linked to the user, and will be used in all future API calls. It is the responsibility of the application developer to securely store, manage, and communicate users' API keys
 *
 * @param username Required NSString The username, typically an email address
 * @param password NSString The password. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX
 * @param passcode NSString The temporary passcode.
 * @param expiry PPLoginExpiryType API key expiration period in days, nonzero. By default, this is set to -1, which means the key will never expire.
 * @param appName NSString Short application name to trigger some automatic actions like registrating the user in an organization.  Regex provided by system property SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @param callback PPLoginBlock Callback method provides API key, expire data, and optional error
 **/
+ (void)loginWithUsername:(NSString * _Nonnull )username password:(NSString * _Nullable )password passcode:(NSString * _Nullable )passcode expiry:(PPLoginExpiryType)expiry appName:(NSString * _Nullable )appName callback:(PPLoginBlock _Nonnull )callback;
+ (void)loginWithUsername:(NSString * _Nonnull )username password:(NSString * _Nonnull )password expiry:(PPLoginExpiryType)expiry appName:(NSString * _Nullable )appName callback:(PPLoginBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Passcode

/**
 * Send passcode
 * Send a temporary pass code to a user.
 * Currently it can be send only by SMS, if the user has a valid mobile phone number.
 *
 * @param username Required NSString The username.
 * @param type Required PPLoginNotificationType Notification type: 2 = SMS
 * @param brand NSString A parameter identifying a customer's specific notification template
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)sendPasscodeWithUsername:(NSString * _Nonnull )username type:(PPLoginNotificationType)type brand:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName callback:(PPErrorBlock _Nonnull )callback;
+ (void)sendPasscodeWithUsername:(NSString * _Nonnull )username type:(PPLoginNotificationType)type callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Login with an existing API key

/**
 * Login with an existing API key.
 * This login API allows the user to log in with an existing API key instead of username and password.  It is typically used to check if the API key is valid, and to renew the key if it is going to expire soon.
 * If no key is provided, then this API request can is used to generate a temporary key that is valid for only a brief amount of time.
 *
 * @param key NSString API key
 * @param keyType PPLoginKeyType Returned API key type:
 *      0 = Normal user application, default.
 *      1 = Temporary key
 * @param expiry PPUserExpiry API key expiry period in days, nonzero. By default the key will never expire.
 * @param clientId NSString Client or application ID to retrieve a specific key for this client.
 * @param cloudName NSString The third party cloud name, where the API key must be validated.
 * @param callback PPUserLoginBlock Callback method provides API key, expire data, and optional error
 **/
+ (void)loginWithKey:(NSString * _Nullable )key keyType:(PPLoginKeyType)keyType expiry:(PPLoginExpiryType)expiry clientId:(NSString * _Nullable )clientId cloudName:(NSString * _Nullable )cloudName callback:(PPLoginBlock _Nonnull )callback;

@end
