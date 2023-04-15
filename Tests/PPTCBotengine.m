//
//  PPTCBotengine.m
//  Tests iOS
//
//  Created by Destry Teeter on 4/11/22.
//  Copyright © 2022 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPBotengine.h>

static NSString *moduleName = @"Botengine";

@interface PPTCBotengine : PPBaseTestCase

@property (strong, nonatomic) PPBotengineAppInstance *appInstance;
@end

@implementation PPTCBotengine

- (void)setUp {
    [super setUp];
    
    NSDictionary *appInstanceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_BOTENGINE_APP_INSTANCE filename:PLIST_FILE_UNIT_TESTS];
//
    self.appInstance = [PPBotengineAppInstance appInstanceFromAppInstanceDict:appInstanceDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Synthetic APIs

/**
 * Send a data stream message
 * Applications can send a message to bots.
 * The message can be sent to bots subscribed on the specific data stream address or bots of provided instands ID's
 * End users can send messages to bots only purchased by them including organizational bots. Organization administrators can send messages to organizational bots in the same organization and to non-organization and individual bots of user in this organization.
 * The end user IDs and the bot IDs (appInstanceId) are specified in the request body.
 *
 * @ param scope PPBotengineAppInstanceDataStreamBitmask Optional Bitmask to feed organization and/or individual bots
 * @ param address NSString Data stream address
 * @ param locationId PPLocationId Send data to bots of this location. Mandatatory for end users.
 * @ param organizationId PPOrganizationId Send data to bots of users of the specific organization, used by an administrator.
 * @ param feed NSDictionry Feed to send to the bot
 * @ param appInstanceId NSInteger ID of a specific app instance to obtain information about
 *
 * @ param callback NSError with server status
 */
- (void)testUploadFile {
    NSString *methodName = @"PostDataStream";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];

    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/appstore/stream" statusCode:200 headers:nil];

    [PPBotengine postDataStream:PPBotengineAppInstanceDataStreamBitmaskInvdividual address:@"test" locationId:123 organizationId:PPOrganizationIdNone feed:@{} appInstanceId:PPBotengineAppInstanceIdNone callback:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
