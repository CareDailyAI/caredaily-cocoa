//
//  PPBotengine.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// The Bot Shop APIs allow a user to discover and manage their bots.

#import "PPBaseModel.h"
#import "PPBotengineAppInstance.h"

@class PPBotengineApp;

@interface PPBotengine : PPBaseModel

/**
 * Search app store
 * It is recommended that the server side do some kind of optimization to recommend the most relevant and downloaded bots for the given search criteria.
 *
 * @param searchBy Search in name, author, keywords
 * @param category Category Search. i.e. 'S', 'E', etc.
 * @param compatible Filter by apps that are compatible with our user account or not, leave blank to return all apps
 * @param lang Language filter, leave blank to return apps in all languages
 * @param type PPBotengineAppType Filter by the bot type field
 * @param locationId PPLocationId Return bots available for this location
 * @param organizationId PPOrganizationId Return bots available for this organization
 *
 * @param callback PPBotengineAppsBlock Array of available apps and server status
 */
+ (void)searchAppStore:(NSString * _Nullable )searchBy category:(NSString * _Nullable )category compatible:(BOOL)compatible language:(NSString * _Nullable )lang type:(PPBotengineAppType)type locaitonId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineAppsBlock _Nonnull )callback;
+ (void)searchAppStore:(NSString * _Nullable )searchBy category:(NSString * _Nullable )category compatible:(BOOL)compatible language:(NSString * _Nullable )lang callback:(PPBotengineAppsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Get app object
 * Each app can contain a publicly available icon and/or other images.
 *
 * @param name Object name. Use "icon" for icons.
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 *
 * @param callback PPBotengineAppObjectBlock App object with server status
 */
+ (void)getAppObject:(NSString * _Nullable )name bundleId:(NSString * _Nullable )bundle callback:(PPBotengineAppObjectBlock _Nonnull )callback;

/**
 * Get app information
 * This App Idenfication API does not refer to a specific app instance, but the general app itself. It combines information input from several other APIs to provides comprehensive information about the app back to the user, minus the search keywords specified by the developer. It also adds the compatibility information and detailed ratings, so the user can see in advance what devices this app is compatible with and how it would access those devices.
 *
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param lang Language filter, leave blank to return apps in all languages
 * @param locationId PPLocationId Check compatibility for this location
 * @param organizationId PPOrganizationId Check compatibility for this organization
 *
 * @param callback PPBotengineAppInfoBlock with server status
 */
+ (void)getAppInformation:(NSString * _Nullable )bundle language:(NSString * _Nullable )lang locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineAppInfoBlock _Nonnull )callback;
+ (void)getAppInformation:(NSString * _Nullable )bundle language:(NSString * _Nullable )lang callback:(PPBotengineAppInfoBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Purchase a new app instance
 *
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param locationId PPLocationId Assign the bot instance to the specific user location
 * @param organizationId PPOrganizationId Assign the bot instance to the specific organization
 * @param circleId PPCircleId Assign the bot instance to the specific circle
 *
 * @param callback PPBotengineAppPurchaseBlock with server status
 */
+ (void)purchaseAppInstance:(NSString * _Nullable )bundle locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId circleId:(PPCircleId)circleId callback:(PPBotengineAppPurchaseBlock _Nonnull )callback;
+ (void)purchaseAppInstance:(NSString * _Nullable )bundle callback:(PPBotengineAppPurchaseBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Configure an app instance
 *
 * @param instanceId NSInteger App instance ID
 * @param status PPBotengineAppInstanceStatus App instance status
 * @param nickname NSString User defined nickname
 * @param timezone NSString The local timezone the app should run in
 * @param access NSArray Array of accessible categories/devices
 * @param communications NSArray Array of communication categories
 *
 * @param callback PPErrorBlock with server status
 */
+ (void)configureAppInstance:(NSInteger)instanceId status:(PPBotengineAppInstanceStatus)status nickname:(NSString * _Nullable )nickname timezone:(NSString * _Nullable )timezone access:(NSArray * _Nullable )access communications:(NSArray * _Nullable )communications callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get my app instances
 *
 * @param appInstanceId PPBotengineAppInstanceId Optional app instance ID of a specific app instance to obtain information about
 * @param bundle NSString Optional Bundle name of a specific app instance to obtain information about
 * @param locationId PPLocationId Filtering bot instances by location
 * @param organizationId PPOrganizationId Return bots purchased by this organization
 * @param circleId PPCircleId Return bots purchased by this circle
 * @param userId PPUserId Get specific user bot instances by organization administrator
 *
 * @param callback PPBotengineAppsBlock Array of current app instances and server status
 */
+ (void)getAppInstances:(PPBotengineAppInstanceId)appInstanceId bundle:(NSString * _Nullable )bundle locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId circleId:(PPCircleId)circleId userId:(PPUserId)userId callback:(PPBotengineAppsBlock _Nonnull )callback;
+ (void)getAppInstances:(PPBotengineAppInstanceId)appInstanceId bundle:(NSString * _Nullable )bundle callback:(PPBotengineAppsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete an app instances
 *
 * @param appInstanceId NSInteger ID of a app instance to delete
 *
 * @param callback NSError with server status
 */
+ (void)deleteAppInstances:(NSInteger)appInstanceId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get app reviews
 *
 * @param bundle NSString Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param mine BOOL Return only my review, if I previously wrote one for this app
 * @param version NSString Filter by version number
 * @param lang Language filter, leave blank to return apps in all languages
 *
 * @param callback PPBotengineAppReviewBlock Average rating, list of reviews and server status
 */
+ (void)getAppReviews:(NSString * _Nullable )bundle mine:(BOOL)mine version:(NSString * _Nullable )version language:(NSString * _Nullable )lang callback:(PPBotengineAppReviewBlock _Nonnull )callback;

/**
 * Write app review
 * A user should only be able to supply a single rating for an app, not multiple ratings for the same app. If a review already exists from this user, we should overwrite the previous review with the new one. The nickname is likely the person's registered First and Last name, but should be modifiable to keep the review totally anonymous. A developer cannot publish a review for own app.
 *
 * @param bundle Globally unique bundle ID for the app
 * @param rating NSInteger
 * @param lang NSString
 * @param desc NSString
 * @param nickname NSString
 *
 * @param callback NSError with server status
 */
+ (void)writeAppReview:(NSString * _Nullable )bundle rating:(NSInteger)rating language:(NSString * _Nullable )lang desc:(NSString * _Nullable )desc nickname:(NSString * _Nullable )nickname callback:(PPErrorBlock _Nonnull )callback;

/**
 * Vote for review
 * A user should only be able to vote another user review up or down one time.
 *
 * @param reviewId NSInteger
 * @param vote PPBotengineAppReviewVote vote value
 *
 * @param callback NSError with server status
 */
+ (void)voteForReview:(NSInteger)reviewId vote:(PPBotengineAppReviewVote)vote callback:(PPErrorBlock _Nonnull )callback;

/**
 * Send a data stream message
 * Applications can send a message to bots.
 * The message can be sent to bots subscribed on the specific data stream address or bots of provided instands ID's
 * End users can send messages to bots only purchased by them including organizational bots. Organization administrators can send messages to organizational bots in the same organization and to non-organization and individual bots of user in this organization.
 * The end user IDs and the bot IDs (appInstanceId) are specified in the request body.
 *
 * @param scope PPBotengineAppInstanceDataStreamBitmask Optional Bitmask to feed organization and/or individual bots
 * @param address NSString Data stream address
 * @param locationId PPLocationId Send data to bots of this location. Mandatatory for end users.
 * @param organizationId PPOrganizationId Send data to bots of users of the specific organization, used by an administrator.
 * @param feed NSDictionry Feed to send to the bot
 * @param appInstanceId NSInteger ID of a specific app instance to obtain information about
 *
 * @param callback NSError with server status
 */
+ (void)postDataStream:(PPBotengineAppInstanceDataStreamBitmask)scope address:(NSString * _Nonnull )address locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId feed:(NSDictionary * _Nonnull )feed appInstanceId:(NSInteger)appInstanceId callback:(PPErrorBlock _Nonnull )callback;
+ (void)postDataStream:(PPBotengineAppInstanceDataStreamBitmask)scope address:(NSString * _Nonnull )address feed:(NSDictionary * _Nonnull )feed appInstanceId:(NSInteger)appInstanceId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Summary
 * Returns microservices and data stream addresses for specified location or organization.
 *
 * @param locationId PPLocationId Location ID
 * @param organizationId PPOrganizationId Organization ID
 *
 * @param callback PPBotengineSummaryBlock Summary return block
 */
+ (void)getSummary:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineSummaryBlock _Nonnull )callback;

@end
