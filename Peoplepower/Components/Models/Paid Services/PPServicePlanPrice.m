//
//  PPServicePlanPrice.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPServicePlanPrice.h"

//@implementation PPServicePlanPrice
//
//- (id)initWithId:(PPServicePlanPriceId)priceId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType free:(PPServicePlanSoftwareSubscriptionFree)free duration:(PPServicePlanSoftwareSubscriptionDuration)duration gatewayId:(NSString *)gatewayId appleStoreId:(NSString *)appleStoreId gatewaySandboxId:(NSString *)gatewaySandboxId amount:(PPServicePlanPriceAmount *)amount {
//    self = [super init];
//    if(self) {
//        self.priceId = priceId;
//        self.type = type;
//        self.paymentType = paymentType;
//        self.free = free;
//        self.duration = duration;
//        self.gatewayId = gatewayId;
//        self.appleStoreId = appleStoreId;
//        self.gatewaySandboxId = gatewaySandboxId;
//        self.amount = amount;
//    }
//    return self;
//}
//
//+ (PPServicePlanPrice *)initWithDictionary:(NSDictionary *)priceDict {
//    PPServicePlanPriceId priceId = PPServicePlanPriceIdNone;
//    if([priceDict objectForKey:@"id"]) {
//        priceId = (PPServicePlanPriceId)((NSString *)[priceDict objectForKey:@"id"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionType type = PPServicePlanSoftwareSubscriptionTypeNone;
//    if([priceDict objectForKey:@"type"]) {
//        type = (PPServicePlanSoftwareSubscriptionType)((NSString *)[priceDict objectForKey:@"type"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionPaymentType paymentType = PPServicePlanSoftwareSubscriptionPaymentTypeNone;
//    if([priceDict objectForKey:@"paymentType"]) {
//        paymentType = (PPServicePlanSoftwareSubscriptionPaymentType)((NSString *)[priceDict objectForKey:@"paymentType"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionFree free = PPServicePlanSoftwareSubscriptionFreeNone;
//    if([priceDict objectForKey:@"free"]) {
//        free = (PPServicePlanSoftwareSubscriptionFree)((NSString *)[priceDict objectForKey:@"free"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionDuration duration = PPServicePlanSoftwareSubscriptionDurationNone;
//    if([priceDict objectForKey:@"duration"]) {
//        duration = (PPServicePlanSoftwareSubscriptionDuration)((NSString *)[priceDict objectForKey:@"duration"]).integerValue;
//    }
//    NSString *gatewayId = [priceDict objectForKey:@"gatewayId"];
//    NSString *appleStoreId = [priceDict objectForKey:@"appleStoreId"];
//    NSString *gatewaySandboxId = [priceDict objectForKey:@"gatewaySandboxId"];
//    PPServicePlanPriceAmount *amount = [PPServicePlanPriceAmount initWithDictionary:[priceDict objectForKey:@"amount"]];
//    
//    PPServicePlanPrice *planPrice = [[PPServicePlanPrice alloc] initWithId:priceId type:type paymentType:paymentType free:free duration:duration gatewayId:gatewayId appleStoreId:appleStoreId gatewaySandboxId:gatewaySandboxId amount:amount];
//    return planPrice;
//}
//
//@end

