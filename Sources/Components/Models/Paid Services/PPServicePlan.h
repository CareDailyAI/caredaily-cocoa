//
//  PPServicePlan.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPServicePlanPriceAmount.h"
#import "PPServicePlanSoftwareSubscription.h"

#pragma mark - PPServicePlan

@class PPServicePlanSoftwareSubscription;

@class PPServicePlanPrice;

@interface PPServicePlan : PPBaseModel

/* ID of a specific service plan */
@property (nonatomic) PPServicePlanId planId;

/* Name of a specific service plan */
@property (nonatomic, strong) NSString *name;

/* Description of a specific service plan */
@property (nonatomic, strong) NSString *desc;

/* Whether or not this service plan is available to purchase */
@property (nonatomic) PPServicePlanAvailable available;

/* Whether or not this service plan is subscribed to */
@property (nonatomic) PPServicePlanSubscribed subscribed;

/* List of service plan ID's, where this plan can be upgraded */
@property (nonatomic, strong) RLMArray<RLMInt> *upgradableTo;

/* Set of available prices and options to purchase this service */
@property (nonatomic, strong) RLMArray<PPServicePlanPrice *><PPServicePlanPrice> *prices;

/* Existing subscriptions owned by the user. */
@property (nonatomic, strong) RLMArray<PPServicePlanSoftwareSubscription *><PPServicePlanSoftwareSubscription> *subscriptions;

/* Services provided with this plan. */
@property (nonatomic, strong) RLMArray<PPUserService *><PPUserService> *services;

- (id)initWithId:(PPServicePlanId)planId
            name:(NSString *)name
            desc:(NSString *)desc
       available:(PPServicePlanAvailable)available
    upgradableTo:(RLMArray *)upgradableTo
          prices:(RLMArray *)prices
   subscriptions:(RLMArray *)subscriptions
        services:(RLMArray *)services;

+ (PPServicePlan *)initWithDictionary:(NSDictionary *)planDict;

#pragma mark - Helper Methods

- (BOOL)isEqualToPlan:(PPServicePlan *)plan;

- (void)sync:(PPServicePlan *)plan;

@end

#pragma mark - PPServicePlanSoftwareSubscription

@class PPServicePlanTransaction;

@interface PPServicePlanSoftwareSubscription : PPBaseModel


/* Subscription record ID */
@property (nonatomic) PPServicePlanSoftwareSubscriptionUserPlanId userPlanId;

/* Subscription type: */
@property (nonatomic) PPServicePlanSoftwareSubscriptionType type;

/* Payment type: */
@property (nonatomic) PPServicePlanSoftwareSubscriptionPaymentType paymentType;

/* Price ID */
@property (nonatomic) PPServicePlanPriceId priceId;

/* Status */
@property (nonatomic) PPServicePlanStatus status;

/* Issue Date */
@property (nonatomic, strong) NSDate *issueDate;

/* Start date of the subscription */
@property (nonatomic, strong) NSDate *startDate;

/* End date of the subscription */
@property (nonatomic, strong) NSDate *endDate;

/* Payment gateway product ID of this subscription */
@property (nonatomic, strong) NSString *gatewayId;

/* 'true' if the payment made on a sandbox gateway */
@property (nonatomic) PPServicePlanSoftwareSubscriptionSandbox sandbox;

/* Duration of the subscription in days, if this is a Non-Renewable subscription that requires the IoT Software Suite to expire the subscription. */
@property (nonatomic) PPServicePlanSoftwareSubscriptionDuration duration;

/* 'true' if it is a free trial subscription */
@property (nonatomic) PPServicePlanSoftwareSubscriptionFree free;

/* App Name */
@property (nonatomic, strong) NSString *appName;

/* Location Id */
@property (nonatomic) PPLocationId locationId;

/* User Id */
@property (nonatomic) PPUserId userId;

/* Organization purchased this subscription for the user */
@property (nonatomic) PPOrganizationId organizationId;

/* Payment gateway product ID of this subscription */
@property (nonatomic, strong) NSString *subscriptionId;

/* Payment gateway product ID of this subscription */
@property (nonatomic, strong) NSString *transactionId;

/* Service Plan */
@property (nonatomic, strong) PPServicePlan *plan;

/* Update Plan */
@property (nonatomic, strong) PPServicePlan *updatePlan;

/* Transaction */
@property (nonatomic, strong) PPServicePlanTransaction *transaction;

/* Card Masked Number */
@property (nonatomic, strong) NSString *cardMaskedNumber;

/* CardExpirationDate */
@property (nonatomic, strong) NSString *cardExpirationDate;

/* Services provided with this subscription. */
@property (nonatomic, strong) RLMArray<PPUserService *><PPUserService> *services;

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
        services:(RLMArray *)services;

+ (PPServicePlanSoftwareSubscription *)initWithDictionary:(NSDictionary *)subscriptionDict;

@end

#pragma mark - PPServicePlanPrice

@interface PPServicePlanPrice : PPBaseModel

/* ID of a plan price */
@property (nonatomic) PPServicePlanPriceId priceId;

/* Subscription type: */
@property (nonatomic) PPServicePlanSoftwareSubscriptionType type;

/* Payment type: */
@property (nonatomic) PPServicePlanSoftwareSubscriptionPaymentType paymentType;

/* 'true' if a limited free trial option is available. */
@property (nonatomic) PPServicePlanSoftwareSubscriptionFree free;

/* Duration of the subscription in days, if this is a Non-Renewable subscription that requires the IoT Software Suite to expire the subscription. */
@property (nonatomic) PPServicePlanSoftwareSubscriptionDuration duration;

/* Unique payment gateway product ID for the service plan, e.g. Apple store product ID or PayPal or BrainTree paln ID. You must create an identical product identifier in your iTunes Connect account so Apple can facilitate the sale. */
@property (nonatomic, strong) NSString *gatewayId;

/* Unique identifier for Apple App Store. */
@property (nonatomic, strong) NSString *appleStoreId;

/* Unique payment gateway sandbox product ID */
@property (nonatomic, strong) NSString *gatewaySandboxId;

/* Price amount currency code, symbol and value */
@property (nonatomic, strong) PPServicePlanPriceAmount *amount;

- (id)initWithId:(PPServicePlanPriceId)priceId
            type:(PPServicePlanSoftwareSubscriptionType)type
     paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType
            free:(PPServicePlanSoftwareSubscriptionFree)free
        duration:(PPServicePlanSoftwareSubscriptionDuration)duration
       gatewayId:(NSString *)gatewayId
    appleStoreId:(NSString *)appleStoreId
gatewaySandboxId:(NSString *)gatewaySandboxId
          amount:(PPServicePlanPriceAmount *)amount;

+ (PPServicePlanPrice *)initWithDictionary:(NSDictionary *)priceDict;

@end
