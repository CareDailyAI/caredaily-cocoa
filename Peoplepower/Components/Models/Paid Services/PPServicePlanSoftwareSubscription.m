//
//  PPServicePlanSoftwareSubscription.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPServicePlanSoftwareSubscription.h"

//@implementation PPServicePlanSoftwareSubscription
//
//- (id)initWithId:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType startDate:(NSDate *)startDate endDate:(NSDate *)endDate gatewayId:(NSString *)gatewayId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox duration:(PPServicePlanSoftwareSubscriptionDuration)duration free:(PPServicePlanSoftwareSubscriptionFree)free organizationId:(PPOrganizationId)organizationId subscriptionId:(NSString *)subscriptionId transactionId:(NSString *)transactionId {//} plan:(PPServicePlan *)plan {
//    self = [super init];
//    if(self) {
//        self.userPlanId = userPlanId;
//        self.type = type;
//        self.paymentType = paymentType;
//        self.startDate = startDate;
//        self.endDate = endDate;
//        self.gatewayId = gatewayId;
//        self.sandbox = sandbox;
//        self.duration = duration;
//        self.free = free;
//        self.organizationId = organizationId;
//        self.subscriptionId = subscriptionId;
//        self.transactionId = transactionId;
////        self.plan = plan;
//    }
//    return self;
//}
//
//+ (PPServicePlanSoftwareSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict {
//    PPServicePlanSoftwareSubscriptionUserPlanId userPlanId = PPServicePlanSoftwareSubscriptionUserPlanIdNone;
//    if([subscriptionDict objectForKey:@"id"]) {
//        userPlanId = (PPServicePlanSoftwareSubscriptionUserPlanId)((NSString *)[subscriptionDict objectForKey:@"id"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionType type = PPServicePlanSoftwareSubscriptionTypeNone;
//    if([subscriptionDict objectForKey:@"type"]) {
//        type = (PPServicePlanSoftwareSubscriptionType)((NSString *)[subscriptionDict objectForKey:@"type"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionPaymentType paymentType = PPServicePlanSoftwareSubscriptionPaymentTypeNone;
//    if([subscriptionDict objectForKey:@"paymentType"]) {
//        paymentType = (PPServicePlanSoftwareSubscriptionPaymentType)((NSString *)[subscriptionDict objectForKey:@"paymentType"]).integerValue;
//    }
//    
//    NSString *startDateString = [subscriptionDict objectForKey:@"startDate"];
//    NSDate *startDate = [NSDate date];
//    if(startDateString != nil) {
//        if(![startDateString isEqualToString:@""]) {
//            startDate = [PPNSDate parseDateTime:startDateString];
//        }
//    }
//
//    NSString *endDateString = [subscriptionDict objectForKey:@"endDate"];
//    NSDate *endDate = [NSDate date];
//    if(endDateString != nil) {
//        if(![endDateString isEqualToString:@""]) {
//            endDate = [PPNSDate parseDateTime:endDateString];
//        }
//    }
//
//    NSString *gatewayId = [subscriptionDict objectForKey:@"gatewayId"];
//    PPServicePlanSoftwareSubscriptionSandbox sandbox = PPServicePlanSoftwareSubscriptionSandboxNone;
//    if([subscriptionDict objectForKey:@"sandbox"]) {
//        sandbox = (PPServicePlanSoftwareSubscriptionSandbox)((NSString *)[subscriptionDict objectForKey:@"sandbox"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionDuration duration = PPServicePlanSoftwareSubscriptionDurationNone;
//    if([subscriptionDict objectForKey:@"duration"]) {
//        duration = (PPServicePlanSoftwareSubscriptionDuration)((NSString *)[subscriptionDict objectForKey:@"duration"]).integerValue;
//    }
//    PPServicePlanSoftwareSubscriptionFree free = PPServicePlanSoftwareSubscriptionFreeNone;
//    if([subscriptionDict objectForKey:@"free"]) {
//        free = (PPServicePlanSoftwareSubscriptionFree)((NSString *)[subscriptionDict objectForKey:@"free"]).integerValue;
//    }
//    PPOrganizationId organizationId = PPOrganizationIdNone;
//    if([subscriptionDict objectForKey:@"organizationId"]) {
//        organizationId = (PPOrganizationId)((NSString *)[subscriptionDict objectForKey:@"organizationId"]).integerValue;
//    }
//    NSString *subscriptionId = [subscriptionDict objectForKey:@"subscriptionId"];
//    NSString *transactionId = [subscriptionDict objectForKey:@"transactionId"];
//
////    PPServicePlan *plan = [PPServicePlan initWithDictionary:[subscriptionDict objectForKey:@"plan"]];
//
//    PPServicePlanSoftwareSubscription *softwareSubscription = [[PPServicePlanSoftwareSubscription alloc] initWithId:userPlanId type:type paymentType:paymentType startDate:startDate endDate:endDate gatewayId:gatewayId sandbox:sandbox duration:duration free:free organizationId:organizationId subscriptionId:subscriptionId transactionId:transactionId];// plan:plan];
//    return softwareSubscription;
//}
//
//@end

