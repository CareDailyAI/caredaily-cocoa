//
//  PPTCEnergyManagement.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPAppResources.h>
#import <Peoplepower/PPEnergyManagement.h>
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPNSDate.h>

static NSString *moduleName = @"EnergyManagement";

@interface PPTCEnergyManagement : PPBaseTestCase

@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPEnergyManagementUtilityBill *utilityBill;
@property (strong, nonatomic) PPEnergyManagementBillingInfo *billingInfo;
@property (strong, nonatomic) PPDevice *device;
@end

@implementation PPTCEnergyManagement

- (void)setUp {
    [super setUp];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *utiltiyBillDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_ENERGY_MANAGEMENT_UTILITY_BILL filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *billingInfoDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_ENERGY_MANAGEMENT_BILLING_INFO filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *localDeviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    
    self.location = [PPLocation initWithDictionary:locationDict];
    self.utilityBill = [PPEnergyManagementUtilityBill initWithDictionary:utiltiyBillDict];
    self.billingInfo = [PPEnergyManagementBillingInfo initWithDictionary:billingInfoDict];
    self.device = [PPDevice initWithDictionary:localDeviceDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Energy Measurements by Location

/**
 * Get Energy Usage for a Location.
 *
 * @ param locationId Required PPLocationId Location ID for which to obtain energy measurements
 * @ param aggregation Required PPEnergyManagementAggregation How to aggregate / split the energy data
 * @ param startDate Required NSDate Start date to begin receiving measurements, example: 2014-08-01T12:00:00-08:00
 * @ param endDate NSDate End date to stop receiving measurements, example: 2014-08-01T13:00:00-08:00. Default is the current date.
 * @ param external PPEnergyManagementUsageExternal Define the preference for internal vs. external data sources
 * @ param callback PPEnergyManagementUsageBlock Usage callback block
 **/
- (void)testGetEnergyUsage {
    NSString *methodName = @"GetEnergyUsage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 * 24 * 10)];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/energyUsage/%@/%@", @(self.location.locationId), @(PPEnergyManagementAggregationSplitByDay), [PPNSDate apiFriendStringFromDate:startDate]] statusCode:200 headers:nil];
    
    [PPEnergyManagement getEnergyUsageForLocation:self.location.locationId aggregation:PPEnergyManagementAggregationSplitByDay startDate:startDate endDate:nil external:PPEnergyManagementUsageExternalNone callback:^(NSArray *usages, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Upload Utility Bills for a Location

/**
 * Upload Utility Bills for a Location.
 *
 * @ param locationId Required PPLocationId Location ID for which to update utility bill information
 * @ param billData Required NSArray Bill data to upload
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_testUploadUtilityBillsForLocation {
    NSString *methodName = @"UploadUtilityBillsForLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/billData", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPEnergyManagement uploadUtilityBillsForLocation:self.location.locationId billData:@[self.utilityBill] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Delete a Utility Bill

/**
 * Delete a Utility Bill.
 *
 * @ param locationId Required PPLocationId Location ID for which to delete a utility bill
 * @ param billId Required PPEnergyManagementUtilityBillId Specific Bill ID to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_testDeleteUtilityBill {
    NSString *methodName = @"UploadUtilityBillsForLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/bills/%@", @(self.location.locationId), @(self.utilityBill.billId)] statusCode:200 headers:nil];
    
    [PPEnergyManagement deleteUtilityBill:self.location.locationId billId:self.utilityBill.billId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Get Device Energy Usage

/**
 * Get Device Energy Usage.
 * Return a device's values of power, billing rate, its associated cost, total energy usage, and its cost for the current day, month and year.
 * By default, this API returns total device values. To get the values for the specific part of a device, use an index number (assuming the device supports parameters with index numbers).
 * This method uses the time zone ID from the device location to calculate values. If the time zone is not set, it uses the default server time zone.
 *
 * @ param deviceId Required NSString Device ID for which to obtain energy-related data
 * @ param index NSString Optional index number to obtain energy-related data from a part of a device (assuming the device supports index numbers)
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accountsr
 * @ param userId PPUserId Optional User ID, used by administrator accounts to specific a user to pull energy-related data from
 * @ param callback PPEnergyManagementDeviceUsageBlock Device usage callback block
 **/
- (void)testGetDeviceEnergyUsage {
    NSString *methodName = @"GetDeviceEnergyUsage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/currentEnergyUsage", self.device.deviceId] statusCode:200 headers:nil];
    
    [PPEnergyManagement getDeviceEnergyUsage:self.device.deviceId index:nil locationId:self.location.locationId userId:PPUserIdNone callback:^(PPEnergyManagementDeviceUsagePower *power, PPEnergyManagementDeviceUsageEnergy *energy, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}
#pragma mark - Get Aggregated Energy Usage for a Device

/**
 * Get Aggregated Energy Usage for a Device.
 * Return energy usage at a device level for a specified period of time, and aggregated by different periods.
 * This method uses the time zone ID from the device location to calculate values. If the time zone is not set, it uses the default server time zone.
 *
 * @ param deviceId Required NSString Device ID for which to obtain aggregated energy usage
 * @ param aggregation Required PPEnergyManagementAggregation How to aggregate / split the energy data
 * @ param startDate Required NSDate Start date to begin aggregating energy measurements, example: 2014-08-01T12:00:00-08:00
 * @ param endDate NSDate End date to stop aggregating energy measurements, example: 2014-08-01T13:00:00-08:00. Default is the current date.
 * @ param reduceNoise PPEnergyManagementReducesNoise Return tiny energy values less than defined threshold as zero
 * @ param locationId PPLocationId Request information on a specific location, only called by administrator accounts
 * @ param userId PPUserId User ID to receive aggregated energy measurements from, only called by administrator accounts
 * @ param callback PPEnergyManagementAggregatedDeviceUsageBlock Aggregated device usage callback block
 **/
- (void)testGetAggregatedEnergyUsageForDevice {
    NSString *methodName = @"GetAggregatedEnergyUsageForDevice";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 * 24 * 10)];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/devices/%@/energyUsage/%@/%@", self.device.deviceId, @(PPEnergyManagementAggregationSplitByDay), [PPNSDate apiFriendStringFromDate:startDate]] statusCode:200 headers:nil];
    
    [PPEnergyManagement getAggregatedEnergyUsageForDevice:self.device.deviceId aggregation:PPEnergyManagementAggregationSplitByDay startDate:startDate endDate:nil reduceNoise:PPEnergyManagementReducesNoiseNone locationId:self.location.locationId userId:PPUserIdNone callback:^(NSArray *usages, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}
#pragma mark - Get Billing Information

/**
 * Get Billing Information.
 * The IoT Software Suite contains a billing rates database capable of storing flat-rate, time-of-use, and tiered pricing schemes for utility billing. This group of APIs tracks billing information, and also tracks the user's customizable budget information to help keep them on track.
 * A billing day is the day when the user gets charged by the utility. The billing day is an integer representing a single day of the month, like "28" for the 28th day of the month. Each billing cycle ends on the day before the billing day, at 23:59:59. A new billing cycle starts at 00:00:00 on the billing day.
 *
 * @ param locationId Required PPLocationId Location ID to obtain billing information for.
 * @ param filter Required PPEnergyManagementBillingInfoFilter Filter response by day, budget, rate, or billing
 * @ param callback PPEnergyManagementBillingInfoBlock Billing Info callback block
 **/
- (void)testGetBillingInformation {
    NSString *methodName = @"GetBillingInformation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/billing/%@", @(self.location.locationId), @(PPEnergyManagementBillingInfoFilterGetAllDate)] statusCode:200 headers:nil];
    
    [PPEnergyManagement getBillingInformation:self.location.locationId filter:PPEnergyManagementBillingInfoFilterGetAllDate callback:^(PPEnergyManagementBillingInfo *billingInfo, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}
#pragma mark - Update Billing Information

/**
 * Update Billing Information.
 * Update the billing day, billing rate, and budget information. All fields are optional.
 *
 * @ param locationId Required PPLocationId
 * @ param billingInfo PPEnergyManagementBillingInfo Billing info object to sync to the server
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateBillingInformation {
    NSString *methodName = @"UpdateBillingInformation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/locations/%@/billing", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPEnergyManagement updateBillingInformation:self.location.locationId billingInfo:self.billingInfo callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

@end
