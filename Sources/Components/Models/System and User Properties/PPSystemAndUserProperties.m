//
//  PPSystemAndUserProperties.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPSystemAndUserProperties.h"
#import "PPCloudEngine.h"
#import "PPCurlDebug.h"

@implementation PPSystemAndUserProperties

#pragma mark - Session Management

/**
 * Shared properties across the entire application
 */
+ (NSArray *)sharedPropertiesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    RLMResults<PPProperty *> *sharedProperties = [PPProperty allObjects];
    
    NSMutableArray *sharedPropertiesArray = [[NSMutableArray alloc] initWithCapacity:[sharedProperties count]];
    NSMutableArray *propertiesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPProperty *property in sharedProperties) {
        [sharedPropertiesArray addObject:property];
        
        [propertiesArrayDebug addObject:@{@"name": property.name}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedProperties=%@", __PRETTY_FUNCTION__, propertiesArrayDebug);
#endif
#endif
    return sharedPropertiesArray;
}

/**
 * Add properties.
 * Add properties from local reference.
 *
 * @param properties NSArray Array of properties to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addProperties:(NSArray *)properties userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s properties=%@", __PRETTY_FUNCTION__, properties);
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPProperty *property in properties) {
        [PPProperty createOrUpdateInDefaultRealmWithValue:property];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove properties.
 * Remove properties from local reference.
 *
 * @param properties NSArray Array of properties to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeProperties:(NSArray *)properties userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s properties=%@", __PRETTY_FUNCTION__, properties);
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPProperty *property in properties) {
            [[PPRealm defaultRealm] deleteObject:[PPProperty objectForPrimaryKey:property.name]];
        }
    }];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - User and System Properties

/**
 * Get User or System Property.
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 *
 * @param propertyName NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @param isPublic PPSystemPropertyPublic Return public system property
 * @param callback PPNSStringBlock NSString callback block
 **/
+ (void)getUserOrSystemProperty:(NSString *)propertyName isPublic:(PPSystemPropertyPublic)isPublic callback:(PPNSStringBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"systemProperty/%@", propertyName]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.systemanduserproperties.getUserOrSystemProperty()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            PPLogAPI(@"%@", [PPCurlDebug responseToDescription:responseString]);
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(responseString);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil);
            });
        });
    }];
}

#pragma mark - Manage multiple User Properties

/**
 * Get user properties.
 * This API returna user-specific property values.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * You may also supply only a prefix of the property name you are looking for. The IoT Software Suite will return all properties that contain the given property name prefix.
 *
 * @param propertyName NSString Property name or optional name prefix to filter properties in the batch version
 * @param userId PPUserId User ID, used by an account with administrative privileges to retrieve the properties of another user
 * @param callback PPSystemPropertiesBlock System properties callback block
 **/
+ (void)getUserProperties:(NSString *)propertyName userId:(PPUserId)userId callback:(PPSystemPropertiesBlock)callback {

    NSURLComponents *components = [NSURLComponents componentsWithString:@"userProperties"];
    NSMutableArray *queryItems = @[].mutableCopy;
    if(propertyName) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"propertyName" value:propertyName]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.systemanduserproperties.getUserProperties()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *properties;
            
            if(!error) {
                properties = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *propertyDict in [root objectForKey:@"properties"]) {
                    PPProperty *property = [PPProperty initWithDictionary:propertyDict];
                    [properties addObject:property];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(properties, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Update multiple user properties.
 * The application may update several user properties simultaneously. The maximum value size may be 10,000 characters using this API.
 *
 * @param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user
 * @param properties NSArray Array of properties to update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateMultipleUserProperties:(PPUserId)userId properties:(NSArray *)properties callback:(PPErrorBlock)callback {
    NSAssert1(properties != nil && [properties count] > 0, @"%s missing properties", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"userProperties"];
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    
    NSMutableArray *propertyData = @[].mutableCopy;
    
    for(PPProperty *property in properties) {
        [propertyData addObject:[PPProperty data:property]];
    }
    data[@"property"] = propertyData;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.systemanduserproperties.updateMultipleUserProperties()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage a single User Property

/**
 * Get User Property
 *
 * This API will first attempt to return a user-specific property value in plain text. If there is no user-specific property set, it will attempt to return a system wide property value as plain text. If there is no system property available, it will return no content.
 * When using the returned content in your code, be sure to check for edge cases where no content was retrieved, or the value is out-of-bounds, or the value was not the right type of information your code expects.
 * When retrieving a system property, the API_KEY is optional. When the API key is not presented, the API will always return a System Property and never override it with a User Property of the same name.
 * This is JSON format version of the previously documented API.
 *
 * @param propertyName Required NSString Name of the property value to retrieve, i.e. "presence-ios-debug_level"
 * @param userId PPUserId User ID. used by an account with administrative privileges to retrieve the properties of another user
 * @param isPublic PPSystemPropertyPublic Return public system property
 * @param callback PPSystemPropertyBlock System properties callback block
 **/
+ (void)getUserProperty:(NSString *)propertyName userId:(PPUserId)userId isPublic:(PPSystemPropertyPublic)isPublic callback:(PPSystemPropertyBlock)callback {
    NSAssert1(propertyName != nil, @"%s missing propertyName", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"userProperty/%@?", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:propertyName]]];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.systemanduserproperties.getUserProperty()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPProperty *property;
            
            if(!error) {
                property = [[PPProperty alloc] initWithName:propertyName value:[root objectForKey:@"value"]];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(property, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Update a single user property

/**
 * Update a single user property.
 * The application may update a single user property with a very simple API requiring no XML or JSON body. The maximum value size may be 250 characters using this API.
 *
 * @param propertyName NSString Name of the property to set a value for. Maximum of 250 characters
 * @param value NSString Value to set for this property. Maximum of 250 characters.
 * @param userId PPUserId User ID, used by an account with administrative privileges to update the properties for another user.
 * @param callback PPErrorBlcok Error callback block
 **/
+ (void)updateSingleUserProperty:(NSString *)propertyName value:(NSString *)value userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(propertyName != nil, @"%s missing propertyName", __FUNCTION__);
    NSAssert1(value != nil, @"%s missing value", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"userProperty/%@?", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:propertyName]]];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"value" value:value]];
    if(userId != PPUserIdNone) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.systemanduserproperties.updateSingleUserProperty()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end

