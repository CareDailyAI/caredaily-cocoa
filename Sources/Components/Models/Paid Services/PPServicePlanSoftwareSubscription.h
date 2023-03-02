//
//  PPServicePlanSoftwareSubscription.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

//#import "PPOrganization.h"
//#import "PPServicePlanPriceAmount.h"
//#import "PPUserService.h"
////#import "PPServicePlan.h"
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionUserPlanId) {
//    PPServicePlanSoftwareSubscriptionUserPlanIdNone = -1
//};
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionType) {
//    PPServicePlanSoftwareSubscriptionTypeNone = -1,
//    PPServicePlanSoftwareSubscriptionTypeOneTimePurchase = 1,
//    PPServicePlanSoftwareSubscriptionTypeWeeklySubscription = 2,
//    PPServicePlanSoftwareSubscriptionTypeMonthlySubscription = 3,
//    PPServicePlanSoftwareSubscriptionTypeAnnualSubscription = 4,
//};
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionPaymentType) {
//    PPServicePlanSoftwareSubscriptionPaymentTypeNone = 1,
//    PPServicePlanSoftwareSubscriptionPaymentTypeManual = 0,
//    PPServicePlanSoftwareSubscriptionPaymentTypeAppleInAppPurchase = 1,
//    PPServicePlanSoftwareSubscriptionPaymentTypePaypal = 2,
//    PPServicePlanSoftwareSubscriptionPaymentTypeBraintree = 3,
//};
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionFree) {
//    PPServicePlanSoftwareSubscriptionFreeNone = -1,
//    PPServicePlanSoftwareSubscriptionFreeFalse = 0,
//    PPServicePlanSoftwareSubscriptionFreeTrue = 1
//};
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionDuration) {
//    PPServicePlanSoftwareSubscriptionDurationNone = -1,
//};
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionSandbox) {
//    PPServicePlanSoftwareSubscriptionSandboxNone = -1,
//    PPServicePlanSoftwareSubscriptionSandboxFalse = 0,
//    PPServicePlanSoftwareSubscriptionSandboxTrue = 1
//};
//
//@interface PPServicePlanSoftwareSubscription : PPBaseModel
//
///* Subscription record ID */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionUserPlanId userPlanId;
//
///* Subscription type: */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionType type;
//
///* Payment type: */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionPaymentType paymentType;
//
///* Start date of the subscription */
//@property (nonatomic, strong) NSDate *startDate;
//
///* End date of the subscription */
//@property (nonatomic, strong) NSDate *endDate;
//
///* Payment gateway product ID of this subscription */
//@property (nonatomic, strong) NSString *gatewayId;
//
///* 'true' if the payment made on a sandbox gateway */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionSandbox sandbox;
//
///* Duration of the subscription in days, if this is a Non-Renewable subscription that requires the IoT Software Suite to expire the subscription. */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionDuration duration;
//
///* 'true' if it is a free trial subscription */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionFree free;
//
///* Organization purchased this subscription for the user */
//@property (nonatomic) PPOrganizationId organizationId;
//
///* Payment gateway product ID of this subscription */
//@property (nonatomic, strong) NSString *subscriptionId;
//
///* Payment gateway product ID of this subscription */
//@property (nonatomic, strong) NSString *transactionId;
//
///* Service Plan */
////@property (nonatomic, strong) PPServicePlan *plan;
//
//- (id)initWithId:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType startDate:(NSDate *)startDate endDate:(NSDate *)endDate gatewayId:(NSString *)gatewayId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox duration:(PPServicePlanSoftwareSubscriptionDuration)duration free:(PPServicePlanSoftwareSubscriptionFree)free organizationId:(PPOrganizationId)organizationId subscriptionId:(NSString *)subscriptionId transactionId:(NSString *)transactionId;// plan:(PPServicePlan *)plan;
//
//+ (PPServicePlanSoftwareSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict;
//
//@end

