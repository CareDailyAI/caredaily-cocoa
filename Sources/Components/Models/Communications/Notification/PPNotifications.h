//
//  PPNotifications.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// It is extremely important to communicate with your user base, and the IoT Software Suite enables communications more comprehensively than any other IoT platform in existence today. Whether it's sending messages to your users, allowing your users to talk to each other, or gather quantified feedback from the crowd to drive your roadmap, the IoT Software Suite takes user communications very seriously and provides a well rounded set of APIs to manage communications.
// The IoT Software Suite supports the following types of user communications:
//      - Email notifications with customizable, Velocity-scriptable templates (welcome emails, email address confirmations, password reset, alerts, etc.)
//      - Push notifications (alerts, badges, etc.)
//      - SMS notifications
//      - In-app messaging (from admin to users and groups, users to other users and groups, replies, etc.)
//      - Support requests
//      - Crowd feedback - very powerful CTO-level tool to quantify feature requests and issues across the user base
//

#import "PPBaseModel.h"
#import "PPNotificationSubscription.h"
#import "PPOrganization.h"
#import "PPNotificationPushMessage.h"
#import "PPNotificationEmailMessage.h"
#import "PPNotificationSMSMessage.h"
#import "PPNotificationToken.h"
#import "PPNotification.h"

@interface PPNotifications : PPBaseModel

#pragma mark - Session Management

#pragma mark Notification Subscriptions

/**
 * Shared subscriptions across the entire application
 */
+ (NSArray *)sharedSubscriptionsForUser:(PPUserId)userId;

/**
 * Add subscriptions.
 * Add subscriptions to local reference.
 *
 * @param subscriptions NSArray Array of subscriptions to add.
 * @param userId Required PPUserId User Id to associate these subscriptions with
 **/
+ (void)addSubscriptions:(NSArray *)subscriptions userId:(PPUserId)userId;

/**
 * Remove subscriptions.
 * Remove subscriptions from local reference.
 *
 * @param subscriptions NSArray Array of subscriptions to remove.
 * @param userId Required PPUserId User Id to associate these subscriptions with
 **/
+ (void)removeSubscriptions:(NSArray *)subscriptions userId:(PPUserId)userId;

#pragma mark Notifications

/**
 * Shared notifications across the entire application
 */
+ (NSArray *)sharedNotifications;

/**
 * Add notifications.
 * Add notifications to non-volatile reference.
 *
 * @param notifications NSArray Notifications to add
 **/
+ (void)addNotifications:(NSArray *)notifications;

/**
 * Remove notifications.
 * Remove notifications to non-volatile reference.
 *
 * @param notifications NSArray Notifications
 **/
+ (void)removeNotificaitons:(NSArray *)notifications;

#pragma mark Notification Tokens

/**
 * Shared tokens across the entire application
 */
+ (PPNotificationToken *)sharedTokenForUser:(PPUserId)userId;

/**
 * Add APNs token.
 * Add APNs to non-volatile reference.
 *
 * @param notificationToken PPNotificationToken Notification token
 * @param userId Required PPUserId User Id to associate this token with
 **/
+ (void)addNotificationToken:(PPNotificationToken *)notificationToken userId:(PPUserId)userId;

/**
 * Remove APNs token.
 * Remove APNs to non-volatile reference.
 *
 * @param notificationToken PPNotificationToken Notification token
 * @param userId Required PPUserId User Id to disassociate this token with
 **/
+ (void)removeNotificaitonToken:(PPNotificationToken *)notificationToken userId:(PPUserId)userId;

#pragma mark - Get notification subcriptions

/**
 * Get notification subscriptions.
 * A user may subscribe or unsubscribe from certain types of push and email notifications, or set boundaries on how many notifications their account can receive within a specified amount of time.
 *
 * @param callback PPNotificationSubscriptionsBlock Subscriptions callback block with an array of existing subscriptions
 **/
+ (void)getNotificationSubscriptions:(PPNotificationSubscriptionsBlock _Nonnull )callback;

#pragma mark - Set my notification subscriptions

/**
 * Set my notification subscriptions
 *
 * @param type Required PPNotificationSubscriptionType Type of notification, as defined by the IoT Software Suite during the request to Get Subscription Notifications
 * @param email PPNotificationSubscriptionEmailEnabled Enable or disable email notifications
 * @param push PPNotificationSubscriptionPushEnabled Enable or disable push notifications
 * @param sms PPNotificationSubscriptionSMSEnabled Enable or disable sms notifications
 * @param emailPeriod PPNotificationSubscriptionEmailPeriod Maximum number of seconds between email notifications
 * @param pushPeriod PPNotificationSubscriptionPushPeriod Maximum number of seconds between push notifications
 * @param smsPeriod PPNotificationSubscriptionSMSPeriod Maximum number of seconds between sms notifications
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setNotificationSubscription:(PPNotificationSubscriptionType)type email:(PPNotificationSubscriptionEmailEnabled)email push:(PPNotificationSubscriptionPushEnabled)push sms:(PPNotificationSubscriptionSMSEnabled)sms emailPeriod:(PPNotificationSubscriptionEmailPeriod)emailPeriod pushPeriod:(PPNotificationSubscriptionPushPeriod)pushPeriod smsPeriod:(PPNotificationSubscriptionSMSPeriod)smsPeriod callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Register an app for push notifications

/**
 * Register an app for push notifications
 *
 * @param appName Required NSString Unique App Name to register for push notifications
 * @param notificationToken Required NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @param badge PPNotificationSubscriptionSupportsBadgeIcons Supports badge icons. Default is False.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)registerAnAppForPushNotifications:(NSString * _Nonnull )appName notificationToken:(NSString * _Nonnull )notificationToken badge:(PPNotificationSubscriptionSupportsBadgeIcons)badge callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Unregister an app for push notifications

/**
 * Unregister an app for push notifications
 *
 * @param notificationToken Required NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)unregisterAnAppForPushNotifications:(NSString * _Nonnull )notificationToken callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Send a notification

/**
 * Send a notification.
 * Sends an arbitrary push notification or email to the user. If you're sending an email, you may include a subject and specify whether the email is in HTML format or plain text. Push notification messages are limited by the standard push notification payload size, usually ~120 characters max is OK.
 * This API allows to include inline graphics as an attachment. All attachment fields are mandatory. The content field contains the Base64 encoded binary image content.
 * The generated by the app email content or the template should include correct references to inline graphics content ID's with "cid:" prefixes. For example <img src="cid:inlineImageId">.
 *
 * @param userId PPUserId Send a notification to this user by an administrator
 * @param organizationId PPOrganizationId Use templates of specific organization
 * @param brand NSString Brand name
 * @param emailMessage PPNotificationEmailMessage Email message
 * @param pushMessage PPNotificationPushMessage Push message
 * @param smsMessage PPNotificationSMSMessage SMS message
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)sendNotification:(PPUserId)userId organizationId:(PPOrganizationId)organizationId brand:(NSString * _Nullable )brand emailMessage:(PPNotificationEmailMessage * _Nullable )emailMessage pushMessage:(PPNotificationPushMessage * _Nullable )pushMessage smsMessage:(PPNotificationSMSMessage * _Nullable )smsMessage callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get notifications.
 * Get a history of notificaitons.
 *
 * @param userId PPUserId Get notifications for this user by an administrator
 * @param startDate Required NSDate Start date to select notifications
 * @param endDate NSDate End date to select notifications. Default is the current date.
 * @param callback PPNotificationHistoryBlock Notifications historty callback block
 **/
+ (void)getNotifications:(PPUserId)userId startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate callback:(PPNotificationHistoryBlock _Nonnull )callback;

@end
