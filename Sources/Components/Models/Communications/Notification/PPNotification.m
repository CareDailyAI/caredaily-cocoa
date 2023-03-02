//
//  PPNotification.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/14/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPNotification.h"

@implementation PPNotification

- (id)initWithSendDate:(NSDate *)sendDate sendDateMS:(NSInteger)sendDateMS deliveryType:(PPNotificationDeliveryType)deliveryType subscriptionType:(PPNotificationSubscriptionType)subscriptionType brand:(NSString *)brand templateName:(NSString *)templateName language:(NSString *)language sound:(NSString *)sound badge:(PPUserBadgeCount)badge sentCount:(PPNotificationSentCount)sentCount sourceType:(PPNotificationSourceType)sourceType sourceId:(PPNotificationSourceId)sourceId messageText:(NSString *)messageText {
    self = [super init];
    if(self) {
        _sendDate = sendDate;
        _sendDateMS = sendDateMS;
        _deliveryType = deliveryType;
        _subscriptionType = subscriptionType;
        _brand = brand;
        _templateName = templateName;
        _language = language;
        _sound = sound;
        _badge = badge;
        _sentCount = sentCount;
        _sourceType = sourceType;
        _sourceId = sourceId;
        _messageText = messageText;
    }
    return self;
}

+ (PPNotification *)initWithDictionary:(NSDictionary *)notificationDict {
    NSString *sendDateString = [notificationDict objectForKey:@"sendDate"];
    NSDate *sendDate = [NSDate date];
    if(sendDateString != nil) {
        if(![sendDateString isEqualToString:@""]) {
            sendDate = [PPNSDate parseDateTime:sendDateString];
        }
    }
    
    NSInteger sendDateMS = ((NSString *)[notificationDict objectForKey:@"sendDateMs"]).integerValue;
    
    PPNotificationDeliveryType deliveryType = PPNotificationDeliveryTypeNone;
    if([notificationDict objectForKey:@"deliveryType"]) {
        deliveryType = (PPNotificationDeliveryType)((NSString *)[notificationDict objectForKey:@"deliveryType"]).integerValue;
    }
    PPNotificationSubscriptionType subscriptionType = PPNotificationSubscriptionTypeNone;
    if([notificationDict objectForKey:@"notificationType"]) {
        subscriptionType = (PPNotificationSubscriptionType)((NSString *)[notificationDict objectForKey:@"notificationType"]).integerValue;
    }
    
    NSString *brand = [notificationDict objectForKey:@"brand"];
    NSString *templateName = [notificationDict objectForKey:@"templateName"];
    NSString *language = [notificationDict objectForKey:@"language"];
    NSString *sound = [notificationDict objectForKey:@"sound"];
    
    PPUserBadgeCount badge = PPUserBadgeCountNone;
    if([notificationDict objectForKey:@"badge"]) {
        badge = (PPUserBadgeCount)((NSString *)[notificationDict objectForKey:@"badge"]).integerValue;
    }
    PPNotificationSentCount sentCount = PPNotificationSentCountNone;
    if([notificationDict objectForKey:@"sentCount"]) {
        sentCount = (PPNotificationSentCount)((NSString *)[notificationDict objectForKey:@"sentCount"]).integerValue;
    }
    PPNotificationSourceType sourceType = PPNotificationSourceTypeNone;
    if([notificationDict objectForKey:@"sourceType"]) {
        sourceType = (PPNotificationSourceType)((NSString *)[notificationDict objectForKey:@"sourceType"]).integerValue;
    }
    PPNotificationSourceId sourceId = PPNotificationSourceIdNone;
    if([notificationDict valueForKey:@"sourceId"] && ![[notificationDict valueForKey:@"sourceId"] isKindOfClass:[NSNull class]]) {
        sourceId = (PPNotificationSourceId)((NSString *)[notificationDict objectForKey:@"sourceId"]).integerValue;
    }
    
    NSString *messageText = [notificationDict objectForKey:@"messageText"];
    
    PPNotification *notification = [[PPNotification alloc] initWithSendDate:sendDate sendDateMS:sendDateMS deliveryType:deliveryType subscriptionType:subscriptionType brand:brand templateName:templateName language:language sound:sound badge:badge sentCount:sentCount sourceType:sourceType sourceId:sourceId messageText:messageText];
    return notification;
}

+ (NSString *)stringify:(PPNotification *)message {
    return @"{}";
}
@end
