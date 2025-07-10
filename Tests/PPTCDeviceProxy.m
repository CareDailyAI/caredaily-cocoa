//
//  PPTCDeviceProxy.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/25/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <XCTest/XCTest.h>
#import <Peoplepower/PPDeviceProxy.h>

@interface PPTCDeviceProxy : PPBaseTestCase <PPDeviceProxyDelegate, PPDeviceProxyLocalDelegate>

@property (nonatomic, strong) XCTestExpectation *measurementExpectation;
@property (nonatomic, strong) XCTestExpectation *proxyExpectation;

@property (nonatomic, strong) NSMutableDictionary *measurements;
@property (nonatomic, strong) NSString *measurementSequenceNumber;
@property (nonatomic, strong) NSString *measurementStatus;

@end

@implementation PPTCDeviceProxy

- (void)setUp {
    [super setUp];
    
    // Configure test cloud
    NSDictionary *cloudDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CLOUD filename:PLIST_FILE_UNIT_TESTS];
    PPCloudConnectivityCloud *cloud = [PPCloudConnectivityCloud initWithDictionary:cloudDict];
    [PPUrl setCustomCloud:cloud];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    
    // Initialize shared users
    [PPUserAccounts initializeSharedUsers];
    
    // Configure user
    XCTestExpectation *userExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:user"];
    
    NSDictionary *userDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER filename:PLIST_FILE_UNIT_TESTS];
    NSString *userPassword = [userDict objectForKey:@"password"];
    PPUser *firstUser = [PPUser initWithDictionary:userDict];
    
    BOOL found = NO;
    for(PPUser *user in [PPUserAccounts sharedUsers]) {
        if([user isEqualToUser:firstUser] && user.sessionKey) {
            found = YES;
            break;
        }
    }
    if(found) {
        [PPUserAccounts switchUser:firstUser];
        [userExpectation fulfill];
    }
    else {
        [PPLogin loginWithUsername:firstUser.username password:userPassword passcode:nil expiry:PPLoginExpiryTypeNever appName:appName callback:^(NSString *APIKey, NSDate *expireDate, NSError *error) {
            
            XCTAssertNil(error);
            
            firstUser.sessionKey = APIKey;
            firstUser.sessionKeyExpiry = expireDate;
            [PPUserAccounts switchUser:firstUser];
            
            [userExpectation fulfill];
            
        }];
    }
    
    [self waitForExpectations:@[userExpectation] timeout:10.0];
    
    // Configure location
    XCTestExpectation *locationExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:location"];
    
    if([[PPUserAccounts currentUser].locations count] > 0) {
        [locationExpectation fulfill];
    }
    else {
        [PPUserAccounts getUserInformationUserId:PPUserIdNone organizationId:PPOrganizationIdNone callback:^(PPUser *user, NSError *error) {
            
            XCTAssertNil(error);
            
            [PPUserAccounts switchUser:user];
            
            [locationExpectation fulfill];
            
        }];
    }
    
    [self waitForExpectations:@[locationExpectation] timeout:10.0];
    
    // Configure devices
    XCTestExpectation *proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:proxy"];
    
    // Device is needed to test some apis
    NSDictionary *localDeviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    
    PPDevice *localDevice = [PPDevice initWithDictionary:localDeviceDict];
    PPDevicesAuthToken registerAuthToken = (PPDevicesAuthToken)((NSString *)[localDeviceDict objectForKey:@"authToken"]).integerValue;
    
    if([PPDeviceProxy currentProxy] && [PPDeviceProxy currentProxy].localDevice && [PPDeviceProxy currentProxy].localDevice.device && [PPDeviceProxy currentProxy].localDevice.device.locationId != PPLocationIdNone) {
        [proxyExpectation fulfill];
    }
    else {
        [PPDevices registerDevice:[NSString stringWithFormat:@"%@:%li", [PPDeviceProxyLocal localUDID], [[PPUserAccounts currentUser] currentLocation].locationId] locationId:[[PPUserAccounts currentUser] currentLocation].locationId deviceTypeId:localDevice.typeId authToken:registerAuthToken startDate:nil desc:localDevice.name goalId:localDevice.goalId properties:localDevice.properties callback:^(NSString *deviceId, NSString *authToken, PPDeviceTypeId deviceTypeId, PPDevicesExist exist, NSDictionary *config, NSString *host, PPDevicesPort port, PPDevicesUseSSL useSsl, NSError *error) {
            
            XCTAssertNil(error);
            
            [PPDevices getListOfDevicesForLocationId:[[PPUserAccounts currentUser] currentLocation].locationId userId:PPUserIdNone checkPersistent:PPDevicesCheckPersistentTrue callback:^(NSArray *devices, NSError *error) {
                
                XCTAssertNil(error);
                
                [PPDevices addDevices:devices userId:[PPUserAccounts currentUser].userId];
                
                PPCloudConnectivityServer *server = [[PPCloudConnectivityServer alloc] initWithType:CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO host:host path:@"/deviceio" port:(PPCloudConnectivityPort)port altPort:PPCloudConnectivityPortNone ssl:(PPCloudConnectivitySSL)useSsl altSsl:PPCloudConnectivitySSLNone brand:nil];
                
                PPDeviceProxy *proxy = [[PPDeviceProxy alloc] initWithAuthToken:authToken server:server localDevice:[[PPDeviceProxyLocal alloc] init]];
                [PPDeviceProxy setProxy:proxy];
                XCTAssertNotNil([PPDeviceProxy currentProxy]);
                
                [proxyExpectation fulfill];
            }];
        }];
    }
    
    
    [self waitForExpectations:@[proxyExpectation] timeout:10.0];
    
    [PPDeviceProxy currentProxy].delegate = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTurnOn {
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    XCTAssertTrue([[PPDeviceProxy currentProxy] isOn]);
    
    [[PPDeviceProxy currentProxy] turnOff];
}

- (void)testSendMeasurement {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    _measurementExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:proxy"];
    
    NSDictionary *parametersArray = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICE_MEASUREMENTS_PARAMETERS filename:PLIST_FILE_UNIT_TESTS];
    
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary *paramDict in parametersArray) {
        PPDeviceParameter *param = [PPDeviceParameter initWithDictionary:paramDict];
        [parameters addObject:param];
    }
    
    _measurementStatus = nil;
    
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:[PPDeviceProxy currentProxy].localDevice.device.deviceId lastDataReceivedDate:[NSDate date] lastMeasureDate:[NSDate date] params:parameters];
    [[PPDeviceProxy currentProxy] sendMeasurement:measurement];
    
    [self waitForExpectations:@[_measurementExpectation] timeout:180.0];
    
    XCTAssertTrue([_measurementStatus isEqualToString:@"ACK"]);
}

- (void)testReceiveCommand {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    _measurementExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:proxy"];
    
    NSDictionary *parametersArray = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICE_MEASUREMENTS_PARAMETERS filename:PLIST_FILE_UNIT_TESTS];
    
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary *paramDict in parametersArray) {
        PPDeviceParameter *param = [PPDeviceParameter initWithDictionary:paramDict];
        [parameters addObject:param];
    }
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:proxy"];
    [PPDeviceMeasurements sendCommand:[PPDeviceProxy currentProxy].localDevice.device.deviceId params:parameters commandTimeout:PPDeviceCommandTimeoutDefault locationId:[PPDeviceProxy currentProxy].localDevice.device.locationId comment:nil shared:PPDeviceSharedNone callback:^(NSArray *commands, NSError *error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation, _measurementExpectation] timeout:10.0];
    
    XCTAssertTrue([_measurementStatus isEqualToString:@"ACK"]);
}

- (void)testMotionVideoAlert {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    _measurementExpectation = [[XCTestExpectation alloc] initWithDescription:@"setUp:proxy"];
    
    NSMutableArray *alertParams = [[NSMutableArray alloc] initWithCapacity:0];
    
    PPDeviceParameter *mediaTypeParam = [PPDeviceParameter initWithDictionary:@{@"name":@"mediaType", @"value":@"1"}];
    PPDeviceParameter *deviceModelParam = [PPDeviceParameter initWithDictionary:@{@"name":@"deviceModel", @"value":[UIDevice currentDevice].localizedModel}];
    PPDeviceParameter *debugParam = [PPDeviceParameter initWithDictionary:@{@"name":@"debug", @"value":@"1"}];
    
    [alertParams addObjectsFromArray:@[mediaTypeParam, deviceModelParam, debugParam]];
    
    PPDeviceMeasurementsAlert *alert = [[PPDeviceMeasurementsAlert alloc] initWithAlertId:[PPDeviceProxy uniqueAlertId] deviceId:[PPDeviceProxy currentProxy].localDevice.device.deviceId alertType:@"motion" receivingDate:[NSDate date] params:alertParams];
    
    [[PPDeviceProxy currentProxy] sendAlert:alert];
    
    [self waitForExpectations:@[_measurementExpectation] timeout:10.0];
    
    XCTAssertTrue([_measurementStatus isEqualToString:@"ACK"]);
}

- (void)testTurnOff {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    [[PPDeviceProxy currentProxy] turnOff];
}

- (void)_testGetVideoToken_Vidyo {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:videoToken"];
    
    NSDictionary *videoTokensDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_VIDEO_TOKENS filename:PLIST_FILE_UNIT_TESTS];
    NSString *appName = [videoTokensDict objectForKey:@"appName"];
    NSString *appId = [[videoTokensDict objectForKey:@"providers"] objectForKey:@(PPVideoTokenProviderVidyo).stringValue];
    
    [PPDevices getVideoToken:[PPDeviceProxy currentProxy].localDevice.device.deviceId deviceId:nil provider:PPVideoTokenProviderVidyo identity:nil expire:PPVideoTokenExpireTimeIntervalNone appName:appName authType:PPVideoTokenAuthTypeDeviceAuthToken authToken:[PPDeviceProxy currentProxy].authToken appId:appId callback:^(PPVideoToken *token, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(token);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
    [[PPDeviceProxy currentProxy] turnOff];
}

- (void)_testGetVideoToken_Twilio {
    
    _proxyExpectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:turnOn"];
    
    [[PPDeviceProxy currentProxy] turnOn:self];
    
    [self waitForExpectations:@[_proxyExpectation] timeout:10.0];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"proxy:videoToken"];
    
    NSDictionary *videoTokensDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_VIDEO_TOKENS filename:PLIST_FILE_UNIT_TESTS];
    NSString *appName = [videoTokensDict objectForKey:@"appName"];
    NSString *appId = [[videoTokensDict objectForKey:@"providers"] objectForKey:@(PPVideoTokenProviderVidyo).stringValue];
    
    [PPDevices getVideoToken:[PPDeviceProxy currentProxy].localDevice.device.deviceId deviceId:nil provider:PPVideoTokenProviderTwilio identity:nil expire:PPVideoTokenExpireTimeIntervalNone appName:appName authType:PPVideoTokenAuthTypeDeviceAuthToken authToken:[PPDeviceProxy currentProxy].authToken appId:appId callback:^(PPVideoToken *token, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(token);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
    [[PPDeviceProxy currentProxy] turnOff];
}

#pragma mark - PPDeviceProxyDelegate

- (void)willSendMeasurement:(NSString *)sequenceNumber measurement:(PPDeviceMeasurement *)measurement {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _measurementSequenceNumber = sequenceNumber;
    if(!_measurements) {
        _measurements = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    if(sequenceNumber) {
        [_measurements setObject:measurement forKey:sequenceNumber];
    }
    
    _measurementStatus = nil;
}

- (void)proxyDidSendMeasurement:(NSString *)sequenceNumber status:(NSString *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if(sequenceNumber) {
        [_measurements removeObjectForKey:sequenceNumber];
    }
    _measurementStatus = status;
    
    [_measurementExpectation fulfill];
}

#pragma mark - PPDeviceLocalDelegate

- (void)localDeviceDidBeginInitialization {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)localDeviceExcededMaxInitiliazationAttempts {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)localDeviceProgress:(PPDeviceProxyLocalProgress)progress message:(NSString *)message {
    NSLog(@"%s progress=%li message=%@", __PRETTY_FUNCTION__, (long)progress, message);
}

- (void)localDeviceReady {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [_proxyExpectation fulfill];
}

- (void)localDeviceDidFailInitializationWithError:(NSError *)error {
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
}


- (void)localDeviceWebSocketReady {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


@end
