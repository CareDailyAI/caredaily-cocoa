//
//  PPSystemAndUserProperties.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPSystemAndUserProperties.h"
#import "PPCloudEngine.h"

NSInteger SYSTEM_PROPERTY_CACHE_REFRESH_TIME_SECONDS = 21600;
NSInteger USER_PROPERTY_CACHE_REFRESH_TIME_SECONDS = 30;

NSString *USER_PROPERTY_DEFAULT_USER_TEMPERATURE = @"F";
NSString *USER_PROPERTY_DEFAULT_USER_TIME_FORMAT = @"12";
NSString *USER_PROPERTY_DEFAULT_USER_CURRENCY = @"USD";
NSString *USER_PROPERTY_DEFAULT_USER_CURRENCY_COUNTRY = @"United States";
NSString *USER_PROPERTY_NUMERIC_CODE = @"numericCode";
NSString *USER_PROPERTY_DURESS_CODE = @"duressCode";
NSString *USER_PROPERTY_USER_TIME = @"user-time";
NSString *USER_PROPERTY_USER_TEMPERATURE = @"user-temperature";
NSString *USER_PROPERTY_USER_CURRENCY_CODE = @"user-currencyCode";
NSString *USER_PROPERTY_USER_CURRENCY_SYMBOL = @"user-currencySymbol";
NSString *USER_PROPERTY_USER_CURRENCY_COUNTRY = @"user-currencyCountry";
NSString *SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX = @"^.{8,}$";
NSString *SYSTEM_PROPERTY_CALL_CENTER_SUPPORTED_STATE_IDS = @"call_center-supported_state_ids";
NSString *SYSTEM_PROPERTY_ANALYTICS_QUIET = @"analytics-quiet";
NSString *SYSTEM_PROPERTY_ANALYTICS_LEVEL = @"analytics-level";
NSString *SYSTEM_PROPERTY_PERSISTENT_TIMEOUT = @"persistent-timeout";
NSString *SYSTEM_PROPERTY_POST_FILE_RETRY_INTERVAL = @"post-file-retry-interval";
NSString *SYSTEM_PROPERTY_IOS_DEDICATED_CAMERA_URL = @"ios-dedicatedCameraUrl";
NSString *SYSTEM_PROPERTY_SYSTEM_WEB_CACHE_KEY = @"system-web_cache_key";
NSString *SYSTEM_PROPERTY_IOS_PLAYER_MAX_SECONDS_BEFORE_ABORT_READ_FRAME = @"ios-player_max_seconds_before_abort_read_frame";
NSString *SYSTEM_PROPERTY_IOS_LOG_STREAMING_STATISTICS_ON_WOOPRA = @"ios-log_streaming_statistics_on_woopra";
NSString *SYSTEM_PROPERTY_IOS_MAXIMUM_RETRY_CONNECTION_ATTEMPTS_BEFORE_WARNING = @"ios-maximum_retry_connection_attempts_before_warning";
NSString *SYSTEM_PROPERTY_IOS_COUNTDOWN_TIMER_WARNING_DURATION_SECONDS = @"ios-countdown_timer_warning_duration_seconds";
NSString *SYSTEM_PROPERTY_IOS_FREE_COUNTDOWN_TIMER_TOTAL_SECONDS = @"ios-free-countdown_timer_total_seconds";
NSString *SYSTEM_PROPERTY_IOS_FREE_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS = @"ios-free-maximum_live_streaming_recording_seconds";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_RESOLUTION = @"ios-free-default_resolution";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_MAXIMUM_BITRATE = @"ios-free-default_maximum_bitrate";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_FRAMES_PER_SECOND = @"ios-free-default_frames_per_second";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_KEY_FRAME_INTERVAL = @"ios-free-default_key_frame_interval";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_AUDIO_RATE = @"ios-free-default_audio_rate";
NSString *SYSTEM_PROPERTY_IOS_FREE_DEFAULT_BUFFER_LENGTH = @"ios-free-default_buffer_length";
NSString *SYSTEM_PROPERTY_IOS_PRO_COUNTDOWN_TIMER_TOTAL_SECONDS = @"ios-pro-countdown_timer_total_seconds";
NSString *SYSTEM_PROPERTY_IOS_PRO_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS = @"ios-pro-maximum_live_streaming_recording_seconds";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_RESOLUTION = @"ios-pro-default_resolution";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_MAXIMUM_BITRATE = @"ios-pro-default_maximum_bitrate";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_FRAMES_PER_SECOND = @"ios-pro-default_frames_per_second";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_KEY_FRAME_INTERVAL = @"ios-pro-default_key_frame_interval";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_AUDIO_RATE = @"ios-pro-default_audio_rate";
NSString *SYSTEM_PROPERTY_IOS_PRO_DEFAULT_BUFFER_LENGTH = @"ios-pro-default_buffer_length";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_RESOLUTION = @"ios-slow-default_resolution";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_MAXIMUM_BITRATE = @"ios-slow-default_maximum_bitrate";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_FRAMES_PER_SECOND = @"ios-slow-default_frames_per_second";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_KEY_FRAME_INTERVAL = @"ios-slow-default_key_frame_interval";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_AUDIO_RATE = @"ios-slow-default_audio_rate";
NSString *SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_BUFFER_LENGTH = @"ios-slow-default_buffer_length";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_RESOLUTION = @"ios-videocall-default_resolution";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_MAXIMUM_BITRATE = @"ios-videocall-default_maximum_bitrate";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND = @"ios-videocall-default_frames_per_second";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL = @"ios-videocall-default_key_frame_interval";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_AUDIO_RATE = @"ios-videocall-default_audio_rate";
NSString *SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_BUFFER_LENGTH = @"ios-videocall-default_buffer_length";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_RESOLUTION = @"ios-slow-videocall-default_resolution";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_MAXIMUM_RESOLUTION = @"ios-slow-videocall-default_maximum_bitrate";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND = @"ios-slow-videocall-default_frames_per_second";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL = @"ios-slow-videocall-default_key_frame_interval";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_AUDIO_RATE = @"ios-slow-videocall-default_audio_rate";
NSString *SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_BUFFER_LENGTH = @"ios-slow-videocall-default_buffer_length";
NSString *SYSTEM_PROPERTY_CAMERA_MOTION_ALERT_PERIOD_SECONDS = @"camera-motion_alert_period_seconds";
NSString *SYSTEM_PROPERTY_CAMERA_QUANTIFY_MOTION = @"camera-quantify_motion";
NSString *SYSTEM_PROPERTY_DEFAULT_GETTING_STARTED_VIDEO_URL = @"http://peoplepowerco.com/email/PresenceSetupShort.m4v";
NSString *SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_URL = @"getting-started-video-url";
NSString *SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_URL = @"getting-started-thumbnail-url";
NSString *SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_ARRAY = @"getting-started-video-array";
NSString *SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_ARRAY = @"getting-started-video-thumbnail-array";
NSString *SYSTEM_PROPERTY_BRANDS = @"brands";
NSString *SYSTEM_PROPERTY_PASSCODE_LOWERCASE = @"passcode-lowercase"; // BOOL
NSString *SYSTEM_PROPERTY_COMMUNITY_POST_FILE_CONTENT_LIMIT = @"ppc.communityPostFile.contentLimit";

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
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.systemanduserproperties.getUserOrSystemProperty()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
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
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.systemanduserproperties.getUserProperties()", DISPATCH_QUEUE_SERIAL);
    
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
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.systemanduserproperties.updateMultipleUserProperties()", DISPATCH_QUEUE_SERIAL);
    
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
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.systemanduserproperties.getUserProperty()", DISPATCH_QUEUE_SERIAL);
    
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
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.systemanduserproperties.updateSingleUserProperty()", DISPATCH_QUEUE_SERIAL);
    
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

