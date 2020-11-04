//
//  PPNotificationSubscription.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPNotificationSubscription : PPBaseModel

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
