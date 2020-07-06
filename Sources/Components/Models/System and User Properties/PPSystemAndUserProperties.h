//
//  PPSystemAndUserProperties.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// System Properties are one of the most useful tools to manage and synchronize the behavior of production apps, without releasing a new build of the app. System Properties are key/value pairs that are distributed across every user in the system. The values are plain text. System Properties have been used to specify default "Getting Started" videos to render, the Terms of Service signature ID's required to be signed, the quality of the video to render, and the level of debug information to receive from the user base back to the server.
// User Properties are key/value pairs that are specific to a user, and can override System Properties. User properties can store arbitrary details about the user, beyond what the User Account and Location can store. For example, a developer may want to store the user's preferences for a particular application behavior.
// In the IoT Software Suite, a system administrator may specify and update a System Properties at the server. Please contact support@peoplepowerco.com if you would like to create or update a System Property for your app.
// System and User property names (keys) do not have spaces. Property names can be a maximum of 250 characters. The maximum limit on the user property value is dependent upon the API used to upload the value, either 250 characters if uploaded as a URL parameter, and 10,000 characters if uploaded in the body of an XML or JSON payload.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPProperty.h"

typedef void (^PPSystemPropertyBlock)(PPProperty * _Nullable property, NSError * _Nullable error);
typedef void (^PPSystemPropertiesBlock)(NSArray * _Nullable properties, NSError * _Nullable error);

extern NSInteger SYSTEM_PROPERTY_CACHE_REFRESH_TIME_SECONDS;
extern NSInteger USER_PROPERTY_CACHE_REFRESH_TIME_SECONDS;

extern NSString * _Nonnull USER_PROPERTY_DEFAULT_USER_TEMPERATURE;
extern NSString * _Nonnull USER_PROPERTY_DEFAULT_USER_TIME_FORMAT;
extern NSString * _Nonnull USER_PROPERTY_DEFAULT_USER_CURRENCY;
extern NSString * _Nonnull USER_PROPERTY_DEFAULT_USER_CURRENCY_COUNTRY;
extern NSString * _Nonnull USER_PROPERTY_NUMERIC_CODE;
extern NSString * _Nonnull USER_PROPERTY_DURESS_CODE;
extern NSString * _Nonnull USER_PROPERTY_USER_TIME;
extern NSString * _Nonnull USER_PROPERTY_USER_TEMPERATURE;
extern NSString * _Nonnull USER_PROPERTY_USER_CURRENCY_CODE;
extern NSString * _Nonnull USER_PROPERTY_USER_CURRENCY_SYMBOL;
extern NSString * _Nonnull USER_PROPERTY_USER_CURRENCY_COUNTRY;

#define USER_PROPERTY_SERVICE_START_DATE(serviceName)   [NSString stringWithFormat:@"%@.startDate", serviceName]
#define USER_PROPERTY_END_OF_LIFE_NOTICE(appName)       [NSString stringWithFormat:@"%@-end_of_life_notice", appName]
#define SYSTEM_PROPERTY_PASSWORD_REGEX(appName)         [NSString stringWithFormat:@"%@-password_regex", appName]
#define SYSTEM_PROPERTY_IOS_VERSION(appName)            [NSString stringWithFormat:@"ios-version-%@", appName]
#define SYSTEM_PROPERTY_TERMS_OF_SERVICE(appName)       [NSString stringWithFormat:@"%@-tos", appName]
#define SYSTEM_PROPERTY_LOCATION_ACCESS(appName)        [NSString stringWithFormat:@"%@-LocationAccess", appName]
#define SYSTEM_PROPERTY_END_OF_LIFE_DATE(appName)       [NSString stringWithFormat:@"%@-end_of_life_date", appName]

extern NSString * _Nonnull SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX;
extern NSString * _Nonnull SYSTEM_PROPERTY_CALL_CENTER_SUPPORTED_STATE_IDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_ANALYTICS_QUIET;
extern NSString * _Nonnull SYSTEM_PROPERTY_ANALYTICS_LEVEL;
extern NSString * _Nonnull SYSTEM_PROPERTY_PERSISTENT_TIMEOUT;
extern NSString * _Nonnull SYSTEM_PROPERTY_POST_FILE_RETRY_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_DEDICATED_CAMERA_URL;
extern NSString * _Nonnull SYSTEM_PROPERTY_SYSTEM_WEB_CACHE_KEY;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PLAYER_MAX_SECONDS_BEFORE_ABORT_READ_FRAME;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_LOG_STREAMING_STATISTICS_ON_WOOPRA;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_MAXIMUM_RETRY_CONNECTION_ATTEMPTS_BEFORE_WARNING;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_COUNTDOWN_TIMER_WARNING_DURATION_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_COUNTDOWN_TIMER_TOTAL_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_MAXIMUM_BITRATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_FRAMES_PER_SECOND;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_KEY_FRAME_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_AUDIO_RATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_FREE_DEFAULT_BUFFER_LENGTH;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_COUNTDOWN_TIMER_TOTAL_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_MAXIMUM_BITRATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_FRAMES_PER_SECOND;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_KEY_FRAME_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_AUDIO_RATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_PRO_DEFAULT_BUFFER_LENGTH;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_MAXIMUM_BITRATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_FRAMES_PER_SECOND;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_KEY_FRAME_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_AUDIO_RATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_BUFFER_LENGTH;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_MAXIMUM_BITRATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_AUDIO_RATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_BUFFER_LENGTH;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_MAXIMUM_RESOLUTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_AUDIO_RATE;
extern NSString * _Nonnull SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_BUFFER_LENGTH;
extern NSString * _Nonnull SYSTEM_PROPERTY_CAMERA_MOTION_ALERT_PERIOD_SECONDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_CAMERA_QUANTIFY_MOTION;
extern NSString * _Nonnull SYSTEM_PROPERTY_DEFAULT_GETTING_STARTED_VIDEO_URL;
extern NSString * _Nonnull SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_URL;
extern NSString * _Nonnull SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_URL;
extern NSString * _Nonnull SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_ARRAY;
extern NSString * _Nonnull SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_ARRAY;
extern NSString * _Nonnull SYSTEM_PROPERTY_BRANDS;
extern NSString * _Nonnull SYSTEM_PROPERTY_PASSCODE_LOWERCASE; // BOOL
extern NSString * _Nonnull SYSTEM_PROPERTY_COMMUNITY_POST_FILE_CONTENT_LIMIT;

typedef NS_OPTIONS(NSInteger, PPSystemPropertyPublic) {
    PPSystemPropertyPublicFalse = 0,
    PPSystemPropertyPublicTrue = 1
};

@interface PPSystemAndUserProperties : PPBaseModel

#pragma mark - Session Management

/**
 * Shared properties across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedPropertiesForUser:(PPUserId)userId;

/**
 * Add properties.
 * Add properties to local reference.
 *
 * @param properties NSArray Array of properties to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addProperties:(NSArray *)properties userId:(PPUserId)userId;

/**
 * Remove properties.
 * Remove properties from local reference.
 *
 * @param properties NSArray Array of properties to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeProperties:(NSArray *)properties userId:(PPUserId)userId;

#pragma mark - User and System Properties

/**
 * Get User or System Property.
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 *
 * @param propertyName NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @param isPublic PPSystemPropertyPublic Return public system property
 * @param callback PPNSStringBlock NSString callback block
 **/
+ (void)getUserOrSystemProperty:(NSString *)propertyName isPublic:(PPSystemPropertyPublic)isPublic callback:(PPNSStringBlock)callback;

#pragma mark - Manage multiple User Properties

/**
 * Get user properties.
 * This API returna user-specific property values.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * You may also supply only a prefix of the property name you are looking for. The IoT Software Suite will return all properties that contain the given property name prefix.
 *
 * @param propertyName NSString Property name or optional name prefix to filter properties in the batch version
 * @param userId PPUserId User ID, used by an account with administrative privileges to retrieve the properties of another user
 * @param callback PPSystemPropertiesBlock System properties callback block
 **/
+ (void)getUserProperties:(NSString *)propertyName userId:(PPUserId)userId callback:(PPSystemPropertiesBlock)callback;

/**
 * Update multiple user properties.
 * The application may update several user properties simultaneously. The maximum value size may be 10,000 characters using this API.
 *
 * @param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user
 * @param properties Required NSArray Array of properties to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateMultipleUserProperties:(PPUserId)userId properties:(NSArray *)properties callback:(PPErrorBlock)callback;

#pragma mark - Manage a single User Property

/**
 * Get User Property
 *
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 * This is JSON format version of the previously documented API.
 *
 * @param propertyName Required NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @param userId PPUserId User ID. used by an account with administrative privileges to retrieve the properties of another user
 * @param isPublic PPSystemPropertyPublic Return public system property
 * @param callback PPSystemPropertyBlock System property callback block
 **/
+ (void)getUserProperty:(NSString *)propertyName userId:(PPUserId)userId isPublic:(PPSystemPropertyPublic)isPublic callback:(PPSystemPropertyBlock)callback;

#pragma mark - Update a single user property

/**
 * Update a single user property.
 * The application may update a single user property with a very simple API requiring no XML or JSON body. The maximum value size may be 250 characters using this API.
 *
 * @param propertyName Required NSString Name of the property to set a value for. Maximum of 250 characters
 * @param value Required NSString Value to set for this property. Maximum of 250 characters.
 * @param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user.
 * @param callback PPErrorBlcok Error callback block
 **/
+ (void)updateSingleUserProperty:(NSString *)propertyName value:(NSString *)value userId:(PPUserId)userId callback:(PPErrorBlock)callback;
 
@end
