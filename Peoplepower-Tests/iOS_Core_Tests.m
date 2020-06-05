//
//  iOS_Core_Tests.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/14/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Peoplepower;

@interface iOS_Core_Tests : XCTestCase

@end

@implementation iOS_Core_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testImport {
    PPUser *user = [PPUser initWithDictionary:@{}];
    XCTAssertNotNil(user);
}

@end
