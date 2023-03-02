//
//  PPNotificationSubscription.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPNotificationSubscription.h"

@implementation PPNotificationSubscription

+ (NSString *)primaryKey {
    return @"type";
}

- (id)initWithType:(PPNotificationSubscriptionType)type name:(NSString *)name email:(PPNotificationSubscriptionEmailEnabled)email push:(PPNotificationSubscriptionPushEnabled)push sms:(PPNotificationSubscriptionSMSEnabled)sms emailPeriod:(PPNotificationSubscriptionEmailPeriod)emailPeriod pushPeriod:(PPNotificationSubscriptionPushPeriod)pushPeriod smsPeriod:(PPNotificationSubscriptionSMSPeriod)smsPeriod {
    self = [super init];
    if(self) {
        self.type = type;
        self.name = name;
        self.email = email;
        self.push = push;
        self.sms = sms;
        self.emailPeriod = emailPeriod;
        self.pushPeriod = pushPeriod;
        self.smsPeriod = smsPeriod;
    }
    return self;
}

+ (PPNotificationSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict {
    PPNotificationSubscriptionType type = PPNotificationSubscriptionTypeNone;
    if([subscriptionDict objectForKey:@"type"]) {
        type = (PPNotificationSubscriptionType)((NSString *)[subscriptionDict objectForKey:@"type"]).integerValue;
    }
    NSString *name = [subscriptionDict objectForKey:@"name"];
    PPNotificationSubscriptionEmailEnabled email = PPNotificationSubscriptionEmailEnabledNone;
    if([subscriptionDict objectForKey:@"email"]) {
        email = (PPNotificationSubscriptionEmailEnabled)((NSString *)[subscriptionDict objectForKey:@"email"]).integerValue;
    }
    PPNotificationSubscriptionPushEnabled push = PPNotificationSubscriptionPushEnabledNone;
    if([subscriptionDict objectForKey:@"push"]) {
        push = (PPNotificationSubscriptionPushEnabled)((NSString *)[subscriptionDict objectForKey:@"push"]).integerValue;
    }
    PPNotificationSubscriptionSMSEnabled sms = PPNotificationSubscriptionSMSEnabledNone;
    if([subscriptionDict objectForKey:@"sms"]) {
        sms = (PPNotificationSubscriptionSMSEnabled)((NSString *)[subscriptionDict objectForKey:@"sms"]).integerValue;
    }
    PPNotificationSubscriptionEmailPeriod emailPeriod = PPNotificationSubscriptionEmailPeriodNone;
    if([subscriptionDict objectForKey:@"emailPeriod"]) {
        emailPeriod = (PPNotificationSubscriptionEmailPeriod)((NSString *)[subscriptionDict objectForKey:@"emailPeriod"]).integerValue;
    }
    PPNotificationSubscriptionPushPeriod pushPeriod = PPNotificationSubscriptionPushPeriodNone;
    if([subscriptionDict objectForKey:@"pushPeriod"]) {
        pushPeriod = (PPNotificationSubscriptionPushPeriod)((NSString *)[subscriptionDict objectForKey:@"pushPeriod"]).integerValue;
    }
    PPNotificationSubscriptionSMSPeriod smsPeriod = PPNotificationSubscriptionSMSPeriodNone;
    if([subscriptionDict objectForKey:@"smsPeriod"]) {
        smsPeriod = (PPNotificationSubscriptionSMSPeriod)((NSString *)[subscriptionDict objectForKey:@"smsPeriod"]).integerValue;
    }
    
    PPNotificationSubscription *subscription = [[PPNotificationSubscription alloc] initWithType:type name:name email:email push:push sms:sms emailPeriod:emailPeriod pushPeriod:pushPeriod smsPeriod:smsPeriod];
    
    return subscription;
}

#pragma mark - Helper methods

- (BOOL)isEqualToSubscription:(PPNotificationSubscription *)subscription {
    BOOL equal = NO;
    
    if(self.name && subscription.name) {
        if([self.name isEqualToString:subscription.name]) {
            equal = YES;
        }
    }
    if(self.type != PPNotificationSubscriptionTypeNone && subscription.type != PPNotificationSubscriptionTypeNone) {
        if(self.type == subscription.type) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPNotificationSubscription *)subscription {
    if(subscription.name) {
        _name = subscription.name;
    }
    if(subscription.email != PPNotificationSubscriptionEmailEnabledNone) {
        _email = subscription.email;
    }
    if(subscription.emailPeriod != PPNotificationSubscriptionEmailPeriodNone) {
        _emailPeriod = subscription.emailPeriod;
    }
    if(subscription.push != PPNotificationSubscriptionPushEnabledNone) {
        _push = subscription.push;
    }
    if(subscription.pushPeriod != PPNotificationSubscriptionPushPeriodNone) {
        _pushPeriod = subscription.pushPeriod;
    }
    if(subscription.sms != PPNotificationSubscriptionSMSEnabledNone) {
        _sms = subscription.sms;
    }
    if(subscription.smsPeriod != PPNotificationSubscriptionSMSPeriodNone) {
        _smsPeriod = subscription.smsPeriod;
    }
    if(subscription.type != PPNotificationSubscriptionTypeNone) {
        _type = subscription.type;
    }
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.email = (PPNotificationSubscriptionEmailEnabled)((NSNumber *)[decoder decodeObjectForKey:@"email"]).integerValue;
        self.emailPeriod = (PPNotificationSubscriptionEmailPeriod)((NSNumber *)[decoder decodeObjectForKey:@"emailPeriod"]).integerValue;
        self.push = (PPNotificationSubscriptionPushEnabled)((NSNumber *)[decoder decodeObjectForKey:@"push"]).integerValue;
        self.pushPeriod = (PPNotificationSubscriptionPushPeriod)((NSNumber *)[decoder decodeObjectForKey:@"pushPeriod"]).integerValue;
        self.sms = (PPNotificationSubscriptionSMSEnabled)((NSNumber *)[decoder decodeObjectForKey:@"sms"]).integerValue;
        self.smsPeriod = (PPNotificationSubscriptionSMSPeriod)((NSNumber *)[decoder decodeObjectForKey:@"smsPeriod"]).integerValue;
        self.type = (PPNotificationSubscriptionType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_email) forKey:@"email"];
    [encoder encodeObject:@(_emailPeriod) forKey:@"emailPeriod"];
    [encoder encodeObject:@(_push) forKey:@"push"];
    [encoder encodeObject:@(_pushPeriod) forKey:@"pushPeriod"];
    [encoder encodeObject:@(_sms) forKey:@"sms"];
    [encoder encodeObject:@(_smsPeriod) forKey:@"smsPeriod"];
    [encoder encodeObject:@(_type) forKey:@"type"];
}

@end
