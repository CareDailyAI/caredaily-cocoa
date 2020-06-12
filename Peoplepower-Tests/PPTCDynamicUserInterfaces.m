//
//  PPTCDynamicUserInterfaces.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPNSDate.h>
#import <Peoplepower/PPDynamicUIs.h>

static NSString *moduleName = @"DynamicUIs";

@interface PPTCDynamicUserInterfaces : PPBaseTestCase

@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) PPLocation *location;

@end

@implementation PPTCDynamicUserInterfaces

- (void)setUp {
    [super setUp];
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    
    self.appName = appName;
    self.location = [PPLocation initWithDictionary:locationDict];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Dynamic UI

/**
 * Get Dynamic UI
 *
 * @ param appName Required NSString Unique application name for which to retrieve dynamic UI's
 * @ param version NSString Version number of the app, in case we need different dynamic UI's for one version vs. another
 * @ param callback PPDynamicUIBlock Dynamic UI callback block
 **/
- (void)testGetDynamicUI {
    NSString *methodName = @"GetDynamicUI";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/uiscreens/%@", self.appName] statusCode:200 headers:nil];

    [PPDynamicUIs getDynamicUI:self.appName version:nil callback:^(NSArray *screens, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

#pragma mark - User Totals

/**
 * Get user totals.
 * For the user landing page we are displaying the user's total files, devices, rules and friends. This is a single API to request total numbers.
 *
 * @ param type PPDynamicUILocationTotalsType Bitmask value of selected type(s)
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to get data from the specific user's account.
 * @ param callback PPDynamicUILocationTotalsBlock User totals callback block containing NSDictionary of totals and optional error
 **/
#warning TODO: Fix and replace location totals API
- (void)testGetUserTotals {
    NSString *methodName = @"GetLocationTotals";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/userTotals" statusCode:200 headers:nil];
    
    [PPDynamicUIs getLocationTotals:self.location.locationId type:PPDynamicUILocationTotalsTypeAll userId:PPUserIdNone callback:^(NSDictionary *userTotals, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

@end
