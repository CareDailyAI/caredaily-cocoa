//
//  PPTCCloudsIntegration.m
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 2/13/20.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPCloudsIntegration.h>

static NSString *moduleName = @"CloudsIntegration";

@interface PPTCCloudsIntegration : PPBaseTestCase

@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPDevice *device;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *tempKey;
@property (nonatomic) PPCloudsIntegrationClientApplicationId clientApplicationId;
@property (strong, nonatomic) NSString *clientId;

@end

@implementation PPTCCloudsIntegration

- (void)setUp {
    [super setUp];
    
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *deviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    NSString *brand = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_BRAND filename:PLIST_FILE_UNIT_TESTS];
    PPCloudsIntegrationClientApplicationId clientApplicationId = (PPCloudsIntegrationClientApplicationId)((NSNumber *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_OAUTH_CLIENT_APPLICATION_ID filename:PLIST_FILE_UNIT_TESTS]).integerValue;
    NSString *clientId = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_OAUTH_HOST_CLIENT_ID filename:PLIST_FILE_UNIT_TESTS];
    
    self.location = [PPLocation initWithDictionary:locationDict];
    self.device = [PPDevice initWithDictionary:deviceDict];
    self.brand = brand;
    self.tempKey = @"_API_KEY_";
    self.clientApplicationId = clientApplicationId;
    self.clientId = clientId;
}

- (void)tearDown {
    [super tearDown];
}

/**
 * Get third-party clouds.
 * This API returns a list of supported third-party clouds/applications, where a user may obtain authorization.
 *
 * @ params callback PPCloudsIntegrationCloudsCallback callback Clouds callback block
 **/
- (void)testGetThirdPartyClouds {
    NSString *methodName = @"GetThirdPartyClouds";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/authorize" statusCode:200 headers:nil];
    
    [PPCloudsIntegration getThirdPartyClouds:^(NSMutableArray *applications, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Access a third-party application

/**
 * Access a third-party application.
 * This URL is meant to be loaded in a web view. It will redirect a user to the third party application web page for authenticating and authorizing access to user's data in the external application. Today, this API is called for OAuth2 on Twitter. After completing the operation, the user will be redirected back to a completion web page provided by the IoT Software Suite.
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Application ID
 * @ param locationId Required PPLocationId Location ID where the 3'rd party devices and services will be linked
 * @ param apiKey Required NSString Temporary API key for web page redirect
 * @ param scope NSString OAuth2 scope
 * @ param brand NSString Force forwarding user to a specific branded page.  If not set, the current user brand will be used.
 *
 * @ return NSURL Client auth authentication URL
 **/
- (void)testAccessThirdPartyCloud {
    
    NSURL *url = [PPCloudsIntegration accessThirdPartyCloud:self.clientApplicationId locationId:self.location.locationId apiKey:self.tempKey scope:nil brand:nil];
    
    XCTAssertNotNil(url);
}

#pragma mark - Revoke access to a third-party cloud

/**
 * Revoke access to a third-pary cloud.
 * The user may revoke authorization for the IoT Software Suite to access the user's data on a third-party host. This operation will delete all corresponding access and refresh tokens.
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Application ID
 * @ param locationId Required PPLocationId Location ID to revoke access
 * @ param userId PPUserId Administrators may revoke access to third-pary hosts on behalf of the user
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testRevokeAccessToThirdPartyCloud {
    NSString *methodName = @"RevokeAccessToThirdPartyCloud";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/authorize/%@", @(self.clientApplicationId)] statusCode:200 headers:nil];
    
    [PPCloudsIntegration revokeAccessToThirdPartyCloud:self.clientApplicationId locationId:self.location.locationId userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Authorize a third-party application

/**
 * Authorize a third-party application
 * Begin the process of authorizing a third-party application (the client) to access the user's data. The client has to redirect the user to this HTTP GET URL. The request will be processed in the following steps:
 *      1 - The user is redirected to the Presence login web page, where he or she has to enter his or her username and password.
 *      2 - After successful authentication, the user is redirected to the approval page, where he or she has to allow or deny the client access to data.
 *      3 - From the approval page, the user is redirected to the IoT Software Suite approval URL.
 *      4 - The IoT Software Suite redirects the user to the third-party callback URL with an authorization or error code.
 * Each client has to be registered in Presence before requesting authorization. The registration information includes the client ID, secret, and the callback URL.
 * At the end of this process, the user will be redirected to the callback URL (HTTP Status Code 303, see Other) with the following query parameters:
 *      Parameter   Description     Details
 *      state       string          The same client state value as the input parameter
 *      code        string          The authorization code, if the process was successful
 *      error       string          The authorization error code, if the process was unsuccessful.
 * The application has to GET the Access Token with a separate API call to access data from the IoT Software Suite.
 * You may find the list of authorized third-party apps in the /user GET information API.
 *
 * @ param brand Required NSString Brand
 * @ param clientId Required NSString OAuth Client ID
 * @ param responseType Required NSString OAuth 2 response type. The "code" response type is the only one currently supported.
 * @ param state NSString The clients state which will be returned in the callback URL
 *
 * @ return NSURL Host authorization URL
 **/
- (void)testAuthorizeThirdPartyApplication {
    
    NSURL *url = [PPCloudsIntegration authorizeThirdPartyApplication:self.brand clientId:self.clientId responseType:OAUTH_HOST_RESPONSE_TYPE_CODE state:nil];
    
    XCTAssertNotNil(url);
}

#pragma mark - Approve or Deny Authorization

/**
 * Approve or Deny Authorization.
 * Allow a user to approve or deny an authorization request from the third-party application. The user will be redirected to the external application web page.
 *
 * @ param approved Required PPCloudsIntegrationHostApproved True - The third-party app is approved, False - The third-party app is not approved
 * @ param clientId Required NSString The third-party client identifier
 * @ param state NSString The third-party client state
 * @ param responseType Required NSString The OAuth 2 response type. The "code" response type is the only one currently supported.
 * @ param apiKey Required NSString a temporary user API key
 * @ param brand NSString Brand
 *
 * @ return NSURL Host authorization approval URL
 **/
- (void)testApproveOrDenyAuthorization {
    
    NSURL *url = [PPCloudsIntegration approveOrDenyAuthorization:PPCloudsIntegrationHostApprovedTrue clientId:self.clientId state:@"asdf" responseType:OAUTH_HOST_RESPONSE_TYPE_CODE apiKey:self.tempKey brand:self.brand];
    
    XCTAssertNotNil(url);
}

#pragma mark - Get Access Token

/**
 * Get Access Token.
 * This API uses an authorization code or a previously generated refresh token to grant new access to the IoT Software Suite. It returns a new access token, a token type, expiration time, and a refresh token.
 * Then the received Access Token may be used instead of the user's API key to access data from the user's account.
 * The API requires the third party client ID and secret are separated by a single colon (":") character, within a Base64 encoded string and the "Basic " prefix as described in http://tools.ietf.org/html/rfc2617#section-2 to be sent in the Authorization header. For example:
 *      Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==
 * All parameters should be sent in the "application/x-www-form-urlencoded" format. However query parameters are supported as well.
 * The grant_type parameter is not used, when the authorization code or refresh token are provided, otherwise only "client_credentials" is supported.
 * If an error occurs, an "error_code" and "error_description" will be returned. Error codes include:
 *      - unauthorized_client - Invalid authorization header
 *      - invalid_request - Missing input parameters
 *      - invalid_client - The Client ID or Secret is invalid
 *      - invalid_token - The authorization code or refresh token is incorrect
 *      - server_error - Internal server error
 *
 * @ param code NSString The authorization code
 * @ param refreshToken NSString A refresh token previously received from getting an access token with an authorization code
 * @ param clientId NSString The client ID, if not encoded in the Authorization header or body
 * @ param clientSecret NSString The client secret, if not encoded in the Authorization header or body
 * @ param grantType NSString Grant type.  Not used when the authorization code or refresh token are provided. Otherwise only "client_credentials" is supported.
 * @ param callback PPCloudsIntegrationHostAccessTokenBlock Host access token callback block
 **/
- (void)testGetAccessToken {
    NSString *methodName = @"GetAccessToken";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/oauth/token" statusCode:200 headers:nil];
    
    [PPCloudsIntegration getAccessToken:nil refreshToken:nil clientId:self.clientId clientSecret:nil grantType:nil callback:^(PPCloudsIntegrationHostAccessToken *accessToken, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark Manage OAuth Clients

/**
 * Update OAuth Clients.
 *
 * @ param clientId Required NSString The Client ID to revoke
 * @ param deviceIds NSArray Array of device ids to associate the client with
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateOAuthClient {
    NSString *methodName = @"UpdateOAuthClient";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/authClient" statusCode:200 headers:nil];
    
    [PPCloudsIntegration updateOAuthClient:self.clientId locationId:self.location.locationId deviceIds:@[self.device.deviceId] callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Revoke OAuth Clients.
 * The user may revoke authorization for a third-party to access the user's data on the IoT Software Suite. This operation will delete all corresponding access and refresh tokens.
 *
 * @ param clientId Required NSString The Client ID to revoke
 * @ param userId PPUserId Administrators may revoke access to third-party clients on behalf of a user
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testRevokeOAuthClient {
    NSString *methodName = @"RevokeOAuthClient";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/authClient" statusCode:200 headers:nil];
    
    [PPCloudsIntegration revokeOAuthClient:self.clientId userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark Cloud integration microservices configuration
/**
 * Developers can create, test and submit for approval their versions of third party cloud integration microservices for specific Application ID, but only one published version can exist for each Application ID.
 * It is a responsibility of a system administrator to review, reject, or accept (publish) the versions of the microservice code.
 * Administrator can replace the currently published version by a newest version submitted by the same or other developer.
 * Microservice configuration includes the memory size, timeout, dataAccess, and description (version number and what's new).
 *
 * Memory Size
 * The amount of memory, in MB, required for your microservice code. The execution environment uses this memory size to infer the amount of CPU and memory allocated to the function registered for your microservice code.
 * Important note: AWS Lambda uses this memory size in pricing calculations.
 * The default value is 128 MB. The value must be a multiple of 64 MB, between 128 and 1536.
 *
 * Timeout
 * The execution time, in seconds, at which the code execution service (AWS Lambda) should terminate the microservice function.
 * Important note: Because the execution time has cost implications, it's recommended to set this value based on the expected execution time.
 * The default value is 10. The maximum value is 300 seconds.
 **/

/**
 * Create or update version
 *
 * If there was no development version for specified Cloud application ID and current user ID, it will be created.
 * Administrator can update the development version of any user.
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @ param userId PPUserId Specifc developer ID, for administrators only
 * @ param version Required PPBotengineAppVersion Version
 * @ param callback PPErrorBlock Error callback block;
 **/
- (void)_testCreateOrUpdateVersion {}

#pragma mark Upload Source Code
/**
 * Source code is uploaded as a TAR archive. The TAR archive contains the .py files. The archive may contain file 'structure.json' containing names of packages to install.
 * The microservice source code will be compiled inside a Docker container, and the compiled code will be deployed to the AWS Lambda.
 *
 * Runtime Type
 * Developer should specify the 'runtime' parameter that points to execution environment for their code (version of Python or other programming language).
 * Runtime      Execution environment
 * 1            Python 2.7
 * 2            Python 3.6
 * 3            Node.js 4.3
 **/

/**
 * Upload Code
 *
 * Compilation and deployment may take time. Developer can check the result code using the Get Version History API.
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @ param runtime Required PPCloudsIntegrationCloudMicroServiceRuntime Specified execution environment
 * @ param source Required NSData Binary .tar file containing the microservce source files
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_testUploadCode {}

#pragma mark Version Status
/**
 * Version Status Transition Diagram
 * Description      Current     Upload Source   Submit for      Developer   Admin:          Admin:      Admin:
                    Status      Code            Review          Rejected    Under review    Rejected    Accepted
 * Development      1           1               2               X           X               X           X
 * Submitted for
 *  Review          2           X               X               6           3               X           X
 * Under Review     3           X               X               6           X               8           4 (new version)
 * Published        4           X               X               X           X               X           7 (last version)
 * Admin Rejected   5           1               X               X           X               X           X
 * Developer
 * Rejected         6           1               X               X           X               X           X
 * Replaced by a
 * newer version    7           X               X               X           X               X           X
 **/

/**
 * Upload Version Status
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @ param status Required PPCloudsIntegrationCloudMicroServiceVersionStatus New version status
 * @ param userId PPUserId Specifc developer ID, for administrators only
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_testUpdateVersionStatus {}

#pragma mark Version History

/** Get Versions
 *
 * Developer can get a list of versions of the microservice, created by them for a specific cloud application ID.
 * Administrators can get a list of versions created by any developer for any cloud application ID.
 *
 * @ param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @ param status Required PPCloudsIntegrationCloudMicroServiceVersionStatus New version status
 * @ param userId PPUserId Specifc developer ID, for administrators only
 * @ param callback PPCloudsIntegrationMicroServiceVersionsCallback MicroService versions callback block
 **/
- (void)_testGetVersions {}

@end
