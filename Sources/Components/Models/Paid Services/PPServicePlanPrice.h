//
//  PPServicePlanPrice.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

//#import "PPServicePlanSoftwareSubscription.h"
//#import "PPServicePlanPriceAmount.h"
//
//typedef NS_OPTIONS(NSInteger, PPServicePlanPriceId) {
//    PPServicePlanPriceIdNone = -1,
//};
//
//@interface PPServicePlanPrice : PPBaseModel
//
///* ID of a plan price */
//@property (nonatomic) PPServicePlanPriceId priceId;
//
///* Subscription type: */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionType type;
//
///* Payment type: */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionPaymentType paymentType;
//
///* 'true' if a limited free trial option is available. */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionFree free;
//
///* Duration of the subscription in days, if this is a Non-Renewable subscription that requires the IoT Software Suite to expire the subscription. */
//@property (nonatomic) PPServicePlanSoftwareSubscriptionDuration duration;
//
///* Unique payment gateway product ID for the service plan, e.g. Apple store product ID or PayPal or BrainTree paln ID. You must create an identical product identifier in your iTunes Connect account so Apple can facilitate the sale. */
//@property (nonatomic, strong) NSString *gatewayId;
//
///* Unique identifier for Apple App Store. */
//@property (nonatomic, strong) NSString *appleStoreId;
//
///* Unique payment gateway sandbox product ID */
//@property (nonatomic, strong) NSString *gatewaySandboxId;
//
///* Price amount currency code, symbol and value */
//@property (nonatomic, strong) PPServicePlanPriceAmount *amount;
//
//- (id)initWithId:(PPServicePlanPriceId)priceId type:(PPServicePlanSoftwareSubscriptionType)type paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType free:(PPServicePlanSoftwareSubscriptionFree)free duration:(PPServicePlanSoftwareSubscriptionDuration)duration gatewayId:(NSString *)gatewayId appleStoreId:(NSString *)appleStoreId gatewaySandboxId:(NSString *)gatewaySandboxId amount:(PPServicePlanPriceAmount *)amount;
//
//+ (PPServicePlanPrice *)initWithDictionary:(NSDictionary *)priceDict;
//
//@end

