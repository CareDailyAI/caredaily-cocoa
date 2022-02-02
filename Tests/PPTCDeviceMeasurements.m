//
//  PPTCDeviceMeasurements.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/19/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPNSDate.h>

static NSString *moduleName = @"DeviceMeasurements";

@interface PPTCDeviceMeasurements : PPBaseTestCase

@property (strong, nonatomic) PPDevice *device;
@property (strong, nonatomic) NSArray <PPDeviceParameter *> *parameters;
@property (strong, nonatomic) NSArray <NSString *> *parameterNames;
@property (strong, nonatomic) NSArray <PPDeviceCommand *> *commands;

@end

@implementation PPTCDeviceMeasurements

- (void)setUp {
    [super setUp];
    
    NSDictionary *localDeviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    NSArray *parametersArray = (NSArray *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICE_MEASUREMENTS_PARAMETERS filename:PLIST_FILE_UNIT_TESTS];
    
    self.device = [PPDevice initWithDictionary:localDeviceDict];
    NSMutableArray *parameters = @[].mutableCopy;
    NSMutableArray *parameterNames = @[].mutableCopy;
    [parametersArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:(NSDictionary *)obj];
        [parameters addObject:parameter];
        [parameterNames addObject:parameter.name];
    }];
    self.parameters = parameters;
    self.parameterNames = parameterNames;

    self.commands = @[[[PPDeviceCommand alloc] initWithCommandId:PPDeviceCommandIdNone deviceId:self.device.deviceId creationDate:nil typeId:PPDeviceTypeIdNone parameters:self.parameters type:PPDeviceCommandTypeSet result:PPDeviceCommandResultNone commandTimeout:(PPDeviceCommandTimeout)10000 comment:@"_TEST_"]];
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark - Parameters for a specific device

/**
 * Get current measurements
 *
 * @ param deviceId Required NSString Device ID to extract parameters from.
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @ param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @ param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
- (void)testGetCurrentMeasurements {
    NSString *methodName = @"GetCurrentMeasurements";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/devices/%@/parameters", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDeviceMeasurements getCurrentMeasurements:self.device.deviceId locationId:self.device.locationId userId:PPUserIdNone paramNames:nil shared:PPDeviceSharedNone callback:^(NSArray *measurements, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Send a command
 * A successful result code does not indicate the device executed the command. Check the device's parameters in a few moments to see if it updated its status.
 * If the device is offline, you will receive an error code 21, "Device is offline or disconnected".
 * Index number is optional, and only needed if the device interprets or expects an index number.
 *
 * @ param deviceId Required NSString Device ID for which to send a command
 * @ param params Required NSArray Array of PPDeviceParameters
 * @ param commandTimeout PPDeviceCommandTimeout Command expiry since the creation in milliseconds
 * @ param locationId PPLocationId Access the device on a specific location, only called by administrator accounts
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSendCommand {
    NSString *methodName = @"SendCommand";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/devices/%@/parameters", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDeviceMeasurements sendCommand:self.device.deviceId params:self.parameters commandTimeout:PPDeviceCommandTimeoutDefault locationId:self.device.locationId comment:nil shared:PPDeviceSharedNone commandType:0 skipProspect:true callback:^(NSArray *commands, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Multiple Device Parameters

/**
 * Get current measurements with Search Terms
 *
 * @ param locationId PPLocationId Options Location ID search field to retrieve parameters from
 * @ param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @ param deviceId NSString Optional Device ID to extract parameters from.
 * @ param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @ param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
- (void)testGetMeasurementsWithSearchTerms {
    NSString *methodName = @"GetMeasurementsWithSearchTerms";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/parameters" statusCode:200 headers:nil];
    
    [PPDeviceMeasurements getMeasurementsWithSearchTerms:self.device.locationId userId:PPUserIdNone deviceId:nil paramNames:self.parameterNames shared:PPDeviceSharedNone callback:^(NSArray *measurements, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
* Send Set Commands
* This API allows to send commands to multiple devices simultaneously.
* This operation is not atomic. It will try to execute all commands in the same order, as they are provided. If some command fails, it will execute the next one. The result code is returned for each command.
*
* @ param commands Required NSArray Array of PPDeviceCommands
* @ param locationId Required PPLocationId Device location ID
* @ param shared PPDeviceShared Send command to a device shared in circle. If true, the location ID is not required
* @ param callback PPDeviceMeasurementsCommandsBlock Device commands callback block containing array of command responses
**/
- (void)testSendSetCommands {
    NSString *methodName = @"SendSetCommands";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/devices/%@/parameters", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDeviceMeasurements sendSetCommands:self.commands locationId:self.device.locationId shared:PPDeviceSharedNone callback:^(NSArray * _Nullable commands, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get History of Measurements

/**
 * Get History of Measurements
 *
 * @ param deviceId Required NSString Device ID for which to get a history of measurements
 * @ param startDate Required NSDate Start date to begin receiving measurements.
 * @ param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @ param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @ param index NSString Only obtain measurements for parameters with this index number.
 * @ param interval PPDeviceMeasurementsHistoryInterval OAggregate the readings by this interval, in minutes
 * @ param aggregation PPDeviceMeasurementsHistoryAggregation Interval aggregation algorithm
 * @ param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @ param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
- (void)testGetHistoryOfMeasurements {
    NSString *methodName = @"GetHistoryOfMeasurements";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/devices/%@/parametersByDate/%@", self.device.deviceId, [PPNSDate apiFriendStringFromDate:[NSDate dateWithTimeIntervalSince1970:0]]] statusCode:200 headers:nil];
    
    [PPDeviceMeasurements getHistoryOfMeasurements:self.device.deviceId startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:nil locationId:self.device.locationId userId:PPUserIdNone paramNames:self.parameterNames index:nil interval:PPDeviceMeasurementsHistoryIntervalNone aggregation:PPDeviceMeasurementsHistoryAggregationNone reduceNoise:PPDeviceMeasurementsHistoryReduceNoiseNone callback:^(NSArray *readings, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get the Last N Measurements

/**
 * Get the Last N Measurements.
 * The first timestamp reading will contain all measured parameters and their values. All other timestamp readings will only contain the parameters that changed in value.
 *
 * @ param deviceId Required NSString Device ID for which to get a history of measurements
 * @ param rowCount Required PPDeviceMeasurementsHistoryRowCount Maximum number of measurements to obtain
 * @ param startDate Required NSDate Start date to begin receiving measurements.
 * @ param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @ param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @ param index NSString Only obtain measurements for parameters with this index number.
 * @ param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @ param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
- (void)testGetLastNMeasurements {
    NSString *methodName = @"GetLastNMeasurements";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/devices/%@/parametersByCount/%@", self.device.deviceId, @(PPDeviceMeasurementsHistoryRowCountMinimum)] statusCode:200 headers:nil];
    
    
    [PPDeviceMeasurements getlastNMeasurements:self.device.deviceId rowCount:PPDeviceMeasurementsHistoryRowCountMinimum startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:nil locationId:self.device.locationId userId:PPUserIdNone paramNames:self.parameterNames index:nil reduceNoise:PPDeviceMeasurementsHistoryReduceNoiseNone callback:^(NSArray *readings, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - History of Alerts

/**
 * Get History of Alerts
 *
 * @ param deviceId NSString Device ID for which to get a history of measurements
 * @ param alertType NSString Retrieve only alerts of this type
 * @ param startDate Required NSDate Start date to begin receiving measurements.
 * @ param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @ param callback PPDeviceMeasurementsAlertsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
- (void)testGetHistoryOfAlerts {
    NSString *methodName = @"GetHistoryOfAlerts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/alerts" statusCode:200 headers:nil];
    
    [PPDeviceMeasurements getHistoryOfAlerts:nil alertType:nil startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:nil locationId:self.device.locationId userId:PPUserIdNone callback:^(NSArray *alerts, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

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
 * @ param locationId Required PPLocationId Location ID to get our data from
 * @ param brand NSString Brand name
 * @ param type Required int A bitmask with bits
 * @ param key NSString Request Key
 * @ param deviceId Required NSString Device ID
 * @ param startTime Required NSDate Period start time
 * @ param endTime Required NSDate Period endTime
 * @ param paramNames NSArray Array of device parameter names
 * @ param index NSNumber Device part index
 * @ param ordered NSNumber Ordered data by timestamp
 * @ param compression NSNumber Data compression
 **/
- (void)testSubmitDataRequest {
    NSString *methodName = @"SubmitDataRequest";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/dataRequests" statusCode:200 headers:nil];
    
    PPDeviceDataRequest *paramRequest = [[PPDeviceDataRequest alloc] initWithType:PPDeviceDataRequestTypeParameters key:nil deviceId:self.device.deviceId startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:[NSDate date] paramNames:nil index:nil ordered:PPDeviceDataRequestOderedNone compression:PPDeviceDataRequestCompressionZIP];
    PPDeviceDataRequest *activitiesRequest = [[PPDeviceDataRequest alloc] initWithType:PPDeviceDataRequestTypeActivities key:nil deviceId:self.device.deviceId startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:[NSDate date] paramNames:nil index:nil ordered:PPDeviceDataRequestOderedNone compression:PPDeviceDataRequestCompressionZIP];
    
    [PPDeviceMeasurements submitDataRequest:self.device.locationId brand:nil requests:@[paramRequest, activitiesRequest] byEmail:PPDeviceMeasurementsDataRequestByEmailTrue callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Units of Measurement

/**
 * Get Units of Measurements
 *
 * @ param callback PPDeviceMeasurementsUnitsBlock Device measurements units callback block containing array of unit types
 **/
- (void)testGetUnitsOfMeasurement {
    NSString *methodName = @"GetUnitsOfMeasurement";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/units" statusCode:200 headers:nil];
    
    [PPDeviceMeasurements getUnitsOfMeasurement:^(NSArray *units, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
