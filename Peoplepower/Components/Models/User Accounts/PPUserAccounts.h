//
//  PPUserAccounts.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPLocation.h"
#import "PPLocationUser.h"
#import "PPLocationSpace.h"
#import "PPUserBadge.h"
#import "PPUserTag.h"
#import "PPUserCode.h"
#import "PPUserService.h"
#import "PPOperationToken.h"
#import "PPOrganization.h"
#import "PPLocationNarrative.h"

@class PPUser;
@class PPOperationToken;

typedef void (^PPUserAccountsBlock)(PPUser * _Nullable user, NSError * _Nullable error);
typedef void (^PPUserAccountsServicesBlock)(NSMutableArray * _Nullable services, NSError * _Nullable error);
typedef void (^PPUserAccountsUsersListBlock)(NSArray * _Nullable users, NSError * _Nullable error);
typedef void (^PPUserAccountsRegistrationBlock)(NSString * _Nullable userId, NSString * _Nullable locationId, NSString * _Nullable APIKey, NSDate * _Nullable keyExpireDate, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSceneBlockBlock)(NSArray * _Nullable sharedDevices, NSArray * _Nullable stopSharingDevices, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSceneBlockHistoryBlock)(NSArray * _Nullable events, NSError * _Nullable error);
typedef void (^PPUserAccountTermsOfServiceBlock)(NSArray * _Nullable termsOfServices, NSError * _Nullable error);
typedef void (^PPUserAccountCountriesStatesAndTimeszonesBlock)(PPCountriesStatesAndTimezones * _Nullable countriesStatesAndTimezones, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSpacesBlock)(NSArray * _Nullable spaces, NSError * _Nullable error);
typedef void (^PPUserAccountsUpdateLocationSpacesBlock)(PPLocationSpaceId spaceId, NSError * _Nullable error);
typedef void (^PPUserAccountsPutNarrativeBlock)(PPLocationNarrativeId spaceId, NSError * _Nullable error);
typedef void (^PPUserAccountsNarrativesBlock)(NSArray * _Nullable narratives, NSString * _Nullable nextMarker, NSError * _Nullable error);
typedef void (^PPUserAccountsAddLocationBlock)(PPLocationId locationId, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationPresenceBlock)(NSArray * _Nullable ibeaconUUIDs, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationIdBlock)(PPLocationId locationId, NSError * _Nullable error);
typedef void (^PPUserAccountsStateBlock)(NSDictionary * _Nullable data, NSError * _Nullable error);
typedef void (^PPUserAccountsStatesBlock)(NSArray * _Nullable states, NSError * _Nullable error);
typedef void (^PPUserAccountsUserCodesBlock)(NSArray * _Nullable userCodes, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPUserAccountAuthorizationType) {
    PPUserAccountAuthorizationTypeNone = -1,
    PPUserAccountAuthorizationTypeDeviceAuthenticationToken = 0,
    PPUserAccountAuthorizationTypeStreamingSessionId = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountSendAsRequest) {
    PPUserAccountSendAsRequestNone = -1,
    PPUserAccountSendAsRequestFalse = 0,
    PPUserAccountSendAsRequestTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountsMerge) {
    PPUserAccountsMergeNone = -1,
    PPUserAccountsMergeFalse = 0,
    PPUserAccountsMergeTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountsStateOverwrite) {
    PPUserAccountsStateOverwriteNone = -1,
    PPUserAccountsStateOverwriteFalse = 0,
    PPUserAccountsStateOverwriteTrue = 1
};

@interface PPUserAccounts : PPBaseModel

#pragma mark - Session Management

#pragma mark Users

/**
 * Shared users across the entire application
 */
+ (NSArray *)sharedUsers;

/**
 * Initialie shared users
 **/
+ (void)initializeSharedUsers;

/**
 * Current active user
 */
+ (PPUser *)currentUser;

/**
 * Switch to active user.
 *
 * @param user PPUser User to switch to
 **/
+ (void)switchUser:(PPUser *)user;

/**
 * Sign out users locally.
 * Does not log users out.  API keys will remain active on other devices.
 *
 * @param users NSArray Array of users to sign out.
 **/
+ (void)signOut:(NSArray *)users;

#pragma mark Location Scenes History

/**
 * Shared location scene history across the entire application
 *
 * @param locationId PPLocationId History of scenes for a given location
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedSceneHistoryForLocation:(PPLocationId)locationId userId:(PPUserId)userId;

/**
 * Add location scene history.
 * Add location scene history to local reference.
 *
 * @param locationSceneHistory NSArray Array of location scene history to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addLocationSceneHistory:(NSArray *)locationSceneHistory userId:(PPUserId)userId;

/**
 * Remove location scene history.
 * Remove location scene history from local reference.
 *
 * @param locationSceneHistory scene history NSArray Array of location scene history to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeLocationSceneHistory:(NSArray *)locationSceneHistory userId:(PPUserId)userId;

#pragma mark Countries, States and Timezones

/**
 * Shared Countries across the entire application
 */
+ (PPCountriesStatesAndTimezones *)sharedCountriesStatesAndTimezonesForUser:(PPUserId)userId;

/**
 * Add countries.
 * Add countries to local reference.
 *
 * @param countries PPCountriesStatesAndTimezones Countries object to add.
 * @param userId Required PPUserId User Id to associate these countries with
 **/
+ (void)addCountries:(PPCountriesStatesAndTimezones *)countries userId:(PPUserId)userId;

/**
 * Remove countries.
 * Remove countries from local reference.
 *
 * @param userId Required PPUserId User Id to associate these countries with
 **/
+ (void)removeCountriesForUserId:(PPUserId)userId;

#pragma mark - Manage a user

/**
 * Register a new user and location.
 * When creating a new user, the email address field and appName are mandatory. If the password is not set, the user account will be created, but the user will not be able to login and will have to go throw the password renew process. Although it's not required, we recommend creating a default Location when creating a new User account, to begin grouping Devices by Location and to take advantage of Home / Away settings for that Location.
 * The API returns the registered user ID and a new API key.
 * A new user account can be created by an existing user. In this case the API key must be used. Otherwise an operation token of type 1 must be provided.
 * An operation token must first be gathered to register a new user.
 *
 * @param username NSString Username being used to register new user.
 * @param altUsername NSString Alternate username
 * @param password NSString Password being used to register new user. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX, or for specific appNames SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @param firstName NSString First name
 * @param lastName NSString Last name
 * @param email NSString Email
 * @param appName NSString App name
 * @param language NSString Language
 * @param phone NSString Phone
 * @param phoneType PPUserPhoneType Phone type
 * @param anonymous PPUserAnonymousType Anonymous
 * @param location PPLocation User location
 * @param operationToken PPOperationToken Operation token
 * @param callback PPUserRegistrationBlock User registration block containing userId, locationId, API key, and API key expire date
 **/
+ (void)registerWithUsername:(NSString * _Nullable )username altUsername:(NSString * _Nullable )altUsername password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName email:(NSString * _Nullable )email appName:(NSString * _Nullable )appName language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous location:(PPLocation * _Nullable )location operationToken:(PPOperationToken * _Nullable )operationToken callback:(PPUserAccountsRegistrationBlock _Nonnull )callback;
+ (void)registerWithUsername:(NSString * _Nullable )username password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName email:(NSString * _Nullable )email appName:(NSString * _Nullable )appName language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous location:(PPLocation * _Nullable )location operationToken:(PPOperationToken * _Nullable )operationToken callback:(PPUserAccountsRegistrationBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Get user information.
 * Obtain all the information previously stored on this user, user permissions, locations, paid services, badges, organizations membership information, authorization information in 3'rd party applications (Twitter, GreenButton, etc.), list of 3'rd party applications having access to the user account.
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to receive a specific user's account.
 * @param organizationId PPOrganizationId Organization ID to get user status from a specific organization, including notes and the group the user belongs to.
 * @param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 **/
+ (void)getUserInformationUserId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId callback:(PPUserAccountsBlock _Nonnull )callback;

/**
 * Update user.
 * Upate the user's information. All fields are optional.
 *
 * @param username NSString Username
 * @param altUsername NSString Alternative Username
 * @param password NSString Password
 * @param firstName NSString First name
 * @param lastName NSString Last name
 * @param communityName NSString Community name
 * @param email NSString Email
 * @param emailResetStatus PPUserEmailStatus Email reset status.
 * @param language NSString Language
 * @param phone NSString Phone
 * @param phoneType PPUserPhoneType as NSNumber. Phone type.
 * @param anonymous PPUserAnonymousType Anonymous.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 */
+ (void)updateUsername:(NSString * _Nullable )username altUsername:(NSString * _Nullable )altUsername password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName communityName:(NSString * _Nullable )communityName email:(NSString * _Nullable )email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock _Nullable )callback;
+ (void)updateUsername:(NSString * _Nullable )username altUsername:(NSString * _Nullable )altUsername password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName email:(NSString * _Nullable )email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock _Nullable )callback __attribute__((deprecated));
+ (void)updateUsername:(NSString * _Nullable )username password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName email:(NSString * _Nullable )email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock _Nullable )callback __attribute__((deprecated));

/**
 * Delete user.
 * Delete this user and removes all devices attached to the user's account. Any legal agreements the user signed will be retained in the backend.
 * This API can copy (merge) deleted user account resources to other user account.
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param merge PPUserAccountsMerge Merge deleted user account to another user
 * @param mergeUserId PPUserId User ID where to merge the deleted user provided by an administrator
 * @param mergeUserApiKey NSString API Key of user we want to merge with
 * @param callback NSErrorBlock Error callback block
 */
+ (void)deleteUser:(PPUserId)userId merge:(PPUserAccountsMerge)merge mergeUserId:(PPUserId)mergeUserId mergeUserApiKey:(NSString * _Nullable )mergeUserApiKey callback:(PPErrorBlock _Nullable )callback;
+ (void)deleteUser:(PPUserId)userId callback:(PPErrorBlock _Nullable )callback __attribute__ ((deprecated));

#pragma mark - Get services by device

/**
 * Get services by device
 * A gateway or proxy can request some information about an owner. Currently only assigned paid services are returned.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:Using a Device Authentication Token:
 *      PPCAuthorization: esp token="ABC12345"
 *      Using a Streaming Session ID: PPCAuthorization: stream session="DEF67890"
 *
 * @param proxyId Required NSString Device ID of the gateway or proxy
 * @param authorizationType Required PPUserAccountAuthorizationType Authorization type used to identify the source device.
 * @param token Required if authorizationType set to PPUserAccountAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @param sessionId Required if authorizationType set to PPUserAccountAuthorizationTypeStreamingSessionId NSString Session ID.
 * @param callback PPUserAccountsServicesBlock Callback method provides array of services and optional error
 */
+ (void)getServicesByDevice:(NSString * _Nonnull )proxyId authorizationType:(PPUserAccountAuthorizationType)authorizationType token:(NSString * _Nullable )token sessionId:(NSString * _Nullable )sessionId callback:(PPUserAccountsServicesBlock _Nonnull )callback;
+ (void)getUserByDevice:(NSString * _Nonnull )proxyId authorizationType:(PPUserAccountAuthorizationType)authorizationType token:(NSString * _Nullable )token sessionId:(NSString * _Nullable )sessionId callback:(PPUserAccountsServicesBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Get user by email (undocumented)

/**
 * Get users by email
 * Return a list of users that already have an account.  This API is undocumented.
 * Either an array of emails or phone numbers is required
 *
 * @param emails Required NSArray List of emails to check against
 * @param phones Required NSArray List of phone numbers to check against
 * @param sendAsRequest PPUserAccountSendAsRequest Determine if the API should send the list using url query parameters or in the http body
 * @param callback PPUserAccountsUsersListBlock Callback method provides list of PPUser objects and optional error
 */
+ (void)getUsersByEmails:(NSArray * _Nullable )emails phones:(NSArray * _Nullable )phones sendAsRequest:(PPUserAccountSendAsRequest)sendAsRequest callback:(PPUserAccountsUsersListBlock _Nonnull )callback;
+ (void)getUsersByEmails:(NSArray * _Nonnull )emails sendAsRequest:(PPUserAccountSendAsRequest)sendAsRequest callback:(PPUserAccountsUsersListBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - New Location

/**
 * Add a new Location to an existing user
 *
 * @param name NSString Location name
 * @param type PPLocationType Type of location
 * @param utilityAccountNo NSString Utility account number
 * @param timezone PPTimezone Timezone for this location
 * @param addrStreet1 NSString Address - Street 1
 * @param addrStreet2 NSString Address - Street 2
 * @param addrCity NSString Address - City
 * @param state PPState State for this location
 * @param country PPCountry Country for this location
 * @param zip NSString Zip / Postal code
 * @param latitude NSString Latitude for this location
 * @param longitude NSString Longitude for this location
 * @param size PPLocationSize Size representing this location
 * @param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @param heatingType PPLocationHeatingType Heating type for this location
 * @param coolingType PPLocationCoolingType Cooling type for this location
 * @param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @param thermostatType PPLocationThermostatType Thermostat type for this location
 * @param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param appName NSString App name to associate this location with an organization.
 * @param test PPLocationTest Test location marker
 * @param locationCallback PPUserAccountsAddLocationBlock Error callback block
 **/
+ (void)addNewLocationToExistingUser:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId appName:(NSString * _Nullable )appName test:(PPLocationTest)test locationCallback:(PPUserAccountsAddLocationBlock _Nonnull )locationCallback;
+ (void)addNewLocationToExistingUser:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId appName:(NSString * _Nullable )appName locationCallback:(PPUserAccountsAddLocationBlock _Nonnull )locationCallback __attribute__((deprecated));
+ (void)addNewLocationToExistingUser:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId locationCallback:(PPUserAccountsAddLocationBlock _Nonnull )locationCallback __attribute__((deprecated));
+ (void)addNewLocationToExistingUser:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Update Location

/**
 * Edit a location.
 * Location ID parameter is required.  All others are optional.
 *
 * @param locationId PPLocationId Location id
 * @param name NSString Location name
 * @param type PPLocationType Type of location
 * @param utilityAccountNo NSString Utility account number
 * @param timezone PPTimezone Timezone for this location
 * @param addrStreet1 NSString Address - Street 1
 * @param addrStreet2 NSString Address - Street 2
 * @param addrCity NSString Address - City
 * @param state PPState State for this location
 * @param country PPCountry Country for this location
 * @param zip NSString Zip / Postal code
 * @param latitude NSString Latitude for this location
 * @param longitude NSString Longitude for this location
 * @param size PPLocationSize Size representing this location
 * @param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @param heatingType PPLocationHeatingType Heating type for this location
 * @param coolingType PPLocationCoolingType Cooling type for this location
 * @param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @param thermostatType PPLocationThermostatType Thermostat type for this location
 * @param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @param test PPLocationTest Test location marker
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)editLocation:(PPLocationId)locationId name:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy test:(PPLocationTest)test callback:(PPErrorBlock _Nonnull )callback;
+ (void)editLocation:(PPLocationId)locationId name:(NSString * _Nullable )name type:(PPLocationType)type utilityAccountNo:(NSString * _Nullable )utilityAccountNo timezone:(PPTimezone * _Nullable )timezone addrStreet1:(NSString * _Nullable )addrStreet1 addrStreet2:(NSString * _Nullable )addrStreet2 addrCity:(NSString * _Nullable )addrCity state:(PPState * _Nullable )state country:(PPCountry * _Nullable )country zip:(NSString * _Nullable )zip latitude:(NSString * _Nullable )latitude longitude:(NSString * _Nullable )longitude size:(PPLocationSize * _Nullable )size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray * _Nullable )occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));


/**
 * Delete a location.
 *
 * @param locationId PPLocationId Location id
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteLocation:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Set Location Scene

/**
 * Change the scene at a location
 * By changing the scene at a location, you may cause user-defined Rules to execute such as "When I am home do something" or "When I am going to sleep turn of the TV".
 * The API returns a list user devices shared with friends and their names. If some devices were shared before and by changing the location scene they are not shared anymore, they will be returned as well.
 *
 * @param locationId Required PPLocationId The Location ID for which to trigger an event.
 * @param eventName Required NSString Developer-defined name of the scene. For example, 'HOME', 'AWAY', 'SLEEP', 'VACATION', 'FOOSBALL'. You can define any name you want. The name represents some state, and can be fed into Rules and other areas of the app. Presence uses 'HOME', 'AWAY', 'SLEEP', and 'VACATION'.
 * @param comment NSString Comment on why this event was changed
 * @param callback PPUserAccountsLocationSceneBlockBlock Scene callback block containing shared and unshared devices
 **/
+ (void)changeSceneAtLocation:(PPLocationId)locationId eventName:(NSString * _Nonnull )eventName comment:(NSString * _Nonnull )comment callback:(PPUserAccountsLocationSceneBlockBlock _Nonnull )callback;

#pragma mark - Location Scenes

/**
 * Location scenes history
 * Return location change schemes history in backward order (latest first).
 *
 * @param locationId Required PPLocationId Location Id for this location
 * @param startDate NSDate Start date to begin receiving data
 * @param endDate NSDate End date to stop receiving data. Default is the current date.
 * @param callback PPUserAccountsLocationSceneBlockHistoryBlock Scene history callback block containing array of events
 **/
+ (void)locationScenesHistory:(PPLocationId)locationId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPUserAccountsLocationSceneBlockHistoryBlock _Nonnull )callback;

#pragma mark - Verify email address or phone number

/**
 * Send a verification message
 * Send an email or an SMS to the user containing a link to a temporary page which is valid for one day and/or a verification code, to verify the email address or if this phone number able to receive SMS. When the user clicks on that link, the email address is marked as verified and the user is forwarded to a success page. If the link is expired, the user is forwarded to an error page.
 * By default the IoT Software Suite will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param type Required PPUserEmailVerificationType Message type
 * @param callback PPErrorBlock Error callback block
 */
+ (void)sendAVerificationMessage:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName type:(PPUserEmailVerificationType)type callback:(PPErrorBlock _Nonnull )callback;

/**
 * Provide verification code
 *
 * @param code Required NSString Verification code
 * @param type Required PPUserEmailVerificationType Message type
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)provideVerificationCode:(NSString * _Nonnull )code type:(PPUserEmailVerificationType)type callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Recover password

/**
 * Recover user's password.
 * By default the IoT Software Suit will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @param username Required NSString The username, which is typically the user's email address
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)recoverPassword:(NSString * _Nonnull )username brand:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName callback:(PPErrorBlock _Nonnull ) callback;

/**
 * Put new password.
 * The app calls this API to submit a new password.
 * End users must provide either a temporary API key sent by email or a regular user API key and the old password.
 *
 * @param password Required NSString New Password
 * @param oldPassword NSString Old Password
 * @param passcode NSString Passcode
 * @param tempKey NSString Temporary API key
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putNewPassword:(NSString * _Nonnull )password oldPassword:(NSString * _Nullable )oldPassword passcode:(NSString * _Nullable )passcode tempKey:(NSString * _Nullable )tempKey brand:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Badges

/**
 * Reset badges
 *
 * @param type PPUserBadgeType Type of badge being reset.  If none type is provided, all badge counts will be reset.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)resetBadges:(PPUserBadgeType)type callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Sign Terms of Service

/**
 * Sign terms of service
 * Adds a unique signature identifier to the list of agreements the user has signed.
 *
 * @param termsOfServiceId Required NSString Terms of service ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)signTermsOfService:(NSString * _Nonnull )termsOfServiceId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Get Terms of Service
/**
 * Get Signatures
 * Retrieve all of the Terms of Service agreement signature identifiers to which the user has previously agreed.
 *
 * @param callback PPUserAccountTermsOfServiceBlock Terms of Service callback block
 **/
+ (void)getSignatures:(PPUserAccountTermsOfServiceBlock _Nonnull )callback;

#pragma mark - User Tags

/**
 * Apply tag
 *
 * @param tag Required NSString Tag value
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)applyTag:(NSString * _Nonnull )tag callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete tag
 *
 * @param tag Required NSString Tag value
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)deleteTag:(NSString * _Nonnull )tag callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - User Codes

/**
 * Put user code
 * This API allows to add a new or overwrite an existing user code or update a shared code on the location. A user code can be set by either providing the actual code value or by initiating a process entering the code on the device. If the code is set by the device, process expiry time in seconds can be provided in the setExpiry field.
 *
 * @param type Required PPUserCodeType Code type
 * @param code NSString Alphanumeric string of 4 or more characters.  Codes of type Combined are joined using the "+" character.
 * @param locationId PPLocationId Assign code to a location.  Name is ignored.
 * @param name NSString Code name.  Ignored when including locationId.
 * @param deviceId NSString Device ID
 * @param setExpiry PPUserCodeExpiry Expiry in seconds
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)putUserCode:(PPUserCodeType)type code:(NSString * _Nullable )code locationId:(PPLocationId)locationId name:(NSString * _Nullable )name deviceId:(NSString * _Nullable )deviceId setExpiry:(PPUserCodeExpiry)setExpiry callback:(PPErrorBlock _Nonnull )callback;
+ (void)putUserCode:(PPUserCodeType)type code:(NSString * _Nonnull )code locationId:(PPLocationId)locationId name:(NSString * _Nullable )name callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete user code
 * Either name or locationId is required
 *
 * @param name NSString Code Name
 * @param locationId PPLocationId LocationId to remove this code from
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)deleteUserCode:(NSString * _Nullable )name locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get user codes
 *
 * @param callback PPUserAccountsUserCodesBlock Error callback block
 **/
+ (void)getUserCodes:(PPUserAccountsUserCodesBlock _Nonnull )callback;

#pragma mark - Coutries, states and time zones

/**
 * Get countries, states and time zones.
 * Return a list of countries currently supported on the IoT Software Suite. The Country ID is used when referencing this country in other API calls.
 *
 * @param organizationId PPOrganizationId Filter response by the organization ID
 * @param countryCode NSString Filter response by country codes. You may specify multiple countryCode URL parameters with different values to gather multiple countries data.
 * @param lang NSString Use for language specific response
 * @param callback PPUserAccountCountriesStatesAndTimeszonesBlock Countries, States, and Timezones callback block
 **/
+ (void)getCountries:(PPOrganizationId)organizationId countryCode:(NSString * _Nullable )countryCode lang:(NSString * _Nullable )lang callback:(PPUserAccountCountriesStatesAndTimeszonesBlock _Nonnull )callback;

#pragma mark - Location Users

/**
 * Get location users
 * An owner of a location can assign other existing users to access and manage the location and devices on it and receive notifications related to this location.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPUserAccountsUsersListBlock Location users callback block
 **/
+ (void)getLocationUsers:(PPLocationId)locationId callback:(PPUserAccountsUsersListBlock _Nonnull )callback;

/**
 * Add location users
 *
 * @param locationId Required PPLocationId Location ID
 * @param users Required NSDictionary Dictionary of users to add. e.g. {"id": 123, "locationAccess": 10, "category": 1}
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addLocationUsers:(PPLocationId)locationId users:(NSArray * _Nonnull )users callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete location user
 *
 * @param locationId Required PPLocationId Location ID
 * @param userIds NSArray User ID to delete from the location, multiple values supported. If not set, the calling user will be deleted from the location.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteLocationUser:(PPLocationId)locationId userIds:(NSArray * _Nullable )userIds callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteLocationUser:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Location Spaces

/**
 * Get spaces
 * A user can define location zones called spaces.  A space has a type and a name.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPUserAccountsLocationSpacesBlock Location spaces callback block
 **/
+ (void)getLocationSpaces:(PPLocationId)locationId callback:(PPUserAccountsLocationSpacesBlock _Nonnull )callback;

/**
 * Update space
 * Add new or modify existing space.
 *
 * @param locationId Required PPLocationId Location ID
 * @param space Required PPLocationSpace Location space to add or modify
 * @param callback PPUserAccountsUpdateLocationSpacesBlock Update location space callback block
 **/
+ (void)updateLocationSpace:(PPLocationId)locationId space:(PPLocationSpace * _Nonnull )space callback:(PPUserAccountsUpdateLocationSpacesBlock _Nonnull )callback;

/**
 * delete space
 *
 * @param locationId Required PPLocationId Location ID
 * @param spaceId Required PPLocationSpaceId Location space id to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteLocationSpace:(PPLocationId)locationId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Narratives

/**
 * Create/Update a narrative
 * If `narrativeId` and `narrativeTime` parameters are provided then the API updates the narrative with this ID and time. Otherwise a new narrative is created.
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId PPLocationNarrativeId ID of narrative to update - required for update
 * @param narrativeTime PPLocationNarrativeTime Current record narrative time to update - required for update
 * @param narrative Required PPLocationNarrative Narrative content to put
 * @param analyticAPIKey Required NSString Analytic/Bot API Key
 * @param callback PPUserAccountsPutNarrativeBlock Narrative callback block
 **/
+ (void)createOrUpdateNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId narrativeTime:(PPLocationNarrativeTime)narrativeTime narrative:(PPLocationNarrative * _Nonnull )narrative analyticAPIKey:(NSString * _Nonnull )analyticAPIKey callback:(PPUserAccountsPutNarrativeBlock _Nonnull )callback;

/**
 * Delete a narrative
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId Required PPLocationNarrativeId ID of narrative to delete
 * @param analyticAPIKey Required NSString Analytic/Bot API Key
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId analyticAPIKey:(NSString * _Nonnull )analyticAPIKey callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId narrativeTime:(PPLocationNarrativeTime)narrativeTime analyticAPIKey:(NSString * _Nonnull )analyticAPIKey callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Get narratives
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId PPLocationNarrativeId Filter by ID
 * @param priority PPLocationNarrativePriority Filter by priority higher or equal that that
 * @param toPriority PPLocationNarrativePriority Filter by priority less or equal than that
 * @param searchBy NSString Filter by keywors (like "Door" - show me any recent events that contained the word Door in the title or description)
 * @param startDate NSDate Narrative date range start
 * @param endDate NSDate Narrative date range end
 * @param rowCount PPLocationNarrativeRowCount Maximum rows number to return
 * @param pageMarker NSString Marker to the next page
 * @param analyticAPIKey NSString Analytic/Bot API Key
 * @param sortOptions NSDictionary Sort options
 * @param callback PPUserAccountsNarrativesBlock Narratives callback block
 **/
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority toPriority:(PPLocationNarrativePriority)toPriority searchBy:(NSString * _Nullable )searchBy startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString * _Nullable )pageMarker analyticAPIKey:(NSString * _Nullable )analyticAPIKey sortOptions:(NSDictionary * _Nullable )sortOptions callback:(PPUserAccountsNarrativesBlock _Nonnull )callback;
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority searchBy:(NSString * _Nullable )searchBy startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString * _Nullable )pageMarker analyticAPIKey:(NSString * _Nullable )analyticAPIKey sortOptions:(NSDictionary * _Nullable )sortOptions callback:(PPUserAccountsNarrativesBlock _Nonnull )callback __attribute__((deprecated));
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority searchBy:(NSString * _Nullable )searchBy startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString * _Nullable )pageMarker analyticAPIKey:(NSString * _Nullable )analyticAPIKey callback:(PPUserAccountsNarrativesBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Location States
/**
 * A way for bots to set named location states with flexible JSON object structure.
 **/

/**
 * Set State
 *
 * @param locationId Required PPLocationId Location ID
 * @param name Required NSString State name
 * @param data NSDictionary State information
 * @param overwrite PPUserAccountsStateOverwrite Overwrite the entire state with completely new content
 * @param callback PPErrorBlock Error callback block
 **/
 + (void)setState:(PPLocationId)locationId name:(NSString * _Nonnull )name data:(NSDictionary * _Nullable )data overwrite:(PPUserAccountsStateOverwrite)overwrite callback:(PPErrorBlock _Nonnull )callback;
+ (void)setState:(PPLocationId)locationId name:(NSString * _Nonnull )name data:(NSDictionary * _Nullable )data callback:(PPErrorBlock _Nonnull )callback __attribute__ ((deprecated));

/**
 * Get State
 *
 * @param locationId Required PPLocationId Location ID
 * @param name Required NSString State name
 * @param callback PPUserAccountsStateBlock State callback block
 **/
+ (void)getState:(PPLocationId)locationId name:(NSString * _Nonnull )name callback:(PPUserAccountsStateBlock _Nonnull )callback;

/**
 * Get States
 *
 * @param locationId Required PPLocationId Location ID
 * @param names Required NSArray Array of state names
 * @param callback PPUserAccountsStatesBlock State callback block
 **/
+ (void)getStates:(PPLocationId)locationId names:(NSArray * _Nonnull )names callback:(PPUserAccountsStatesBlock _Nonnull )callback;
 
#pragma mark - Location Time States
/**
 * A way for bots to set time based location states with flexible JSON object structure.
 * The state value can be an any valid JSON node. It can be a single value node (string, integer, etc) or an array or an object node {}.
 * To delete a location state set the value to null.
 * If the value is an object node, the API will read the current state value and try to update only changed fields. To delete a field from the current value set it to null.
 **/

/**
 * Set Time State
 *
 * @param locationId Required PPLocationId Location ID
 * @param date Required NSDate State date or time value
 * @param name Required NSString State name
 * @param overwrite PPUserAccountsStateOverwrite Overwrite the entire state with completely new content
 * @param data NSDictionary State information
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setTimeState:(PPLocationId)locationId date:(NSDate * _Nonnull )date name:(NSString * _Nonnull )name data:(NSDictionary * _Nullable )data overwrite:(PPUserAccountsStateOverwrite)overwrite callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get Time States
 *
 * @param locationId Required PPLocationId Location ID
 * @param startDate Required NSDate Retrun states with dates greater or equal to this value
 * @param endDate NSDate Return states with dates less than this value. If not set, only states with dates exactly equal to startDate will be returned.
 * @param names Required NSArray Array of state names
 * @param callback PPUserAccountsStatesBlock State callback block
 **/
+ (void)getTimeStates:(PPLocationId)locationId startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate names:(NSArray * _Nonnull )names callback:(PPUserAccountsStatesBlock _Nonnull )callback;

#pragma mark - Location Totals
/// See Dynamic UIs

#pragma mark - Location Presence
/**
 These APIs determine if a person is physically present nearby one of the location gateways, where the user has read access.
 **/

/**
 * Get Presence IDs
 *
 * Return UUIDs provided by all gateways, where the user has read access.
 *
 * @param callback PPUserAccountsLocationPresenceBlock Presence IDs callback block
 **/
+ (void)getPresenceIDs:(PPUserAccountsLocationPresenceBlock _Nonnull )callback;

/**
 * Authorize Access
 *
 * Authorize access to the location, where the gateway with provided parameters is located.
 *
 * @param uuid Required NSString UUID string
 * @param major Required NSString Major string
 * @param minor Required NSString Minor string
 * @param callback PPUserAccountsLocationIdBlock Location ID callback block
 **/
+ (void)authorizeAccess:(NSString * _Nonnull )uuid major:(NSString * _Nonnull )major minor:(NSString * _Nonnull )minor callback:(PPUserAccountsLocationIdBlock _Nonnull )callback;

@end
