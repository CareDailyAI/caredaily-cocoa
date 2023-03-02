//
//  PPServicePlan.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPServicePlan.h"

#pragma mark - PPServicePlan

@implementation PPServicePlan

- (id)initWithId:(PPServicePlanId)planId
            name:(NSString *)name
            desc:(NSString *)desc
       available:(PPServicePlanAvailable)available
    upgradableTo:(NSArray *)upgradableTo
          prices:(NSArray *)prices
   subscriptions:(NSArray *)subscriptions
        services:(NSArray *)services {
    self = [super init];
    if(self) {
        self.planId = planId;
        self.name = name;
        self.desc = desc;
        self.available = available;
        self.upgradableTo = upgradableTo;
        self.prices = prices;
        self.subscriptions = subscriptions;
        self.services = services;
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
    
    NSMutableArray *services;
    if([planDict objectForKey:@"services"]) {
        services = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *serviceDict in [planDict objectForKey:@"services"]) {
            PPUserService *service = [PPUserService initWithDictionary:serviceDict];
            [services addObject:service];
        }
    }
    
    PPServicePlan *servicePlan = [[PPServicePlan alloc] initWithId:planId name:name desc:desc available:available upgradableTo:upgradableTo prices:prices subscriptions:subscriptions services:services];
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
    if(plan.services) {
        _services = plan.services;
    }
}

@end

#pragma mark - PPServicePlanSoftwareSubscription

@implementation PPServicePlanSoftwareSubscription

- (id)initWithId:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId
            type:(PPServicePlanSoftwareSubscriptionType)type
     paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType
         priceId:(PPServicePlanPriceId)priceId
          status:(PPServicePlanStatus)status
       issueDate:(NSDate *)issueDate
       startDate:(NSDate *)startDate
         endDate:(NSDate *)endDate
       gatewayId:(NSString *)gatewayId
         sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox
        duration:(PPServicePlanSoftwareSubscriptionDuration)duration
            free:(PPServicePlanSoftwareSubscriptionFree)free
         appName:(NSString *)appName
      locationId:(PPLocationId)locationId
          userId:(PPUserId)userId
  organizationId:(PPOrganizationId)organizationId
  subscriptionId:(NSString *)subscriptionId
   transactionId:(NSString *)transactionId
            plan:(PPServicePlan *)plan
      updatePlan:(PPServicePlan *)updatePlan
cardMaskedNumber:(NSString *)cardMaskedNumber
cardExpirationDate:(NSString *)cardExpirationDate
        services:(NSArray *)services {
    self = [super init];
    if(self) {
        self.userPlanId = userPlanId;
        self.type = type;
        self.paymentType = paymentType;
        self.priceId = priceId;
        self.status = status;
        self.issueDate = issueDate;
        self.startDate = startDate;
        self.endDate = endDate;
        self.gatewayId = gatewayId;
        self.sandbox = sandbox;
        self.duration = duration;
        self.free = free;
        self.appName = appName;
        self.locationId = locationId;
        self.userId = userId;
        self.organizationId = organizationId;
        self.subscriptionId = subscriptionId;
        self.transactionId = transactionId;
        self.plan = plan;
        self.updatePlan = updatePlan;
        self.cardMaskedNumber = cardMaskedNumber;
        self.cardExpirationDate = cardExpirationDate;
        self.services = services;
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
    PPServicePlanPriceId priceId = PPServicePlanPriceIdNone;
    if([subscriptionDict objectForKey:@"priceId"]) {
        priceId = (PPServicePlanPriceId)((NSString *)[subscriptionDict objectForKey:@"priceId"]).integerValue;
    }
    PPServicePlanStatus status = PPServicePlanStatusNone;
    if([subscriptionDict objectForKey:@"status"]) {
        status = (PPServicePlanStatus)((NSString *)[subscriptionDict objectForKey:@"status"]).integerValue;
    }
    
    NSString *issueDateString = [subscriptionDict objectForKey:@"issueDate"];
    NSDate *issueDate = [NSDate date];
    if(issueDateString != nil) {
        if(![issueDateString isEqualToString:@""]) {
            issueDate = [PPNSDate parseDateTime:issueDateString];
        }
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
    NSString *appName = [subscriptionDict objectForKey:@"appName"];
    PPLocationId locationId = PPLocationIdNone;
    if([subscriptionDict objectForKey:@"locationId"]) {
        locationId = (PPLocationId)((NSString *)[subscriptionDict objectForKey:@"locationId"]).integerValue;
    }
    PPUserId userId = PPUserIdNone;
    if([subscriptionDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[subscriptionDict objectForKey:@"userId"]).integerValue;
    }
    PPOrganizationId organizationId = PPOrganizationIdNone;
    if([subscriptionDict objectForKey:@"organizationId"]) {
        organizationId = (PPOrganizationId)((NSString *)[subscriptionDict objectForKey:@"organizationId"]).integerValue;
    }
    NSString *subscriptionId = [subscriptionDict objectForKey:@"subscriptionId"];
    NSString *transactionId = [subscriptionDict objectForKey:@"transactionId"];
    
    PPServicePlan *plan = [PPServicePlan initWithDictionary:[subscriptionDict objectForKey:@"plan"]];
    PPServicePlan *updatePlan = [PPServicePlan initWithDictionary:[subscriptionDict objectForKey:@"updatePlan"]];
    
    NSString *cardMaskedNumber = [subscriptionDict objectForKey:@"cardMaskedNumber"];
    NSString *cardExpirationDate = [subscriptionDict objectForKey:@"cardExpirationDate"];
    
    NSMutableArray *services;
    if([subscriptionDict objectForKey:@"services"]) {
        services = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *serviceDict in [subscriptionDict objectForKey:@"services"]) {
            PPUserService *service = [PPUserService initWithDictionary:serviceDict];
            [services addObject:service];
        }
    }
    
    PPServicePlanSoftwareSubscription *softwareSubscription = [[PPServicePlanSoftwareSubscription alloc] initWithId:userPlanId
                                                                                                               type:type
                                                                                                        paymentType:paymentType
                                                                                                            priceId:priceId
                                                                                                             status:status
                                                                                                          issueDate:issueDate
                                                                                                          startDate:startDate
                                                                                                            endDate:endDate
                                                                                                          gatewayId:gatewayId
                                                                                                            sandbox:sandbox
                                                                                                           duration:duration
                                                                                                               free:free
                                                                                                            appName:appName
                                                                                                         locationId:locationId
                                                                                                             userId:userId
                                                                                                     organizationId:organizationId
                                                                                                     subscriptionId:subscriptionId
                                                                                                      transactionId:transactionId
                                                                                                               plan:plan
                                                                                                         updatePlan:updatePlan
                                                                                                   cardMaskedNumber:cardMaskedNumber
                                                                                                 cardExpirationDate:cardExpirationDate
                                                                                                           services:services];
    return softwareSubscription;
}

@end

#pragma mark - PPServicePlanPrice

@implementation PPServicePlanPrice

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

