//
//  PPTCPaidServices.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPPaidServices.h>

static NSString *moduleName = @"PaidServices";

@interface PPTCPaidServices : PPBaseTestCase

@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) PPUser *user;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) NSData *transactionReceiptData;
@property (strong, nonatomic) NSString *tempKey;
@property (nonatomic) PPServicePlanPriceId planPriceId;
@property (nonatomic) PPServicePlanSoftwareSubscriptionUserPlanId userPlanId;
@property (nonatomic) PPServicePlanId targetPlanId;
@property (strong, nonatomic) NSString *nonce;

@end

@implementation PPTCPaidServices

- (void)setUp {
    [super setUp];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *userDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSData *transactionReceiptData = [@"EXAMPLE" dataUsingEncoding:NSUTF8StringEncoding];
    
    self.appName = appName;
    self.user = [PPUser initWithDictionary:userDict];
    self.location = [PPLocation initWithDictionary:locationDict];
    self.transactionReceiptData = transactionReceiptData;
    self.tempKey = @"TEMP_KEY";
    self.planPriceId = 123;
    self.userPlanId = 456;
    self.targetPlanId = 789;
    self.nonce = @"NONCE_TOKEN";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Get Software Subscriptions

/**
 * Get Software Subscriptions.
 * Return a list of paid service plans for sale, or having been purchased by the user. System and organization administrators can retrieve data for other users.
 * Software service plans can be subscription-based, or one-time feature buys. The IoT Software Suite supports Apple's Auto-renewable Subscriptions as well as Non-Renewing Subscriptions with custom limits on durations. Please see https://developer.apple.com/in-app-purchase/ for more details.
 *
 * @ param appName NSString Retrieve the subscriptions available for the given unique app name
 * @ param userId PPUserId Used by administrators to specify another user
 * @ param organizationId PPOrganizationId Used by administrators to receive plans for another user in specific organization
 * @ param hiddenPrices PPPaidServicesHiddenPrices Return hidden prices. It can be useful for testing new features before exposing them to public.
 * @ param callback PPPaidServicesServicePlansCallback Service Plans callback block containing list of service plans
 **/
- (void)testGetSoftwareSubscriptions {
    NSString *methodName = @"GetSoftwareSubscriptions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/servicePlans" statusCode:200 headers:nil];
    
    [PPPaidServices getSoftwareSubscriptions:self.location.locationId appName:nil userId:PPUserIdNone organizationId:PPOrganizationIdNone hiddenPrices:PPPaidServicesHiddenPricesNone callback:^(NSArray *servicePlans, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

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
 * @ param appName NSString Unique app name that is making the purchase
 * @ param transactionReceiptData Required NSData Authenticated receipt data for verification
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSubmitApplePurchaseReceipt {
    NSString *methodName = @"SubmitApplePurchaseReceipt";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/receipt/apple" statusCode:200 headers:nil];
    
    [PPPaidServices submitApplePurchaseReceipt:self.location.locationId appName:self.appName transactionReceiptData:self.transactionReceiptData callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - User Payment Profiles

#warning TODO: Add "Get Payment Profiles" API

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
 * @ param planPriceId Required PPServicePlanPriceId Service plan price ID
 * @ param tempKey Requried NSString A temporary API key
 * @ param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on Paypal sandbox server
 * @ param callback PPPaidServicePaypalRedirectCallback Paypal redirect callback with NSURL for paypal user authentication page
 **/
#warning DEPRECATED?
- (void)_testRedirectUserToPaypalWebsite {
    NSString *methodName = @"RedirectUserToPaypalWebsite";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/paypalpurchase/%@", @(self.planPriceId)] statusCode:200 headers:nil];
    
    [PPPaidServices redirectUserToPaypalWebsite:self.planPriceId tempKey:self.tempKey sandbox:PPServicePlanSoftwareSubscriptionSandboxTrue callback:^(NSURL *authenticationUrl, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Payment token

/**
 * Get payment provider token.
 * Retrive a token for specific payment service provider.
 *
 * @ param paymentType Required PPPaidServicesServicePaymentType Payment type linked to specific payment service provider
 * @ param appName Required NSString Retrieve the token for the given unique app name
 * @ param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on sandbox payment provider service
 * @ param callback PPPaidServicePaymentProviderCallback Payment provider callback containing token
 **/
 #warning DEPRECATED?
- (void)_testGetPaymentProviderToken {
    NSString *methodName = @"GetPaymentProviderToken";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/paymentToken/%@", @(PPPaidServicesServicePaymentTypeBraintree)] statusCode:200 headers:nil];
    
    [PPPaidServices getPaymentProviderToken:PPPaidServicesServicePaymentTypeBraintree appName:self.appName sandbox:PPServicePlanSoftwareSubscriptionSandboxTrue callback:^(NSString *token, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
#pragma mark - Purchase

/**
 * Provide new purchase info
 * Provide purchase information like subsription ID or receipt or nonce, which proofs that the purchase has been made.
 *
 * @ param priceId Required PPServicePlanPriceId Service plan price ID
 * @ param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on sandbox payment provider service
 * @ param userId PPUserId Purchase as a specific user
 * @ param paymentType Required PPServicePlanSoftwareSubscriptionPaymentType Payment type
 * @ param subscriptionId Required NSString Subscription ID of plan
 * @ param nonce Required NSString Unique token that can only be used once
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testProvideNewPurchaseInfo {
    NSString *methodName = @"ProvideNewPurchaseInfo";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/purchase" statusCode:200 headers:nil];
    
    [PPPaidServices provideNewPurchaseInfo:self.location.locationId priceId:self.planPriceId sandbox:PPServicePlanSoftwareSubscriptionSandboxTrue userId:PPUserIdNone paymentType:PPServicePlanSoftwareSubscriptionPaymentTypeBraintree subscriptionId:nil nonce:self.nonce services:nil bots:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Update purchase info.
 * Update purchase information like a receipt or nonce for an existing service subscription.
 *
 * @ param userPlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The User Service Plan ID to update
 * @ param nonce Required NSString Unique token that can only be used once
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdatePurchaseInfo {
    NSString *methodName = @"UpdatePurchaseInfo";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/purchase" statusCode:200 headers:nil];
    
    [PPPaidServices updatePurchaseInfo:self.userPlanId nonce:self.nonce callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Upgrade purchase

/**
 * Upgrade purchased plan.
 * Upgrade existing user service plan to another with different services.
 *
 * @ param userPlanId Required PPServicePlanSoftwareSubscriptionUserPlanId Existing user plan ID
 * @ param targetPlanId Required PPServicePlanId New service plan ID
 * @ param nonce Required NSString Unique token that can only be used once
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpgradePurchasedPlan {
    NSString *methodName = @"UpgradePurchasedPlan";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/purchase/upgrade" statusCode:200 headers:nil];
    
    [PPPaidServices upgradePurchasedPlan:self.userPlanId targetPlanId:self.targetPlanId userId:PPUserIdNone services:nil bots:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

#pragma mark - User subscriptions

/**
 * Get user subscriptions.
 * This API returns all service plans purchased by a user or manually assigned to him.
 *
 * @ param status PPServicePlanStatus Service Plan status
 * @ param userId PPUserId Used by organization administrators to specify user
 * @ param callback PPPaidServicesSubscriptionsCallback Subscriptions callback with list of purchased subscriptions
 **/
- (void)testGetUserSubscriptions {
    NSString *methodName = @"GetUserSubscriptions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/userServicePlans" statusCode:200 headers:nil];
    
    [PPPaidServices getUserSubscriptions:PPServicePlanStatusNone userId:PPUserIdNone callback:^(NSArray *subscriptions, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Transactions

/**
 * Get transactions.
 * This API returns all payment transactions for specific user service plan.
 *
 * @ param userServicePlanId PPServicePlanId User service plan ID
 * @ param userId PPUserId Used by administrators to specify user
 * @ param callback PPPaidServicesTransactionsCallback Transactions callback block
 **/
- (void)testGetTransactions {
    NSString *methodName = @"GetTransactions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/userServicePlanTransactions/%@", @(self.targetPlanId)]  statusCode:200 headers:nil];
    
    [PPPaidServices getTransactions:self.targetPlanId userId:PPUserIdNone callback:^(NSArray *transactions, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Manage services

/**
 * Assign services to users.
 * This API can be called by any user to assign free services, or by an administrator with a corresponding privilege level to assign a service plan to other users.
 *
 * @ param servicePlanId PPServicePlanId The Service Plan ID to assign
 * @ param userIds NSArray Used by organization administrators to speiciy users.
 * @ param organizationId PPOrganizationId Organization ID. Required if called by an organization administrator.
 * @ param username NSString Set by the paid service administrator only, this can be either the username or user ID
 * @ param endDate NSDate The end date of the subscription
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testAssignServicesToUser {
    NSString *methodName = @"AssignServicesToUser";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/userServicePlans/%@", @(self.targetPlanId)] statusCode:200 headers:nil];
    
    [PPPaidServices assignServicesToUser:self.location.locationId servicePlanId:self.targetPlanId userIds:@[@(self.user.userId).stringValue] organizationId:PPOrganizationIdNone username:nil endDate:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Cancel subscription.
 * Cancel subscription purchased through Paypal or assigned to the user manually.
 *
 * @ param servicePlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The Service Plan ID to delete
 * @ param userId NSArray Used by organization administrators to speiciy users.
 * @ param organizationId PPOrganizationId Organization ID. Required if called by an organization administrator.
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testCancelSubscription {
    NSString *methodName = @"CancelSubscription";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/userServicePlans/%@", @(self.userPlanId)] statusCode:200 headers:nil];
    
    [PPPaidServices cancelSubscription:self.userPlanId userId:self.user.userId organizationId:PPOrganizationIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get Store Products

/**
 * Get Store Products.
 * The Store manages links to products that can be purchased through specific apps and web consoles, including options for graphics to display, the order in which to display them, alternative text, links, icons, etc. Link to an external store such as Amazon.com or GoDaddy to execute the purchase of physical goods.
 *
 * @ param appName NSString Unique app name to display store products for your specific app
 * @ param callback PPPaidServicesProductsCallback Products callback block
 **/
- (void)testGetStoreProducts {
    NSString *methodName = @"GetStoreProducts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/market" statusCode:200 headers:nil];
    
    [PPPaidServices getStoreProducts:nil callback:^(NSArray *products, NSString *affiliateCode, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
