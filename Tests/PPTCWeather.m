//
//  PPTCWeather.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPWeatherManagement.h>

static NSString *moduleName = @"Weather";

@interface PPTCWeather : PPBaseTestCase

@property (strong, nonatomic) PPLocation *location;

@end

@implementation PPTCWeather

- (void)setUp {
    [super setUp];
    
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    self.location = [PPLocation initWithDictionary:locationDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Forecast by Geocode

/**
 * Get Forecast by Geocode.
 * Retrieve weather forecust at certain point by latitude and longitude.
 *
 * @ param latitude Required CGFloat Latitude
 * @ param longitude Required CGFloat Longitude
 * @ param units NSString Units for measurements, default value is "Metric".
 * @ param hours PPWeatherManagementForecastHours Forecast depth in hours.
 * @ param organizationId Integer For specific organization. Used by administrator only.
 * @ param callback PPWeatherBlock Weather callback block
 **/
- (void)testGetForecastByGeocode {
    NSString *methodName = @"GetForecastByGeocode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/weather/forecast/geocode/%f/%f", self.location.latitude.floatValue, self.location.longitude.floatValue] statusCode:200 headers:nil];
    
    [PPWeatherManagement getForecastByGeocode:self.location.latitude.floatValue longitude:self.location.longitude.floatValue units:nil hours:PPWeatherManagementForecastHoursNone organizationId:-1 callback:^(PPWeather *weather, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Forecast by Location

/**
 * Get Forecast by Location.
 * Retrieve weather forecast by the location address.
 *
 * @ param locationId Required PPLocationId ID of location
 * @ param units NSString Units for measurements, default value is "Metric".
 * @ param hours PPWeatherManagementForecastHours Forecast depth in hours.
 * @ param callback PPWeatherBlock Weather callback block
 **/
- (void)testGetForecastByLocation {
    NSString *methodName = @"GetForecastByLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/weather/forecast/location/%@", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPWeatherManagement getForecastByLocation:self.location.locationId units:nil hours:PPWeatherManagementForecastHoursNone callback:^(PPWeather *weather, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Current weather by Geocode

/**
 * Get current weather by Geocode.
 * Retrieve current weather at certain point by latitude and longitude.
 *
 * @ param latitude Required CGFloat Latitude
 * @ param longitude Required CGFloat Longitude
 * @ param units NSString Units for measurements, default value is "Metric".
 * @ param organizationId Integer For specific organization. Used by administrator only.
 * @ param callback PPWeatherBlock Weather callback block
 **/
- (void)testGetCurrentWeatherByGeocode {
    NSString *methodName = @"GetCurrentWeatherByGeocode";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/weather/current/geocode/%f/%f", self.location.latitude.floatValue, self.location.longitude.floatValue] statusCode:200 headers:nil];
    
    [PPWeatherManagement getCurrentWeatherByGeocode:self.location.latitude.floatValue longitude:self.location.longitude.floatValue units:nil organizationId:-1 callback:^(PPWeather *weather, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

#pragma mark - Current weather by Location

/**
 * Get current weather by Location.
 * Retrieve current weather at the specific location.
 *
 * @ param locationId Required PPLocationId ID of location
 * @ param units NSString Units for measurements, default value is "Metric".
 * @ param callback PPWeatherBlock Weather callback block
 **/
- (void)testGetCurrentWeatherByLocation {
    NSString *methodName = @"GetCurrentWeatherByLocation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/weather/current/location/%@", @(self.location.locationId)] statusCode:200 headers:nil];
    
    [PPWeatherManagement getCurrentWeatherByLocation:self.location.locationId units:nil callback:^(PPWeather *weather, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

@end
