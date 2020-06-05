//
//  PPAppResources.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/15/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Files

extern NSString *PLIST_FILE_UNIT_TESTS;
extern NSString *PLIST_FILE_CONFIG;
extern NSString *PLIST_FILE_ATTRIBUTIONS;

#pragma mark - Config

extern NSString *PLIST_KEY_CONFIG_APP_NAME;
extern NSString *PLIST_KEY_CONFIG_COMPANY_NAME;
extern NSString *PLIST_KEY_CONFIG_BRAND;
extern NSString *PLIST_KEY_CONFIG_CLOUD;
extern NSString *PLIST_KEY_CONFIG_COLORS;

#pragma mark - Attributions

extern NSString *PLIST_KEY_ATTRIBUTIONS_ATTRIBUTIONS;

#pragma mark - Versioning

extern NSString *PLIST_KEY_CONFIG_IOT_ICONS_VERSION;

#pragma mark - Unit Testing

#pragma mark - Server Settings

extern NSString *PLIST_KEY_TEST_APP_NAME;
extern NSString *PLIST_KEY_TEST_BRAND;
extern NSString *PLIST_KEY_TEST_CLOUD;
extern NSString *PLIST_KEY_TEST_SERVER_URL;

#pragma mark - User Accounts

extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_PASSWORD;
extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_USERNAME;

extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER;
extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER_2;
extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER_3;

extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION;
extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION_2;
extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION_3;

extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_LOCATION_SPACE;

extern NSString *PLIST_KEY_TEST_USER_ACCOUNTS_NARRATIVE;

#pragma mark - Devices

extern NSString *PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE;
extern NSString *PLIST_KEY_TEST_DEVICES_PROPERTIES;
extern NSString *PLIST_KEY_TEST_DEVICES_VIDEO_TOKENS;

#pragma mark - Device Measurements

extern NSString *PLIST_KEY_TEST_DEVICE_MEASUREMENTS_PARAMETERS;

#pragma mark - Communications

#pragma mark Notifications

extern NSString *PLIST_KEY_TEST_NOTIFICATION_TOKEN;
extern NSString *PLIST_KEY_TEST_NOTIFICATION_PUSH_MESSAGE;
extern NSString *PLIST_KEY_TEST_NOTIFICATION_EMAIL_MESSAGE;
extern NSString *PLIST_KEY_TEST_NOTIFICATION_SMS_MESSAGE;

#pragma mark Crowd Feedback

extern NSString *PLIST_KEY_TEST_CROWD_FEEDBACK_FEEDBACK;
extern NSString *PLIST_KEY_TEST_CROWD_FEEDBACK_FEEDBACK_SUPPORT;

#pragma mark In-App Messaging

extern NSString *PLIST_KEY_TEST_IN_APP_MESSAGING_MESSAGE;

#pragma mark Questions

extern NSString *PLIST_KEY_TEST_QUESTIONS;

#pragma mark SMS Group Texting

extern NSString *PLIST_KEY_TEST_SMS_GROUP_TEXTING_SUBSCRIBER;

#pragma mark - User and System Properties

extern NSString *PLIST_KEY_TEST_SYSTEM_AND_USER_PROPERTIES;

#pragma mark - File Management

extern NSString *PLIST_KEY_TEST_FILE_MANAGEMENT_IMAGE;
extern NSString *PLIST_KEY_TEST_FILE_MANAGEMENT_VIDEO;
extern NSString *PLIST_KEY_TEST_FILE_MANAGEMENT_AUDIO;

#pragma mark - Rules

extern NSString *PLIST_KEY_TEST_RULES_RULE;
extern NSString *PLIST_KEY_TEST_RULES_GOAL;

#pragma mark - Professional Monitoring

extern NSString *PLIST_KEY_TEST_PROFESSIONAL_MONITORING_CALL_CENTER;

#pragma mark - Energy Management

extern NSString *PLIST_KEY_TEST_ENERGY_MANAGEMENT_UTILITY_BILL;
extern NSString *PLIST_KEY_TEST_ENERGY_MANAGEMENT_BILLING_INFO;

#pragma mark - Products

extern NSString *PLIST_KEY_TEST_PRODUCTS_DEVICE_TYPE;
extern NSString *PLIST_KEY_TEST_PRODUCTS_PARAMETER;
extern NSString *PLIST_KEY_TEST_PRODUCTS_RULE_PHRASE;
extern NSString *PLIST_KEY_TEST_PRODUCTS_MEDIA;
extern NSString *PLIST_KEY_TEST_PRODUCTS_MODEL;
extern NSString *PLIST_KEY_TEST_PRODUCTS_CATEGORY;
extern NSString *PLIST_KEY_TEST_PRODUCTS_STORY;

#pragma mark - OAuth

extern NSString *PLIST_KEY_TEST_OAUTH_CLIENT_APPLICATION_ID;
extern NSString *PLIST_KEY_TEST_OAUTH_HOST_CLIENT_ID;

#pragma mark - Friends

extern NSString *PLIST_KEY_TEST_FRIENDS_FRIEND;

#pragma mark - Circles

extern NSString *PLIST_KEY_TEST_CIRCLES_CIRCLE;
extern NSString *PLIST_KEY_TEST_CIRCLES_MEMBER;
extern NSString *PLIST_KEY_TEST_CIRCLES_POST;

#pragma mark - Community

extern NSString *PLIST_KEY_TEST_COMMUNITY_POST;
extern NSString *PLIST_KEY_TEST_COMMUNITY_COMMENT;
extern NSString *PLIST_KEY_TEST_COMMUNITY_FILE_VIDEO;
extern NSString *PLIST_KEY_TEST_COMMUNITY_FILE_IMAGE;
extern NSString *PLIST_KEY_TEST_COMMUNITY_FILE_AUDIO;

@interface PPAppResources : NSObject

+ (NSObject *)getPlistEntry:(NSString *)key filename:(NSString *)filename;

@end
