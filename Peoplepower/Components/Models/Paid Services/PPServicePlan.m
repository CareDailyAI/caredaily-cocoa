//
//  PPServicePlan.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPServicePlan.h"

#pragma mark - PPServicePlan

@implementation PPServicePlan

+ (NSString *)primaryKey {
    return @"planId";
}

- (id)initWithId:(PPServicePlanId)planId name:(NSString *)name desc:(NSString *)desc available:(PPServicePlanAvailable)available upgradableTo:(RLMArray *)upgradableTo prices:(RLMArray *)prices subscriptions:(RLMArray *)subscriptions {
    self = [super init];
    if(self) {
        self.planId = planId;
        self.name = name;
        self.desc = desc;
        self.available = available;
        self.upgradableTo = (RLMArray<RLMInt> *)upgradableTo;
        self.prices = (RLMArray<PPServicePlanPrice *><PPServicePlanPrice> *)prices;
        self.subscriptions =(RLMArray<PPServicePlanSoftwareSubscription *><PPServicePlanSoftwareSubscription> *) subscriptions;
    }
    return self;
}

+ (PPServicePlan *)initWithDictionary:(NSDictionary *)planDict {
    PPServicePlanId planId = PPServicePlanIdNone;
    if([planDict objectForKey:@"id"]) {
        planId = (PPServicePlanId)((NSString *)[planDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [planDict objectForKey:@"name"];
    NSString *desc = [planDict objectForKey:@"desc"];
    PPServicePlanAvailable available = PPServicePlanAvailableNone;
    if([planDict objectForKey:@"available"]) {
        available = (PPServicePlanAvailable)((NSString *)[planDict objectForKey:@"available"]).integerValue;
    }
    NSArray *upgradableTo = [planDict objectForKey:@"upgradableTo"];
    
    NSMutableArray *prices;
    if([planDict objectForKey:@"prices"]) {
        prices = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *priceDict in [planDict objectForKey:@"prices"]) {
            PPServicePlanPrice *price = [PPServicePlanPrice initWithDictionary:priceDict];
            [prices addObject:price];
        }
    }
    
    NSMutableArray *subscriptions;
    if([planDict objectForKey:@"subscriptions"]) {
        subscriptions = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *subscriptionDict in [planDict objectForKey:@"subscriptions"]) {
            PPServicePlanSoftwareSubscription *subscription = [PPServicePlanSoftwareSubscription initWithDictionary:subscriptionDict];
            [subscriptions addObject:subscription];
        }
    }
    
    PPServicePlan *servicePlan = [[PPServicePlan alloc] initWithId:planId name:name desc:desc available:available upgradableTo:(RLMArray<RLMInt> *)upgradableTo prices:(RLMArray<PPServicePlanPrice *><PPServicePlanPrice> *)prices subscriptions:(RLMArray<PPServicePlanSoftwareSubscription *><PPServicePlanSoftwareSubscription> *)subscriptions];
    return servicePlan;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToPlan:(PPServicePlan *)plan {
    BOOL equal = NO;
    
    if(plan.planId != PPServicePlanIdNone && _planId != PPServicePlanIdNone) {
        if(plan.planId == _planId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPServicePlan *)plan {
    if(plan.planId != PPServicePlanIdNone) {
        _planId = plan.planId;
    }
    if(plan.name) {
        _name = plan.name;
    }
    if(plan.desc) {
        _desc = plan.desc;
    }
    if(plan.available != PPServicePlanAvailableNone) {
        _available = plan.available;
    }
    if(plan.upgradableTo) {
        _upgradableTo = plan.upgradableTo;
    }
    if(plan.prices) {
        _prices = plan.prices;
    }
    if(plan.subscriptions) {
        _subscriptions = plan.subscriptions;
    }
}

@end

#pragma mark - PPServicePlanSoftwareSubscription

@implementation PPServicePlanSoftwareSubscription

+ (NSString *)primaryKey {
    return @"userPlanId";
}

- (PPServicePlanTransaction *)transaction {
    return [PPServicePlanTransaction objectForPrimaryKey:_transactionId];
}

- (id)initWithId:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType startDate:(NSDate *)startDate endDate:(NSDate *)endDate gatewayId:(NSString *)gatewayId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox duration:(PPServicePlanSoftwareSubscriptionDuration)duration free:(PPServicePlanSoftwareSubscriptionFree)free organizationId:(PPOrganizationId)organizationId subscriptionId:(NSString *)subscriptionId transactionId:(NSString *)transactionId plan:(PPServicePlan *)plan {
    self = [super init];
    if(self) {
        self.userPlanId = userPlanId;
        self.type = type;
        self.paymentType = paymentType;
        self.startDate = startDate;
        self.endDate = endDate;
        self.gatewayId = gatewayId;
        self.sandbox = sandbox;
        self.duration = duration;
        self.free = free;
        self.organizationId = organizationId;
        self.subscriptionId = subscriptionId;
        self.transactionId = transactionId;
        self.plan = plan;
    }
    return self;
}

+ (PPServicePlanSoftwareSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict {
    PPServicePlanSoftwareSubscriptionUserPlanId userPlanId = PPServicePlanSoftwareSubscriptionUserPlanIdNone;
    if([subscriptionDict objectForKey:@"id"]) {
        userPlanId = (PPServicePlanSoftwareSubscriptionUserPlanId)((NSString *)[subscriptionDict objectForKey:@"id"]).integerValue;
    }
    if([subscriptionDict objectForKey:@"userPlanId"]) {
        userPlanId = (PPServicePlanSoftwareSubscriptionUserPlanId)((NSString *)[subscriptionDict objectForKey:@"userPlanId"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionType type = PPServicePlanSoftwareSubscriptionTypeNone;
    if([subscriptionDict objectForKey:@"type"]) {
        type = (PPServicePlanSoftwareSubscriptionType)((NSString *)[subscriptionDict objectForKey:@"type"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionPaymentType paymentType = PPServicePlanSoftwareSubscriptionPaymentTypeNone;
    if([subscriptionDict objectForKey:@"paymentType"]) {
        paymentType = (PPServicePlanSoftwareSubscriptionPaymentType)((NSString *)[subscriptionDict objectForKey:@"paymentType"]).integerValue;
    }
    
    NSString *startDateString = [subscriptionDict objectForKey:@"startDate"];
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSString *endDateString = [subscriptionDict objectForKey:@"endDate"];
    NSDate *endDate = [NSDate date];
    if(endDateString != nil) {
        if(![endDateString isEqualToString:@""]) {
            endDate = [PPNSDate parseDateTime:endDateString];
        }
    }
    
    NSString *gatewayId = [subscriptionDict objectForKey:@"gatewayId"];
    PPServicePlanSoftwareSubscriptionSandbox sandbox = PPServicePlanSoftwareSubscriptionSandboxNone;
    if([subscriptionDict objectForKey:@"sandbox"]) {
        sandbox = (PPServicePlanSoftwareSubscriptionSandbox)((NSString *)[subscriptionDict objectForKey:@"sandbox"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionDuration duration = PPServicePlanSoftwareSubscriptionDurationNone;
    if([subscriptionDict objectForKey:@"duration"]) {
        duration = (PPServicePlanSoftwareSubscriptionDuration)((NSString *)[subscriptionDict objectForKey:@"duration"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionFree free = PPServicePlanSoftwareSubscriptionFreeNone;
    if([subscriptionDict objectForKey:@"free"]) {
        free = (PPServicePlanSoftwareSubscriptionFree)((NSString *)[subscriptionDict objectForKey:@"free"]).integerValue;
    }
    PPOrganizationId organizationId = PPOrganizationIdNone;
    if([subscriptionDict objectForKey:@"organizationId"]) {
        organizationId = (PPOrganizationId)((NSString *)[subscriptionDict objectForKey:@"organizationId"]).integerValue;
    }
    NSString *subscriptionId = [subscriptionDict objectForKey:@"subscriptionId"];
    NSString *transactionId = [subscriptionDict objectForKey:@"transactionId"];
    
    PPServicePlan *plan = [PPServicePlan initWithDictionary:[subscriptionDict objectForKey:@"plan"]];
    
    PPServicePlanSoftwareSubscription *softwareSubscription = [[PPServicePlanSoftwareSubscription alloc] initWithId:userPlanId type:type paymentType:paymentType startDate:startDate endDate:endDate gatewayId:gatewayId sandbox:sandbox duration:duration free:free organizationId:organizationId subscriptionId:subscriptionId transactionId:transactionId plan:plan];
    return softwareSubscription;
}

@end

#pragma mark - PPServicePlanPrice

@implementation PPServicePlanPrice

+ (NSString *)primaryKey {
    return @"priceId";
}

- (id)initWithId:(PPServicePlanPriceId)priceId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType free:(PPServicePlanSoftwareSubscriptionFree)free duration:(PPServicePlanSoftwareSubscriptionDuration)duration gatewayId:(NSString *)gatewayId appleStoreId:(NSString *)appleStoreId gatewaySandboxId:(NSString *)gatewaySandboxId amount:(PPServicePlanPriceAmount *)amount {
    self = [super init];
    if(self) {
        self.priceId = priceId;
        self.type = type;
        self.paymentType = paymentType;
        self.free = free;
        self.duration = duration;
        self.gatewayId = gatewayId;
        self.appleStoreId = appleStoreId;
        self.gatewaySandboxId = gatewaySandboxId;
        self.amount = amount;
    }
    return self;
}

+ (PPServicePlanPrice *)initWithDictionary:(NSDictionary *)priceDict {
    PPServicePlanPriceId priceId = PPServicePlanPriceIdNone;
    if([priceDict objectForKey:@"id"]) {
        priceId = (PPServicePlanPriceId)((NSString *)[priceDict objectForKey:@"id"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionType type = PPServicePlanSoftwareSubscriptionTypeNone;
    if([priceDict objectForKey:@"type"]) {
        type = (PPServicePlanSoftwareSubscriptionType)((NSString *)[priceDict objectForKey:@"type"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionPaymentType paymentType = PPServicePlanSoftwareSubscriptionPaymentTypeNone;
    if([priceDict objectForKey:@"paymentType"]) {
        paymentType = (PPServicePlanSoftwareSubscriptionPaymentType)((NSString *)[priceDict objectForKey:@"paymentType"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionFree free = PPServicePlanSoftwareSubscriptionFreeNone;
    if([priceDict objectForKey:@"free"]) {
        free = (PPServicePlanSoftwareSubscriptionFree)((NSString *)[priceDict objectForKey:@"free"]).integerValue;
    }
    PPServicePlanSoftwareSubscriptionDuration duration = PPServicePlanSoftwareSubscriptionDurationNone;
    if([priceDict objectForKey:@"duration"]) {
        duration = (PPServicePlanSoftwareSubscriptionDuration)((NSString *)[priceDict objectForKey:@"duration"]).integerValue;
    }
    NSString *gatewayId = [priceDict objectForKey:@"gatewayId"];
    NSString *appleStoreId = [priceDict objectForKey:@"appleStoreId"];
    NSString *gatewaySandboxId = [priceDict objectForKey:@"gatewaySandboxId"];
    PPServicePlanPriceAmount *amount = [PPServicePlanPriceAmount initWithDictionary:[priceDict objectForKey:@"amount"]];
    
    PPServicePlanPrice *planPrice = [[PPServicePlanPrice alloc] initWithId:priceId type:type paymentType:paymentType free:free duration:duration gatewayId:gatewayId appleStoreId:appleStoreId gatewaySandboxId:gatewaySandboxId amount:amount];
    return planPrice;
}

@end

