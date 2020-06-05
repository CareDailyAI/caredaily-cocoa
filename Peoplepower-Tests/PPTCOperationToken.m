//
//  PPTCOperationToken.m
//  PPiOSCore-Tests
//
//  Created by Destry Teeter on 2/12/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPOperationTokenManagement.h>

static NSString *moduleName = @"OperationToken";

@interface PPTCOperationToken : PPBaseTestCase

@end

@implementation PPTCOperationToken

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGetOperationToken {
    NSString *methodName = @"GetOperationToken";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/token" statusCode:200 headers:nil];
    
    [PPOperationTokenManagement getOperationToken:PPOperationTokenTypeUserRegistration callback:^(PPOperationToken *operationToken, NSError *error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
