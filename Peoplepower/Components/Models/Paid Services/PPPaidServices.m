//
//  PPPaidServices.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPPaidServices.h"
#import "PPCloudEngine.h"

@implementation PPPaidServices

#pragma mark - Session Management

#pragma mark Service Planes

/**
 * Shared servicePlans across the entire application
 * @param userId Required PPUserId User Id to associate these servicePlans with
 */
+ (NSArray *)sharedServicePlansForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPServicePlan *> *sharedServicePlans = [PPServicePlan allObjects];
    
    NSMutableArray *sharedServicePlansArray = [[NSMutableArray alloc] initWithCapacity:[sharedServicePlans count]];
    NSMutableArray *servicePlansArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPServicePlan *servicePlan in sharedServicePlans) {
        [sharedServicePlansArray addObject:servicePlan];
        
        [servicePlansArrayDebug addObject:@{@"planId": @(servicePlan.planId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedServicePlans=%@", __PRETTY_FUNCTION__, servicePlansArrayDebug);
#endif
#endif
    return sharedServicePlansArray;
}

/**
 * Add servicePlans.
 * Add servicePlans from local reference.
 *
 * @param servicePlans NSArray Array of servicePlans to remove.
 * @param userId Required PPUserId User Id to associate these servicePlans with
 **/
+ (void)addServicePlans:(NSArray *)servicePlans userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s servicePlans=%@", __PRETTY_FUNCTION__, servicePlans);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPServicePlan *servicePlan in servicePlans) {
        [PPServicePlan createOrUpdateInDefaultRealmWithValue:servicePlan];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove servicePlans.
 * Remove servicePlans from local reference.
 *
 * @param servicePlans NSArray Array of servicePlans to remove.
 * @param userId Required PPUserId User Id to associate these servicePlans with
 **/
+ (void)removeServicePlans:(NSArray *)servicePlans userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s servicePlans=%@", __PRETTY_FUNCTION__, servicePlans);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPServicePlan *servicePlan in servicePlans) {
            [[PPRealm defaultRealm] deleteObject:[PPServicePlan objectForPrimaryKey:@(servicePlan.planId)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Products

/**
 * Shared products across the entire application
 * @param userId Required PPUserId User Id to associate these products with
 */
+ (NSArray *)sharedProductsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPStoreProduct *> *sharedProducts = [PPStoreProduct allObjects];
    
    NSMutableArray *sharedProductsArray = [[NSMutableArray alloc] initWithCapacity:[sharedProducts count]];
    NSMutableArray *productsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPStoreProduct *product in sharedProducts) {
        [sharedProductsArray addObject:product];
        
        [productsArrayDebug addObject:@{@"productId": @(product.productId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedProducts=%@", __PRETTY_FUNCTION__, productsArrayDebug);
#endif
#endif
    return sharedProductsArray;
}

/**
 * Add products.
 * Add products from local reference.
 *
 * @param products NSArray Array of products to remove.
 * @param userId Required PPUserId User Id to associate these products with
 **/
+ (void)addProducts:(NSArray *)products userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s products=%@", __PRETTY_FUNCTION__, products);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPStoreProduct *product in products) {
        [PPStoreProduct createOrUpdateInDefaultRealmWithValue:product];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove products.
 * Remove products from local reference.
 *
 * @param products NSArray Array of products to remove.
 * @param userId Required PPUserId User Id to associate these products with
 **/
+ (void)removeProducts:(NSArray *)products userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s products=%@", __PRETTY_FUNCTION__, products);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPStoreProduct *product in products) {
            [[PPRealm defaultRealm] deleteObject:[PPStoreProduct objectForPrimaryKey:@(product.productId)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Get Software Subscriptions

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
+ (void)getSoftwareSubscriptions:(PPLocationId)locationId appName:(NSString *)appName userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId hiddenPrices:(PPPaidServicesHiddenPrices)hiddenPrices callback:(PPPaidServicesServicePlansCallback)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"servicePlans?"];
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(appName) {
        [requestString appendFormat:@"appName=%@&", appName];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    if(hiddenPrices != PPPaidServicesHiddenPricesNone) {
        [requestString appendFormat:@"hiddenPrices=%@&", (hiddenPrices) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.getSoftwareSubscriptions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *servicePlans;
            
            if(!error) {
                servicePlans = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *planDict in [root objectForKey:@"servicePlans"]) {
                    PPServicePlan *plan = [PPServicePlan initWithDictionary:planDict];
                    [servicePlans addObject:plan];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(servicePlans, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getSoftwareSubscriptions:(NSString *)appName userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId hiddenPrices:(PPPaidServicesHiddenPrices)hiddenPrices callback:(PPPaidServicesServicePlansCallback)callback {
    NSLog(@"%s deprecated. Use +getSoftwareSubscriptions:appName:userId:organizationId:hiddenPrices:callback:", __FUNCTION__);
    [PPPaidServices getSoftwareSubscriptions:PPLocationIdNone appName:appName userId:userId organizationId:organizationId hiddenPrices:hiddenPrices callback:callback];
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
 * @param locationId Required PPLocation ID
 * @param appName NSString Unique app name that is making the purchase
 * @param transactionReceiptData Required NSData Authenticated receipt data for verification
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)submitApplePurchaseReceipt:(PPLocationId)locationId appName:(NSString *)appName transactionReceiptData:(NSData *)transactionReceiptData callback:(PPErrorBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"receipt/apple?"];
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(transactionReceiptData != nil, @"%s missing transactionReceiptData", __FUNCTION__);
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(appName) {
        [requestString appendFormat:@"appName=%@&", appName];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:transactionReceiptData];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.submitApplePurchaseReceipt()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)submitApplePurchaseReceipt:(NSString *)appName transactionReceiptData:(NSData *)transactionReceiptData callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +submitApplePurchaseReceipt:appName:transactionReceiptData:callback:", __FUNCTION__);
    [PPPaidServices submitApplePurchaseReceipt:PPLocationIdNone appName:appName transactionReceiptData:transactionReceiptData callback:callback];
}

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
+ (void)redirectUserToPaypalWebsite:(PPServicePlanPriceId)planPriceId tempKey:(NSString *)tempKey sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox callback:(PPPaidServicePaypalRedirectCallback)callback {
    NSAssert1(planPriceId != PPServicePlanPriceIdNone, @"%s missing planPriceId", __FUNCTION__);
    NSAssert1(tempKey != nil, @"%s missing tempKey", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"paypalpurchase/%li?API_KEY=%@?", (long)planPriceId, tempKey];
    
    if(sandbox != PPServicePlanSoftwareSubscriptionSandboxNone) {
        [requestString appendFormat:@"sandbox=%@&", (sandbox) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.redirectUserToPaypalWebsite()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSURL *authenticationUrl = [NSURL URLWithString:responseString];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(authenticationUrl, nil);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)getPaymentProviderToken:(PPPaidServicesServicePaymentType)paymentType appName:(NSString *)appName sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox callback:(PPPaidServicePaymentProviderCallback)callback {
    NSAssert1(paymentType != PPPaidServicesServicePaymentTypeNone, @"%s missing paymentType", __FUNCTION__);
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"paymentToken/%li?", (long)paymentType];
    
    if(appName) {
        [requestString appendFormat:@"appName=%@&", appName];
    }
    if(sandbox != PPServicePlanSoftwareSubscriptionSandboxNone) {
        [requestString appendFormat:@"sandbox=%@&", (sandbox) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.getPaymentProviderToken()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *token;
            
            if(!error) {
                token = [root objectForKey:@"token"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(token, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Purchase

/**
 * Provide new purchase info
 * Provide purchase information like subsription ID or receipt or nonce, which proofs that the purchase has been made.
 *
 * @param priceId Required PPServicePlanPriceId Service plan price ID
 * @param sandbox PPServicePlanSoftwareSubscriptionSandbox Set to true, if need to test the process on sandbox payment provider service
 * @param userId PPUserId Purchase as a specific user
 * @param paymentType Required PPServicePlanSoftwareSubscriptionPaymentType Payment type
 * @param subscriptionId NSString Subscription ID of plan
 * @param nonce Required NSString Unique token that can only be used once
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)provideNewPurchaseInfo:(PPLocationId)locationId priceId:(PPServicePlanPriceId)priceId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox userId:(PPUserId)userId paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType subscriptionId:(NSString *)subscriptionId nonce:(NSString *)nonce services:(NSArray *)services bots:(NSArray *)bots callback:(PPErrorBlock)callback {
    NSAssert1(priceId != PPServicePlanPriceIdNone, @"%s missing priceId", __FUNCTION__);
    NSAssert1(paymentType != PPServicePlanSoftwareSubscriptionPaymentTypeNone, @"%s missing paymentType", __FUNCTION__);
    NSAssert1(nonce != nil, @"%s missing nonce", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"purchase?priceId=%li&paymentType=%li&", (long)priceId, (long)paymentType];
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(sandbox != PPServicePlanSoftwareSubscriptionSandboxNone) {
        [requestString appendFormat:@"sandbox=%@", (sandbox) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    
    NSMutableString *JSONString;
    if(subscriptionId || nonce) {
        JSONString = [[NSMutableString alloc] init];
        
        [JSONString appendString:@"{"];
        BOOL appendComma = NO;
        if(subscriptionId) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"subscriptionId\": \"%@\"", subscriptionId];
            appendComma = YES;
        }
        if(nonce) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"nonce\": \"%@\"", nonce];
            appendComma = YES;
        }
        
#warning PPPaidServices provideNewPurchaseInfo:priceId:sandbox:userId:paymentType:subscriptionId:nonce:services:bots:callback - Figure out resourceID definition for services and bots
        /*
        if(services) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:@"\"services\": ["];
            BOOL appendServicesComma = NO;
            for(PPServicePlan *servicePlan in services) {
                if(appendServicesComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendString:@"{"];
                BOOL appendServicePlanComma = NO;
                if(servicePlan.name) {
                    [JSONString appendFormat:@"\"name\":\"%@\"", servicePlan.name];
                    appendServicePlanComma = YES;
                }
                if(servicePlan.planId != PPServicePlanIdNone) {
                    if(appendServicePlanComma) {
                        [JSONString appendString:@","];
                    }
                    [JSONString appendFormat:@"\"resourceId\":%li", servicePlan.planId];
                }
                
                [JSONString appendString:@"}"];
                
                appendServicesComma = YES;
            }
            
            [JSONString appendString:@"]"];
            appendComma = YES;
        }
        
        if(bots) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:@"\"bots\": ["];
            BOOL appendBotsComma = NO;
            for(PPBotengineApp *bot in bots) {
                if(appendBotsComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendString:@"{"];
                BOOL appendBotComma = NO;
                if(bot.bundle) {
                    [JSONString appendFormat:@"\"bundle\":\"%@\"", bot.bundle];
                    appendBotComma = YES;
                }
                
                if(bot.?? != ??) {
                    if(appendBotComma) {
                        [JSONString appendString:@","];
                    }
                    [JSONString appendFormat:@"\"resourceId\":%li", bot.??];
                }
                
                [JSONString appendString:@"}"];
                
                appendBotsComma = YES;
            }
            
            [JSONString appendString:@"]"];
            appendComma = YES;
        }
         */
        [JSONString appendString:@"}"];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(JSONString) {
        [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.provideNewPurchaseInfo()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)provideNewPurchaseInfo:(PPServicePlanPriceId)priceId sandbox:(PPServicePlanSoftwareSubscriptionSandbox)sandbox userId:(PPUserId)userId paymentType:(PPServicePlanSoftwareSubscriptionPaymentType)paymentType subscriptionId:(NSString *)subscriptionId nonce:(NSString *)nonce callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +provideNewPurchaseInfo:priceId:sandbox:userId:paymentType:subscriptionId:nonce:services:bots:callback:", __FUNCTION__);
    [PPPaidServices provideNewPurchaseInfo:PPLocationIdNone priceId:priceId sandbox:sandbox userId:userId paymentType:paymentType subscriptionId:subscriptionId nonce:nonce services:nil bots:nil callback:callback];
}

/**
 * Update purchase info.
 * Update purchase information like a receipt or nonce for an existing service subscription.
 *
 * @param userPlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The User Service Plan ID to update
 * @param nonce Required NSString Unique token that can only be used once
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updatePurchaseInfo:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId nonce:(NSString *)nonce callback:(PPErrorBlock)callback {
    NSAssert1(userPlanId != PPServicePlanSoftwareSubscriptionUserPlanIdNone, @"%s missing userPlanId", __FUNCTION__);
    NSAssert1(nonce != nil, @"%s missing nonce", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"purchase?userPlanId=%li&", (long)userPlanId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"nonce\": \"%@\"", nonce];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.updatePurchaseInfo()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)upgradePurchasedPlan:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId targetPlanId:(PPServicePlanId)targetPlanId userId:(PPUserId)userId services:(NSArray *)services bots:(NSArray *)bots callback:(PPErrorBlock)callback {
    NSAssert1(userPlanId != PPServicePlanSoftwareSubscriptionUserPlanIdNone, @"%s missing userPlanId", __FUNCTION__);
    NSAssert1(targetPlanId != PPServicePlanIdNone, @"%s missing targetPlanId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"purchase/upgrade?userPlanId=%li&targetPlanId=%li&", (long)userPlanId, (long)targetPlanId];
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
#warning PPPaidServices upgradePurchasedPlay:targetPlanId:userId:services:bots:callback - Figure out resourceID definition for services and bots
    /*
    BOOL appendComma = NO;
    if(services) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"services\": ["];
        BOOL appendServicesComma = NO;
        for(PPServicePlan *servicePlan in services) {
            if(appendServicesComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:@"{"];
            BOOL appendServicePlanComma = NO;
            if(servicePlan.name) {
                [JSONString appendFormat:@"\"name\":\"%@\"", servicePlan.name];
                appendServicePlanComma = YES;
            }
            if(servicePlan.planId != PPServicePlanIdNone) {
                if(appendServicePlanComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendFormat:@"\"resourceId\":%li", servicePlan.planId];
            }
            
            [JSONString appendString:@"}"];
            
            appendServicesComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(bots) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"bots\": ["];
        BOOL appendBotsComma = NO;
        for(PPBotengineApp *bot in bots) {
            if(appendBotsComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:@"{"];
            BOOL appendBotComma = NO;
            if(bot.bundle) {
                [JSONString appendFormat:@"\"bundle\":\"%@\"", bot.bundle];
                appendBotComma = YES;
            }
            
            if(bot.?? != ??) {
                if(appendBotComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendFormat:@"\"resourceId\":%li", bot.??];
            }
            
            [JSONString appendString:@"}"];
            
            appendBotsComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    */
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.upgradePurchasedPlan()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)upgradePurchasedPlan:(PPServicePlanSoftwareSubscriptionUserPlanId)userPlanId targetPlanId:(PPServicePlanId)targetPlanId nonce:(NSString *)nonce callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +upgradePurchasedPlan:targetPlanId:nonce:callback:", __FUNCTION__);
    [PPPaidServices upgradePurchasedPlan:userPlanId targetPlanId:targetPlanId userId:PPUserIdNone services:nil bots:nil callback:callback];
}
#pragma mark - User subscriptions

/**
 * Get user subscriptions.
 * This API returns all service plans purchased by a user or manually assigned to him.
 *
 * @param status PPServicePlanStatus Service Plan status
 * @param userId PPUserId Used by organization administrators to specify user
 * @param callback PPPaidServicesSubscriptionsCallback Subscriptions callback with list of purchased subscriptions
 **/
+ (void)getUserSubscriptions:(PPServicePlanStatus)status userId:(PPUserId)userId callback:(PPPaidServicesSubscriptionsCallback)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"userServicePlans?"];
    
    if(status != PPServicePlanStatusNone) {
        [requestString appendFormat:@"status=%li&", (long)status];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.getUserSubscriptions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *subscriptions;
            
            if(!error) {
                subscriptions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *subscriptionDict in [root objectForKey:@"subscriptions"]) {
                    PPServicePlanSoftwareSubscription *subscription = [PPServicePlanSoftwareSubscription initWithDictionary:subscriptionDict];
                    [subscriptions addObject:subscription];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(subscriptions, error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Transactions

/**
 * Get transactions.
 * This API returns all payment transactions for specific user service plan.
 *
 * @param userServicePlanId Required PPServicePlanId User service plan ID
 * @param userId PPUserId Used by administrators to specify user
 * @param callback PPPaidServicesTransactionsCallback Transactions callback block
 **/
+ (void)getTransactions:(PPServicePlanId)userServicePlanId userId:(PPUserId)userId callback:(PPPaidServicesTransactionsCallback)callback {
    NSAssert1(userServicePlanId != PPServicePlanIdNone, @"%s missing userServicePlanId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"userServicePlanTransactions/%li?", (long)userServicePlanId];
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.getTransactions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *transactions;
            
            if(!error) {
                transactions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *transactionDict in [root objectForKey:@"transactions"]) {
                    PPServicePlanTransaction *transaction = [PPServicePlanTransaction initWithDictionary:transactionDict];
                    [transactions addObject:transaction];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(transactions, error);
            });
        });
    } failure:^(NSError *error) {
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)assignServicesToUser:(PPLocationId)locationId servicePlanId:(PPServicePlanId)servicePlanId userIds:(NSArray *)userIds organizationId:(PPOrganizationId)organizationId username:(NSString *)username endDate:(NSDate *)endDate callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(servicePlanId != PPServicePlanIdNone, @"%s missing servicePlanId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"userServicePlans/%li?", (long)servicePlanId];
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userIds) {
        [requestString appendFormat:@"userId=%@&", [userIds componentsJoinedByString:@"userId="]];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    if(username) {
        [requestString appendFormat:@"username=%@&", username];
    }
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.assignServicesToUser()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] POST:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)assignServicesToUser:(PPServicePlanId)servicePlanId userIds:(NSArray *)userIds organizationId:(PPOrganizationId)organizationId username:(NSString *)username endDate:(NSDate *)endDate callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +assignServicesToUser:servicePlanId:userIds:organizationId:username:endDate:callback:", __FUNCTION__);
    [PPPaidServices assignServicesToUser:PPLocationIdNone servicePlanId:servicePlanId userIds:userIds organizationId:organizationId username:username endDate:endDate callback:callback];
}

/**
 * Cancel subscription.
 * Cancel subscription purchased through Paypal or assigned to the user manually.
 *
 * @param servicePlanId Required PPServicePlanSoftwareSubscriptionUserPlanId The Service Plan ID to delete
 * @param userId NSArray Used by organization administrators to speiciy users.
 * @param organizationId PPOrganizationId Organization ID. Required if called by an organization administrator.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)cancelSubscription:(PPServicePlanSoftwareSubscriptionUserPlanId)servicePlanId userId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId callback:(PPErrorBlock)callback {
    NSAssert1(servicePlanId != PPServicePlanSoftwareSubscriptionUserPlanIdNone, @"%s missing servicePlanId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"userServicePlans/%li?", (long)servicePlanId];
    
    if(userId) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.cancelSubscription()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Get Store Products

/**
 * Get Store Products.
 * The Store manages links to products that can be purchased through specific apps and web consoles, including options for graphics to display, the order in which to display them, alternative text, links, icons, etc. Link to an external store such as Amazon.com or GoDaddy to execute the purchase of physical goods.
 *
 * @param appName NSString Unique app name to display store products for your specific app
 * @param callback PPPaidServicesProductsCallback Products callback block
 **/
+ (void)getStoreProducts:(NSString *)appName callback:(PPPaidServicesProductsCallback)callback {
    
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"market?"];
    
    if(appName) {
        [requestString appendFormat:@"appName=%@&", appName];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.paidservices.getStoreProducts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *products;
            NSString *affiliateCode;
            
            if(!error) {
                products = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *productDict in [root objectForKey:@"products"]) {
                    PPStoreProduct *product = [PPStoreProduct initWithDictionary:productDict];
                    [products addObject:product];
                }
            
                affiliateCode = [root objectForKey:@"affiliateCode"];
            }
                
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(products, affiliateCode, error);
            });
        });
    } failure:^(NSError *error) {
        PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end

