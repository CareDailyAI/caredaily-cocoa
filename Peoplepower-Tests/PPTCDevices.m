//
//  PPTCDevices.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/17/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPDevices.h>
#import <Peoplepower/PPLocationSpace.h>

static NSString *moduleName = @"Devices";

@interface PPTCDevices : PPBaseTestCase

@property (strong, nonatomic) PPDevice *device;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) NSArray<PPDeviceProperty *> *properties;
@property (strong, nonatomic) PPLocationSpace *space;

@end

@implementation PPTCDevices

- (void)setUp {
    [super setUp];
    
    NSDictionary *deviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSArray *propertiesArray = (NSArray *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_PROPERTIES filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *spaceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_LOCATION_SPACE filename:PLIST_FILE_UNIT_TESTS];
    
    self.device = [PPDevice initWithDictionary:deviceDict];
    self.location = [PPLocation initWithDictionary:locationDict];
    NSMutableArray *properties = @[].mutableCopy;
    [propertiesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [properties addObject:[PPDeviceProperty initWithDictionary:(NSDictionary *)obj]];
    }];
    self.properties = properties;
    self.space = [PPLocationSpace initWithDictionary:spaceDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Manage Devices

/**
 * Register a device
 * Registration response will describe how the device should connect to the cloud server instance.
 *
 * @ param deviceId NSString Globally unique device identifier for this device. Must not include '/' or '' characters.
 * @ param locationId PPLocationId Specific Location to add this device to
 * @ param deviceTypeId PPDeviceTypeId Type of device being registered. Optional, but highly recommended you specify this.
 * @ param authToken PPDevicesAuthToken True - Request an authentication token. False - No authentication token necessary
 * @ param startDate NSDate Timestamp at which to register this product. The IoT Software Suite will ignore inbound measurements with a timestamp before the registration time. Default is the current time at the server.
 * @ param desc NSString Device nickname / description
 * @ param goalId PPDeviceTypeGoalId Device usage goal ID
 * @ param properties NSDictionary Additional properties needed to register the device. e.g. {"properties": [{"name": "username","value": "admin"},{"name": "port","index": "01","value": "1234"}]}
 * @ param callback PPDevicesRegisterBlock Device registration block providing device Id, auth token, device type, exist (whether or not the device was already registered), hot, port, ssl, and error details
 **/
- (void)testRegisterDevice {
    NSString *methodName = @"RegisterDevice";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/devices" statusCode:200 headers:nil];
    
    [PPDevices registerDevice:self.device.deviceId locationId:self.location.locationId deviceTypeId:self.device.typeId authToken:PPDevicesAuthTokenNoAuthenticationTokenNeeded startDate:[NSDate date] desc:self.device.name goalId:self.device.goalId properties:self.device.properties proxyId:nil callback:^(NSString *deviceId, NSString *authToken, PPDeviceTypeId deviceTypeId, PPDevicesExist exist, NSString *host, PPDevicesPort port, PPDevicesUseSSL useSsl, NSError *error) {
                         
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get a list of devices
 * Returns a list of devices belonging to the user. This API returns some UI specific device type attributes and device parameters.
 *
 * @ param locationId PPLocationId Obtain a list of devices for the specified Location ID
 * @ param userId NSNumber Obtain a list of devices for the specified user ID, used by administrators
 * @ param checkPersistent NSNumber Devices may connect to the IoT Software Suite with a persistent GET connection, or a web socket.
 *      true - The server will check for an active persistent connection with the device, and overwrite the previously declared 'connected' value.
 *      false - Do not check for persistent connections when declaring the device "connected" (faster, more efficient)
 *      Not Set - the server will check for a persistent connection only for devices which were not previously declared 'connected'.
 * @ param callback PPDevicesBlock Devices callback block containing list of devices and error object
 **/
- (void)testGetListOfDevicesForLocation {
    NSString *methodName = @"GetListOfDevices";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/devices" statusCode:200 headers:nil];
    
    [PPDevices getListOfDevicesForLocationId:self.location.locationId userId:PPUserIdNone checkPersistent:PPDevicesCheckPersistentTrue callback:^(NSArray *devices, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
                                        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
/**
 * Delete Devices.
 * There are multiple ways to delete a device. This method is the most flexible, allowing multiple devices to be deleted simultaneously. Devices linked to a proxy will be removed from the proxy. Device linked to a hub will be removed from the hub.
 *
 * @ param deviceIds Requried NSArray Array of device IDs to be deleted
 * @ param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @ param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @ param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @ param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteDevices {
    NSString *methodName = @"DeleteDevices";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/devices" statusCode:200 headers:nil];
    
    [PPDevices deleteDevices:self.location.locationId deviceIds:@[self.device.deviceId] keepOnAccount:PPDevicesKeepOnAccountNone keepSlave:PPDevicesKeepSlaveNone keepSlaveOnGateway:PPDevicesKeepSlaveOnGatewayNone clear:PPDevicesClearNone callback:^(NSError *error) {
    
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Manage single device

/**
 * Get Device by ID.
 * Test if the device is owned by this user. If YES, the API will provide the device and the linked location information. Otherwise it will return an error code and only device type and category.
 * The lastDataReceivedDate is the last timestamp at which the IoT Software Suite received and stored data from this device. The lastMeasureDate is the last timestamp of measured data from this device. The startDate is when this device was registered.
 *
 * @ param deviceId Required NSString Device ID to obtain information on
 * @ param checkConnected PPDeviceConnected Check the device connection status
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUresId Request information on a specific user, only called by administrator accounts
 * @ param callback PPDeviceBlock Device callback block with device and location
 **/
- (void)testGetDeviceById {
    NSString *methodName = @"GetDeviceById";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices getDevice:self.device.deviceId checkConnected:PPDeviceConnectedNone locationId:self.location.locationId userId:PPUserIdNone callback:^(PPDevice *device, PPLocation *location, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
/**
 * Update a Device.
 * Update the device nickname / description, the device goal, the newDevice flag, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @ param deviceId Required NSString Device ID to update
 * @ param desc NSString Description / Name of the device
 * @ param goalId PPDeviceTypeGoalId Goal id of this device
 * @ param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @ param locationId PPLocationId New location to move this device to
 * @ param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateDevice {
    NSString *methodName = @"UpdateDevice";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/devices/%@", @(self.location.locationId), self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices updateDevice:self.device.deviceId locationId:self.location.locationId desc:self.device.name goalId:self.device.goalId newDevice:PPDeviceNewDeviceTrue newLocationId:PPLocationIdNone startDate:nil callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a single Device.
 * There are multiple ways to delete a device. This method is foolproof, but can only delete one device at a time. Devices linked to a proxy will be removed from the proxy.
 *
 * @ param deviceId Required NSString Device ID to be deleted
 * @ param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @ param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @ param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @ param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteDeviceAtLocation {
    NSString *methodName = @"DeleteDeviceAtLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/devices/%@", @(self.location.locationId), self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices deleteDevice:self.device.deviceId locationId:self.location.locationId keepOnAccount:PPDevicesKeepOnAccountNone keepSlave:PPDevicesKeepSlaveNone keepSlaveOnGateway:PPDevicesKeepSlaveOnGatewayNone clear:PPDevicesClearNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Manage a device on a specific location

/**
 * Update a Device at a specific location.
 * Update the device nickname / description, the device goal, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @ param deviceId Required NSString Device ID to update
 * @ param currentLocationId Required PPLocationId Location ID that contains the device
 * @ param desc NSString Description / Name of the device
 * @ param goalId PPDeviceTypeGoalId Goal id of this device
 * @ param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @ param locationId PPLocationId New location to move this device to
 * @ param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateDeviceAtLocation {
    NSString *methodName = @"UpdateDeviceAtLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
        
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/devices/%@", @(self.location.locationId), self.device.deviceId] statusCode:200 headers:nil];

        
    [PPDevices updateDevice:self.device.deviceId locationId:self.device.locationId desc:self.device.name goalId:self.device.goalId newDevice:self.device.newDevice newLocationId:self.location.locationId startDate:[NSDate date] callback:^(NSError *error) {
         
       XCTAssertNil(error);
       [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:45.0];
}

#pragma mark - Device activation info

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 *
 * @ param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @ param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @ param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
- (void)testGetDeviceActivationInfo {
    NSString *methodName = @"GetDeviceActivationInfo";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/deviceActivation/%@", @(self.device.typeId)] statusCode:200 headers:nil];
    
    [PPDevices getDeviceActivationInfo:self.device.typeId sendEmail:PPDeviceActivationSendEmailNone callback:^(PPDeviceActivationInfo *deviceActivationInfo, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Device activation info at a specific location

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 * Registers a device at a specific location.
 *
 * @ param locationId Required PPLocationId Location ID to register a device
 * @ param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @ param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @ param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
- (void)testGetDeviceActivationInfoAtLocation {
    NSString *methodName = @"GetDeviceActivationInfoAtLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/deviceActivation/%@", @(self.location.locationId), @(self.device.typeId)] statusCode:200 headers:nil];
    
    [PPDevices getDeviceActivationInfo:self.location.locationId deviceTypeId:self.device.typeId sendEmail:PPDeviceActivationSendEmailNone callback:^(PPDeviceActivationInfo *deviceActivationInfo, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}


#pragma mark - Device Properties

/**
 * Set a single device property
 *
 * @ param deviceId Required NSString Device ID for which to set a key/value property
 * @ param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @ param value Required NSString Value to store, 250 characters max
 * @ param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @ param userId PPUserId Device owner ID for access by an administrator
 * @ param locationId PPLocationId Device location ID for access by an administrator
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSetDeviceProperty {
    NSString *methodName = @"SetDeviceProperty";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/properties", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices setDeviceProperty:self.device.deviceId name:self.properties[0].name value:self.properties[0].content index:self.properties[0].index userId:PPUserIdNone locationId:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Set multiple device properties
 *
 * @ param deviceId Required NSString Device ID for which to set a key/value property
 * @ param properties Required NSArray Array of PPDeviceProperty objects
 * @ param userId PPUserId Device owner ID for access by an administrator
 * @ param locationId PPLocationId Device location ID for access by an administrator
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSetDeviceProperties {
    NSString *methodName = @"SetDeviceProperties";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/properties", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices setDeviceProperties:self.device.deviceId properties:self.properties userId:PPUserIdNone locationId:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get device properties
 *
 * @ param deviceId Required NSString Device ID for which to set a key/value property
 * @ param name NSString Name of the key, used to recall this property later. 250 characters max
 * @ param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @ param userId PPUserId Device owner ID for access by an administrator
 * @ param locationId PPLocationId Device location ID for access by an administrator
 * @ param callback PPDevicePropertiesBlock Device properties callback block
 **/
- (void)testGetDeviceProperties {
    NSString *methodName = @"GetDeviceProperties";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/properties", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices getDeviceProperties:self.device.deviceId name:self.properties[0].name index:self.properties[0].index userId:PPUserIdNone locationId:self.location.locationId callback:^(NSArray *properties, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete device properties
 *
 * @ param deviceId Required NSString Device ID for which to set a key/value property
 * @ param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @ param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @ param userId PPUserId Device owner ID for access by an administrator
 * @ param locationId PPLocationId Device location ID for access by an administrator
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteDeviceProperty {
    NSString *methodName = @"DeleteDeviceProperty";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/properties", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPDevices deleteDeviceProperties:self.device.deviceId name:self.properties[0].name index:self.properties[0].index userId:PPUserIdNone locationId:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Firmware update

/**
 * Get firmware jobs.
 * Retrieve a list of available firmware updates for user devices.
 *
 * @ param deviceId NSString Optional filter by deviceID
 * @ param index NSString Check update for specific device part
 * @ param userId PPUserId Device owner ID for access by an administrator
 * @ param callback PPDeviceFirmwareJobsBlock Device firmware jobs callback block
 **/
- (void)testGetDeviceFirmwareJobs {
    NSString *methodName = @"GetDeviceFirmwareJobs";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/fwupdate"] statusCode:200 headers:nil];
    
    [PPDevices getDeviceFirmwareJobsDeviceId:self.device.deviceId index:nil userId:PPUserIdNone callback:^(NSMutableArray *jobs, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Set firmware update status
 * Approve or decline the firmware update.The user can schedule the update after specific date and time.
 *
 * @ param deviceId Required NSString Device ID
 * @ param status Required PPDeviceFirmwareUpdateStatus New job status: 2 = approve, 3 = decline
 * @ param index NSString Update firmware of specific device part
 * @ param startDate NSDate Firmware udpate start date
 * @ param userId Device owner ID for access by an administrator
 * @ param callback PPError Error callback block
 **/
- (void)testSetCurrentFirmwareUpdateStatus {
    NSString *methodName = @"SetCurrentFirmwareUpdateStatus";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/fwupdate"] statusCode:200 headers:nil];
    
    [PPDevices setCurrentFirmwareUpdateStatus:self.device.deviceId status:PPDeviceFirmwareUpdateStatusDone index:nil startDate:nil userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Device Spaces

/**
 * Link Space
 * A use can map devices to location spaces. Each device can be linked to one or multiple spaces on the same location based on the device type.
 *
 * @ param locationId required PPLocationId Location ID of the device
 * @ param deviceId required NSString Device ID of the device
 * @ param spaceId required PPLocationSpaceId Space ID of the location space
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testLinkSpace {
    NSString *methodName = @"LinkSpace";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/devices/%@/spaces/%@", @(self.location.locationId), self.device.deviceId, @(self.space.spaceId)] statusCode:200 headers:nil];
    
    [PPDevices linkSpace:self.location.locationId deviceId:self.device.deviceId spaceId:self.space.spaceId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Unlink space
 *
 * @ param locationId required PPLocationId Location ID of the device
 * @ param deviceId required NSString Device ID of the device
 * @ param spaceId required PPLocationSpaceId Space ID of the location space
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUnlinkSpace {
    NSString *methodName = @"UnlinkSpace";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/devices/%@/spaces/%@", @(self.location.locationId), self.device.deviceId, @(self.space.spaceId)] statusCode:200 headers:nil];
    
    [PPDevices unlinkSpace:self.location.locationId deviceId:self.device.deviceId spaceId:self.space.spaceId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
