//
//  PPNotifications.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotifications.h"
#import "PPCloudEngine.h"
#import "PPUserAccounts.h"

@implementation PPNotifications

#pragma mark - Session Management

#pragma mark Notification Subscriptions

/**
 * Shared subscriptions across the entire application
 */
+ (NSArray *)sharedSubscriptionsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPNotificationSubscription *> *sharedSubscriptions = [PPNotificationSubscription allObjects];
    
    NSMutableArray *sharedSubscriptionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *subscriptionsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPNotificationSubscription *subscription in sharedSubscriptions) {
        [sharedSubscriptionsArray addObject:subscription];
        NSMutableDictionary *subscriptionIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [subscriptionIdentifiers setValue:@(subscription.type) forKey:@"type"];
        if(subscription.name) {
            [subscriptionIdentifiers setValue:subscription.name forKey:@"name"];
        }
        [subscriptionsArrayDebug addObject:subscriptionIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedSubscriptions=%@", __PRETTY_FUNCTION__, subscriptionsArrayDebug);
#endif
#endif
    return sharedSubscriptionsArray;
}

/**
 * Add subscriptions.
 * Add subscriptions from local reference.
 *
 * @param subscriptions NSArray Array of subscriptions to remove.
 **/
+ (void)addSubscriptions:(NSArray *)subscriptions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s subscriptions=%@", __PRETTY_FUNCTION__, subscriptions);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPNotificationSubscription *subscription in subscriptions) {
        [PPNotificationSubscription createOrUpdateInDefaultRealmWithValue:subscription];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove subscriptions.
 * Remove subscriptions from local reference.
 *
 * @param subscriptions NSArray Array of subscriptions to remove.
 **/
+ (void)removeSubscriptions:(NSArray *)subscriptions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s subscriptions=%@", __PRETTY_FUNCTION__, subscriptions);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPNotificationSubscription *subscription in subscriptions) {
            [[PPRealm defaultRealm] deleteObject:[PPNotificationSubscription objectForPrimaryKey:@(subscription.type)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Notification Tokens

__strong static NSMutableDictionary*_sharedTokens = nil;

/**
 * Shared subscriptions across the entire application
 */
+ (PPNotificationToken *)sharedTokenForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPNotificationToken *> *sharedTokens = [PPNotificationToken allObjects];
    
    PPNotificationToken *sharedToken = [sharedTokens firstObject];
    NSMutableArray *tokensArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPNotificationToken *token in sharedTokens) {
        [tokensArrayDebug addObject:@{@"token": token.token}];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedTokens=%@", __PRETTY_FUNCTION__, tokensArrayDebug);
#endif
#endif
    return sharedToken;
}

/**
 * Add APNs token.
 * Add APNs to non-volatile reference.
 *
 * @param notificationToken PPNotificationToken Notification token
 **/
+ (void)addNotificationToken:(PPNotificationToken *)notificationToken userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s notificationToken=%@", __PRETTY_FUNCTION__, notificationToken);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    [PPNotificationToken createOrUpdateInDefaultRealmWithValue:notificationToken];
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s token=%@", __PRETTY_FUNCTION__, notificationToken.token);
#endif
#endif
}

/**
 * Remove APNs token.
 * Remove APNs to non-volatile reference.
 *
 * @param notificationToken PPNotificationToken Notification token
 **/
+ (void)removeNotificaitonToken:(PPNotificationToken *)notificationToken userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s notificationToken=%@", __PRETTY_FUNCTION__, notificationToken);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        [[PPRealm defaultRealm] deleteObject:[PPNotificationToken objectForPrimaryKey:notificationToken.token]];
    }];
    
    NSLog(@"< %s", __PRETTY_FUNCTION__);
}

#pragma mark Notifications

/**
 * Shared notifications across the entire application
 *
 * @param userId Required PPUserId User Id to associate these notification with
 */
+ (NSArray *)sharedNotificationsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPNotification *> *sharedNotifications = [PPNotification allObjects];
    
    NSMutableArray *sharedNotificationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *notificationsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPNotification *notification in sharedNotifications) {
        [sharedNotificationsArray addObject:notification];
        NSMutableDictionary *notificationIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [notificationIdentifiers setValue:notification.sendDate forKey:@"sendDate"];
        if(notification.messageText) {
            [notificationIdentifiers setValue:notification.messageText forKey:@"messageText"];
        }
        [notificationsArrayDebug addObject:notificationIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedNotifications=%@", __PRETTY_FUNCTION__, notificationsArrayDebug);
#endif
#endif
    return sharedNotificationsArray;
}

/**
 * Add notifications.
 * Add notifications to non-volatile reference.
 *
 * @param notifications NSArray Notifications to add
 **/
+ (void)addNotifications:(NSArray *)notifications userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s notifications=%@", __PRETTY_FUNCTION__, notifications);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPNotification *notification in notifications) {
        [PPNotification createOrUpdateInDefaultRealmWithValue:notification];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove notifications.
 * Remove notifications to non-volatile reference.
 *
 * @param notifications NSArray Notifications
 * @param userId Required PPUserId User Id to associate these notification with
 **/
+ (void)removeNotificaitons:(NSArray *)notifications userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s notifications=%@", __PRETTY_FUNCTION__, notifications);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPNotification *notification in notifications) {
            [[PPRealm defaultRealm] deleteObject:[PPNotification objectForPrimaryKey:@(notification.sendDateMS)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Get notification subcriptions

/**
 * Get notification subscriptions.
 * A user may subscribe or unsubscribe from certain types of push and email notifications, or set boundaries on how many notifications their account can receive within a specified amount of time.
 *
 * @param callback PPNotificationSubscriptionsBlock Subscriptions callback block with an array of existing subscriptions
 **/
+ (void)getNotificationSubscriptions:(PPNotificationSubscriptionsBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithString:@"notificationSubscriptions"];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.getNotificationSubscription()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            NSMutableArray *subscriptions;
            
            if(!error) {
                subscriptions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *subscriptionDict in [root objectForKey:@"subscriptions"]) {
                    PPNotificationSubscription *subscription = [PPNotificationSubscription initWithDictionary:subscriptionDict];
                    [subscriptions addObject:subscription];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(subscriptions, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain,
                                                                                                                                (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)setNotificationSubscription:(PPNotificationSubscriptionType)type email:(PPNotificationSubscriptionEmailEnabled)email push:(PPNotificationSubscriptionPushEnabled)push sms:(PPNotificationSubscriptionSMSEnabled)sms emailPeriod:(PPNotificationSubscriptionEmailPeriod)emailPeriod pushPeriod:(PPNotificationSubscriptionPushPeriod)pushPeriod smsPeriod:(PPNotificationSubscriptionSMSPeriod)smsPeriod callback:(PPErrorBlock)callback {
    NSAssert1(type != PPNotificationSubscriptionTypeNone, @"%s missing type", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"notificationSubscriptions/%@", @(type)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(email != PPNotificationSubscriptionEmailEnabledNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"email" value:@(email).stringValue]];
    }
    if(push != PPNotificationSubscriptionPushEnabledNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"push" value:@(push).stringValue]];
    }
    if(sms != PPNotificationSubscriptionSMSEnabledNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"sms" value:@(sms).stringValue]];
    }
    if(emailPeriod != PPNotificationSubscriptionEmailPeriodNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"emailPeriod" value:@(emailPeriod).stringValue]];
    }
    if(pushPeriod != PPNotificationSubscriptionPushPeriodNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"pushPeriod" value:@(pushPeriod).stringValue]];
    }
    if(smsPeriod != PPNotificationSubscriptionSMSPeriodNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"smsPeriod" value:@(smsPeriod).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.setNotificationSubscription()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Register an app for push notifications

/**
 * Register an app for push notifications
 *
 * @param appName Required NSString Unique App Name to register for push notifications
 * @param notificationToken Required NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @param badge PPNotificationSubscriptionSupportsBadgeIcons Supports badge icons. Default is False.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)registerAnAppForPushNotifications:(NSString *)appName notificationToken:(NSString *)notificationToken badge:(PPNotificationSubscriptionSupportsBadgeIcons)badge callback:(PPErrorBlock)callback {
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    NSAssert1(notificationToken != nil, @"%s missing notificationToken", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"notificationToken/%@/%@", appName, notificationToken]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(badge != PPNotificationSubscriptionSupportsBadgeIconsNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"badge" value:(badge) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.registerAnAppForPushNotifications()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Unregister an app for push notifications

/**
 * Unregister an app for push notifications
 *
 * @param notificationToken Required NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)unregisterAnAppForPushNotifications:(NSString *)notificationToken callback:(PPErrorBlock)callback {
    NSAssert1(notificationToken != nil, @"%s missing notificationToken", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"notificationToken/%@", notificationToken]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.unregisterAnAppForPushNotifications()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)sendNotification:(PPUserId)userId organizationId:(PPOrganizationId)organizationId brand:(NSString *)brand emailMessage:(PPNotificationEmailMessage *)emailMessage pushMessage:(PPNotificationPushMessage *)pushMessage smsMessage:(PPNotificationSMSMessage *)smsMessage callback:(PPErrorBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"notifications"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(organizationId != PPOrganizationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"organizationId" value:@(organizationId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    data[@"brand"] = brand;
    if(pushMessage) {
        data[@"pushMessage"] = [PPNotificationPushMessage data:pushMessage];
    }
    if(emailMessage) {
        data[@"emailMessage"] = [PPNotificationEmailMessage data:emailMessage];
    }
    if(smsMessage) {
        data[@"smsMessage"] = [PPNotificationSMSMessage data:smsMessage];
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.sendNotification()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Get notifications.
 * Get a history of notificaitons.
 *
 * @param userId PPUserId Get notifications for this user by an administrator
 * @param startDate Required NSDate Start date t oselect notifications
 * @param endDate NSDate End date to select notifications. Default is the current date.
 * @param callback PPNotificationHistoryBlock Notifications historty callback block
 **/
+ (void)getNotifications:(PPUserId)userId startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPNotificationHistoryBlock)callback {
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"notifications"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.notifications.getNotifications()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *notifications;
            
            if(!error) {
                notifications = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *notificationDict in [root objectForKey:@"notifications"]) {
                    PPNotification *notification = [PPNotification initWithDictionary:notificationDict];
                    [notifications addObject:notification];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(notifications, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

@end
