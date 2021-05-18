//
//  PPTCCloudConnectivity.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPCloudConnectivity.h>

static NSString *moduleName = @"CloudConnectivity";

@interface PPTCCloudConnectivity : PPBaseTestCase

@end

@implementation PPTCCloudConnectivity

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - How to ping

/**
 * Check Availability.
 * Ping is disabled on all deployed instances of the IoT Software Suite for security reasons. We use an HTTP GET request to check for cloud availability, which returns "OK" if the IoT Software Suite instance is available. Combine this with the "time" Linux command to measure the response time of the IoT Software Suite.
 *
 * @ param callback PPCloudConnectivityAvailabilityBlock Availability callback block
 **/
- (void)testCheckAvailability {
    NSString *methodName = @"CheckAvailability";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"txt" path:@"/espapi/watch" statusCode:200 headers:nil];
    
    [PPCloudConnectivity checkAvailability:^(NSString *status, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue([status isEqualToString:@"OK"]);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Available Server Instances

/**
 * Get Connection Settings.
 *
 * @ param deviceId NSString When specified, the API will return connection settings for this device. For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @ param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server,
 *      - true - return the server, where the device is connected now or nothing.
 *      Default false for all except streaming API, where it will try to find the server, where the device is connected first.
 * @ param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @ param callback PPCloudConnectivityCloudsBlock Clouds callback block
 **/
- (void)testGetConnectionSettings {
    NSString *methodName = @"GetConnectionSettings";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/settings" statusCode:200 headers:nil];
    
    [PPCloudConnectivity getConnectionSettings:@"myDevice" connected:PPCloudConnectivityConnectedTrue version:1 callback:^(NSArray *clouds, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue([@"Production" isEqualToString:((PPCloudConnectivityCloud *)clouds[0]).name]);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Server Instances

/**
 * Get server.
 * This API returns just one server connection settings by type.
 *
 * @ param type Required NSString Server type
 * @ param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @ param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @ param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @ param brand NSString Return brand specific server, if available.
 * @ param appName NSString Return app specific server, if available.
 * @ param callback PPCloudConnectivityServerBlock Server callback block
 **/
- (void)testGetServer {
    NSString *methodName = @"GetServer";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/settingsServer/%@", CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO] statusCode:200 headers:nil];
    
    [PPCloudConnectivity getServer:CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO deviceId:nil connected:PPCloudConnectivityConnectedNone version:PPCloudConnectivityVersionNone brand:nil appName:nil callback:^(PPCloudConnectivityServer *server, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

/**
 * Get server URL.
 * This API returns just one server connection url by type.
 *
 * @ param type Required NSString Server type
 * @ param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @ param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @ param ssl Required PPCloudConnectivitySSL Flag to return SSL version of the URL, if available
 * @ param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @ param brand NSString Return brand specific server, if available.
 * @ param appName NSString Return app specific server, if available.
 * @ param callback PPCloudConnectivityServerBlock Server callback block
 **/
- (void)testGetServerURL {
    NSString *methodName = @"GetServerURL";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"txt" path:@"/espapi/cloud/json/settingsServer" statusCode:200 headers:nil];
    
    [PPCloudConnectivity getServerURL:CLOUD_CONNECTIVITY_SERVER_TYPE_APP_API deviceId:nil connected:PPCloudConnectivityConnectedNone ssl:PPCloudConnectivitySSLTrue version:PPCloudConnectivityVersionNone brand:nil appName:nil callback:^(NSURL *url, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Cloud Instances

/**
 * Get Cloud Instance.
 * Return the Cloud instance where this specific device should be pointed.
 * This API must be called only after the first initial device start and/or after a factory reset.
 *
 * @ param deviceId Required deviceId NSString Device ID
 * @ param callback PPCloudConnectivityCloudBlock Cloud callback block
 **/
- (void)testGetCloudInstance {
    NSString *methodName = @"GetCloudInstance";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/settingsCloud" statusCode:200 headers:nil];
    
    [PPCloudConnectivity getCloudInstance:@"__DEVICE_ID__" callback:^(PPCloudConnectivityCloud *cloud, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Version Information

/**
 * Get server version information.
 *
 * @ param callback PPCloudConnectivityVersionBlock Version callback block
 **/
//- (void)testGetVersionInformation {
//    NSString *methodName = @"GetVersionInformation";
//    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
//    
//    [self stubRequestForModule:moduleName methodName:methodName ofType:@"txt" path:@"/espapi/version" statusCode:200 headers:nil];
//    
//    [PPCloudConnectivity getVersionInformation:^(NSString *version, NSError *error) {
//
//        XCTAssertNil(error);
//        [expectation fulfill];
//        
//    }];
//    [self waitForExpectations:@[expectation] timeout:10.0];
//}

@end

