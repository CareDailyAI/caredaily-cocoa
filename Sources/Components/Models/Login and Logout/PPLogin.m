//
//  PPLogin.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPLogin.h"
#import "PPCloudEngine.h"
#import "PPOperationTokenManagement.h"

@implementation PPLogin

#pragma mark - Login

/**
 * Login by username and password or a temporary passcode.
 * Allows a user to login using their private credentials (username and password). This request returns an API key which is linked to the user, and will be used in all future API calls. It is the responsibility of the application developer to securely store, manage, and communicate users' API keys
 *
 * @param username Required NSString The username, typically an email address
 * @param password NSString The password. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX
 * @param passcode NSString The temporary passcode.
 * @param expiry PPUserExpiryType API key expiration period in days, nonzero. By default, this is set to -1, which means the key will never expire.
 * @param appName NSString Short application name to trigger some automatic actions like registrating the user in an organization.  Regex provided by system property SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @param keyType PPLoginKeyType Returned API key type:
 *      0 = Normal user application, default.
 *      1 = Temporary key
 *      11 = Admin key
 *      13 = OAuth 2.0 access token
 *      14 = OAuth 2.0 refresh token
 * @param clientId NSString Short application client ID to generate a specific user API key.
 * @param smsPrefix NSNumber Passcode SMS prefix type to automatically parse it by the app: 1 = Google <#>
 * @param appHash NSString 11-character app hash
 * @param sign NSNumber Set it to true, if an encrypted signature authentication is used.
 * @param signAlgorithm NSString Signature algorithm
 * @param callback PPLoginBlock Callback method provides API key, expire data, and optional error
 **/
+ (void)loginWithUsername:(NSString * _Nonnull )username password:(NSString * _Nullable )password passcode:(NSString * _Nullable )passcode expiry:(PPLoginExpiryType)expiry appName:(NSString * _Nullable )appName keyType:(PPLoginKeyType)keyType clientId:(NSString * _Nullable )clientId smsPrefix:(NSNumber * _Nullable )smsPrefix appHash:(NSString * _Nullable )appHash sign:(NSNumber * _Nullable )sign signAlgorithm:(NSString * _Nullable )signAlgorithm callback:(PPLoginBlock _Nonnull )callback {
    NSAssert1(username != nil, @"%s missing username", __FUNCTION__);
    NSAssert1(password != nil || passcode != nil, @"%s missing password or passcode", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"login"] resolvingAgainstBaseURL:NO];
    
    NSString *cleanedUsername = [[username stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"username" value:cleanedUsername]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"expiry" value:@(expiry).stringValue]];
    if (appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    if (keyType != PPLoginKeyTypeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keyType" value:@(keyType).stringValue]];
    }
    if (clientId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"clientId" value:clientId]];
    }
    if (smsPrefix) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"smsPrefix" value:smsPrefix.stringValue]];
    }
    if (appHash) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appHash" value:appHash]];
    }
    if (sign) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"sign" value:(sign.boolValue) ? @"true" : @"false"]];
    }
    if (signAlgorithm) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"signAlgorithm" value:signAlgorithm]];
    }
    
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    NSString *encodedPassword;
    NSString *encodedPasscode;
    if(password) {
        encodedPassword = [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:password];
    }
    else if(passcode) {
        encodedPasscode = [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:passcode];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(password) {
        [request setValue:encodedPassword forHTTPHeaderField:HTTP_HEADER_PASSWORD];
    }
    else if(passcode) {
        [request setValue:encodedPasscode forHTTPHeaderField:HTTP_HEADER_PASSCODE];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.login.loginWithUsername()", DISPATCH_QUEUE_SERIAL);
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *userKey;
            NSDate *userKeyExpireDate;
            
            if(error) {
                if(error.code == 16) {
                    // Lock our account
                    [PPOperationTokenManagement lockAccount:username root:root];
                    
                    // Handle returning a localized error description of the lock time
                    [PPOperationTokenManagement isAccountLocked:username error:&error];
                    
                    // Explicitly track this error here because it's not tracked inside or PPBaseModel
                    NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:3];
                    [properties setObject:[NSString stringWithFormat:@"%ld", (long)error.code] forKey:@"Code"];
                    if([error.userInfo objectForKey:NSLocalizedDescriptionKey] != nil) {
                        [properties setObject:[error.userInfo objectForKey:NSLocalizedDescriptionKey] forKey:@"Description"];
                    }
                    if([error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey] != nil) {
                        [properties setObject:[error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey] forKey:@"Recovery"];
                    }
                    [properties setObject:NSStringFromClass([self class]) forKey:@"Location"];
                    
                    [PPUserAnalytics track:@"error" properties:properties logLevel:ANALYTICS_LEVEL_INFO];
                }
                
            }
            else {
            
                userKey = [root objectForKey:@"key"];
            
                NSString *userKeyExpireDateString = [root objectForKey:@"keyExpire"];
            
                userKeyExpireDate = [NSDate date];
                if(userKeyExpireDateString != nil) {
                    if(![userKeyExpireDateString isEqualToString:@""]) {
                        userKeyExpireDate = [PPNSDate parseDateTime:userKeyExpireDateString];
                    }
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));

            dispatch_async(dispatch_get_main_queue(), ^{
                callback(userKey, userKeyExpireDate, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password passcode:(NSString *)passcode expiry:(PPLoginExpiryType)expiry appName:(NSString *)appName callback:(PPLoginBlock)callback {
    NSLog(@"%s deprecated. Use +loginWithUsername:password:passcode:expiry:appname:keyType:clientId:smsPrefix:appHash:sign:signAlgorithm:callback:", __FUNCTION__);
    [PPLogin loginWithUsername:username password:password passcode:passcode expiry:expiry appName:appName keyType:PPLoginKeyTypeNone clientId:nil smsPrefix:nil appHash:nil sign:nil signAlgorithm:nil callback:callback];
}
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password expiry:(PPLoginExpiryType)expiry appName:(NSString *)appName callback:(PPLoginBlock)callback {
    NSLog(@"%s deprecated. Use +loginWithUsername:password:passcode:expiry:appname:keyType:clientId:smsPrefix:appHash:sign:signAlgorithm:callback:", __FUNCTION__);
    [PPLogin loginWithUsername:username password:password passcode:nil expiry:expiry appName:appName keyType:PPLoginKeyTypeNone clientId:nil smsPrefix:nil appHash:nil sign:nil signAlgorithm:nil callback:callback];
}

#pragma mark - Passcode

/**
 * Send passcode
 * Send a temporary pass code to a user.
 * Currently it can be send only by SMS, if the user has a valid mobile phone number.
 *
 * @param username Required NSString The username.
 * @param type Required PPLoginNotificationType Notification type: 2 = Email; 3 = SMS
 * @param brand NSString A parameter identifying a customer's specific notification template
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)sendPasscodeWithUsername:(NSString *)username type:(PPLoginNotificationType)type brand:(NSString *)brand appName:(NSString *)appName callback:(PPErrorBlock)callback {
    NSAssert1(username != nil, @"%s missing username", __FUNCTION__);
    NSAssert1(type != PPLoginNotificationTypeNone, @"%s missing type", __FUNCTION__);
    
    NSString *cleanedUsername = [[username stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"passcode"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"username" value:cleanedUsername]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"prefDeliveryType" value:@(type).stringValue]];
    if(brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    if(appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.login.sendPasscode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
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
+ (void)sendPasscodeWithUsername:(NSString *)username type:(PPLoginNotificationType)type callback:(PPErrorBlock)callback {
    [PPLogin sendPasscodeWithUsername:username type:type brand:nil appName:nil callback:callback];
}

#pragma mark - Login with an existing API key

/**
 * Login with an existing API key.
 * This login API allows the user to log in with an existing API key instead of username and password.  It is typically used to check if the API key is valid, and to renew the key if it is going to expire soon.
 * If no key is provided, then this API request can is used to generate a temporary key that is valid for only a brief amount of time.
 *
 * @param key NSString API key
 * @param keyType PPUserKeyType Returned API key type:
 *      0 = Normal user application, default.
 *      1 = Temporary key
 * @param expiry PPUserExpiry API key expiry period in days, nonzero. By default the key will never expire.
 * @param clientId NSString Client or application ID to retrieve a specific key for this client.
 * @param cloudName NSString The third party cloud name, where the API key must be validated.
 * @param callback PPUserLoginBlock Callback method provides API key, expire data, and optional error
 **/
+ (void)loginWithKey:(NSString *)key keyType:(PPLoginKeyType)keyType expiry:(PPLoginExpiryType)expiry clientId:(NSString *)clientId cloudName:(NSString *)cloudName callback:(PPLoginBlock)callback {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"loginByKey"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keyType" value:@(keyType).stringValue]];
    if(expiry) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"expiry" value:@(expiry).stringValue]];
    }
    if(clientId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"clientId" value:clientId]];
    }
    if(cloudName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"cloudName" value:cloudName]];
    }
    components.queryItems = queryItems;
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(key) {
        [request setValue:key forHTTPHeaderField:HTTP_HEADER_API_KEY];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.login.loginWithKey()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *userKey;
            NSDate *userKeyExpireDate;
            
            if(!error) {
            
                userKey = [root objectForKey:@"key"];
                NSString *userKeyExpireDateString = [root objectForKey:@"keyExpire"];
            
                if(userKeyExpireDateString != nil) {
                    if(![userKeyExpireDateString isEqualToString:@""]) {
                        userKeyExpireDate = [PPNSDate parseDateTime:userKeyExpireDateString];
                    }
                }
            }
            
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(userKey, userKeyExpireDate, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Signature Key

/**
Generate a new RSA signature private/public keys pair for the user or upload own RSA public key to the account.Both private and public keys are in Base64 format. The private key is PKCS #8 encoded. The public key must be X.509 formatted.
 */

/** Get Private Key
 * @param appName NSString App name used to store the public key
 * @param callback PPSignatureKeyBlock Private key object.
*/
+ (void)getPrivateKey:(NSString * _Nonnull )appName callback:(PPSignatureKeyBlock _Nonnull )callback {
   
   NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"signatureKey"] resolvingAgainstBaseURL:NO];
   
   NSMutableArray *queryItems = @[].mutableCopy;
   [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
   components.queryItems = queryItems;
   
   dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.login.getPrivateKey()", DISPATCH_QUEUE_SERIAL);
   
   PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
       
   [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
       
       dispatch_async(queue, ^{
           
           NSError *error = nil;
           NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
           
           NSString *privateKey;
           
           if(!error) {
           
               PPLogAPI(@"%s >> %@", __PRETTY_FUNCTION__, root);
               
               privateKey = [root objectForKey:@"privateKey"];
           }
           
           PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
           
           dispatch_async(dispatch_get_main_queue(), ^{
               callback(privateKey, error);
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


/** Put Public Key
 * @param appName NSString App name used to store the public key
 * @param callback PPErrorBlock Error object.
 */

+ (void)putPublicKey:(NSString *)appName publicKey:(NSString *)publicKey callback:(PPErrorBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"signatureKey"] resolvingAgainstBaseURL:NO];
   
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    components.queryItems = queryItems;
    
    NSDictionary *data = @{@"publicKey": publicKey};

    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
   
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
   
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.login.putPublicKey()", DISPATCH_QUEUE_SERIAL);
   
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

@end
