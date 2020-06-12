//
//  PPNotificationSubscription.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionType) {
    PPNotificationSubscriptionTypeNone = -1,
    PPNotificationSubscriptionTypeAll = 0, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeMarketing = 1, // Email; Configurable;
    PPNotificationSubscriptionTypeDeviceSharing = 2, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeOrganizations = 3, // Email and Push;
    PPNotificationSubscriptionTypeAnalytics = 4, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeQuestions = 5, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeUserAccountCreationFollowup = 6, // Email;
    PPNotificationSubscriptionTypeDeviceAlerts = 7, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeExternalNotifications = 8, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeInAppMessage = 9, // Push;
    PPNotificationSubscriptionTypeNewDeviceAdded = 10, // Push;
    PPNotificationSubscriptionTypeAccountIssues = 11, // Push;
    PPNotificationSubscriptionTypeAddingFriends = 12, // Email and Push;
    PPNotificationSubscriptionTypeNotificationByOAuthClient = 13, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeAddingCircleMembers = 15, // Email and Push;
    PPNotificationSubscriptionTypeDeviceFirmwareUpdate = 16, // Push;
    PPNotificationSubscriptionTypeSMSSubscription = 17, // Push;
    PPNotificationSubscriptionTypeErrorsWithOAuthApps = 18, // Push;
    PPNotificationSubscriptionTypeBotErrorsToDevelopers = 19, // Email;
    PPNotificationSubscriptionTypeAppBadgeChange = 20 // Push;
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionEmailEnabled) {
    PPNotificationSubscriptionEmailEnabledNone = -1,
    PPNotificationSubscriptionEmailEnabledFalse = 0,
    PPNotificationSubscriptionEmailEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionPushEnabled) {
    PPNotificationSubscriptionPushEnabledNone = -1,
    PPNotificationSubscriptionPushEnabledFalse = 0,
    PPNotificationSubscriptionPushEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSMSEnabled) {
    PPNotificationSubscriptionSMSEnabledNone = -1,
    PPNotificationSubscriptionSMSEnabledFalse = 0,
    PPNotificationSubscriptionSMSEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionEmailPeriod) {
    PPNotificationSubscriptionEmailPeriodNone = -1,
    PPNotificationSubscriptionEmailPeriodAllTheTime = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionPushPeriod) {
    PPNotificationSubscriptionPushPeriodNone = -1,
    PPNotificationSubscriptionPushPeriodAllTheTime = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSMSPeriod) {
    PPNotificationSubscriptionSMSPeriodNone = -1,
    PPNotificationSubscriptionSMSPeriodAllTheTime = 0
};

@interface PPNotificationSubscription : RLMObject

/* Notification type, defined by the IoT Software Suite and retrieved in the GET API */
@property (nonatomic) PPNotificationSubscriptionType type;

/* Name of the type of notification */
@property (nonatomic, strong) NSString *name;

/* Email notifications enabled status */
@property (nonatomic) PPNotificationSubscriptionEmailEnabled email;

/* Push notifications enabled status */
@property (nonatomic) PPNotificationSubscriptionPushEnabled push;

/* SMS notifications enabled status */
@property (nonatomic) PPNotificationSubscriptionSMSEnabled sms;

/* How long to wait between emails, in seconds. */
@property (nonatomic) PPNotificationSubscriptionEmailPeriod emailPeriod;

/* How long to wait between push notifications, in seconds. */
@property (nonatomic) PPNotificationSubscriptionPushPeriod pushPeriod;

/* How long to wait between SMS notifications, in seconds. */
@property (nonatomic) PPNotificationSubscriptionSMSPeriod smsPeriod;

- (id)initWithType:(PPNotificationSubscriptionType)type name:(NSString *)name email:(PPNotificationSubscriptionEmailEnabled)email push:(PPNotificationSubscriptionPushEnabled)push sms:(PPNotificationSubscriptionSMSEnabled)sms emailPeriod:(PPNotificationSubscriptionEmailPeriod)emailPeriod pushPeriod:(PPNotificationSubscriptionPushPeriod)pushPeriod smsPeriod:(PPNotificationSubscriptionSMSPeriod)smsPeriod;

+ (PPNotificationSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict;

#pragma mark - Helper methods

- (BOOL)isEqualToSubscription:(PPNotificationSubscription *)subscription;

- (void)sync:(PPNotificationSubscription *)subscription;

@end

RLM_ARRAY_TYPE(PPNotificationSubscription);
