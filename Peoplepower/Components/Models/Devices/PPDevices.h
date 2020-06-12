//
//  PPDevices.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Devices must be added to a user's account to communicate data with the IoT Software Suite.
// A device may be registered through this Application API using a smartphone phone or web portal. This is usually the easiest way for users to register a device.
// If the user added a device that is a proxy, then the proxy device may automatically add more devices to the users account as those devices are discovered.
//

#import "PPBaseModel.h"
#import "PPDevice.h"
#import "PPDeviceCamera.h"
#import "PPDevicePictureFrame.h"
#import "PPDeviceActivationInfo.h"
#import "PPDeviceFirmwareUpdateJob.h"
#import "PPUser.h"


typedef NS_OPTIONS(NSInteger, PPDevicesExist) {
    PPDevicesExistNone = -1,
    PPDevicesExistFalse = 0,
    PPDevicesExistTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesUseSSL) {
    PPDevicesUseSSLNone = -1,
    PPDevicesUseSSLFalse = 0,
    PPDevicesUseSSLTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesPort) {
    PPDevicesPortNone = -1,
};

typedef void (^PPDevicesRegisterBlock)(NSString * _Nullable deviceId, NSString * _Nullable authToken, PPDeviceTypeId deviceTypeId, PPDevicesExist exist, NSString * _Nullable host, PPDevicesPort port, PPDevicesUseSSL useSsl, NSError * _Nullable error);
typedef void (^PPDevicesBlock)(NSArray * _Nullable devices, NSError * _Nullable error);
typedef void (^PPDeviceBlock)(PPDevice * _Nullable device, PPLocation * _Nullable location, NSError * _Nullable error);
typedef void (^PPDeviceActivationBlock)(PPDeviceActivationInfo * _Nullable deviceActivationInfo, NSError * _Nullable error);
typedef void (^PPDevicePropertiesBlock)(NSArray * _Nullable properties, NSError * _Nullable error);
typedef void (^PPDeviceFirmwareJobsBlock)(NSMutableArray * _Nullable jobs, NSError * _Nullable error);
typedef void (^PPDeviceVideoTokenBlock)(PPVideoToken * _Nullable token, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPDevicesAuthToken) {
    PPDevicesAuthTokenNone = -1,
    PPDevicesAuthTokenNoAuthenticationTokenNeeded = 0,
    PPDevicesAuthTokenRequestAuthenticationToken = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesCheckPersistent) {
    PPDevicesCheckPersistentNone = -1,
    PPDevicesCheckPersistentFalse = 0,
    PPDevicesCheckPersistentTrue
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepOnAccount) {
    PPDevicesKeepOnAccountNone = -1,
    PPDevicesKeepOnAccountFalse = 0,
    PPDevicesKeepOnAccountTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepSlave) {
    PPDevicesKeepSlaveNone = -1,
    PPDevicesKeepSlaveFalse = 0,
    PPDevicesKeepSlaveTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepSlaveOnGateway) {
    PPDevicesKeepSlaveOnGatewayNone = -1,
    PPDevicesKeepSlaveOnGatewayFalse = 0,
    PPDevicesKeepSlaveOnGatewayTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesClear) {
    PPDevicesClearNone = -1,
    PPDevicesClearFalse = 0,
    PPDevicesClearTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceActivationSendEmail) {
    PPDeviceActivationSendEmailNone = -1,
    PPDeviceActivationSendEmailFalse = 0,
    PPDeviceActivationSendEmailTrue = 1
};

@interface PPDevices : PPBaseModel

#pragma mark - Session Management

#pragma mark Devices

/**
 * Shared devices across the entire application
 *
 * @param location PPLocation Location devices
 * @param userId Required PPUserId User Id to associate these devices with
 *
 * @return NSArray Array of shared devices
 */
+ (NSArray *)sharedDevicesForLocation:(PPLocation *)location userId:(PPUserId)userId;

/**
 * Add devices.
 * Add devices to local reference.
 *
 * @param devices NSArray Array of devices to add.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)addDevices:(NSArray *)devices userId:(PPUserId)userId;

/**
 * Remove devices.
 * Remove devices from local reference.
 *
 * @param devices NSArray Array of devices to remove.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)removeDevices:(NSArray *)devices userId:(PPUserId)userId;

/**
 * Local device from shared devices.
 *
 * @param location Required PPLocation Local device for this location
 * @param userId Required PPUserId User Id to associate these devices with
 *
 * @return PPDevice Local device
 **/
+ (PPDevice *)localDeviceForLocation:(PPLocation *)location userId:(PPUserId)userId;

#pragma mark Firmware Update Jobs

/**
 * Shared firmware update jobs across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 *
 * @return NSArray Array of shared firmware update jobs
 */
+ (NSArray *)sharedFirmwareUpdateJobsForUser:(PPUserId)userId;

/**
 * Add firmware update job.
 * Add firmware update jobs to local reference.
 *
 * @param firmwareUpdateJobs NSArray Array of firmware update jobs to add.
 * @param userId Required PPUserId User Id to associate these jobs with
 **/
+ (void)addFirmwareUpdateJobs:(NSArray *)firmwareUpdateJobs userId:(PPUserId)userId;

/**
 * Remove firmware update jobs.
 * Remove firmware update jobs from local reference.
 *
 * @param firmwareUpdateJobs NSArray Array of firmware update jobs to remove.
 * @param userId Required PPUserId User Id to associate these jobs with
 **/
+ (void)removeFirmwareUpdateJobs:(NSArray *)firmwareUpdateJobs userId:(PPUserId)userId;

#pragma mark - Manage Devices

/**
 * Register a device
 * Registration response will describe how the device should connect to the cloud server instance.
 *
 * @param deviceId NSString Globally unique device identifier for this device. Must not include '/' or '' characters.
 * @param locationId PPLocationId Specific Location to add this device to
 * @param deviceTypeId PPDeviceTypeId Type of device being registered. Optional, but highly recommended you specify this.
 * @param authToken PPDevicesAuthToken True - Request an authentication token. False - No authentication token necessary
 * @param startDate NSDate Timestamp at which to register this product. The IoT Software Suite will ignore inbound measurements with a timestamp before the registration time. Default is the current time at the server.
 * @param desc NSString Device nickname / description
 * @param goalId PPDeviceTypeGoalId Device usage goal ID
 * @param properties NSArray Additional properties needed to register the device. e.g. [{"name": "username","value": "admin"},{"name": "port","index": "01","value": "1234"}]
 * @param proxyId NSString Device ID of the proxy
 * @param callback PPDevicesRegisterBlock Device registration block providing device Id, auth token, device type, exist (whether or not the device was already registered), hot, port, ssl, and error details
 **/
+ (void)registerDevice:(NSString * _Nullable )deviceId locationId:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId authToken:(PPDevicesAuthToken)authToken startDate:(NSDate * _Nullable )startDate desc:(NSString * _Nullable )desc goalId:(PPDeviceTypeGoalId)goalId properties:(NSArray * _Nullable )properties proxyId:(NSString *)proxyId callback:(PPDevicesRegisterBlock _Nonnull )callback;
+ (void)registerDevice:(NSString * _Nullable )deviceId locationId:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId authToken:(PPDevicesAuthToken)authToken startDate:(NSDate * _Nullable )startDate desc:(NSString * _Nullable )desc goalId:(PPDeviceTypeGoalId)goalId properties:(NSArray * _Nullable )properties callback:(PPDevicesRegisterBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Get a list of devices
 * Returns a list of devices belonging to the user. This API returns some UI specific device type attributes and device parameters.
 *
 * @param locationId Required PPLocationId Obtain a list of devices for the specified Location ID
 * @param userId NSNumber Obtain a list of devices for the specified user ID, used by administrators
 * @param checkPersistent NSNumber Devices may connect to the IoT Software Suite with a persistent GET connection, or a web socket.
 *      true - The server will check for an active persistent connection with the device, and overwrite the previously declared 'connected' value.
 *      false - Do not check for persistent connections when declaring the device "connected" (faster, more efficient)
 *      Not Set - the server will check for a persistent connection only for devices which were not previously declared 'connected'.
 * @param callback PPDevicesBlock Devices callback block containing list of devices and error object
 **/
+ (void)getListOfDevicesForLocationId:(PPLocationId)locationId userId:(PPUserId)userId checkPersistent:(PPDevicesCheckPersistent)checkPersistent callback:(PPDevicesBlock _Nonnull )callback;

/**
 * Delete Devices.
 * There are multiple ways to delete a device. This method is the most flexible, allowing multiple devices to be deleted simultaneously. Devices linked to a proxy will be removed from the proxy. Device linked to a hub will be removed from the hub.
 *
 * @param locationId Required PPLocationId Location ID where to delete devices
 * @param deviceIds Requried NSArray Array of device IDs to be deleted
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevices:(PPLocationId)locationId deviceIds:(NSArray * _Nonnull )deviceIds keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteDevices:(NSArray * _Nonnull )deviceIds keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Manage single device

/**
 * Get Device by ID.
 * Test if the device is owned by this user. If YES, the API will provide the device and the linked location information. Otherwise it will return an error code and only device type and category.
 * The lastDataReceivedDate is the last timestamp at which the IoT Software Suite received and stored data from this device. The lastMeasureDate is the last timestamp of measured data from this device. The startDate is when this device was registered.
 *
 * @param deviceId Required NSString Device ID to obtain information on
 * @param checkConnected PPDeviceConnected Check the device connection status
 * @param locationId Required PPLocationId Request information on a specific location, only called by administrator accounts
 * @param userId PPUresId Request information on a specific user, only called by administrator accounts
 * @param callback PPDeviceBlock Device callback block with device and location
 **/
+ (void)getDevice:(NSString * _Nonnull )deviceId checkConnected:(PPDeviceConnected)checkConnected locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPDeviceBlock _Nonnull )callback;

/**
 * Update a Device.
 * Update the device nickname / description, the device goal, the newDevice flag, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @param deviceId Required NSString Device ID to update
 * @param desc NSString Description / Name of the device
 * @param goalId PPDeviceTypeGoalId Goal id of this device
 * @param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @param locationId PPLocationId New location to move this device to
 * @param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateDevice:(NSString * _Nonnull )deviceId desc:(NSString * _Nullable )desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice locationId:(PPLocationId)locationId startDate:(NSDate * _Nullable )startDate callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete a single Device.
 * There are multiple ways to delete a device. This method is foolproof, but can only delete one device at a time. Devices linked to a proxy will be removed from the proxy.
 *
 * @param deviceId Required NSString Device ID to be deleted
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevice:(NSString * _Nonnull )deviceId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#warning Add GetServicesByDevice

#pragma mark - Manage a device on a specific location

/**
 * Update a Device at a specific location.
 * Update the device nickname / description, the device goal, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @param deviceId Required NSString Device ID to update
 * @param locationId Required PPLocationId Location ID that contains the device
 * @param desc NSString Description / Name of the device
 * @param goalId PPDeviceTypeGoalId Goal id of this device
 * @param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @param newLocationId PPLocationId New location to move this device to
 * @param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateDevice:(NSString * _Nonnull )deviceId locationId:(PPLocationId)locationId desc:(NSString * _Nullable )desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice newLocationId:(PPLocationId)newLocationId startDate:(NSDate * _Nullable )startDate callback:(PPErrorBlock _Nonnull )callback;
+ (void)updateDevice:(NSString * _Nonnull )deviceId currentLocationId:(PPLocationId)currentLocationId desc:(NSString * _Nullable )desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice locationId:(PPLocationId)locationId startDate:(NSDate * _Nullable )startDate callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete a Device at a specific location.
 * There are multiple ways to delete a device. This ability to delete a device from a specific location is useful for system and organization administrators. Devices linked to a proxy will be removed from the proxy.
 *
 * @param deviceId Required NSString Device ID to be deleted
 * @param locationId Required PPLocationId Location ID that contains the device
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevice:(NSString * _Nonnull )deviceId locationId:(PPLocationId)locationId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteDevice:(NSString * _Nonnull )deviceId currentLocationId:(PPLocationId)currentLocationId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Device activation info

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 *
 * @param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
+ (void)getDeviceActivationInfo:(PPDeviceTypeId)deviceTypeId sendEmail:(PPDeviceActivationSendEmail)sendEmail callback:(PPDeviceActivationBlock _Nonnull )callback;

#pragma mark - Device activation info at a specific location

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 * Registers a device at a specific location.
 *
 * @param locationId Required PPLocationId Location ID to register a device
 * @param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
+ (void)getDeviceActivationInfo:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId sendEmail:(PPDeviceActivationSendEmail)sendEmail callback:(PPDeviceActivationBlock _Nonnull )callback;


#pragma mark - Device Properties

/**
 * Set a single device property
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @param value Required NSString Value to store, 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setDeviceProperty:(NSString * _Nonnull )deviceId name:(NSString * _Nonnull )name value:(NSString * _Nonnull )value index:(NSString * _Nullable )index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Set multiple device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param properties Required NSArray Array of PPDeviceProperty objects
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setDeviceProperties:(NSString * _Nonnull )deviceId properties:(NSArray * _Nonnull )properties userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Get device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name NSString Name of the key, used to recall this property later. 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPDevicePropertiesBlock Device properties callback block
 **/
+ (void)getDeviceProperties:(NSString * _Nonnull )deviceId name:(NSString * _Nullable )name index:(NSString * _Nullable )index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPDevicePropertiesBlock _Nonnull )callback;

/**
 * Delete device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDeviceProperties:(NSString * _Nonnull )deviceId name:(NSString * _Nonnull )name index:(NSString * _Nullable )index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;


#pragma mark - Firmware update

/**
 * Get firmware jobs.
 * Retrieve a list of available firmware updates for user devices.
 *
 * @param deviceId NSString Optional filter by deviceID
 * @param index NSString Check update for specific device part
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param callback PPDeviceFirmwareJobsBlock Device firmware jobs callback block
 **/
+ (void)getDeviceFirmwareJobsDeviceId:(NSString * _Nullable )deviceId index:(NSString * _Nullable )index userId:(PPUserId)userId callback:(PPDeviceFirmwareJobsBlock _Nonnull )callback;

/**
 * Set firmware update status
 * Approve or decline the firmware update.The user can schedule the update after specific date and time.
 *
 * @param deviceId Required NSString Device ID
 * @param status Required PPDeviceFirmwareUpdateStatus New job status: 2 = approve, 3 = decline
 * @param index NSString Update firmware of specific device part
 * @param startDate NSDate Firmware udpate start date
 * @param userId Device owner ID for access by an administrator
 * @param callback PPError Error callback block
 **/
+ (void)setCurrentFirmwareUpdateStatus:(NSString * _Nonnull )deviceId status:(PPDeviceFirmwareUpdateStatus)status index:(NSString * _Nullable )index startDate:(NSDate * _Nullable )startDate userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Video Tokens

/**
 * Get video token.
 * Retrieve a video token for a given provider.
 *
 * @param proxyId Required NSString Device ID of the proxy
 * @param deviceId NSString Device ID of the device, if different from the proxyId
 * @param provider Required PPVideoTokenProvider Video token provider
 * @param identity NSString Twilio token identity. If not set, the device ID will be used.
 * @param expire PPVideoTokenExpireTimeInterval Token expire time in seconds, default is 3600
 * @param appName Required NSString App name, where the key is configured
 * @param authType required PPVideoTokenAuthType Auth token type
 * @param authToken Required NSString Either esp token=ABC12345 or stream session=ABC12345
 * @param appId Required NSString Provider application ID
 * @param callback PPDeviceVideoTokenBlock Video token callback block
 **/
+ (void)getVideoToken:(NSString * _Nonnull )proxyId deviceId:(NSString * _Nullable )deviceId provider:(PPVideoTokenProvider)provider identity:(NSString * _Nullable )identity expire:(PPVideoTokenExpireTimeInterval)expire appName:(NSString * _Nonnull )appName authType:(PPVideoTokenAuthType)authType authToken:(NSString * _Nonnull )authToken appId:(NSString * _Nonnull )appId callback:(PPDeviceVideoTokenBlock _Nonnull )callback;

#pragma mark - Device Spaces

/**
 * Link Space
 * A use can map devices to location spaces. Each device can be linked to one or multiple spaces on the same location based on the device type.
 *
 * @param locationId required PPLocationId Location ID of the device
 * @param deviceId required NSString Device ID of the device
 * @param spaceId required PPLocationSpaceId Space ID of the location space
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)linkSpace:(PPLocationId)locationId deviceId:(NSString * _Nonnull )deviceId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Unlink space
 *
 * @param locationId required PPLocationId Location ID of the device
 * @param deviceId required NSString Device ID of the device
 * @param spaceId required PPLocationSpaceId Space ID of the location space
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)unlinkSpace:(PPLocationId)locationId deviceId:(NSString * _Nonnull )deviceId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock _Nonnull )callback;

@end
