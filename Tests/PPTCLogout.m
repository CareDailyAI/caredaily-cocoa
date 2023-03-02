//
//  PPTCLogout.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/15/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLogout.h>

static NSString *moduleName = @"Logout";

@interface PPTCLogout : PPBaseTestCase

@end

@implementation PPTCLogout

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 * Logout the user and securely remove the API key from the server database. All application instances for this user are simultaneously logged out.
 *
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testLogout {
    NSString *methodName = @"Logout";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/logout" statusCode:200 headers:nil];
    
    [PPLogout logoutcallback:^(NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
    
}

@end
