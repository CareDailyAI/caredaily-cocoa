//
//  PPCloudConnectivity.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCloudConnectivityCloud.h"

typedef void (^PPCloudConnectivityAvailabilityBlock)(NSString * _Nullable status, NSError * _Nullable error);
typedef void (^PPCloudConnectivityCloudsBlock)(NSArray * _Nullable clouds, NSError * _Nullable error);
typedef void (^PPCloudConnectivityCloudBlock)(PPCloudConnectivityCloud * _Nullable cloud, NSError * _Nullable error);
typedef void (^PPCloudConnectivityServerBlock)(PPCloudConnectivityServer * _Nullable server, NSError * _Nullable error);
typedef void (^PPCloudConnectivityServerURLBlock)(NSURL * _Nullable url, NSError * _Nullable error);
typedef void (^PPCloudConnectivityVersionBlock)(NSString * _Nullable version, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPCloudConnectivityConnected) {
    PPCloudConnectivityConnectedNone = -1,
    PPCloudConnectivityConnectedFalse = 0,
    PPCloudConnectivityConnectedTrue = 1
};

@interface PPCloudConnectivity : PPBaseModel

/**
 * System Start Date
 * Earlies available date the will work with our server
 *
 * @return NSDate
 */
+ (NSDate * _Nonnull )serverStartDate;

/**
 * System End Date
 * Latest available date the will work with our server
 *
 * @return NSDate
 */
+ (NSDate * _Nonnull )serverEndDate;

#pragma mark - How to ping

/**
 * Check Availability.
 * Ping is disabled on all deployed instances of the IoT Software Suite for security reasons. We use an HTTP GET request to check for cloud availability, which returns "OK" if the IoT Software Suite instance is available. Combine this with the "time" Linux command to measure the response time of the IoT Software Suite.
 *
 * @param callback PPCloudConnectivityAvailabilityBlock Availability callback block
 **/
+ (void)checkAvailability:(PPCloudConnectivityAvailabilityBlock _Nonnull )callback;

#pragma mark - Available Server Instances

/**
 * Get Connection Settings.
 *
 * @param deviceId NSString When specified, the API will return connection settings for this device. For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server,
 *      - true - return the server, where the device is connected now or nothing.
 *      Default false for all except streaming API, where it will try to find the server, where the device is connected first.
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param callback PPCloudConnectivityCloudsBlock Clouds callback block
 **/
+ (void)getConnectionSettings:(NSString * _Nullable )deviceId connected:(PPCloudConnectivityConnected)connected version:(PPCloudConnectivityVersion)version callback:(PPCloudConnectivityCloudsBlock _Nonnull )callback;

#pragma mark - Server Instances

/**
 * Get server.
 * This API returns just one server connection settings by type.
 *
 * @param type Required NSString Server type
 * @param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param brand NSString Return brand specific server, if available.
 * @param appName NSString Return app specific server, if available.
 * @param callback PPCloudConnectivityServerBlock Server callback block
 **/
+ (void)getServer:(NSString * _Nonnull )type deviceId:(NSString * _Nullable )deviceId connected:(PPCloudConnectivityConnected)connected version:(PPCloudConnectivityVersion)version brand:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName callback:(PPCloudConnectivityServerBlock _Nonnull )callback;

/**
 * Get server URL.
 * This API returns just one server connection url by type.
 *
 * @param type Required NSString Server type
 * @param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @param ssl Required PPCloudConnectivitySSL Flag to return SSL version of the URL, if available
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param brand NSString Return brand specific server, if available.
 * @param appName NSString Return app specific server, if available.
 * @param callback PPCloudConnectivityServerBlock Server callback block
 **/
+ (void)getServerURL:(NSString * _Nonnull )type deviceId:(NSString * _Nullable )deviceId connected:(PPCloudConnectivityConnected)connected ssl:(PPCloudConnectivitySSL)ssl version:(PPCloudConnectivityVersion)version brand:(NSString * _Nullable )brand appName:(NSString * _Nullable )appName callback:(PPCloudConnectivityServerURLBlock _Nonnull )callback;

#pragma mark - Cloud Instances

/**
 * Get Cloud Instance.
 * Return the Cloud instance where this specific device should be pointed.
 * This API must be called only after the first initial device start and/or after a factory reset.
 *
 * @param deviceId Required deviceId NSString Device ID
 * @param callback PPCloudConnectivityCloudBlock Cloud callback block
 **/
+ (void)getCloudInstance:(NSString * _Nonnull )deviceId callback:(PPCloudConnectivityCloudBlock _Nonnull )callback;

#pragma mark - Version Information

/**
 * Get server version information.
 *
 * @param callback PPCloudConnectivityVersionBlock Version callback block
 **/
+ (void)getVersionInformation:(PPCloudConnectivityVersionBlock _Nonnull )callback __attribute__((deprecated));

@end
