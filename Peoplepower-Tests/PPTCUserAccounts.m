//
//  PPUserAccounts.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/17/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPUser.h>
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPAppResources.h>
#import <Peoplepower/PPUserAccounts.h>
#import <Peoplepower/PPNSDate.h>

static NSString *moduleName = @"UserAccounts";

@interface PPTCUserAccounts : PPBaseTestCase

@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) PPUser *user;
@property (strong, nonatomic) NSString *userPassword;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPLocationNarrative *narrative;
@property (strong, nonatomic) PPLocationSpace *space;

@end

@implementation PPTCUserAccounts

- (void)setUp {
    [super setUp];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *userDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *narrativeDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_NARRATIVE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *spaceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_LOCATION_SPACE filename:PLIST_FILE_UNIT_TESTS];
    
    self.appName = appName;
    self.user = [PPUser initWithDictionary:userDict];
    self.userPassword = [userDict objectForKey:@"password"];
    self.location = [PPLocation initWithDictionary:locationDict];
    self.narrative = [PPLocationNarrative initWithDictionary:narrativeDict];
    self.space = [PPLocationSpace initWithDictionary:spaceDict];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Manage a user

/**
 * Register a new user and location.
 * When creating a new user, the email address field and appName are mandatory. If the password is not set, the user account will be created, but the user will not be able to login and will have to go throw the password renew process. Although it's not required, we recommend creating a default Location when creating a new User account, to begin grouping Devices by Location and to take advantage of Home / Away settings for that Location.
 * The API returns the registered user ID and a new API key.
 * A new user account can be created by an existing user. In this case the API key must be used. Otherwise an operation token of type 1 must be provided.
 * An operation token must first be gathered to register a new user.
 *
 * @ param username NSString Email being used to register new user.
 * @ param password NSString Password being used to register new user. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX, or for specific appNames SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @ param firstName NSString First name
 * @ param lastName NSString Last name
 * @ param email NSString Email
 * @ param appName NSString App name
 * @ param language NSString Language
 * @ param phone NSString Phone
 * @ param phoneType PPUserPhoneType Phone type
 * @ param anonymous PPUserAnonymousType Anonymous
 * @ param location PPLocation User location
 * @ param operationToken PPOperationToken Operation token
 * @ param callback PPUserRegistrationBlock User registration block containing userId, locationId, API key, and API key expire date
 **/
- (void)testRegisterWithUsername {
    NSString *methodName = @"RegisterWithUsername";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    PPOperationToken *operationToken = [[PPOperationToken alloc] initWithToken:@"__OP_TOKEN__" type:PPOperationTokenTypeUserRegistration validFrom:[NSDate date] expire:[NSDate dateWithTimeIntervalSinceNow:300]];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/user" statusCode:200 headers:nil];
    
    [PPUserAccounts registerWithUsername:self.user.username altUsername:nil password:self.userPassword firstName:self.user.firstName lastName:self.user.lastName email:self.user.email.email appName:self.appName language:self.user.language phone:self.user.phone phoneType:self.user.phoneType anonymous:self.user.anonymous location:self.location operationToken:operationToken callback:^(NSString *userId, NSString *locationId, NSString *APIKey, NSDate *keyExpireDate, NSError *error) {
                                                                   
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:45.0];
}

/**
 * Get user information.
 * Obtain all the information previously stored on this user, user permissions, locations, paid services, badges, organizations membership information, authorization information in 3'rd party applications (Twitter, GreenButton, etc.), list of 3'rd party applications having access to the user account.
 *
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to receive a specific user's account.
 * @ param organizationId PPOrganizationId Organization ID to get user status from a specific organization, including notes and the group the user belongs to.
 * @ param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 **/
- (void)testGetUserInformation {
    NSString *methodName = @"GetUserInformation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/user" statusCode:200 headers:nil];
        
    [PPUserAccounts getUserInformationUserId:PPUserIdNone organizationId:PPOrganizationIdNone callback:^(PPUser *user, NSError *error) {
                                        
        XCTAssertNil(error);
        
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
/**
 * Update user.
 * Upate the user's information. All fields are optional.
 *
 * @ param username NSString Username
 * @ param password NSString Password
 * @ param firstName NSString First name
 * @ param lastName NSString Last name
 * @ param email NSString Email
 * @ param emailResetStatus PPUserEmailStatus Email reset status.
 * @ param language NSString Language
 * @ param phone NSString Phone
 * @ param phoneType PPUserPhoneType as NSNumber. Phone type.
 * @ param anonymous PPUserAnonymousType Anonymous.
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @ param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 */
- (void)testUpdateUser {
    NSString *methodName = @"UpdateUser";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/user" statusCode:200 headers:nil];
    
    [PPUserAccounts updateUsername:self.user.username altUsername:nil password:nil firstName:self.user.firstName lastName:self.user.lastName communityName:nil email:self.user.email.email emailResetStatus:PPUserEmailStatusNone language:self.user.language phone:self.user.phone phoneType:self.user.phoneType anonymous:self.user.anonymous userId:PPUserIdNone callback:^(NSError *error) {
                              
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

/**
 * Delete user.
 * Delete this user and removes all devices attached to the user's account. Any legal agreements the user signed will be retained in the backend.
 *
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @ param callback NSErrorBlock Error callback block
 */
- (void)testDeleteUser {
    NSString *methodName = @"DeleteUser";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/user" statusCode:200 headers:nil];
            
    [PPUserAccounts deleteUser:PPUserIdNone merge:PPUserAccountsMergeNone mergeUserId:PPUserIdNone mergeUserApiKey:nil callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:55.0];
}

- (void)testMergeUser {
    NSString *methodName = @"MergeUser";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/user" statusCode:200 headers:nil];
    
    [PPUserAccounts deleteUser:PPUserIdNone merge:PPUserAccountsMergeTrue mergeUserId:self.user.userId mergeUserApiKey:@"__MERGE_API_KEY__" callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:300.0];
}

#pragma mark - Get user by device

/**
 * Get user by device
 * A gateway or proxy can request some information about an owner. Currently only assigned paid services are returned.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:Using a Device Authentication Token:
 *      PPCAuthorization: esp token="ABC12345"
 *      Using a Streaming Session ID: PPCAuthorization: stream session="DEF67890"
 *
 * @ param proxyId NSString Device ID of the gateway or proxy
 * @ param callback PPUserAccountsServicesBlock Callback method provides PPUser object and optional error
 */
- (void)testGetUserByDevice {
    NSString *methodName = @"GetServicesByDevice";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSString *deviceId = @"__DEVICE_ID__";
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/services", deviceId] statusCode:200 headers:nil];
    
    [PPUserAccounts getServicesByDevice:deviceId authorizationType:PPUserAccountAuthorizationTypeDeviceAuthenticationToken token:@"__AUTH_TOKEN__" sessionId:nil callback:^(NSMutableArray *services, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:30.0];
}

#pragma mark - Get user by email (undocumented)

/**
 * Get users by email
 * Return a list of users that already have an account.  This API is undocumented
 *
 * @ param emails Required NSArray List of emails to check agains
 * @ param sendAsRequest PPUserAccountSendAsRequest Determine if the API should send the list using url query parameters or in the http body
 * @ param callback PPUserAccountsUsersListBlock Callback method provides list of PPUser objects and optional error
 */
- (void)testGetUsersByEmails {
    NSString *methodName = @"GetUserByEmailOrPhone";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/users" statusCode:200 headers:nil];
    
    [PPUserAccounts getUsersByEmails:@[@"test@peoplepowerco.com"] phones:@[@"15555555555"] sendAsRequest:PPUserAccountSendAsRequestNone callback:^(NSArray *users, NSError *error) {
    
        XCTAssertNil(error);
        [expectation fulfill];
    
    }];
    [self waitForExpectations:@[expectation] timeout:30.0];
}

#pragma mark - New Location

/**
 * Add a new Location to an existing user
 *
 * @ param name NSString Location name
 * @ param type PPLocationType Type of location
 * @ param utilityAccountNo NSString Utility account number
 * @ param timezone PPTimezone Timezone for this location
 * @ param addrStreet1 NSString Address - Street 1
 * @ param addrStreet2 NSString Address - Street 2
 * @ param addrCity NSString Address - City
 * @ param state PPState State for this location
 * @ param country PPCountry Country for this location
 * @ param zip NSString Zip / Postal code
 * @ param latitude NSString Latitude for this location
 * @ param longitude NSString Longitude for this location
 * @ param size PPLocationSize Size representing this location
 * @ param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @ param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @ param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @ param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @ param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @ param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @ param heatingType PPLocationHeatingType Heating type for this location
 * @ param coolingType PPLocationCoolingType Cooling type for this location
 * @ param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @ param thermostatType PPLocationThermostatType Thermostat type for this location
 * @ param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testAddNewLocationToExistingUser {
    NSString *methodName = @"AddNewLocationToExistingUser";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/location" statusCode:200 headers:nil];
        
    [PPUserAccounts addNewLocationToExistingUser:self.location.name type:self.location.type utilityAccountNo:self.location.utilityAccountNo timezone:self.location.timezone addrStreet1:self.location.addrStreet1 addrStreet2:self.location.addrStreet2 addrCity:self.location.addrCity state:self.location.state country:self.location.country zip:self.location.zip latitude:self.location.latitude longitude:self.location.longitude size:self.location.size storiesNumber:self.location.storiesNumber roomsNumber:self.location.roomsNumber bathroomsNumber:self.location.bathroomsNumber occupantsNumber:self.location.occupantsNumber occupantsRanges:self.location.occupantsRanges usagePeriod:self.location.usagePeriod heatingType:self.location.heatingType coolingType:self.location.coolingType waterHeaterType:self.location.waterHeaterType thermostatType:self.location.thermostatType fileUploadPolicy:self.location.fileUploadPolicy userId:PPUserIdNone appName:self.appName locationCallback:^(PPLocationId locationId, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Update Location

/**
 * Edit a location.
 * Location ID parameter is required.  All others are optional.
 *
 * @ param locationId PPLocationId Location id
 * @ param name NSString Location name
 * @ param type PPLocationType Type of location
 * @ param utilityAccountNo NSString Utility account number
 * @ param timezone PPTimezone Timezone for this location
 * @ param addrStreet1 NSString Address - Street 1
 * @ param addrStreet2 NSString Address - Street 2
 * @ param addrCity NSString Address - City
 * @ param state PPState State for this location
 * @ param country PPCountry Country for this location
 * @ param zip NSString Zip / Postal code
 * @ param latitude NSString Latitude for this location
 * @ param longitude NSString Longitude for this location
 * @ param size PPLocationSize Size representing this location
 * @ param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @ param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @ param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @ param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @ param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @ param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @ param heatingType PPLocationHeatingType Heating type for this location
 * @ param coolingType PPLocationCoolingType Cooling type for this location
 * @ param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @ param thermostatType PPLocationThermostatType Thermostat type for this location
 * @ param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testEditLocation {
    NSString *methodName = @"EditLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts editLocation:self.location.locationId name:self.location.name type:self.location.type utilityAccountNo:self.location.utilityAccountNo timezone:self.location.timezone addrStreet1:self.location.addrStreet1 addrStreet2:self.location.addrStreet2 addrCity:self.location.addrCity state:self.location.state country:self.location.country zip:self.location.zip latitude:self.location.latitude longitude:self.location.longitude size:self.location.size storiesNumber:self.location.storiesNumber roomsNumber:self.location.roomsNumber bathroomsNumber:self.location.bathroomsNumber occupantsNumber:self.location.occupantsNumber occupantsRanges:self.location.occupantsRanges usagePeriod:self.location.usagePeriod heatingType:self.location.heatingType coolingType:self.location.coolingType waterHeaterType:self.location.waterHeaterType thermostatType:self.location.thermostatType fileUploadPolicy:self.location.fileUploadPolicy callback:^(NSError *error) {
    
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

/**
 * Delete a location.
 * Location ID parameter is required.  All others are optional.
 *
 * @ param locationId PPLocationId Location id
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteLocation {
    NSString *methodName = @"DeleteLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@", @(self.location.locationId)] statusCode:200 headers:nil];
        
    [PPUserAccounts deleteLocation:self.location.locationId callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

#pragma mark - Set Location Scene

/**
 * Change the scene at a location
 * By changing the scene at a location, you may cause user-defined Rules to execute such as "When I am home do something" or "When I am going to sleep turn of the TV".
 * The API returns a list user devices shared with friends and their names. If some devices were shared before and by changing the location scene they are not shared anymore, they will be returned as well.
 *
 * @ param locationId PPLocationId The Location ID for which to trigger an event.
 * @ param eventName NSString Developer-defined name of the scene. For example, 'HOME', 'AWAY', 'SLEEP', 'VACATION', 'FOOSBALL'. You can define any name you want. The name represents some state, and can be fed into Rules and other areas of the app. Presence uses 'HOME', 'AWAY', 'SLEEP', and 'VACATION'.
 * @ param comment NSString Comment on why this event was changed
 * @ param callback PPUserAccountsLocationSceneBlockBlock Scene callback block containing shared and unshared devices
 **/
- (void)testChangeSceneAtLocation {
    NSString *methodName = @"ChangeSceneAtLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSString *eventName = @"__EVENT_NAME__";
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/event/%@", @(self.location.locationId), eventName] statusCode:200 headers:nil];
        
    [PPUserAccounts changeSceneAtLocation:self.location.locationId eventName:eventName comment:@"Some Comment" callback:^(NSArray *sharedDevices, NSArray *stopSharingDevices, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

#pragma mark - Location Scenes

/**
 * Location scenes history
 * Return location change schemes history in backward order (latest first).
 *
 * @ param locationId PPLocationId Location Id for this location
 * @ param startDate NSDate Start date to begin receiving data
 * @ param endDate NSDate End date to stop receiving data. Default is the current date.
 * @ param callback PPUserAccountsLocationSceneBlockHistoryBlock Scene history callback block containing array of events
 **/
- (void)testLocationScenesHistory {
    NSString *methodName = @"LocationScenesHistory";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/events", @(self.location.locationId)] statusCode:200 headers:nil];
        
    [PPUserAccounts locationScenesHistory:self.location.locationId startDate:nil endDate:nil callback:^(NSArray *events, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

#pragma mark - Verify email address or phone number

/**
 * Send a verification message
 * Send an email or an SMS to the user containing a link to a temporary page which is valid for one day and/or a verification code, to verify the email address or if this phone number able to receive SMS. When the user clicks on that link, the email address is marked as verified and the user is forwarded to a success page. If the link is expired, the user is forwarded to an error page.
 * By default the IoT Software Suite will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @ param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @ param appName NSString App name to identify the brand
 * @ param type PPUserEmailVerificationType Message type
 * @ param callback PPErrorBlock Error callback block
 */
- (void)testSendAVerificationMessage {
    NSString *methodName = @"SendAVerificationMessage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/emailVerificationMessage" statusCode:200 headers:nil];
    
    [PPUserAccounts sendAVerificationMessage:nil appName:nil type:PPUserEmailVerificationTypeEmail callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Recover password

/**
 * Recover user's password.
 * By default the IoT Software Suit will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @ param username NSString The username, which is typically the user's email address
 * @ param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @ param appName NSString App name to identify the brand
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testRecoverPassword {
    NSString *methodName = @"RecoverPassword";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/newPassword" statusCode:200 headers:nil];
    
    [PPUserAccounts recoverPassword:self.user.username brand:nil appName:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Put new password.
 * The wb page calls this API to submit a new password
 *
 * @ param password Required NSString New Password
 * @ param tempKey NSString Temporary API key
 * @ param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @ param appName NSString App name to identify the brand
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testNewPassword {
    NSString *methodName = @"NewPassword";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/newPassword" statusCode:200 headers:nil];
    
    
    [PPUserAccounts putNewPassword:@"__NEW_PASSWORD__" oldPassword:@"__OLD_PASSWORD__" passcode:nil tempKey:nil brand:nil appName:nil callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Badges

/**
 * Reset badges
 *
 * @ param type PPUserBadgeType Type of badge being reset.  If none type is provided, all badge counts will be reset.
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testResetBadges {
    NSString *methodName = @"ResetBadges";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/badges" statusCode:200 headers:nil];
    
    [PPUserAccounts resetBadges:PPUserBadgeTypeNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Sign Terms of Service

/**
 * Sign terms of service
 * Adds a unique signature identifier to the list of agreements the user has signed.
 *
 * @ param termsOfServiceId NSString Terms of service ID
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSignTermsOfService {
    NSString *methodName = @"SignTermsOfService";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSString *signatureId = @"tos-123";
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/termsOfServices/%@", signatureId] statusCode:200 headers:nil];
    
    [PPUserAccounts signTermsOfService:signatureId callback:^(NSError *error) {
    
        XCTAssertNil(error);
        [expectation fulfill];
   
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

#pragma mark - Get Terms of Service
/**
 * Get Signatures
 * Retrieve all of the Terms of Service agreement signature identifiers to which the user has previously agreed.
 *
 * @ param callback PPUserAccountTermsOfServiceBlock Terms of Service callback block
 **/
- (void)testGetSignatures {
    NSString *methodName = @"GetSignatures";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/termsOfServices" statusCode:200 headers:nil];
    
    [PPUserAccounts getSignatures:^(NSArray *termsOfServices, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - User Tags

/**
 * Apply tag
 *
 * @ param tag NSString Tag value
 * @ param callback NSErrorBlock Error callback block
 **/
- (void)testApplyTag {
    NSString *methodName = @"ApplyTag";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSString *tag = @"__TAG__";
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/usertags/%@", tag] statusCode:200 headers:nil];
    
    [PPUserAccounts applyTag:tag callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete tag
 *
 * @ param tag NSString Tag value
 * @ param callback NSErrorBlock Error callback block
 **/
- (void)testDeleteTag {
    NSString *methodName = @"DeleteTag";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSString *tag = @"__TAG__";
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/usertags/%@", tag] statusCode:200 headers:nil];
    
    [PPUserAccounts deleteTag:tag callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - User Codes

/**
 * Put user code
 *
 * @ param type Required PPUserCodeType Code type
 * @ param code Required NSString Alphanumeric string of 4 or more characters.  Codes of type Combined are joined using the "+" character.
 * @ param locationId PPLocationId Assign code to a location.  Name is ignored.
 * @ param name NSString Code name.  Ignored when including locationId.
 * @ param callback NSErrorBlock Error callback block
 **/
- (void)testPutUserCode {
    NSString *methodName = @"PutUserCode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/userCodes" statusCode:200 headers:nil];
    
    [PPUserAccounts putUserCode:PPUserCodeTypeManual code:@"12345" locationId:PPLocationIdNone name:@"__MY_CODE__" callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete user code
 * Either name or locationId is required
 *
 * @ param name NSString Code Name
 * @ param locationId PPLocationId LocationId to remove this code from
 * @ param callback NSErrorBlock Error callback block
 **/
- (void)testDeleteUserCode {
    NSString *methodName = @"DeleteUserCode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/userCodes" statusCode:200 headers:nil];
    
    [PPUserAccounts deleteUserCode:@"12345" locationId:PPLocationIdNone callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get user codes
 *
 * @ param callback PPUserAccountsUserCodesBlock Error callback block
 **/
- (void)testGetUserCodes {
    NSString *methodName = @"GetUserCodes";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/userCodes" statusCode:200 headers:nil];
    
    [PPUserAccounts getUserCodes:^(NSArray * _Nullable userCodes, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Coutries, states and time zones

/**
 * Get countries, states and time zones.
 * Return a list of countries currently supported on the IoT Software Suite. The Country ID is used when referencing this country in other API calls.
 *
 * @ param organizationId PPOrganizationId Filter response by the organization ID
 * @ param countryCode NSString Filter response by country codes. You may specify multiple countryCode URL parameters with different values to gather multiple countries data.
 * @ param lang NSString Use for language specific response
 * @ param callback PPUserAccountCountriesStatesAndTimeszonesBlock Countries, States, and Timezones callback block
 **/
- (void)testGetCountries {
    NSString *methodName = @"GetCountries";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/countries" statusCode:200 headers:nil];
    
    [PPUserAccounts getCountries:PPOrganizationIdNone countryCode:nil lang:nil callback:^(PPCountriesStatesAndTimezones *countriesStatesAndTimezones, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Location Users

/**
 * Get location users
 * An owner of a location can assign other existing users to access and manage the location and devices on it and receive notifications related to this location.
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param callback PPUserAccountsUsersListBlock Location users callback block
 **/
- (void)testGetLocationUsers {
    NSString *methodName = @"GetLocationUsers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/users", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts getLocationUsers:self.location.locationId callback:^(NSArray *users, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Add location users
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param users Required NSDictionary Dictionary of users to add. e.g. {"id": 123, "deviceAccess": 10, "locationAccess": 10}
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testAddLocationUsers {
    NSString *methodName = @"AddLocationUsers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/users", @(self.location.locationId)] statusCode:200 headers:nil];
    
    NSDictionary *userDict = @{@"id": @(456), @"locationAccess": @(PPLocationAccessAdmin), @"schedules": @[@{@"daysOfWeek": @(PPRuleCalendarDaysOfWeekMonday), @"startTime": @(0), @"endTime": @(24 * 3660)}]};
    
    [PPUserAccounts addLocationUsers:self.location.locationId users:@[userDict] callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete location user
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param userId Required PPUserId User ID
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteLocationUsers {
    NSString *methodName = @"DeleteLocationUsers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/users", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts deleteLocationUser:self.location.locationId userIds:@[@(456)] callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Location Spaces

/**
 * Get spaces
 * A user can define location zones called spaces.  A space has a type and a name.
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param callback PPUserAccountsLocationSpacesBlock Location spaces callback block
 **/
- (void)testGetSpaces {
    NSString *methodName = @"GetSpaces";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/spaces", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts getLocationSpaces:self.location.locationId callback:^(NSArray *spaces, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Update space
 * Add new or modify existing space.
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param space Required PPLocationSpace Location space to add or modify
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateSpace {
    NSString *methodName = @"UpdateSpace";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/spaces", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts updateLocationSpace:self.location.locationId space:self.space callback:^(PPLocationSpaceId spaceId, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * delete space
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param spaceId Required PPLocationSpaceId Location space id to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteSpace {
    NSString *methodName = @"DeleteSpace";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/location/%@/spaces", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts deleteLocationSpace:self.location.locationId spaceId:self.space.spaceId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Narratives

/**
 * Create/Update a narrative
 * If `narrativeId` and `narrativeTime` parameters are provided then the API updates the narrative with this ID and time. Otherwise a new narrative is created.
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param narrativeId PPLocationNarrativeId ID of narrative to update - required for update
 * @ param narrativeTime PPLocationNarrativeTime Current record narrative time to update - required for update
 * @ param narrative Required PPLocationNarrative Narrative content to put
 * @ param analyticAPIKey Required NSString Analytic/Bot API Key
 * @ param callback PPUserAccountsPutNarrativeBlock Narrative callback block
 **/
- (void)testCreateNarrative {
    NSString *methodName = @"CreateNarrative";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/narratives", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts createOrUpdateNarrative:self.location.locationId narrativeId:PPLocationNarrativeIdNone narrativeTime:PPLocationNarrativeTimeNone narrative:self.narrative analyticAPIKey:@"__ANALYTIC_API_KEY__" callback:^(PPLocationNarrativeId spaceId, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a narrative
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param narrativeId PPLocationNarrativeId ID of narrative to update - required for update
 * @ param narrativeTime PPLocationNarrativeTime Current record narrative time to update - required for update
 * @ param analyticAPIKey Required NSString Analytic/Bot API Key
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteNarrative {
    NSString *methodName = @"CreateNarrative";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/narratives", @(self.location.locationId)] statusCode:200 headers:nil];
        
    [PPUserAccounts deleteNarrative:self.location.locationId narrativeId:self.narrative.narrativeId analyticAPIKey:@"__ANALYTIC_API_KEY__" callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Get narratives
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param narrativeId PPLocationNarrativeId Filter by ID
 * @ param priority PPLocationNarrativePriority Filter by priority higher or equal that that
 * @ param searchBy NSString Filter by keywors (like "Door" - show me any recent events that contained the word Door in the title or description)
 * @ param startDate NSDate Narrative date range start
 * @ param endDate NSDate Narrative date range end
 * @ param rowCount PPLocationNarrativeRowCount Maximum rows number to return
 * @ param analyticAPIKey NSString Analytic/Bot API Key
 * @ param callback PPUserAccountsNarrativesBlock Narratives callback block
 **/
- (void)testGetNarratives {
    NSString *methodName = @"GetNarratives";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/narratives", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts getNarrative:self.location.locationId narrativeId:PPLocationNarrativeIdNone priority:PPLocationNarrativePriorityNone toPriority:PPLocationNarrativePriorityNone searchBy:nil startDate:nil endDate:nil rowCount:(PPLocationNarrativeRowCount)1 pageMarker:nil analyticAPIKey:nil sortOptions:nil callback:^(NSArray *narratives, NSString *nextMarker, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Location Presence
/**
 These APIs determine if a person is physically present nearby one of the location gateways, where the user has read access.
 **/

/**
 * Get Presence IDs
 *
 * Return UUIDs provided by all gateways, where the user has read access.
 *
 * @ param callback PPUserAccountsLocationPresenceBlock Presence IDs callback block
 **/
- (void)testGetPresenceIDs {
    NSString *methodName = @"GetPresenceIDs";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/presence" statusCode:200 headers:nil];
    
    [PPUserAccounts getPresenceIDs:^(NSArray *ibeaconUUIDs, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Authorize Access
 *
 * Authorize access to the location, where the gateway with provided parameters is located.
 *
 * @ param uuid Required NSString UUID string
 * @ param major Required NSString Major string
 * @ param minor Required NSString Minor string
 * @ param callback PPUserAccountsLocationIdBlock Location ID callback block
 **/
- (void)testAuthorizeAccess {
    NSString *methodName = @"AuthorizeAccess";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/presence" statusCode:200 headers:nil];
    
    [PPUserAccounts authorizeAccess:@"ABC123" major:@"123" minor:@"123" callback:^(PPLocationId locationId, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Location States
/**
 * A way for bots to set named location states with flexible JSON object structure.
 **/

/**
 * Set State
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param name Required NSString State name
 * @ param data NSDictionary State information
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSetState {
    NSString *methodName = @"SetState";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/state", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts setState:self.location.locationId name:@"test_state" data:@{@"key": @"value"} overwrite:PPUserAccountsStateOverwriteNone callback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get State
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param name Required NSString State name
 * @ param callback PPUserAccountsStateBlock State callback block
 **/
- (void)testGetState {
    NSString *methodName = @"GetState";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/state", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts getState:self.location.locationId name:@"test_state" callback:^(NSDictionary *data, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get States
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param names Required NSArray Array of state names
 * @ param callback PPUserAccountsStatesBlock State callback block
 **/
- (void)testGetStates {
    NSString *methodName = @"GetStates";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/state", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPUserAccounts getStates:self.location.locationId names:@[@"test_state"] callback:^(NSArray *states, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Set Time State
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param date Required NSDate State date or time value
 * @ param name Required NSString State name
 * @ param overwrite PPUserAccountsStateOverwrite Overwrite the entire state with completely new content
 * @ param data NSDictionary State information
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSetTimeState {
    NSString *methodName = @"SetTimeState";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/timeStates", @(self.location.locationId)] statusCode:200 headers:nil];
        
    [PPUserAccounts setTimeState:self.location.locationId date:[PPNSDate parseDateTime:@"2019-12-01T00:00:00Z"] name:@"test_state" data:@{@"key": @"value"} overwrite:PPUserAccountsStateOverwriteNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Time States
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param startDate Required NSDate Retrun states with dates greater or equal to this value
 * @ param endDate NSDate Return states with dates less than this value. If not set, only states with dates exactly equal to startDate will be returned.
 * @ param names Required NSArray Array of state names
 * @ param callback PPUserAccountsStatesBlock State callback block
 **/
- (void)testGetTimeStates {
    NSString *methodName = @"GetTimeStates";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/timeStates", @(self.location.locationId)] statusCode:200 headers:nil];
        
    [PPUserAccounts getTimeStates:self.location.locationId startDate:[PPNSDate parseDateTime:@"2019-12-01T00:00:00Z"] endDate:nil names:@[@"test_state"] callback:^(NSArray *states, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
