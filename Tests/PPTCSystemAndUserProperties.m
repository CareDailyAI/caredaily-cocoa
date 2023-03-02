//
//  PPTCSystemAndUserProperties.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/20/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPSystemAndUserProperties.h>

static NSString *moduleName = @"SystemAndUserProperties";

@interface PPTCSystemAndUserProperties : PPBaseTestCase

@property (strong, nonatomic) NSArray<PPProperty *> *properties;
@end

@implementation PPTCSystemAndUserProperties

- (void)setUp {
    [super setUp];
    
    NSArray *propertiesArray = (NSArray *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_SYSTEM_AND_USER_PROPERTIES filename:PLIST_FILE_UNIT_TESTS];
    
    NSMutableArray *properties = [[NSMutableArray alloc] initWithCapacity:0];
    [propertiesArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull propertyDict, NSUInteger idx, BOOL * _Nonnull stop) {
        PPProperty *property = [PPProperty initWithDictionary:propertyDict];
        [properties addObject:property];
    }];
    self.properties = properties;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - User and System Properties

/**
 * Get User or System Property.
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 *
 * @ param propertyName NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @ param isPublic PPSystemPropertyPublic Return public system property
 * @ param callback PPNSStringBlock NSString callback block
 **/
- (void)testGetUserOrSystemProperty {
    NSString *methodName = @"GetUserOrSystemProperty";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"txt" path:[NSString stringWithFormat:@"/espapi/cloud/json/systemProperty/%@", USER_PROPERTY_DEFAULT_USER_CURRENCY] statusCode:200 headers:nil];
    
    [PPSystemAndUserProperties getUserOrSystemProperty:USER_PROPERTY_DEFAULT_USER_CURRENCY isPublic:PPSystemPropertyPublicTrue callback:^(NSString *s) {
        
        XCTAssertNotNil(s);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

#pragma mark - Manage multiple User Properties

/**
 * Get user properties.
 * This API returna user-specific property values.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * You may also supply only a prefix of the property name you are looking for. The IoT Software Suite will return all properties that contain the given property name prefix.
 *
 * @ param propertyName NSString Property name or optional name prefix to filter properties in the batch version
 * @ param userId PPUserId User ID, used by an account with administrative privileges to retrieve the properties of another user
 * @ param callback PPSystemPropertiesBlock System properties callback block
 **/
- (void)testGetUserProperties {
    NSString *methodName = @"GetUserProperties";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/userProperties" statusCode:200 headers:nil];
    
    [PPSystemAndUserProperties getUserProperties:nil userId:PPUserIdNone callback:^(NSArray *properties, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

/**
 * Update multiple user properties.
 * The application may update several user properties simultaneously. The maximum value size may be 10,000 characters using this API.
 *
 * @ param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user
 * @ param properties NSArray Array of properties to update
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateMultipleUserProperties {
    NSString *methodName = @"UpdateMultipleUserProperties";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/userProperties" statusCode:200 headers:nil];
    
    [PPSystemAndUserProperties updateMultipleUserProperties:PPUserIdNone properties:self.properties callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

#pragma mark - Manage a single User Property

/**
 * Get User or System Property
 *
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 * This is JSON format version of the previously documented API.
 *
 * @ param propertyName NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @ param userId PPUserId User ID. used by an account with administrative privileges to retrieve the properties of another user
 * @ param isPublic PPSystemPropertyPublic Return public system property
 * @ param callback PPSystemPropertyBlock System property callback block
 **/
- (void)testGetUserProperty {
    NSString *methodName = @"GetUserProperty";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/userProperty/%@", USER_PROPERTY_DEFAULT_USER_CURRENCY] statusCode:200 headers:nil];
    
    [PPSystemAndUserProperties getUserProperty:USER_PROPERTY_DEFAULT_USER_CURRENCY userId:PPUserIdNone isPublic:PPSystemPropertyPublicTrue callback:^(PPProperty *property, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

#pragma mark - Update a single user property

/**
 * Update a single user property.
 * The application may update a single user property with a very simple API requiring no XML or JSON body. The maximum value size may be 250 characters using this API.
 *
 * @ param propertyName NSString Name of the property to set a value for. Maximum of 250 characters
 * @ param value NSString Value to set for this property. Maximum of 250 characters.
 * @ param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user.
 * @ param callback PPErrorBlcok Error callback block
 **/
- (void)testUpdateSingleUserProperty {
    NSString *methodName = @"UpdateSingleUserProperty";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/userProperty/%@", self.properties[0].name] statusCode:200 headers:nil];
    
    [PPSystemAndUserProperties updateSingleUserProperty:self.properties[0].name value:self.properties[0].value userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

@end
