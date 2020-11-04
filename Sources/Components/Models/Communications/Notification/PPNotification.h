//
//  PPNotification.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/14/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationSubscription.h"

@interface PPNotification : PPBaseModel

@property (nonatomic, strong) NSDate *sendDate;
@property (nonatomic) NSInteger sendDateMS;
@property (nonatomic) PPNotificationDeliveryType deliveryType;
@property (nonatomic) PPNotificationSubscriptionType subscriptionType;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic) PPUserBadgeCount badge;
@property (nonatomic) PPNotificationSentCount sentCount;
@property (nonatomic) PPNotificationSourceType sourceType;
@property (nonatomic) PPNotificationSourceId sourceId;
@property (nonatomic, strong) NSString *messageText;

- (id)initWithSendDate:(NSDate *)sendDate sendDateMS:(NSInteger)sendDateMS deliveryType:(PPNotificationDeliveryType)deliveryType subscriptionType:(PPNotificationSubscriptionType)subscriptionType brand:(NSString *)brand templateName:(NSString *)templateName language:(NSString *)language sound:(NSString *)sound badge:(PPUserBadgeCount)badge sentCount:(PPNotificationSentCount)sentCount sourceType:(PPNotificationSourceType)sourceType sourceId:(PPNotificationSourceId)sourceId messageText:(NSString *)messageText;

+ (PPNotification *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotification *)message;

@end
