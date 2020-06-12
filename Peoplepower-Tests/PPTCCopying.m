//
//  PPTCCopying.m
//  PPiOSCore-Tests
//
//  Created by Destry Teeter on 2/27/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPUser.h>
#import <Peoplepower/PPRule.h>
#import <Peoplepower/PPDeviceParameter.h>

@interface PPTCCopying : XCTestCase

@end

@implementation PPTCCopying

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testUser {
    NSDictionary *dict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER_2 filename:PLIST_FILE_UNIT_TESTS];
    PPUser *obj = [PPUser initWithDictionary:dict];
    
    XCTAssertNotNil([obj copy]);
}

- (void)testLocation {
    NSDictionary *dict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION_2 filename:PLIST_FILE_UNIT_TESTS];
    PPLocation *obj = [PPLocation initWithDictionary:dict];
    XCTAssertNotNil([obj copy]);
}

- (void)testRule {
    NSDictionary *dict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_RULES_RULE filename:PLIST_FILE_UNIT_TESTS];
    PPRule *obj = [PPRule initWithDictionary:dict];
    XCTAssertNotNil([obj copy]);
}

- (void)testDeviceParameter {
    NSArray *array = (NSArray *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICE_MEASUREMENTS_PARAMETERS filename:PLIST_FILE_UNIT_TESTS];
    for (NSDictionary *dict in array) {
        PPDeviceParameter *obj = [PPDeviceParameter initWithDictionary:dict];
        XCTAssertNotNil([obj copy]);
    }
}

@end
