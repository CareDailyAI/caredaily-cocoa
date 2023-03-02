//
//  PPTCLogin.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/15/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPUser.h>
#import <Peoplepower/PPLogin.h>

static NSString *moduleName = @"Login";

@interface PPTCLogin : PPBaseTestCase

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) PPUser *user;


@end

@implementation PPTCLogin

- (void)setUp {
    [super setUp];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSString *brand = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_BRAND filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *userDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER filename:PLIST_FILE_UNIT_TESTS];
    
    self.appName = appName;
    self.brand = brand;
    self.user = [PPUser initWithDictionary:userDict];
    self.password = [userDict objectForKey:@"password"];
}

- (void)tearDown {
    [super tearDown];
}

/**
 * Login by username and password or a temporary passcode.
 * Allows a user to login using their private credentials (username and password). This request returns an API key which is linked to the user, and will be used in all future API calls. It is the responsibility of the application developer to securely store, manage, and communicate users' API keys
 *
 * @ param username Required NSString The username, typically an email address
 * @ param password NSString The password. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX
 * @ param passcode NSString The temporary passcode.
 * @ param expiry PPUserExpiryType API key expiration period in days, nonzero. By default, this is set to -1, which means the key will never expire.
 * @ param appName NSString Short application name to trigger some automatic actions like registrating the user in an organization.  Regex provided by system property SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @ param callback PPUserAccountsLoginBlock Callback method provides API key, expire data, and optional error
 **/
- (void)testLoginWithUsernameAndPassword {
    NSString *methodName = @"LoginWithUsername";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/login" statusCode:200 headers:nil];
    
    [PPLogin loginWithUsername:self.user.username password:self.password passcode:nil expiry:PPLoginExpiryTypeNever appName:self.appName callback:^(NSString *APIKey, NSDate *expireDate, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Send passcode
 * Send a temporary pass code to a user.
 * Currently it can be send only by SMS, if the user has a valid mobile phone number.
 *
 * @ param username Required NSString The username.
 * @ param type Required PPLoginNotificationType Notification type: 2 = SMS
 * @ param brand NSString A parameter identifying a customer's specific notification template
 * @ param appName NSString App name to identify the brand
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSendPasscode {
    NSString *methodName = @"SendPasscode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/passcode" statusCode:200 headers:nil];
    
    [PPLogin sendPasscodeWithUsername:self.user.username type:PPLoginNotificationTypeSMS brand:self.brand appName:self.appName callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Login by username and password or a temporary passcode.
 * Allows a user to login using their private credentials (username and password). This request returns an API key which is linked to the user, and will be used in all future API calls. It is the responsibility of the application developer to securely store, manage, and communicate users' API keys
 *
 * @ param username Required NSString The username, typically an email address
 * @ param password NSString The password. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX
 * @ param passcode NSString The temporary passcode.
 * @ param expiry PPUserExpiryType API key expiration period in days, nonzero. By default, this is set to -1, which means the key will never expire.
 * @ param appName NSString Short application name to trigger some automatic actions like registrating the user in an organization.  Regex provided by system property SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @ param callback PPUserAccountsLoginBlock Callback method provides API key, expire data, and optional error
 **/
- (void)testLoginWithUsernameAndPasscode {
    NSString *methodName = @"LoginWithUsernameAndPasscode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/login" statusCode:200 headers:nil];
    
    [PPLogin loginWithUsername:self.user.username password:nil passcode:@"PASSCD" expiry:PPLoginExpiryTypeNever appName:self.appName callback:^(NSString *APIKey, NSDate *expireDate, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Login with an existing API key.
 * This login API allows the user to log in with an existing API key instead of username and password.  It is typically used to check if the API key is valid, and to renew the key if it is going to expire soon.
 * If no key is provided, then this API request can is used to generate a temporary key that is valid for only a brief amount of time.
 *
 * @ param key NSString API key
 * @ param keyType PPUserKeyType Returned API key type:
 *      0 = Normal user application, default.
 *      1 = Temporary key
 * @ param expiry PPUserExpiry API key expiry period in days, nonzero. By default the key will never expire.
 * @ param clientId NSString Client or application ID to retrieve a specific key for this client.
 * @ param cloudName NSString The third party cloud name, where the API key must be validated.
 * @ param callback PPUserLoginBlock Callback method provides API key, expire data, and optional error
 **/
- (void)testLoginWithKey {
    NSString *methodName = @"LoginWithKey";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/loginByKey" statusCode:200 headers:nil];
       
    [PPLogin loginWithKey:self.user.sessionKey keyType:PPLoginKeyTypeTempKey expiry:PPLoginExpiryTypeNever clientId:nil cloudName:nil callback:^(NSString *APIKey, NSDate *expireDate, NSError *error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testGetPrivateKey {
    NSString *methodName = @"GetPrivateKey";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/signatureKey" statusCode:200 headers:nil];
       
    [PPLogin getPrivateKey:@"" callback:^(NSString * _Nullable privateKey, NSError * _Nullable error) {
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testPutPublicKey {
    NSString *methodName = @"PutPublicKey";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/signatureKey" statusCode:200 headers:nil];
       
    [PPLogin putPublicKey:@"" publicKey:@"" callback:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
