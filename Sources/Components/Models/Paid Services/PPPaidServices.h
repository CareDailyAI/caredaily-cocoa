//
//  PPPaidServices.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite facilitates sales of software services, and physical products.
//

#import "PPBaseModel.h"
#import <StoreKit/StoreKit.h>
#import "PPServicePlan.h"
#import "PPServicePlanPrice.h"
#import "PPServicePlanTransaction.h"
#import "PPStoreProduct.h"
#import "PPOrganization.h"

@interface PPPaidServices : PPBaseModel

#pragma mark - Session Management

#pragma mark Service Plans

/**
 * Shared servicePlans across the entire application
 */
+ (NSArray *)sharedServicePlansForUser:(PPUserId)userId;

/**
 * Add service plans.
 * Add service plans to local reference.
 *
 * @param servicePlans NSArray Array of servicePlans to add.
 * @param userId Required PPUserId User Id to associate these servicePlans with
 **/
+ (void)addServicePlans:(NSArray *)servicePlans userId:(PPUserId)userId;

/**
 * Remove service plans.
 * Remove service plans from local reference.
 *
 * @param servicePlans NSArray Array of servicePlans to remove.
 * @param userId Required PPUserId User Id to associate these servicePlans with
 **/
+ (void)removeServicePlans:(NSArray *)servicePlans userId:(PPUserId)userId;

#pragma mark Products

/**
 * Shared products across the entire application
 */
+ (NSArray *)sharedProductsForUser:(PPUserId)userId;

/**
 * Add products.
 * Add products to local reference.
 *
 * @param products NSArray Array of products to add.
 * @param userId Required PPUserId User Id to associate these products with
 **/
+ (void)addProducts:(NSArray *)products userId:(PPUserId)userId;

/**
 * Remove products.
 * Remove products from local reference.
 *
 * @param products NSArray Array of products to remove.
 * @param userId Required PPUserId User Id to associate these products with
 **/
+ (void)removeProducts:(NSArray *)products userId:(PPUserId)userId;

#pragma mark - Get Software ServicePlans

/**
 * Get Software Subscriptions.
 * Return a list of paid service plans for sale, or having been purchased by the user. System and organization administrators can retrieve data for other users.
 * Software service plans can be subscription-based, or one-time feature buys. The IoT Software Suite supports Apple's Auto-renewable Subscriptions as well as Non-Renewing Subscriptions with custom limits on durations. Please see https://developer.apple.com/in-app-purchase/ for more details.
 *
 * @param locationId Required PPLocationId Location ID
 * @param appName NSString Retrieve the subscriptions available for the given unique app name
 * @param userId PPUserId Used by administrators to specify another user
 * @param organizationId PPOrganizationId Used by administrators to receive plans for another user in specific organization
 * @param hiddenPrices PPPaidServicesHiddenPrices Return hidden prices. It can be useful for testing new features before exposing them to public.
 * @param callback PPPaidServicesServicePlansCallback Service Plans callback block containing list of service plans
 **/
+ (void)getSoftwareSubscriptions:(PPLocationId)locationId appName:(NSString * _Nullable )appName userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId hiddenPrices:(PPPaidServicesHiddenPrices)hiddenPrices callback:(PPPaidServicesServicePlansCallback _Nonnull )callback;
+ (void)getSoftwareSubscriptions:(NSString * _Nullable )appName userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId hiddenPrices:(PPPaidServicesHiddenPrices)hiddenPrices callback:(PPPaidServicesServicePlansCallback _Nonnull )callback __attribute__((deprecated));

#pragma mark - Submit an Apple Purchase Receipt

/**
 * Submit an Apple Purchase Receipt.
 * When making a purchase through the Apple App Store, the app will hand over control to Apple to handle the transaction. When the transaction is complete, it is the app's responsibility to capture the authenticated receipt from Apple and reliably pass the receipt to the IoT Software Suite. The IoT Software Suite will validate the receipt by calling the payment provider's server, and then securely apply the purchase to the user's account.
 * This API will return a result code:
 *      - 0 = Success
 *      - 6 = Object Not Found, the receipt is not found on the Apple Store
 *      - 7 = Access Denied, the receipt is already submitted by a different user
 *      - 8 = Wrong Parameter Value, The receipt is invalid or expired
 *      - 26 = Duplicate Entry, The receipt is already submitted by the same user
 *
 * @param locationId Required PPLocation ID
 * @param appName NSString Unique app name that is making the purchase
 * @param transactionReceiptData Required NSData Authenticated receipt data for verification
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)submitApplePurchaseReceipt:(PPLocationId)locationId appName:(NSString * _Nullable )appName transactionReceiptData:(NSData * _Nonnull )transactionReceiptData callback:(PPErrorBlock _Nonnull )callback;
+ (void)submitApplePurchaseReceipt:(NSString * _Nullable )appName transactionReceiptData:(NSData * _Nonnull )transactionReceiptData callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Purchase through Paypal

/**
 * Redirect user to Paypal website.
 * When a user purchases services through Paypal, he goes through several steps:
 *      1 UI redirects the user to this URL.
 *      2 The IoT Software Suite makes a request to Paypal by the given plan ID and redirects the user to the Paypal screen.
 *      3 The user enters payments info on the Paypal screen.
 *      4 Paypal replies to the server and redirects the user to the IoT Software Suite response URL.
 *      5 The IoT Software Suite assigns the service plan to the user and redirects the user to a success or an error screen.
 *
 * @param planPriceId Required PPServicePlanPriceId Service plan price ID
 * @param tempKey Requried NSString A temporary API key
 * @param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on Paypal sandbox server
 * @param callback PPPaidServicePaypalRedirectCallback Paypal redirect callback with NSURL for paypal user authentication page
 **/
+ (void)redirectUserToPaypalWebsite:(PPServicePlanPriceId)planPriceId tempKey:(NSString * _Nonnull )tempKey sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox callback:(PPPaidServicePaypalRedirectCallback _Nonnull )callback;

#pragma mark - Payment token

/**
 * Get payment provider token.
 * Retrive a token for specific payment service provider.
 *
 * @param paymentType Required PPPaidServicesServicePaymentType Payment type linked to specific payment service provider
 * @param appName Required NSString Retrieve the token for the given unique app name
 * @param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on sandbox payment provider service
 * @param callback PPPaidServicePaymentProviderCallback Payment provider callback containing token
 **/
+ (void)getPaymentProviderToken:(PPPaidServicesServicePaymentType)paymentType appName:(NSString * _Nonnull )appName sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox callback:(PPPaidServicePaymentProviderCallback _Nonnull )callback;

#pragma mark - Purchase

/**
 * Provide new purchase info
 * Provide purchase information like subsription ID or receipt or nonce, which proofs that the purchase has been made.
 * If the purchased service plan contains services with resource types other than "user" (0), the request must include corresponding resource ID's for these services.
 *
 * @param locationId Required PPLocationId Location ID
 * @param priceId Required PPServicePlanPriceId Service plan price ID
 * @param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on sandbox payment provider service
 * @param userId PPUserId Purchase as a specific user
 * @param paymentType Required PPServicePlanSoftwareSubscriptionPaymentType Payment type
 * @param subscriptionId Required NSString Subscription ID of plan
 * @param nonce Required NSString Unique token that can only be used once
 * @param services NSArray Services
 * @param bots NSArray Bots
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)provideNewPurchaseInfo:(PPLocationId)locationId priceId:(PPServicePlanPriceId)priceId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox userId:(PPUserId)userId paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType subscriptionId:(NSString * _Nullable )subscriptionId nonce:(NSString * _Nonnull )nonce services:(NSArray * _Nullable )services bots:(NSArray * _Nullable )bots callback:(PPErrorBlock _Nonnull )callback;
+ (void)provideNewPurchaseInfo:(PPServicePlanPriceId)priceId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox userId:(PPUserId)userId paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType subscriptionId:(NSString * _Nonnull )subscriptionId nonce:(NSString * _Nonnull )nonce callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Update purchase info.
 * Update purchase information like a receipt or nonce for an existing service subscription.
 *
 * @param userPlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The User Service Plan ID to update
 * @param nonce Required NSString Unique token that can only be used once
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updatePurchaseInfo:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId nonce:(NSString * _Nonnull )nonce callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Upgrade purchase

/**
 * Upgrade purchased plan.
 * Upgrade existing user service plan to another with different services.
 *
 * @param userPlanId Required PPServicePlanSoftwareSubscriptionUserPlanId Existing user plan ID
 * @param targetPlanId Required PPServicePlanId New service plan ID
 * @param userId PPUserId User ID on which account need to make changes. Can be used by a purchase administrator.
 * @param services NSArray Services
 * @param bots NSArray Bots
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)upgradePurchasedPlan:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId targetPlanId:(PPServicePlanId)targetPlanId userId:(PPUserId)userId services:(NSArray * _Nullable )services bots:(NSArray * _Nullable )bots callback:(PPErrorBlock _Nonnull )callback;
+ (void)upgradePurchasedPlan:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId targetPlanId:(PPServicePlanId)targetPlanId nonce:(NSString * _Nonnull )nonce callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Location Service Plans

/**
 * Get location service plans.
 * This API returns all service plans on specific location or purchased by a user or manually assigned to him.
 * Either locationId or userId parameters must be used.
 *
 * @param locationId PPLocationId Get plan for this location
 * @param status PPServicePlanStatus Service Plan status
 * @param userPlanId PPServicePlanId Get specific service by plan ID
 * @param userId PPUserId Ger plan by this user. Used by organization administrators.
 * @param callback PPPaidServicesSubscriptionsCallback Subscriptions callback with list of purchased subscriptions
 **/
+ (void)getLocationServicePlans:(PPLocationId)locationId status:(PPServicePlanStatus)status userPlanId:(PPServicePlanId)userPlanId userId:(PPUserId)userId callback:(PPPaidServicesSubscriptionsCallback _Nonnull )callback;
+ (void)getUserSubscriptions:(PPServicePlanStatus)status userId:(PPUserId)userId callback:(PPPaidServicesSubscriptionsCallback _Nonnull )callback __attribute__ ((deprecated));

#pragma mark - Transactions

/**
 * Get transactions.
 * This API returns all payment transactions for specific user service plan.
 *
 * @param userServicePlanId Required PPServicePlanId User service plan ID
 * @param userId PPUserId Used by administrators to specify user
 * @param callback PPPaidServicesTransactionsCallback Transactions callback block
 **/
+ (void)getTransactions:(PPServicePlanId)userServicePlanId userId:(PPUserId)userId callback:(PPPaidServicesTransactionsCallback _Nonnull )callback;

#pragma mark - Manage services

/**
 * Assign services to users.
 * This API can be called by any user to assign free services, or by an administrator with a corresponding privilege level to assign a service plan to other users.
 *
 * @param locationId Required PPLocation ID
 * @param servicePlanId Required PPServicePlanId The Service Plan ID to assign
 * @param userIds NSArray Used by organization administrators to speiciy users.
 * @param organizationId PPOrganizationId Organization ID. Required if called by an organization administrator.
 * @param username NSString Set by the paid service administrator only, this can be either the username or user ID
 * @param endDate NSDate The end date of the subscription
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)assignServicesToUser:(PPLocationId)locationId servicePlanId:(PPServicePlanId)servicePlanId userIds:(NSArray * _Nullable )userIds organizationId:(PPOrganizationId)organizationId username:(NSString * _Nullable )username endDate:(NSDate * _Nullable )endDate callback:(PPErrorBlock _Nonnull )callback;
+ (void)assignServicesToUser:(PPServicePlanId)servicePlanId userIds:(NSArray * _Nullable )userIds organizationId:(PPOrganizationId)organizationId username:(NSString * _Nullable )username endDate:(NSDate * _Nullable )endDate callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Cancel subscription.
 * Cancel subscription purchased through Paypal or assigned to the user manually.
 *
 * @param servicePlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The Service Plan ID to delete
 * @param userId NSArray Used by organization administrators to speiciy users.
 * @param organizationId PPOrganizationId Organization ID. Required if called by an organization administrator.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)cancelSubscription:(PPServicePlanSoftwareSubscriptionUserPlanId)servicePlanId userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Get Store Products

/**
 * Get Store Products.
 * The Store manages links to products that can be purchased through specific apps and web consoles, including options for graphics to display, the order in which to display them, alternative text, links, icons, etc. Link to an external store such as Amazon.com or GoDaddy to execute the purchase of physical goods.
 *
 * @param appName NSString Unique app name to display store products for your specific app
 * @param callback PPPaidServicesProductsCallback Products callback block
 **/
+ (void)getStoreProducts:(NSString * _Nullable )appName callback:(PPPaidServicesProductsCallback _Nonnull )callback;

@end
