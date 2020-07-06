//
//  PPDeviceMeasurements.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite interacts with devices and UI's through parameters. The command channel parameters to the device are completely separate from the measurement channel parameters back from the device; that is, if you send a command to a device outletStatus = 0, then the device must respond back with a measurement showing outletStatus = 0 before the UI is able to identify the state changed at the device.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPLocation.h"
#import "PPDeviceMeasurement.h"
#import "PPDeviceMeasurementsReading.h"
#import "PPDeviceMeasurementsAlert.h"
#import "PPDeviceMeasurementUnit.h"
#import "PPDeviceCommand.h"
#import "PPDeviceDataRequest.h"

typedef void (^PPDeviceMeasurementsBlock)(NSArray * _Nullable measurements, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsCommandsBlock)(NSArray * _Nullable commands, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsReadingsBlock)(NSArray * _Nullable readings, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsAlertsBlock)(NSArray * _Nullable alerts, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsUnitsBlock)(NSArray * _Nullable units, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryInterval) {
    PPDeviceMeasurementsHistoryIntervalNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryAggregation) {
    PPDeviceMeasurementsHistoryAggregationNone = -1,
    PPDeviceMeasurementsHistoryAggregationLastValueBeforeIntervalPoint = 0,
    PPDeviceMeasurementsHistoryAggregationMinimumValue = 1,
    PPDeviceMeasurementsHistoryAggregationMaximumValue = 2,
    PPDeviceMeasurementsHistoryAggregationMedianValue = 3,
    PPDeviceMeasurementsHistoryAggregationTimeDistributedAverageValue = 4,
    PPDeviceMeasurementsHistoryAggregationAverageValue = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryReduceNoise) {
    PPDeviceMeasurementsHistoryReduceNoiseNone = -1,
    PPDeviceMeasurementsHistoryReduceNoiseFalse = 0,
    PPDeviceMeasurementsHistoryReduceNoiseTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryRowCount) {
    PPDeviceMeasurementsHistoryRowCountNone = -1,
    PPDeviceMeasurementsHistoryRowCountMinimum = 1,
    PPDeviceMeasurementsHistoryRowCountMaximum = 1000
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsDataRequestByEmail) {
    PPDeviceMeasurementsDataRequestByEmailNone = -1,
    PPDeviceMeasurementsDataRequestByEmailFalse = 0,
    PPDeviceMeasurementsDataRequestByEmailTrue = 1
};

@interface PPDeviceMeasurements : PPBaseModel

#pragma mark - Session Management

/**
 * Add measurements.
 * Add measurements to local reference.
 *
 * @param measurements NSArray Array of measurements to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addMeasurements:(NSArray *)measurements userId:(PPUserId)userId;

/**
 * Add readings.
 * Add readings to local reference.
 *
 * @param readings NSArray Array of readings to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addReadings:(NSArray *)readings userId:(PPUserId)userId;

/**
 * Add alerts.
 * Add alerts to local reference.
 *
 * @param alerts NSArray Array of alerts to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addAlerts:(NSArray *)alerts userId:(PPUserId)userId;

/**
 * Add units of measurement.
 * Add units of measurement to local reference.
 *
 * @param unitsOfMeasurement NSArray Array of units of measurement to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addUnitsOfMeasurement:(NSArray *)unitsOfMeasurement userId:(PPUserId)userId;


#pragma mark - Parameters for a specific device

/**
 * Get current measurements
 *
 * @param deviceId Required NSString Device ID to extract parameters from.
 * @param locationId Required PPLocationId Request information on a specific location.
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param shared PPDeviceShared Get parameters from a device shared in circle. If true, the location ID is not required.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getCurrentMeasurements:(NSString * _Nonnull )deviceId locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray * _Nullable )paramNames shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsBlock _Nonnull )callback;
+ (void)getCurrentMeasurements:(NSString * _Nonnull )deviceId locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray * _Nullable )paramNames callback:(PPDeviceMeasurementsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Send a command
 * A successful result code does not indicate the device executed the command. Check the device's parameters in a few moments to see if it updated its status.
 * If the device is offline, you will receive an error code 21, "Device is offline or disconnected".
 * Index number is optional, and only needed if the device interprets or expects an index number.
 * Optional fields:
 *  Index number is needed, if the device interprets or expects an index number.
 *  Unit can be used, if the app needs to use non-system unit for this parameter.
 *  commandTimeout contains the command expiry since the creation in milliseconds.
 *  Comment describes, why this command was made.
 *
 * @param deviceId Required NSString Device ID for which to send a command
 * @param params Required NSArray Array of PPDeviceParameters
 * @param commandTimeout PPDeviceCommandTimeout Command expiry since the creation in milliseconds
 * @param locationId Required PPLocationId Device Location ID
 * @param comment NSString Describes why this command was made
 * @param shared PPDeviceShared Send command to a device shared in circle. If true, the location ID is not required
 * @param callback PPDeviceMeasurementsCommandsBlock Device commands callback block containing array of command responses
 **/
+ (void)sendCommand:(NSString * _Nonnull )deviceId params:(NSArray * _Nonnull )params commandTimeout:(PPDeviceCommandTimeout)commandTimeout locationId:(PPLocationId)locationId comment:(NSString * _Nullable )comment shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsCommandsBlock _Nonnull )callback;
+ (void)sendCommand:(NSString * _Nonnull )deviceId params:(NSArray * _Nonnull )params commandTimeout:(PPDeviceCommandTimeout)commandTimeout locationId:(PPLocationId)locationId callback:(PPDeviceMeasurementsCommandsBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Multiple Device Parameters

/**
 * Get Measurements with Search Terms
 *
 * @param locationId Required PPLocationId Request information on a specific location.
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param deviceId NSString Device ID to extract parameters from.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param shared PPDeviceShared Get parameters from a device shared in circle. If true, the location ID is not required.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString * _Nullable )deviceId paramNames:(NSArray * _Nullable )paramNames shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsBlock _Nonnull )callback;
+ (void)getMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString * _Nonnull )deviceId paramNames:(NSArray * _Nullable )paramNames callback:(PPDeviceMeasurementsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Send Set Commands
 * This API allows to send commands to multiple devices simultaneously.
 * This operation is not atomic. It will try to execute all commands in the same order, as they are provided. If some command fails, it will execute the next one. The result code is returned for each command.
 *
 * @param commands Required NSArray Array of PPDeviceCommands
 * @param locationId Required PPLocationId Device location ID
 * @param shared PPDeviceShared Send command to a device shared in circle. If true, the location ID is not required
 * @param callback PPDeviceMeasurementsCommandsBlock Device commands callback block containing array of command responses
 **/
+ (void)sendSetCommands:(NSArray * _Nonnull )commands locationId:(PPLocationId)locationId shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsCommandsBlock _Nonnull )callback;
+ (void)sendSetCommands:(NSArray * _Nonnull )commands locationId:(PPLocationId)locationId callback:(PPDeviceMeasurementsCommandsBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Search Measurements

/**
 * Get current measurements with Search Terms
 *
 * @param locationId PPLocationId Options Location ID search field to retrieve parameters from
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param deviceId NSString Optional Device ID to extract parameters from.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getCurrentMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString * _Nullable )deviceId paramNames:(NSArray * _Nullable )paramNames callback:(PPDeviceMeasurementsBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Get History of Measurements

/**
 * Get History of Measurements
 *
 * @param deviceId Required NSString Device ID for which to get a history of measurements
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location.
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @param index NSString Only obtain measurements for parameters with this index number.
 * @param interval PPDeviceMeasurementsHistoryInterval OAggregate the readings by this interval, in minutes
 * @param aggregation PPDeviceMeasurementsHistoryAggregation Interval aggregation algorithm
 * @param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getHistoryOfMeasurements:(NSString * _Nonnull )deviceId startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray * _Nullable )paramNames index:(NSString * _Nullable )index interval:(PPDeviceMeasurementsHistoryInterval)interval aggregation:(PPDeviceMeasurementsHistoryAggregation)aggregation reduceNoise:(PPDeviceMeasurementsHistoryReduceNoise)reduceNoise callback:(PPDeviceMeasurementsReadingsBlock _Nonnull )callback;

#pragma mark - Get the Last N Measurements

/**
 * Get the Last N Measurements.
 * The first timestamp reading will contain all measured parameters and their values. All other timestamp readings will only contain the parameters that changed in value.
 *
 * @param deviceId Required NSString Device ID for which to get a history of measurements
 * @param rowCount Required PPDeviceMeasurementsHistoryRowCount Maximum number of measurements to obtain
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @param index NSString Only obtain measurements for parameters with this index number.
 * @param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getlastNMeasurements:(NSString * _Nonnull )deviceId rowCount:(PPDeviceMeasurementsHistoryRowCount)rowCount startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray * _Nullable )paramNames index:(NSString * _Nullable )index reduceNoise:(PPDeviceMeasurementsHistoryReduceNoise)reduceNoise callback:(PPDeviceMeasurementsReadingsBlock _Nonnull )callback;

#pragma mark - History of Alerts

/**
 * Get History of Alerts
 *
 * @param deviceId NSString Device ID for which to get a history of measurements
 * @param alertType NSString Retrieve only alerts of this type
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param callback PPDeviceMeasurementsAlertsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getHistoryOfAlerts:(NSString * _Nullable )deviceId alertType:(NSString * _Nullable )alertType startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPDeviceMeasurementsAlertsBlock _Nonnull )callback;

#pragma mark - Data Requests

/**
 * Submit Data Request
 * Selecting large amount of data from the database can take significant time. To avoid this long waiting period a user can submit requests for all data to the server asynchronously. When the requests will be completed, the user will receive data by email.Currently only requests for historical device parameters and device activities (connection status) are supported.A historical request must contain following fields:
 *      Name            Required    Details
 *      type            Yes         A bitmask with bits
 *                                      1 = device parameters history
 *                                      2 = device activities history
 *      key                         Request key
 *      deviceId        Yes         Device ID
 *      startDate       Yes         Period start time in milliseconds
 *      endDate         Yes         Period end time in milliseconds
 *      paramNames                  Array of device parameter names
 *      index                       Device part index
 *      ordered                     Order data by timestamp
 *                                      1 = ASC
 *                                      -1 = DESC
 *      compression                 Data compression
 *                                      0 = LZ4, default
 *                                      1 = ZIP
 *                                      2 = none
 *
 * Selected data will be uploaded to S3 in CSV format (compressed) and stored for one day.
 *
 * @param locationId Required PPLocationId Location ID to get our data from
 * @param brand NSString Brand name
 * @param byEmail PPDeviceMeasurementsDataRequestByEmail send by email
 * @param requests NSArray<PPDeviceDataRequest> Data Requests
 * @param callback PPErrorBlock Callback block
 **/
+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString * _Nullable )brand requests:(NSArray * _Nullable )requests byEmail:(PPDeviceMeasurementsDataRequestByEmail)byEmail callback:(PPErrorBlock _Nonnull )callback;
+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString * _Nullable )brand requests:(NSArray * _Nullable )requests callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));
+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString * _Nullable )brand type:(PPDeviceDataRequestType)type key:(NSString * _Nullable )key deviceId:(NSString * _Nullable )deviceId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate paramNames:(NSArray * _Nullable )paramNames index:(NSNumber * _Nullable )index ordered:(PPDeviceDataRequestOdered)ordered compression:(PPDeviceDataRequestCompression)compression callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#warning Add Get Data API

#pragma mark - Units of Measurement

/**
 * Get Units of Measurements
 *
 * @param callback PPDeviceMeasurementsUnitsBlock Device measurements units callback block containing array of unit types
 **/
+ (void)getUnitsOfMeasurement:(PPDeviceMeasurementsUnitsBlock _Nonnull )callback;

@end
