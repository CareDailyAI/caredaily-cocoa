//
//  PPCloudsIntegration.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// OAuth 2.0 Client
// OAuth 2.0 allows the IoT Software Suite to act as a client or a host for a third-party clouds.
// As a client, the IoT Software Suite may obtain authorizations from third-party clouds and applications such as Twitter or Green Button to access user data.
// As a host, the IoT Software Suite provides authorization information to third party applications using the OAuth 2.0 open standard.
//

#import "PPBaseModel.h"
#import "PPCloudsIntegrationCloud.h"
#import "PPCloudsIntegrationClient.h"
#import "PPCloudsIntegrationHost.h"
#import "PPCloudsIntegrationHostAccessToken.h"
#import "PPUser.h"

typedef void (^PPCloudsIntegrationCloudsCallback)(NSMutableArray * _Nullable clouds, NSError * _Nullable error);
typedef void (^PPCloudsIntegrationHostAccessTokenBlock)(PPCloudsIntegrationHostAccessToken * _Nullable accessToken, NSError * _Nullable error);
typedef void (^PPCloudsIntegrationMicroServiceVersionsCallback)(NSMutableArray * _Nullable versions, NSError * _Nullable error);

@interface PPCloudsIntegration : PPBaseModel

#pragma mark - Session Management

/**
 * Shared clouds across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedCloudsForUser:(PPUserId)userId;

/**
 * Add clouds.
 * Add clouds to local reference.
 *
 * @param clouds NSArray Array of clients to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addClouds:(NSArray *)clouds userId:(PPUserId)userId;

/**
 * Remove clouds.
 * Remove clouds from local reference.
 *
 * @param clouds NSArray Array of clouds to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeClouds:(NSArray *)clouds userId:(PPUserId)userId;

#pragma mark - Supported third-party clouds

/**
 * Get third-party clouds.
 * This API returns a list of supported third-party clouds/applications, where a user may obtain authorization.
 *
 * @params callback PPCloudsIntegrationCloudsCallback callback Clouds callback block
 **/
+ (void)getThirdPartyClouds:(PPCloudsIntegrationCloudsCallback _Nonnull )callback;
+ (void)getOAuthClients:(PPCloudsIntegrationCloudsCallback _Nonnull )callback __attribute__((deprecated));

#pragma mark - Access a third-party application

/**
 * Access a third-party application.
 * This URL is meant to be loaded in a web view. It will redirect a user to the third party application web page for authenticating and authorizing access to user's data in the external application. Today, this API is called for OAuth2 on Twitter. After completing the operation, the user will be redirected back to a completion web page provided by the IoT Software Suite.
 *
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Application ID
 * @param locationId Required PPLocationId Location ID where the 3'rd party devices and services will be linked
 * @param apiKey Required NSString Temporary API key for web page redirect
 * @param scope NSString OAuth2 scope
 * @param brand NSString Force forwarding user to a specific branded page.  If not set, the current user brand will be used.
 *
 * @return NSURL Client auth authentication URL
 **/
+ (NSURL * _Nonnull )accessThirdPartyCloud:(PPCloudsIntegrationClientApplicationId)applicationId locationId:(PPLocationId)locationId apiKey:(NSString * _Nonnull )apiKey scope:(NSString * _Nullable )scope brand:(NSString * _Nullable )brand;
+ (NSURL * _Nonnull )OAuthClientAuthorizeURL:(PPCloudsIntegrationClientApplicationId)applicationId apiKey:(NSString * _Nonnull )apiKey scope:(NSString * _Nullable )scope brand:(NSString * _Nullable )brand __attribute__((deprecated));

#pragma mark - Revoke access to a third-party cloud

/**
 * Revoke access to a third-pary cloud.
 * The user may revoke authorization for the IoT Software Suite to access the user's data on a third-party host. This operation will delete all corresponding access and refresh tokens.
 *
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Application ID
 * @param locationId Required PPLocationId Location ID to revoke access
 * @param userId PPUserId Administrators may revoke access to third-pary hosts on behalf of the user
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)revokeAccessToThirdPartyCloud:(PPCloudsIntegrationClientApplicationId)applicationId locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)revokeAccessToOAuthClientHost:(PPCloudsIntegrationClientApplicationId)applicationId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

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
 * @param brand Required NSString Brand
 * @param clientId Required NSString OAuth Client ID
 * @param responseType Required NSString OAuth 2 response type. The "code" response type is the only one currently supported.
 * @param state NSString The clients state which will be returned in the callback URL
 *
 * @return NSURL Host authorization URL
 **/
+ (NSURL * _Nonnull )authorizeThirdPartyApplication:(NSString * _Nonnull )brand clientId:(NSString * _Nonnull )clientId responseType:(NSString * _Nonnull )responseType state:(NSString * _Nullable )state;
+ (NSURL * _Nonnull )OAuthHostAuthorizationURL:(NSString * _Nonnull )brand clientId:(NSString * _Nonnull )clientId responseType:(NSString * _Nonnull )responseType state:(NSString * _Nullable )state __attribute__((deprecated));

#pragma mark - Approve or Deny Authorization

/**
 * Approve or Deny Authorization.
 * Allow a user to approve or deny an authorization request from the third-party application. The user will be redirected to the external application web page.
 *
 * @param approved Required PPCloudsIntegrationHostApproved True - The third-party app is approved, False - The third-party app is not approved
 * @param clientId Required NSString The third-party client identifier
 * @param state NSString The third-party client state
 * @param responseType Required NSString The OAuth 2 response type. The "code" response type is the only one currently supported.
 * @param apiKey Required NSString a temporary user API key
 * @param brand NSString Brand
 *
 * @return NSURL Host authorization approval URL
 **/
+ (NSURL * _Nonnull )approveOrDenyAuthorization:(PPCloudsIntegrationHostApproved)approved clientId:(NSString * _Nonnull )clientId state:(NSString * _Nullable )state responseType:(NSString * _Nonnull )responseType apiKey:(NSString * _Nonnull )apiKey brand:(NSString * _Nullable )brand;
+ (NSURL * _Nonnull )OAuthHostAuthorizationApprovalURL:(PPCloudsIntegrationHostApproved)approved clientId:(NSString * _Nonnull )clientId state:(NSString * _Nullable )state responseType:(NSString * _Nonnull )responseType apiKey:(NSString * _Nonnull )apiKey brand:(NSString * _Nullable )brand __attribute__((deprecated));

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
 * @param code NSString The authorization code
 * @param refreshToken NSString A refresh token previously received from getting an access token with an authorization code
 * @param clientId NSString The client ID, if not encoded in the Authorization header or body
 * @param clientSecret NSString The client secret, if not encoded in the Authorization header or body
 * @param grantType NSString Grant type.  Not used when the authorization code or refresh token are provided. Otherwise only "client_credentials" is supported.
 * @param callback PPCloudsIntegrationHostAccessTokenBlock Host access token callback block
 **/
+ (void)getAccessToken:(NSString * _Nullable )code refreshToken:(NSString * _Nullable )refreshToken clientId:(NSString * _Nullable )clientId clientSecret:(NSString * _Nullable )clientSecret grantType:(NSString * _Nullable )grantType callback:(PPCloudsIntegrationHostAccessTokenBlock _Nonnull )callback;

#pragma mark Manage OAuth Clients

/**
 * Update OAuth Clients.
 *
 * @param clientId Required NSString The Client ID to revoke
 * @param locationId Required PPLocationId Access to devices on specific location
 * @param deviceIds NSArray Array of device ids to associate the client with
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateOAuthClient:(NSString * _Nonnull )clientId locationId:(PPLocationId)locationId deviceIds:(NSArray * _Nullable )deviceIds callback:(PPErrorBlock _Nonnull )callback;
+ (void)updateOAuthClient:(NSString * _Nonnull )clientId deviceIds:(NSArray * _Nullable )deviceIds callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Revoke OAuth Clients.
 * The user may revoke authorization for a third-party to access the user's data on the IoT Software Suite. This operation will delete all corresponding access and refresh tokens.
 *
 * @param clientId Required NSString The Client ID to revoke
 * @param userId PPUserId Administrators may revoke access to third-party clients on behalf of a user
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)revokeOAuthClient:(NSString * _Nonnull )clientId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;

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
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @param userId PPUserId Specifc developer ID, for administrators only
 * @param version Required PPBotengineAppVersion Version
 * @param callback PPErrorBlock Error callback block;
 **/
+ (void)createOrUpdateVersion:(PPCloudsIntegrationClientApplicationId)applicationId userId:(PPUserId)userId version:(PPBotengineAppVersion * _Nonnull )version callback:(PPErrorBlock _Nonnull )callback;

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
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @param runtime Required PPCloudsIntegrationCloudMicroServiceRuntime Specified execution environment
 * @param source Required NSData Binary .tar file containing the microservce source files
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadCode:(PPCloudsIntegrationClientApplicationId)applicationId runtime:(PPCloudsIntegrationClientApplicationId)runtime source:(NSData * _Nonnull )source callback:(PPErrorBlock _Nonnull )callback;

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
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @param status Required PPCloudsIntegrationCloudMicroServiceVersionStatus New version status
 * @param userId PPUserId Specifc developer ID, for administrators only
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateVersionStatus:(PPCloudsIntegrationClientApplicationId)applicationId status:(PPCloudsIntegrationCloudMicroServiceVersionStatus)status userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark Version History

/** Get Versions
 *
 * Developer can get a list of versions of the microservice, created by them for a specific cloud application ID.
 * Administrators can get a list of versions created by any developer for any cloud application ID.
 *
 * @param applicationId Required PPCloudsIntegrationClientApplicationId Cloud application ID
 * @param status Required PPCloudsIntegrationCloudMicroServiceVersionStatus New version status
 * @param userId PPUserId Specifc developer ID, for administrators only
 * @param callback PPCloudsIntegrationMicroServiceVersionsCallback MicroService versions callback block
 **/
+ (void)getVersions:(PPCloudsIntegrationClientApplicationId)applicationId status:(PPCloudsIntegrationCloudMicroServiceVersionStatus)status userId:(PPUserId)userId callback:(PPCloudsIntegrationMicroServiceVersionsCallback _Nonnull )callback;

@end
