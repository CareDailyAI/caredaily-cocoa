//
//  PPProfessionalMonitoring.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite is wired for professional monitoring. We connect with a 5-diamond certified central station in North America. This can be replaced with your own professional monitoring call center to enable international services and professional monitoring.
//

#import "PPBaseModel.h"
#import "PPCallCenter.h"
#import "PPCallCenterAlert.h"

typedef void (^PPCallCenterBlock)(PPCallCenter * _Nullable callCenter, NSError * _Nullable error);
typedef void (^PPCallCenterAlertsBlock)(NSArray * _Nullable alerts, NSError * _Nullable error);

@interface PPProfessionalMonitoring : PPBaseModel

#pragma mark - Session Management

/**
 * Shared call center across the entire application
 */
+ (PPCallCenter *)sharedCallCenterForUser:(PPUserId)userId;


/**
 * Add call center.
 * Add call center to local reference.
 *
 * @param callCenter PPCallCenter Call center to add.
 * @param userId Required PPUserId User Id to associate these subscriptions with
 **/
+ (void)addCallCenter:(PPCallCenter *)callCenter userId:(PPUserId)userId;

/**
 * Remove call center.
 * Remove call center from local reference.
 *
 * @param userId Required PPUserId User Id to disassociate this call center with
 **/
+ (void)removeCallCenterForUserId:(PPUserId)userId;

#pragma mark Alerts

/**
 * Shared alerts across the entire application
 */
+ (NSArray *)sharedAlertsForUser:(PPUserId)userId;

/**
 * Add alerts.
 * Add alerts to local reference.
 *
 * @param alerts NSArray Array of alerts to add.
 * @param userId Required PPUserId User Id to associate these subscriptions with
 **/
+ (void)addAlerts:(NSArray *)alerts userId:(PPUserId)userId;

/**
 * Remove alerts.
 * Remove alerts from local reference.
 *
 * @param alerts NSArray Array of alerts to remove.
 * @param userId Required PPUserId User Id to associate these subscriptions with
 **/
+ (void)removeAlerts:(NSArray *)alerts userId:(PPUserId)userId;

#pragma mark - Call Center

/**
 * Get call center.
 * Retrieve call center service statuses, if the service is available and if the registration in the third party application has been completed. If the service is available, but the registration has not been completed yet, then the IoT Software Suite does not have enough information to do it.
 * Call center registration can have following statuses:
 *      Value   Status                  Description
 *      0       Unavailable             The service never purchased
 *      1       Available               The service purchased, but the user does not have enough information for registration
 *      2       Registration pending    The registration process has not been completed yet
 *      3       Registered              Registration completed
 *      4       Cancellation pending    The cancellation has not been completed yet
 *      5       Canceled                Cancellation completed
 * To complete the call center registration the user has to submit own name, phone number and address using the update user info API and a list of emergency contacts. The complete list of missing fields is returned.
 * Also this API returns an array of emergency contacts including the first and the last name, the phone number of the person in the order, how they have to be contacted.
 * The alert status with the alert date is returned in a case of an emergency situation. It can have following values:
 *      Value   Status      Description
 *      0                   An alert never raised
 *      1       Raised      An alert raised, but the call center not contacted yet
 *      3       Reported    The alert reported to the call center
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId Used by administrators to access specific user information
 * @param callback PPCallCenterBlock Call center block containing call center object
 **/
+ (void)getCallCenter:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPCallCenterBlock _Nonnull )callback;
+ (void)getCallCenter:(PPCallCenterBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Update call center.
 * Update user's call center record. The API can raise a alert by setting the alert status.
 * If the new alert status is not provided, the API overwrites the call center contacts information. Submitting null or an empty contacts array will not affect existing contacts data.
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID to associate the Call Center Site Owner to a specific user
 * @param alertStatus PPCallCenterAlertStatus New alert status
 * @param contacts NSArray Udpated contact list
 * @param codeword NSString New codeword
 * @param permit NSString New permit ID
 * @param callback PPCallCenterBlock Call center callback block
 **/
+ (void)updateCallCenter:(PPLocationId)locationId userId:(PPUserId)userId alertStatus:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray * _Nullable )contacts codeword:(NSString * _Nullable )codeword permit:(NSString * _Nullable )permit callback:(PPCallCenterBlock _Nonnull )callback;
+ (void)updateCallCenter:(PPLocationId)locationId alertStatus:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray * _Nullable )contacts codeword:(NSString * _Nullable )codeword permit:(NSString * _Nullable )permit callback:(PPCallCenterBlock _Nonnull )callback __attribute__((deprecated));
+ (void)updateCallCenter:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray * _Nullable )contacts codeword:(NSString * _Nullable )codeword permit:(NSString * _Nullable )permit callback:(PPCallCenterBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Cancel call center.
 * Update user's call center record status to available and delete contacts.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPErrorBlock Error callback block
 */
+ (void)cancelCallCenter:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Call Center Alerts

/**
 * Get call center alerts.
 * Retrieve history of call center alerts.The alert source type can have following values:
 *      Value   Description
 *      0       Unknown
 *      1       Raised by a rule
 *      2       Raised by a composer app
 *      3       Raised by an app API
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPCallCenterAlertsBlock Call center alerts callback
 **/
+ (void)getCallCenterAlerts:(PPLocationId)locationId callback:(PPCallCenterAlertsBlock _Nonnull )callback;
+ (void)getCallCenterAlerts:(PPCallCenterAlertsBlock _Nonnull )callback __attribute__((deprecated));

@end
