//
//  PPTCProfessionalMonitoring.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPUser.h>
#import <Peoplepower/PPProfessionalMonitoring.h>

static NSString *moduleName = @"ProfessionalMonitoring";

@interface PPTCProfessionalMonitoring : PPBaseTestCase

@property (strong, nonatomic) PPUser *user;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPCallCenter *callCenter;
@end

@implementation PPTCProfessionalMonitoring

- (void)setUp {
    [super setUp];
    
    NSDictionary *userDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_USER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *callCenterDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_PROFESSIONAL_MONITORING_CALL_CENTER filename:PLIST_FILE_UNIT_TESTS];
    
    self.user = [PPUser initWithDictionary:userDict];
    self.location = [PPLocation initWithDictionary:locationDict];
    self.callCenter = [PPCallCenter initWithDictionary:callCenterDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Call Center

/**
 * Get call center.
 * Retrieve call center service statuses, if the service is available and if the registration in the third party application has been completed. If the service is available, but the registration has not been completed yet, then the IoT Software Suite does not have enough information to do it.
 * Call center registration can have following statuses:
 *      Value   Status                  Description
 *      0       Unavailable             The service never purchased
 *      1       Available               The service purchased, but the user does not have enough information for registration
 *      2       Registration pending    The registration process has not been completed yet
 *      3       Registered              Registration completed
 *      4       Cancellation pending    The cancellation has not been completed yet
 *      5       Canceled                Cancellation completed
 * To complete the call center registration the user has to submit own name, phone number and address using the update user info API and a list of emergency contacts. The complete list of missing fields is returned.
 * Also this API returns an array of emergency contacts including the first and the last name, the phone number of the person in the order, how they have to be contacted.
 * The alert status with the alert date is returned in a case of an emergency situation. It can have following values:
 *      Value   Status      Description
 *      0                   An alert never raised
 *      1       Raised      An alert raised, but the call center not contacted yet
 *      3       Reported    The alert reported to the call center
 *
 * @ param callback PPCallCenterBlock Call center block containing call center object
 **/
- (void)testGetCallCenter {
    NSString *methodName = @"GetCallCenter";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/callCenter" statusCode:200 headers:nil];
    
    [PPProfessionalMonitoring getCallCenter:self.location.locationId userId:PPUserIdNone callback:^(PPCallCenter *callCenter, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Update call center.
 * Update user's call center record. The API can raise a alert by setting the alert status.
 * If the new alert status is not provided, the API overwrites the call center contacts information. Submitting null or an empty contacts array will not affect existing contacts data.
 *
 * @ param alertStatus PPCallCenterAlertStatus New alert status
 * @ param contacts NSArray Udpated contact list
 * @ param codeword NSString New codeword
 * @ param permit NSString New permit ID
 * @ param callback PPCallCenterBlock Call center callback block
 **/
- (void)testUpdateCallCenter {
    NSString *methodName = @"UpdateCallCenter";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/callCenter" statusCode:200 headers:nil];
    
    [PPProfessionalMonitoring updateCallCenter:self.location.locationId userId:self.user.userId alertStatus:self.callCenter.alertStatus contacts:self.callCenter.contacts codeword:self.callCenter.codeword permit:self.callCenter.permit callback:^(PPCallCenter *callCenter, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Cancel call center.
 * Update user's call center record status to available and delete contacts.
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param callback PPErrorBlock Error callback block
 */
//+ (void)cancelCallCenter:(PPLocationId)locationId callback:(PPErrorBlock)callback;
- (void)testCancelCallCenter {
    NSString *methodName = @"CancelCallCenter";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/callCenter" statusCode:200 headers:nil];
    
    [PPProfessionalMonitoring cancelCallCenter:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Call Center Alerts

/**
 * Get call center alerts.
 * Retrieve history of call center alerts.The alert source type can have following values:
 *      Value   Description
 *      0       Unknown
 *      1       Raised by a rule
 *      2       Raised by a composer app
 *      3       Raised by an app API
 *
 * @ param callback PPCallCenterAlertsBlock Call center alerts callback
 **/
- (void)testGetCallCenterAlerts {
    NSString *methodName = @"GetCallCenterAlerts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/callCenterAlerts" statusCode:200 headers:nil];
    
    [PPProfessionalMonitoring getCallCenterAlerts:self.location.locationId callback:^(NSArray *alerts, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
@end
