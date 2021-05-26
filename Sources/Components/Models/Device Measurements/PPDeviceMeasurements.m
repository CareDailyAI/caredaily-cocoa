//
//  PPDeviceMeasurements.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceMeasurements.h"
#import "PPCloudEngine.h"

@implementation PPDeviceMeasurements

#pragma mark - Session Management

/**
 * Add measurements.
 * Add measurements to local reference.
 *
 * @param measurements NSArray Array of measurements to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addMeasurements:(NSArray *)measurements userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s measurements=%@", __PRETTY_FUNCTION__, measurements);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add readings.
 * Add readings to local reference.
 *
 * @param readings NSArray Array of readings to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addReadings:(NSArray *)readings userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s readings=%@", __PRETTY_FUNCTION__, readings);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add alerts.
 * Add alerts to local reference.
 *
 * @param alerts NSArray Array of alerts to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addAlerts:(NSArray *)alerts userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s alerts=%@", __PRETTY_FUNCTION__, alerts);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add units of measurement.
 * Add units of measurement to local reference.
 *
 * @param unitsOfMeasurement NSArray Array of units of measurement to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addUnitsOfMeasurement:(NSArray *)unitsOfMeasurement userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s unitsOfMeasurement=%@", __PRETTY_FUNCTION__, unitsOfMeasurement);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Parameters for a specific device

/**
 * Get current measurements
 *
 * @param deviceId Required NSString Device ID to extract parameters from.
 * @param locationId Required PPLocationId Request information on a specific location, only called by administrator accounts
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param shared PPDeviceShared Get parameters from a device shared in circle. If true, the location ID is not required.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getCurrentMeasurements:(NSString *)deviceId locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray *)paramNames shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/parameters", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(shared == PPDeviceSharedTrue) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"shared" value:(shared) ? @"true" : @"false"]];
        if(locationId != PPLocationIdNone) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
        }
    }
    else if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(paramNames) {
        for(NSString *paramName in paramNames) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"paramName" value:paramName]];
        }
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getCurrentMeasurements()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *measurements;
            
            if(!error) {
                measurements = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *measurementDict in [root objectForKey:@"devices"]) {
                    PPDeviceMeasurement *measurement = [PPDeviceMeasurement initWithMeasurementDict:measurementDict];
                    [measurements addObject:measurement];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(measurements, error);
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
+ (void)getCurrentMeasurements:(NSString *)deviceId locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray *)paramNames callback:(PPDeviceMeasurementsBlock)callback {
    NSLog(@"%s deprecated. Use +getCurrentMeasurements:locationId:userId:paramNames:shared:callback:", __FUNCTION__);
    [PPDeviceMeasurements getCurrentMeasurements:deviceId locationId:locationId userId:userId paramNames:paramNames shared:PPDeviceSharedNone callback:callback];
}

/**
 * Send a command
 * A successful result code does not indicate the device executed the command. Check the device's parameters in a few moments to see if it updated its status.
 * If the device is offline, you will receive an error code 21, "Device is offline or disconnected".
 * Index number is optional, and only needed if the device interprets or expects an index number.
 * Optional fields:
 *  Index number is needed, if the device interprets or expects an index number.
 *  Unit can be used, if the app needs to use non-system unit for this parameter.
 *  commandTimeout contains the command expiry since the creation in milliseconds.
 *  Comment describes, why this command was made.
 *
 *
 * @param deviceId Required NSString Device ID for which to send a command
 * @param params Required NSArray Array of PPDeviceParameters
 * @param commandTimeout PPDeviceCommandTimeout Command expiry since the creation in milliseconds
 * @param locationId Required PPLocationId Device Location ID
 * @param comment NSString Describes why this command was made
 * @param shared PPDeviceShared Send command to a device shared in circle. If true, the location ID is not required
 * @param commandType PPDeviceMeasurementsCommandType Command type: 0 = set, 4 = get, 5 = update, 6 = delete
 * @param callback PPDeviceMeasurementsCommandsBlock Device commands callback block containing array of command responses
 **/
+ (void)sendCommand:(NSString *)deviceId params:(NSArray *)params commandTimeout:(PPDeviceCommandTimeout)commandTimeout locationId:(PPLocationId)locationId comment:(NSString *)comment shared:(PPDeviceShared)shared commandType:(PPDeviceMeasurementsCommandType)commandType callback:(PPDeviceMeasurementsCommandsBlock _Nonnull)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(params != nil && [params count] > 0, @"%s missing params", __FUNCTION__);

    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/parameters", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    if(shared == PPDeviceSharedTrue) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"shared" value:(shared) ? @"true" : @"false"]];
        if(locationId != PPLocationIdNone) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
        }
    }
    else if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    NSMutableArray *paramsData = @[].mutableCopy;
    for(PPDeviceParameter *param in params) {
        [paramsData addObject:[PPDeviceParameter data:param]];
    }
    data[@"params"] = paramsData;
    
    if(commandTimeout != PPDeviceCommandTimeoutNone) {
        data[@"commandTimeout"] = @(commandTimeout * 1000);
    }
    if(comment) {
        data[@"comment"] = comment;
    }
    if (commandType != PPDeviceMeasurementsCommandTypeNone) {
        data[@"commandType"] = @(commandType);
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.sendCommand()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *commandResponses;
            
            if(!error) {
                commandResponses = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *commandDict in [root objectForKey:@"commands"]) {
                    PPDeviceCommand *command = [PPDeviceCommand initWithDictionary:commandDict];
                    [commandResponses addObject:command];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(commandResponses, error);
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
+ (void)sendCommand:(NSString *)deviceId params:(NSArray *)params commandTimeout:(PPDeviceCommandTimeout)commandTimeout locationId:(PPLocationId)locationId comment:(NSString *)comment shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsCommandsBlock)callback {
    NSLog(@"%s deprecated. Use +sendCommand:deviceId:params:commandTimeout:locationId:comment:shared:commandType:callback:", __FUNCTION__);
    [PPDeviceMeasurements sendCommand:deviceId params:params commandTimeout:commandTimeout locationId:locationId comment:nil shared:PPDeviceSharedNone commandType:PPDeviceMeasurementsCommandTypeNone callback:callback];
}
+ (void)sendCommand:(NSString *)deviceId params:(NSArray *)params commandTimeout:(PPDeviceCommandTimeout)commandTimeout locationId:(PPLocationId)locationId callback:(PPDeviceMeasurementsCommandsBlock)callback {
    NSLog(@"%s deprecated. Use +sendCommand:deviceId:params:commandTimeout:locationId:comment:shared:commandType:callback:", __FUNCTION__);
    [PPDeviceMeasurements sendCommand:deviceId params:params commandTimeout:commandTimeout locationId:locationId comment:nil shared:PPDeviceSharedNone commandType:PPDeviceMeasurementsCommandTypeNone callback:callback];
}

#pragma mark - Multiple Device Parameters

/**
 * Get Measurements with Search Terms
 *
 * @param locationId Required PPLocationId Request information on a specific location.
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param deviceId NSString Device ID to extract parameters from.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param shared PPDeviceShared Get parameters from a device shared in circle. If true, the location ID is not required.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString *)deviceId paramNames:(NSArray *)paramNames shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);

    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"parameters"] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    if(shared == PPDeviceSharedTrue) {[queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"shared" value:(shared) ? @"true" : @"false"]];
        if(locationId != PPLocationIdNone) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
        }
    }
    else if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(paramNames) {
        for(NSString *paramName in paramNames) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"paramName" value:paramName]];
        }
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getMeasurementsWithSearchTerms()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *measurements;
            
            if(!error) {
                measurements = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *measurementDict in [root objectForKey:@"devices"]) {
                    PPDeviceMeasurement *measurement = [PPDeviceMeasurement initWithMeasurementDict:measurementDict];
                    [measurements addObject:measurement];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(measurements, error);
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
+ (void)getMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString *)deviceId paramNames:(NSArray *)paramNames callback:(PPDeviceMeasurementsBlock)callback {
    NSLog(@"%s deprecated. Use +getMeasurementsWithSearchTerms:userId:deviceId:paramNames:shared:callback:", __FUNCTION__);
    [PPDeviceMeasurements getMeasurementsWithSearchTerms:locationId userId:userId deviceId:deviceId paramNames:paramNames shared:PPDeviceSharedNone callback:callback];
}

/**
 * Send Set Commands
 * This API allows to send commands to multiple devices simultaneously.
 * This operation is not atomic. It will try to execute all commands in the same order, as they are provided. If some command fails, it will execute the next one. The result code is returned for each command.
 *
 * @param commands Required NSArray Array of PPDeviceCommands
 * @param locationId Required PPLocationId Device location ID
 * @param shared PPDeviceShared Send command to a device shared in circle. If true, the location ID is not required
 * @param callback PPDeviceMeasurementsCommandsBlock Device commands callback block containing array of command responses
 **/
+ (void)sendSetCommands:(NSArray *)commands locationId:(PPLocationId)locationId shared:(PPDeviceShared)shared callback:(PPDeviceMeasurementsCommandsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(commands != nil && [commands count] > 0, @"%s missing commands", __FUNCTION__);

    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"parameters"] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    if(shared == PPDeviceSharedTrue) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"shared" value:(shared) ? @"true" : @"false"]];
        if(locationId != PPLocationIdNone) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
        }
    }
    else if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    NSMutableArray *devicesData = @[].mutableCopy;
    
    for(PPDeviceCommand *command in commands) {
        
        NSMutableDictionary *commandData = @{}.mutableCopy;
        
        commandData[@"deviceId"] = command.deviceId;
        
        PPDeviceCommandTimeout timeout = PPDeviceCommandTimeoutDefault;
        if(command.commandTimeout != PPDeviceCommandTimeoutNone) {
            timeout = command.commandTimeout;
        }
        commandData[@"commandTimeout"] = @(timeout * 1000);
        NSMutableArray *paramsData = @[].mutableCopy;
        
        for(PPDeviceParameter *param in command.parameters) {
            [paramsData addObject:[PPDeviceParameter data:param]];
        }
        commandData[@"params"] = paramsData;
        if(command.comment) {
            commandData[@"comment"] = command.comment;
        }
        [devicesData addObject:commandData];
    }
    data[@"devices"] = devicesData;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.sendSetCommands()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *commandResponses;
            
            if(!error) {
                commandResponses = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *commandDict in [root objectForKey:@"commands"]) {
                    PPDeviceCommand *command = [PPDeviceCommand initWithDictionary:commandDict];
                    [commandResponses addObject:command];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(commandResponses, error);
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
+ (void)sendSetCommands:(NSArray *)commands locationId:(PPLocationId)locationId callback:(PPDeviceMeasurementsCommandsBlock)callback {
    NSLog(@"%s deprecated. Use +sendSetCommands:locationId:shared:callback:", __FUNCTION__);
    [PPDeviceMeasurements sendSetCommands:commands locationId:locationId shared:PPDeviceSharedNone callback:callback];
}

#pragma mark - Search Measurements

/**
 * Get current measurements with Search Terms
 *
 * @param locationId PPLocationId Options Location ID search field to retrieve parameters from
 * @param userId PPUserId Optional user ID search field for an administrator to retrieve parameters of the device owned by this user.
 * @param deviceId NSString Optional Device ID to extract parameters from.
 * @param paramNames NSArray Optional Parameter names to extract.  You may specify multiple paramName URL parameters to gather multiple specific parameters.
 * @param callback PPDeviceMeasurementsBlock Device measurements callback block containing array of devices and parameters
 **/
+ (void)getCurrentMeasurementsWithSearchTerms:(PPLocationId)locationId userId:(PPUserId)userId deviceId:(NSString *)deviceId paramNames:(NSArray *)paramNames callback:(PPDeviceMeasurementsBlock)callback {
    NSLog(@"%s deprecated. Use +getMeasurementsWithSearchTerms:userId:deviceId:paramNames:shared:callback:", __FUNCTION__);
    [PPDeviceMeasurements getMeasurementsWithSearchTerms:locationId userId:userId deviceId:deviceId paramNames:paramNames shared:PPDeviceSharedNone callback:callback];
}

#pragma mark - Get History of Measurements

/**
 * Get History of Measurements
 *
 * @param deviceId Required NSString Device ID for which to get a history of measurements
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @param index NSString Only obtain measurements for parameters with this index number.
 * @param interval PPDeviceMeasurementsHistoryInterval OAggregate the readings by this interval, in minutes
 * @param aggregation PPDeviceMeasurementsHistoryAggregation Interval aggregation algorithm
 * @param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getHistoryOfMeasurements:(NSString *)deviceId startDate:(NSDate *)startDate endDate:(NSDate *)endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray *)paramNames index:(NSString *)index interval:(PPDeviceMeasurementsHistoryInterval)interval aggregation:(PPDeviceMeasurementsHistoryAggregation)aggregation reduceNoise:(PPDeviceMeasurementsHistoryReduceNoise)reduceNoise callback:(PPDeviceMeasurementsReadingsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/parametersByDate/%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId], [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]]] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(paramNames) {
        for(NSString *paramName in paramNames) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"paramName" value:paramName]];
        }
    }
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(aggregation != PPDeviceMeasurementsHistoryAggregationNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"aggregation" value:@(aggregation).stringValue]];
    }
    if(reduceNoise != PPDeviceMeasurementsHistoryReduceNoiseNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"reduceNoise" value:(reduceNoise) ? @"true" : @"false"]];
    }
    if(interval != PPDeviceMeasurementsHistoryIntervalNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"interval" value:@(interval).stringValue]];
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getHistoryOfMeasurements()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *readings;
            
            if(!error) {
                readings = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *readingDict in [root objectForKey:@"readings"]) {
                    PPDeviceMeasurementsReading *reading = [PPDeviceMeasurementsReading initWithDictionary:readingDict];
                    [readings addObject:reading];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(readings, error);
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

#pragma mark - Get the Last N Measurements

/**
 * Get the Last N Measurements.
 * The first timestamp reading will contain all measured parameters and their values. All other timestamp readings will only contain the parameters that changed in value.
 *
 * @param deviceId Required NSString Device ID for which to get a history of measurements
 * @param rowCount Required PPDeviceMeasurementsHistoryRowCount Maximum number of measurements to obtain
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param paramNames NSArray Only obtain measurements for given parameter names. Multiple names can be passed.
 * @param index NSString Only obtain measurements for parameters with this index number.
 * @param reduceNoise PPDeviceMeasurementsHistoryReduceNoise Return tiny parametert values less than defined threshold as zero
 * @param callback PPDeviceMeasurementsReadingsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getlastNMeasurements:(NSString *)deviceId rowCount:(PPDeviceMeasurementsHistoryRowCount)rowCount startDate:(NSDate *)startDate endDate:(NSDate *)endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId paramNames:(NSArray *)paramNames index:(NSString *)index reduceNoise:(PPDeviceMeasurementsHistoryReduceNoise)reduceNoise callback:(PPDeviceMeasurementsReadingsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(rowCount != PPDeviceMeasurementsHistoryRowCountNone, @"%s missing rowCount", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
                
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/parametersByCount/%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId], @(rowCount)]] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(paramNames) {
        for(NSString *paramName in paramNames) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"paramName" value:paramName]];
        }
    }
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(reduceNoise != PPDeviceMeasurementsHistoryReduceNoiseNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"reduceNoise" value:(reduceNoise) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
              
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getLastNMeasurements()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *readings;
            
            if(!error) {
                readings = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *readingDict in [root objectForKey:@"readings"]) {
                    PPDeviceMeasurementsReading *reading = [PPDeviceMeasurementsReading initWithDictionary:readingDict];
                    [readings addObject:reading];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(readings, error);
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

#pragma mark - History of Alerts

/**
 * Get History of Alerts
 *
 * @param deviceId NSString Device ID for which to get a history of measurements
 * @param alertType NSString Retrieve only alerts of this type
 * @param startDate Required NSDate Start date to begin receiving measurements.
 * @param endDate NSDate End date to stop receiving measurements. Default is the current date.
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive measurements from, only called by administrator accounts
 * @param callback PPDeviceMeasurementsAlertsBlock Device measurements readings callback block containing array of devices and historical readings
 **/
+ (void)getHistoryOfAlerts:(NSString *)deviceId alertType:(NSString *)alertType startDate:(NSDate *)startDate endDate:(NSDate *)endDate locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPDeviceMeasurementsAlertsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
                
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"alerts"] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    if(alertType) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"alertType" value:alertType]];
    }
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getHistoryOfAlerts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *alerts;
            
            if(!error) {
                alerts = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *alertDict in [root objectForKey:@"alerts"]) {
                    PPDeviceMeasurementsAlert *alert = [PPDeviceMeasurementsAlert initWithDictionary:alertDict];
                    [alerts addObject:alert];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(alerts, error);
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

#pragma mark - Data Requests

/**
 * Submit Data Request
 * Selecting large amount of data from the database can take significant time. To avoid this long waiting period a user can submit requests for all data to the server asynchronously. When the requests will be completed, the user will receive data by email.Currently only requests for historical device parameters and device activities (connection status) are supported.A historical request must contain following fields:
 *      Name            Required    Details
 *      type            Yes         A bitmask with bits
 *                                      1 = device parameters history
 *                                      2 = device activities history
 *      key                         Request key
 *      deviceId        Yes         Device ID
 *      startDate       Yes         Period start time in milliseconds
 *      endDate         Yes         Period end time in milliseconds
 *      paramNames                  Array of device parameter names
 *      index                       Device part index
 *      ordered                     Order data by timestamp
 *                                      1 = ASC
 *                                      -1 = DESC
 *      compression                 Data compression
 *                                      0 = LZ4, default
 *                                      1 = ZIP
 *                                      2 = none
 *
 * Selected data will be uploaded to S3 in CSV format (compressed) and stored for one day.
 *
 * @param locationId Required PPLocationId Location ID to get our data from
 * @param brand NSString Brand name
 * @param requests NSArray<PPDeviceDataRequest> Data Requests
 * @param callback PPErrorBlock Callback block
 **/
+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString *)brand requests:(NSArray *)requests byEmail:(PPDeviceMeasurementsDataRequestByEmail)byEmail callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);

    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"dataRequests"] resolvingAgainstBaseURL:NO];

    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (brand) {
        data[@"brand"] = brand;
    }
    if (byEmail != PPDeviceMeasurementsDataRequestByEmailNone) {
        data[@"byEmail"] = (byEmail == PPDeviceMeasurementsDataRequestByEmailTrue) ? @(true) : @(false);
    }
    NSMutableArray *dataRequests = [[NSMutableArray alloc] initWithCapacity:requests.count];
    for (PPDeviceDataRequest *request in requests) {
        [dataRequests addObject:[PPDeviceDataRequest dictionaryRepresentation:request]];
    }
    data[@"dataRequests"] = dataRequests;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.submitDataRequest()", DISPATCH_QUEUE_SERIAL);
    
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

+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString *)brand requests:(NSArray *)requests callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +submitDataRequest:brand:requests:callback:", __FUNCTION__);
    [PPDeviceMeasurements submitDataRequest:locationId brand:brand requests:requests byEmail:PPDeviceMeasurementsDataRequestByEmailFalse callback:callback];
}
+ (void)submitDataRequest:(PPLocationId)locationId brand:(NSString *)brand type:(PPDeviceDataRequestType)type key:(NSString *)key deviceId:(NSString *)deviceId startDate:(NSDate *)startDate endDate:(NSDate *)endDate paramNames:(NSArray *)paramNames index:(NSNumber *)index ordered:(PPDeviceDataRequestOdered)ordered compression:(PPDeviceDataRequestCompression)compression callback:(PPErrorBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +submitDataRequest:brand:requests:callback:", __FUNCTION__);
    PPDeviceDataRequest *request = [[PPDeviceDataRequest alloc] initWithType:type key:key deviceId:deviceId startDate:startDate endDate:endDate paramNames:paramNames index:index ordered:ordered compression:compression];
    [PPDeviceMeasurements submitDataRequest:locationId brand:brand requests:@[request] byEmail:PPDeviceMeasurementsDataRequestByEmailFalse callback:callback];
}

#warning Add Get Data API

#pragma mark - Units of Measurement

/**
 * Get Units of Measurements
 *
 * @param callback PPDeviceMeasurementsUnitsBlock Device measurements units callback block containing array of unit types
 **/
+ (void)getUnitsOfMeasurement:(PPDeviceMeasurementsUnitsBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithString:@"units"];

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.deviceMeasurements.getUnitsOfMeasurements()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *units;
            
            if(!error) {
                units = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *unitDict in [root objectForKey:@"units"]) {
                    PPDeviceMeasurementUnit *unit = [PPDeviceMeasurementUnit initWithDictionary:unitDict];
                    [units addObject:unit];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(units, error);
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


@end
