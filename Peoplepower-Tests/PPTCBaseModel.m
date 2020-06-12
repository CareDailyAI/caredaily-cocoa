//
//  PPTCBaseModel.m
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 3/15/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Peoplepower/PPBaseModel.h>

@interface PPTCBaseModel : XCTestCase

@end

@implementation PPTCBaseModel

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [PPBaseModel disableTracking:YES];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [PPBaseModel disableTracking:NO];
}

- (void)testErrorCodes {
    
    NSError *nilError = [PPBaseModel resultCodeToNSError:0];
    XCTAssertNil(nilError);
    
    NSError *lockedError;
    NSTimeInterval lockTimeout = 300;
    NSDate *lockTime = [NSDate dateWithTimeIntervalSinceNow:300];
    NSString *lockedErrorResponse = [NSString stringWithFormat:@"{\"lockTime\": %@, \"lockTimeout\": %@, \"resultCode\": 19, \"resultCodeDesc\": \"This operation is temporary locked\"}", @(lockTime.timeIntervalSince1970 * 1000), @(lockTimeout * 1000)];
    [PPBaseModel processJSONResponse:[lockedErrorResponse dataUsingEncoding:NSUTF8StringEncoding] error:&lockedError];
    XCTAssertNotNil(lockedError);

    for (NSInteger i = 1; i <= 38; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 10000; i <= 10043; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 20000; i <= 20005; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 30000; i <= 30003; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 40000; i <= 40001; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 50000; i <= 50003; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 60000; i <= 60003; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 70000; i <= 70003; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
    
    for (NSInteger i = 80000; i <= 80003; i++) {
        NSError *error = [PPBaseModel resultCodeToNSError:i];
        XCTAssertNotNil(error);
    }
}

@end
