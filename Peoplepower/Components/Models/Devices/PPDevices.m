//
//  PPDevices.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevices.h"
#import "PPCloudEngine.h"
#import "PPUserAccounts.h"

@implementation PPDevices

#pragma mark - Session Management

__strong static NSMutableDictionary*_sharedDevices = nil;

/**
 * Shared devices across the entire application
 */
+ (NSArray *)sharedDevicesForLocation:(PPLocation *)location userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    NSMutableArray<RLMResults *> *sharedDevices = [[NSMutableArray alloc] initWithCapacity:0];
    if(location) {
        [sharedDevices addObject:[PPDevice objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPDeviceCamera objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPDeviceCameraLocal objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPDevicePictureFrame objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPDevicePictureFrameLocal objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPCircleDevice objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPCircleDeviceCamera objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPCircleDevicePictureFrame objectsWhere:@"locationId == %li", (long)location.locationId]];
        [sharedDevices addObject:[PPFriendshipDevice objectsWhere:@"locationId == %li", (long)location.locationId]];
    }
    else {
        [sharedDevices addObject:[PPDevice allObjects]];
        [sharedDevices addObject:[PPDeviceCamera allObjects]];
        [sharedDevices addObject:[PPDeviceCameraLocal allObjects]];
        [sharedDevices addObject:[PPDevicePictureFrame allObjects]];
        [sharedDevices addObject:[PPDevicePictureFrameLocal allObjects]];
        [sharedDevices addObject:[PPCircleDevice allObjects]];
        [sharedDevices addObject:[PPCircleDeviceCamera allObjects]];
        [sharedDevices addObject:[PPCircleDevicePictureFrame allObjects]];
        [sharedDevices addObject:[PPFriendshipDevice allObjects]];
    }
    NSMutableArray *sharedDevicesArray = [[NSMutableArray alloc] initWithCapacity:[sharedDevices count]];
    NSMutableArray *devicesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(RLMResults *results in sharedDevices) {
        for(PPDevice *device in results) {
            
            if(device.locationId == PPLocationIdNone) {
                // Ignore devices that might be associated with a file.
                continue;
            }
            
            [sharedDevicesArray addObject:device];
            
            [devicesArrayDebug addObject:@{@"deviceId": device.deviceId, @"locationId": @(device.locationId), @"class": NSStringFromClass([device class])}];
        }
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDevices=%@", __PRETTY_FUNCTION__, devicesArrayDebug);
#endif
#endif
    return sharedDevicesArray;
}

/**
 * Add devices.
 * Add devices to local reference.
 *
 * @param devices NSArray Array of devices to remove.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)addDevices:(NSArray *)devices userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s devices=%@", __PRETTY_FUNCTION__, devices);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPDevice *device in devices) {
        if([device isKindOfClass:[PPFriendshipDevice class]]) {
            [PPFriendshipDevice createOrUpdateInDefaultRealmWithValue:device];
        }
        else if([device isKindOfClass:[PPDeviceCameraLocal class]]) {
            [PPDeviceCameraLocal createOrUpdateInDefaultRealmWithValue:device];
            if([[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDevicePictureFrameLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrameLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPDeviceCamera class]]) {
            [PPDeviceCamera createOrUpdateInDefaultRealmWithValue:device];
            if([[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPDevicePictureFrameLocal class]]) {
            [PPDevicePictureFrameLocal createOrUpdateInDefaultRealmWithValue:device];
            if([[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDeviceCameraLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDeviceCameraLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPDevicePictureFrame class]]) {
            [PPDevicePictureFrame createOrUpdateInDefaultRealmWithValue:device];
            if([[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPCircleDeviceCamera class]]) {
            if([[PPDeviceCameraLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                continue;
            }
            [PPCircleDeviceCamera createOrUpdateInDefaultRealmWithValue:device];
            if([[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPCircleDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPCircleDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPCircleDevicePictureFrame class]]) {
            if([[PPDevicePictureFrameLocal objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                continue;
            }
            [PPCircleDevicePictureFrame createOrUpdateInDefaultRealmWithValue:device];
            if([[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPCircleDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPCircleDeviceCamera objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
            else if([[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevicePictureFrame objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else if([device isKindOfClass:[PPCircleDevice class]]) {
            [PPCircleDevice createOrUpdateInDefaultRealmWithValue:device];
            if([[PPDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
        else {
            [PPDevice createOrUpdateInDefaultRealmWithValue:device];
            if([[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId] count] > 0) {
                [[PPRealm defaultRealm] deleteObjects:[PPCircleDevice objectsWhere:@"deviceId == %@ && locationId == %li", device.deviceId, (long)device.locationId]];
            }
        }
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove devices.
 * Remove devices from local reference.
 *
 * @param devices NSArray Array of devices to remove.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)removeDevices:(NSArray *)devices userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s devices=%@", __PRETTY_FUNCTION__, devices);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPDevice *device in devices) {
            if([device isKindOfClass:[PPFriendshipDevice class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPFriendshipDevice objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPCircleDeviceCamera class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPCircleDeviceCamera objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPCircleDevicePictureFrame class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPCircleDevicePictureFrame objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPCircleDevice class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPCircleDevice objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPDeviceCameraLocal class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPDeviceCameraLocal objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPDeviceCamera class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPDeviceCamera objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPDevicePictureFrameLocal class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPDevicePictureFrameLocal objectForPrimaryKey:device.deviceId]];
            }
            else if([device isKindOfClass:[PPDevicePictureFrame class]]) {
                [[PPRealm defaultRealm] deleteObject:[PPDevicePictureFrame objectForPrimaryKey:device.deviceId]];
            }
            else {
                [[PPRealm defaultRealm] deleteObject:[PPDevice objectForPrimaryKey:device.deviceId]];
            }
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Local device from shared devices.
 *
 * @param location Required PPLocation Local device for this location
 * @param userId Required PPUserId User Id to associate these devices with
 *
 * @return PPDevice Local device
 **/
+ (PPDevice *)localDeviceForLocation:(PPLocation *)location userId:(PPUserId)userId {
    NSArray *sharedDevices = [PPDevices sharedDevicesForLocation:location userId:userId];
    
    PPDevice *localDevice;
    for(PPDevice *device in sharedDevices) {
        if([device.deviceId isEqualToString:[PPDeviceProxyLocal localDeviceId:location.locationId]]) {
            localDevice = device;
            break;
        }
    }
    return localDevice;
}

#pragma mark Firmware Update Jobs

/**
 * Shared firmware update jobs across the entire application
 *
 * @return NSArray Array of shared firmware update jobs
 */
+ (NSArray *)sharedFirmwareUpdateJobsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    RLMResults<PPDeviceFirmwareUpdateJob *> *sharedFirmwareUpdateJobs = [PPDeviceFirmwareUpdateJob allObjects];
    NSMutableArray *sharedFirmwareUpdateJobsArray = [[NSMutableArray alloc] initWithCapacity:[sharedFirmwareUpdateJobs count]];
    NSMutableArray *firmwareUpdateJobsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPDeviceFirmwareUpdateJob *firmwareUpdateJob in sharedFirmwareUpdateJobs) {
        [sharedFirmwareUpdateJobsArray addObject:firmwareUpdateJob];
        
        [firmwareUpdateJobsArrayDebug addObject:@{@"jobId": @(firmwareUpdateJob.jobId), @"deviceId": firmwareUpdateJob.device.deviceId}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFirmwareUpdateJobs=%@", __PRETTY_FUNCTION__, firmwareUpdateJobsArrayDebug);
#endif
#endif
    return sharedFirmwareUpdateJobsArray;
}

/**
 * Add firmware update job.
 * Add firmware update jobs to local reference.
 *
 * @param firmwareUpdateJobs NSArray Array of firmware update jobs to add.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)addFirmwareUpdateJobs:(NSArray *)firmwareUpdateJobs userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s firmwareUpdateJobs=%@", __PRETTY_FUNCTION__, firmwareUpdateJobs);
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPDeviceFirmwareUpdateJob *firmwareUpdateJob in firmwareUpdateJobs) {
        [PPDeviceFirmwareUpdateJob createOrUpdateInDefaultRealmWithValue:firmwareUpdateJob];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove firmware update jobs.
 * Remove firmware update jobs from local reference.
 *
 * @param firmwareUpdateJobs NSArray Array of firmware update jobs to remove.
 * @param userId Required PPUserId User Id to associate these devices with
 **/
+ (void)removeFirmwareUpdateJobs:(NSArray *)firmwareUpdateJobs userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s firmwareUpdateJobs=%@", __PRETTY_FUNCTION__, firmwareUpdateJobs);
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPDeviceFirmwareUpdateJob *firmwareUpdateJob in firmwareUpdateJobs) {
            [[PPRealm defaultRealm] deleteObject:[PPDeviceFirmwareUpdateJob objectForPrimaryKey:@(firmwareUpdateJob.jobId)]];
        }
    }];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Manage Devices

/**
 * Register a device
 * Registration response will describe how the device should connect to the cloud server instance.
 *
 * @param deviceId NSString Globally unique device identifier for this device. Must not include '/' or '' characters.
 * @param locationId PPLocationId Specific Location to add this device to
 * @param deviceTypeId PPDeviceTypeId Type of device being registered. Optional, but highly recommended you specify this.
 * @param authToken PPDevicesAuthToken True - Request an authentication token. False - No authentication token necessary
 * @param startDate NSDate Timestamp at which to register this product. The IoT Software Suite will ignore inbound measurements with a timestamp before the registration time. Default is the current time at the server.
 * @param desc NSString Device nickname / description
 * @param goalId PPDeviceTypeGoalId Device usage goal ID
 * @param properties NSArray Additional properties needed to register the device. e.g. [{"name": "username","value": "admin"},{"name": "port","index": "01","value": "1234"}]
 * @param callback PPDevicesRegisterBlock Device registration block providing device Id, auth token, device type, exist (whether or not the device was already registered), hot, port, ssl, and error details
 **/
+ (void)registerDevice:(NSString *)deviceId locationId:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId authToken:(PPDevicesAuthToken)authToken startDate:(NSDate *)startDate desc:(NSString *)desc goalId:(PPDeviceTypeGoalId)goalId properties:(NSArray *)properties proxyId:(NSString *)proxyId callback:(PPDevicesRegisterBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"devices"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    
    if(deviceTypeId != PPDeviceTypeIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceType" value:@(deviceTypeId).stringValue]];
    }
    if(proxyId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"proxyId" value:proxyId]];
    }
    
    if(authToken != PPDevicesAuthTokenNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"authToken" value:(authToken) ? @"true" : @"false"]];
    }
    if(startDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(desc) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"desc" value:desc]];
    }
    if(goalId != PPDeviceTypeGoalIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"goalId" value:@(goalId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableArray *data = @[].mutableCopy;
    if (properties) {
        for(PPDeviceProperty *property in properties) {
            [data addObject:[PPDeviceProperty data:property]];
        }
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"properties": data} options:0 error:&dataError];
    if(dataError) {
        callback(nil, nil, PPDeviceTypeIdNone, PPDevicesExistNone, nil, PPDevicesPortNone, PPDevicesUseSSLNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(properties) {
        [request setHTTPBody:body];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.registerDevice()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
        [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
            
            dispatch_async(queue, ^{
                
                NSError *error = nil;
                NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
                
                NSString *deviceId;
                NSString *authToken;
                PPDeviceTypeId deviceTypeId = PPDeviceTypeIdNone;
                PPDevicesExist exist = PPDevicesExistNone;
                NSString *host;
                PPDevicesPort port = PPDevicesPortNone;
                PPDevicesUseSSL useSSL = PPDevicesUseSSLNone;
                
                if(!error) {
                    deviceId = [root objectForKey:@"deviceId"];
                    authToken = [root objectForKey:@"authToken"];
                    if([root objectForKey:@"deviceType"]) {
                        deviceTypeId = (PPDeviceTypeId)((NSString *)[root objectForKey:@"deviceType"]).integerValue;
                    }
                    if([root objectForKey:@"exist"]) {
                        exist = (PPDevicesExist)((NSString *)[root objectForKey:@"exist"]).boolValue;
                    }
                    host = [root objectForKey:@"host"];
                    if([root objectForKey:@"port"]) {
                        port = (PPDevicesPort)((NSString *)[root objectForKey:@"port"]).integerValue;
                    }
                    if([root objectForKey:@"useSSL"]) {
                        useSSL = (PPDevicesUseSSL)((NSString *)[root objectForKey:@"useSSL"]).boolValue;
                    }
                }
                
                PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(deviceId, authToken, deviceTypeId, exist, host, port, useSSL, error);
                });
            });
        } failure:^(NSError *error) {
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, PPDeviceTypeIdNone, PPDevicesExistNone, nil, PPDevicesPortNone, PPDevicesUseSSLNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            }); 
        }];
}
+ (void)registerDevice:(NSString *)deviceId locationId:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId authToken:(PPDevicesAuthToken)authToken startDate:(NSDate *)startDate desc:(NSString *)desc goalId:(PPDeviceTypeGoalId)goalId properties:(NSArray *)properties callback:(PPDevicesRegisterBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +registerDevice:locationId:deviceTypeId:authToken:startDate:desc:goalId:properties:proxyId:callback:", __FUNCTION__);
    [PPDevices registerDevice:deviceId locationId:locationId deviceTypeId:deviceTypeId authToken:authToken startDate:startDate desc:desc goalId:goalId properties:properties proxyId:nil callback:callback];
}

/**
 * Get a list of devices
 * Returns a list of devices belonging to the user. This API returns some UI specific device type attributes and device parameters.
 *
 * @param locationId Required PPLocationId Obtain a list of devices for the specified Location ID
 * @param userId NSNumber Obtain a list of devices for the specified user ID, used by administrators
 * @param checkPersistent NSNumber Devices may connect to the IoT Software Suite with a persistent GET connection, or a web socket.
 *      true - The server will check for an active persistent connection with the device, and overwrite the previously declared 'connected' value.
 *      false - Do not check for persistent connections when declaring the device "connected" (faster, more efficient)
 *      Not Set - the server will check for a persistent connection only for devices which were not previously declared 'connected'.
 * @param callback PPDevicesBlock Devices callback block containing list of devices and error object
 **/
+ (void)getListOfDevicesForLocationId:(PPLocationId)locationId userId:(PPUserId)userId checkPersistent:(PPDevicesCheckPersistent)checkPersistent callback:(PPDevicesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"devices"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(checkPersistent != PPDevicesCheckPersistentNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"checkPersistent" value:(checkPersistent) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getListOfDevicesForLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSArray *sortedDevices;
            
            if(!error) {
                NSMutableArray *devices = [NSMutableArray arrayWithCapacity:0];
                for(NSDictionary *deviceDict in [root objectForKey:@"devices"]) {
                    PPDevice *device;
                    NSString *deviceId = [deviceDict objectForKey:@"id"];
                    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
                    if([deviceDict objectForKey:@"type"]) {
                        typeId = (PPDeviceTypeId)((NSString *)[deviceDict objectForKey:@"type"]).integerValue;
                    }
                    switch (typeId) {
                        case PPDeviceTypeIdiOSMobileCamera:
                            if([deviceId rangeOfString:[PPDeviceProxyLocal localUDID]].location != NSNotFound) {
                                device = [PPDeviceCameraLocal initWithDictionary:deviceDict];
                                break;
                            }
                            // Fallthrough
                            
                        case PPDeviceTypeIdiOSPictureFrame:
                            if([deviceId rangeOfString:[PPDeviceProxyLocal localUDID]].location != NSNotFound) {
                                device = [PPDevicePictureFrameLocal initWithDictionary:deviceDict];
                                break;
                            }
                            // Fallthrough
                            
                        default:
                            device = [PPDevice initWithDictionary:deviceDict];
                            break;
                    }
                    
                    [devices addObject:device];
                }
                
                sortedDevices = [devices sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    PPDevice *firstDevice = (PPDevice *)a;
                    PPDevice *secondDevice = (PPDevice *)b;
                    
                    // Organize multiple device types alphabetically
                    if(firstDevice.typeId == secondDevice.typeId) {
                        return [firstDevice.name compare:secondDevice.name];
                    }
                    
                    // Organize all devices by device type
                    NSNumber *first = [NSNumber numberWithInt:(int)firstDevice.typeId];
                    NSNumber *second = [NSNumber numberWithInt:(int)secondDevice.typeId];
                    return [second compare:first];
                }];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(sortedDevices, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete Devices.
 * There are multiple ways to delete a device. This method is the most flexible, allowing multiple devices to be deleted simultaneously. Devices linked to a proxy will be removed from the proxy. Device linked to a hub will be removed from the hub.
 *
 * @param deviceIds NSArray Array of device IDs to be deleted
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevices:(PPLocationId)locationId deviceIds:(NSArray *)deviceIds keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceIds != nil && [deviceIds count] > 0, @"%s missing deviceIds", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"devices"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    for(NSString *deviceId in deviceIds) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(keepOnAccount != PPDevicesKeepOnAccountNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepOnAccount" value:(keepOnAccount) ? @"true" : @"false"]];
    }
    if(keepSlave != PPDevicesKeepSlaveNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepSlave" value:(keepSlave) ? @"true" : @"false"]];
    }
    if(keepSlaveOnGateway != PPDevicesKeepSlaveOnGatewayNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepSlaveOnGateway" value:(keepSlaveOnGateway) ? @"true" : @"false"]];
    }
    if(clear != PPDevicesClearNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"clear" value:(clear) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.deleteDevices()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteDevices:(NSArray *)deviceIds keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated, use +deleteDevices:deviceIds:keepOnAccount:keepSlave:keepSlaveOnGateway:clear:callback:", __FUNCTION__);
    [PPDevices deleteDevices:PPLocationIdNone deviceIds:deviceIds keepOnAccount:keepOnAccount keepSlave:keepSlave keepSlaveOnGateway:keepSlaveOnGateway clear:clear callback:callback];
}

#pragma mark - Manage single device

/**
 * Get Device by ID.
 * Test if the device is owned by this user. If YES, the API will provide the device and the linked location information. Otherwise it will return an error code and only device type and category.
 * The lastDataReceivedDate is the last timestamp at which the IoT Software Suite received and stored data from this device. The lastMeasureDate is the last timestamp of measured data from this device. The startDate is when this device was registered.
 *
 * @param deviceId Required NSString Device ID to obtain information on
 * @param checkConnected PPDeviceConnected Check the device connection status
 * @param locationId Required PPLocationId Request information on a specific location, only called by administrator accounts
 * @param userId PPUresId Request information on a specific user, only called by administrator accounts
 * @param callback PPDeviceBlock Device callback block with device and location
 **/
+ (void)getDevice:(NSString *)deviceId checkConnected:(PPDeviceConnected)checkConnected locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPDeviceBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(checkConnected != PPDeviceConnectedNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"checkConnected" value:(checkConnected) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getDevice()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDevice *device;
            PPLocation *location;
            
            if(!error) {
                NSDictionary *deviceDict = [root objectForKey:@"device"];
                NSString *deviceId = [deviceDict objectForKey:@"id"];
                PPDeviceTypeId typeId = PPDeviceTypeIdNone;
                if([deviceDict objectForKey:@"type"]) {
                    typeId = (PPDeviceTypeId)((NSString *)[deviceDict objectForKey:@"type"]).integerValue;
                }
                switch (typeId) {
                    case PPDeviceTypeIdiOSMobileCamera:
                        if([deviceId rangeOfString:[PPDeviceProxyLocal localUDID]].location != NSNotFound) {
                            device = [PPDeviceCameraLocal initWithDictionary:deviceDict];
                        }
                        else {
                            device = [PPDeviceCamera initWithDictionary:deviceDict];
                        }
                        break;
                    case PPDeviceTypeIdiOSPictureFrame:
                        if([deviceId rangeOfString:[PPDeviceProxyLocal localUDID]].location != NSNotFound) {
                            device = [PPDevicePictureFrameLocal initWithDictionary:deviceDict];
                        }
                        else {
                            device = [PPDevicePictureFrame initWithDictionary:deviceDict];
                        }
                        break;
                        
                    default:
                        device = [PPDevice initWithDictionary:deviceDict];
                        break;
                }
                
                NSDictionary *locationDict = [root objectForKey:@"location"];
                location = [PPLocation initWithDictionary:locationDict];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(device, location, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Update a Device.
 * Update the device nickname / description, the device goal, the newDevice flag, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @param deviceId Required NSString Device ID to update
 * @param desc NSString Description / Name of the device
 * @param goalId PPDeviceTypeGoalId Goal id of this device
 * @param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @param locationId Required PPLocationId New location to move this device to
 * @param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateDevice:(NSString *)deviceId desc:(NSString *)desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice locationId:(PPLocationId)locationId startDate:(NSDate *)startDate callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateDevice:locationId:desc:goalId:newDevice:newLocationId:startDate:callback:", __FUNCTION__);
    [PPDevices updateDevice:deviceId locationId:PPLocationIdNone desc:desc goalId:goalId newDevice:newDevice newLocationId:locationId startDate:startDate callback:callback];
}

/**
 * Delete a single Device.
 * There are multiple ways to delete a device. This method is foolproof, but can only delete one device at a time. Devices linked to a proxy will be removed from the proxy.
 *
 * @param deviceId Required NSString Device ID to be deleted
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevice:(NSString *)deviceId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteDevice:locationId:keepOnAccount:keepSlave:keepSlaveOnGateway:clear:callback:", __FUNCTION__);
    [PPDevices deleteDevice:deviceId locationId:PPLocationIdNone keepOnAccount:keepOnAccount keepSlave:keepSlave keepSlaveOnGateway:keepSlaveOnGateway clear:clear callback:callback];
}

#warning Add GetServicesByDevice

#pragma mark - Manage a device on a specific location

/**
 * Update a Device at a specific location.
 * Update the device nickname / description, the device goal, or move the device to a new location / user.
 * The startDate field declares when the device was moved. By default, this is set to the current time when the API call is made. With this field, it's possible to retroactively declare that the device was at a different location in the past.
 *
 * @param deviceId Required NSString Device ID to update
 * @param locationId Required PPLocationId Location ID that contains the device
 * @param desc NSString Description / Name of the device
 * @param goalId PPDeviceTypeGoalId Goal id of this device
 * @param newDevice PPDeviceNewDevice New device tag for this device.  Set to False to stop OOBE.
 * @param newLocationId PPLocationId New location to move this device to
 * @param startDate NSDate Retroactively declare when this device was moved/added to a location
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateDevice:(NSString *)deviceId locationId:(PPLocationId)locationId desc:(NSString *)desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice newLocationId:(PPLocationId)newLocationId startDate:(NSDate *)startDate callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/devices/%@", @(locationId), [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableDictionary *data = @{}.mutableCopy;
        
    if(desc || goalId != PPDeviceTypeGoalIdNone || newDevice != PPDeviceNewDeviceNone) {
        NSMutableDictionary *deviceData = @{}.mutableCopy;
        
        if(desc) {
            deviceData[@"desc"] = desc;
        }
        if(goalId != PPDeviceTypeGoalIdNone) {
            deviceData[@"goalId"] = @(goalId);
        }
        if(newDevice != PPDeviceNewDeviceNone) {
            deviceData[@"newDevice"] = (newDevice) ? @"true" : @"false";
        }
        
        data[@"device"] = deviceData;
    }
    
    if(newLocationId != PPLocationIdNone && startDate) {
        NSMutableDictionary *locationData = @{}.mutableCopy;
        
        if(newLocationId != PPLocationIdNone) {
            locationData[@"id"] = @(newLocationId);
        }
        if(startDate) {
            locationData[@"startDate"] = [PPNSDate apiFriendStringFromDate:startDate];
        }
        data[@"location"] = locationData;
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.updateDeviceAtLocation()", DISPATCH_QUEUE_SERIAL);
    
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
                callback(error);
            });
        });
    }];
}
+ (void)updateDevice:(NSString *)deviceId currentLocationId:(PPLocationId)currentLocationId desc:(NSString *)desc goalId:(PPDeviceTypeGoalId)goalId newDevice:(PPDeviceNewDevice)newDevice locationId:(PPLocationId)locationId startDate:(NSDate *)startDate callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateDevice:locationId:desc:goalId:newDevice:newLocationId:startDate:callback:", __FUNCTION__);
    [PPDevices updateDevice:deviceId locationId:currentLocationId desc:desc goalId:goalId newDevice:newDevice newLocationId:locationId startDate:startDate callback:callback];
}

/**
 * Delete a Device at a specific location.
 * There are multiple ways to delete a device. This ability to delete a device from a specific location is useful for system and organization administrators. Devices linked to a proxy will be removed from the proxy.
 *
 * @param deviceId Required NSString Device ID to be deleted
 * @param locationId Required PPLocationId Location ID that contains the device
 * @param keepOnAccount PPDevicesKeepOnAccount Send only the delete command to the gateway, but keep the device on the user account.
 * @param keepSlave PPDevicesKeepSlave Delete only the gateway from the user account without removing slave devices
 * @param keepSlaveOnGateway PPDevicesKeepSlaveOnGateway Delete slave devices from the account only, but not delete them on the gateway
 * @param clear PPDevicesClear True - Delete the device from all previous locations and clear its current parameter values, but don't delete its history. False - Do not remove the device from previous locations and do not clear its current parameters when deleting it
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDevice:(NSString *)deviceId locationId:(PPLocationId)locationId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/devices/%@", @(locationId), [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(keepOnAccount != PPDevicesKeepOnAccountNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepOnAccount" value:(keepOnAccount) ? @"true" : @"false"]];
    }
    if(keepSlave != PPDevicesKeepSlaveNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepSlave" value:(keepSlave) ? @"true" : @"false"]];
    }
    if(keepSlaveOnGateway != PPDevicesKeepSlaveOnGatewayNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"keepSlaveOnGateway" value:(keepSlaveOnGateway) ? @"true" : @"false"]];
    }
    if(clear != PPDevicesClearNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"clear" value:(clear) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.deleteDeviceAtLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteDevice:(NSString *)deviceId currentLocationId:(PPLocationId)currentLocationId keepOnAccount:(PPDevicesKeepOnAccount)keepOnAccount keepSlave:(PPDevicesKeepSlave)keepSlave keepSlaveOnGateway:(PPDevicesKeepSlaveOnGateway)keepSlaveOnGateway clear:(PPDevicesClear)clear callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteDevice:locationId:keepOnAccount:keepSlave:keepSlaveOnGateway:clear:callback:", __FUNCTION__);
    [PPDevices deleteDevice:deviceId locationId:currentLocationId keepOnAccount:keepOnAccount keepSlave:keepSlave keepSlaveOnGateway:keepSlaveOnGateway clear:clear callback:callback];
}

#pragma mark - Device activation info

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 *
 * @param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
+ (void)getDeviceActivationInfo:(PPDeviceTypeId)deviceTypeId sendEmail:(PPDeviceActivationSendEmail)sendEmail callback:(PPDeviceActivationBlock)callback {
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"deviceActivation/%@", @(deviceTypeId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(sendEmail != PPDeviceActivationSendEmailNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"sendEmail" value:(sendEmail) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getDeviceActivationInfo()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceActivationInfo *activationInfo;
            
            if(!error) {
                activationInfo = [PPDeviceActivationInfo initWithDictionary:root];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(activationInfo, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Device activation info at a specific location

/**
 * Get device activation info.
 * Some devices require manual interaction to complete registration in the IoT Software Suite. This API returns instructions how to do it and can send them to user's email address as well.
 * Registers a device at a specific location.
 *
 * @param locationId Required PPLocationId Location ID to register a device
 * @param deviceTypeId Required PPDeviceTypeId Device type ID for which instructions are requested
 * @param sendEmail PPDevicesSendEmail Requset instructions to be sent by email. False by default.
 * @param callback PPDeviceActivationInfoBlock Device activation info callback block
 **/
+ (void)getDeviceActivationInfo:(PPLocationId)locationId deviceTypeId:(PPDeviceTypeId)deviceTypeId sendEmail:(PPDeviceActivationSendEmail)sendEmail callback:(PPDeviceActivationBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceTypeId != PPDeviceTypeIdNone, @"%s missing deviceTypeId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/deviceActivation/%@", @(locationId), @(deviceTypeId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(sendEmail != PPDeviceActivationSendEmailNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"sendEmail" value:(sendEmail) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getDeviceActivationInfoAtLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPDeviceActivationInfo *activationInfo;
            
            if(!error) {
                activationInfo = [PPDeviceActivationInfo initWithDictionary:root];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(activationInfo, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}


#pragma mark - Device Properties

/**
 * Set a single device property
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @param value Required NSString Value to store, 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setDeviceProperty:(NSString *)deviceId name:(NSString *)name value:(NSString *)value index:(NSString *)index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    NSAssert1(value != nil, @"%s missing value", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/properties", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"value" value:value]];
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.setDeviceProperty()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Set multiple device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param properties Required NSArray Array of PPDeviceProperty objects
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setDeviceProperties:(NSString *)deviceId properties:(NSArray *)properties userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(properties != nil && [properties count] > 0, @"%s missing properties", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/properties", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableArray *data = @[].mutableCopy;
    for(PPDeviceProperty *property in properties) {
        [data addObject:[PPDeviceProperty data:property]];
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"property": data} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.setDeviceProperties()", DISPATCH_QUEUE_SERIAL);
    
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
                callback(error);
            });
        });
    }];
}

/**
 * Get device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name NSString Name of the key, used to recall this property later. 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPDevicePropertiesBlock Device properties callback block
 **/
+ (void)getDeviceProperties:(NSString *)deviceId name:(NSString *)name index:(NSString *)index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPDevicePropertiesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/properties", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    if(name) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    }
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getDeviceProperties()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *properties;
            
            if(!error) {
                properties = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *propertyDict in [root objectForKey:@"properties"]) {
                    PPDeviceProperty *property = [PPDeviceProperty initWithDictionary:propertyDict];
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
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete device properties
 *
 * @param deviceId Required NSString Device ID for which to set a key/value property
 * @param name Required NSString Name of the key, used to recall this property later. 250 characters max
 * @param index NSString Index number, used to specify multiple parameters of the same key like an array
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param locationId Required PPLocationId Device location ID for access by an administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteDeviceProperties:(NSString *)deviceId name:(NSString *)name index:(NSString *)index userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"devices/%@/properties", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.deleteDeviceProperties()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}


#pragma mark - Firmware update

/**
 * Get firmware jobs.
 * Retrieve a list of available firmware updates for user devices.
 *
 * @param deviceId NSString Optional filter by deviceID
 * @param index NSString Check update for specific device part
 * @param userId PPUserId Device owner ID for access by an administrator
 * @param callback PPDeviceFirmwareJobsBlock Device firmware jobs callback block
 **/
+ (void)getDeviceFirmwareJobsDeviceId:(NSString *)deviceId index:(NSString *)index userId:(PPUserId)userId callback:(PPDeviceFirmwareJobsBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"fwupdate"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getDeviceFirmwareUpdateJobs()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *jobs;
            
            if(!error) {
                jobs = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *jobDict in [root objectForKey:@"jobs"]) {
                    PPDeviceFirmwareUpdateJob *job = [PPDeviceFirmwareUpdateJob initWithDictionary:jobDict];
                    [jobs addObject:job];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(jobs, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Set firmware update status
 * Approve or decline the firmware update.The user can schedule the update after specific date and time.
 *
 * @param deviceId Required NSString Device ID
 * @param status Required PPDeviceFirmwareUpdateStatus New job status: 2 = approve, 3 = decline
 * @param index NSString Update firmware of specific device part
 * @param startDate NSDate Firmware udpate start date
 * @param userId Device owner ID for access by an administrator
 * @param callback PPError Error callback block
 **/
+ (void)setCurrentFirmwareUpdateStatus:(NSString *)deviceId status:(PPDeviceFirmwareUpdateStatus)status index:(NSString *)index startDate:(NSDate *)startDate userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(status != PPDeviceFirmwareUpdateStatusNone, @"%s missing status", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"fwupdate"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"status" value:@(status).stringValue]];
    if(index) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"index" value:index]];
    }
    if(startDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.setCurrentFirmwareUpdateStatus()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Video Tokens

/**
 * Get video token.
 * Retrieve a video token for a given provider.
 *
 * @param proxyId Required NSString Device ID of the proxy
 * @param deviceId NSString Device ID of the device, if different from the proxyId
 * @param provider Required PPVideoTokenProvider Video token provider
 * @param identity NSString Twilio token identity. If not set, the device ID will be used.
 * @param expire PPVideoTokenExpireTimeInterval Token expire time in seconds, default is 3600
 * @param appName Required NSString App name, where the key is configured
 * @param authType required PPVideoTokenAuthType Auth token type
 * @param authToken Required NSString Either esp token=ABC12345 or stream session=ABC12345
 * @param appId Required NSString Provider application ID
 * @param callback PPDeviceVideoTokenBlock Video token callback block
 **/
+ (void)getVideoToken:(NSString *)proxyId deviceId:(NSString *)deviceId provider:(PPVideoTokenProvider)provider identity:(NSString *)identity expire:(PPVideoTokenExpireTimeInterval)expire appName:(NSString *)appName authType:(PPVideoTokenAuthType)authType authToken:(NSString *)authToken appId:(NSString *)appId callback:(PPDeviceVideoTokenBlock)callback {
    NSAssert1(provider != PPVideoTokenProviderNone, @"%s missing provider", __FUNCTION__);
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    NSAssert1(authType != PPVideoTokenAuthTypeNone, @"%s missing authType", __FUNCTION__);
    NSAssert1(authToken != nil, @"%s missing authToken", __FUNCTION__);
    NSAssert1(appId != nil, @"%s missing appId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"videoToken"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"proxyId" value:proxyId]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"provider" value:@(provider).stringValue]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(expire != PPVideoTokenExpireTimeIntervalNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"expire" value:@(expire).stringValue]];
    }
    if(identity) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"identity" value:identity]];
    }
    components.queryItems = queryItems;
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(authType == PPVideoTokenAuthTypeDeviceAuthToken) {
        [request setValue:[NSString stringWithFormat:@"esp token=%@", authToken] forHTTPHeaderField:@"PPCAuthorization"];
    }
    else if(authType == PPVideoTokenAuthTypeStreamingId) {
        [request setValue:[NSString stringWithFormat:@"stream session=%@", authToken] forHTTPHeaderField:@"PPCAuthorization"];
    }
    [request setValue:appId forHTTPHeaderField:@"APP_ID"];
       
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.getVideoToken()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPVideoToken *token;
            
            if(!error) {
                if([root objectForKey:@"token"]) {
                    token = [PPVideoToken initWithDictionary:root];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(token, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        });
    }];
}

#pragma mark - Device Spaces

/**
 * Link Space
 * A use can map devices to location spaces. Each device can be linked to one or multiple spaces on the same location based on the device type.
 *
 * @param locationId required PPLocationId Location ID of the device
 * @param deviceId required NSString Device ID of the device
 * @param spaceId required PPLocationSpaceId Space ID of the location space
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)linkSpace:(PPLocationId)locationId deviceId:(NSString *)deviceId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(spaceId != PPLocationSpaceIdNone, @"%s missing spaceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/devices/%@/spaces/%@", @(locationId), [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId], @(spaceId)]] resolvingAgainstBaseURL:NO];
        
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.linkSpace()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Unlink space
 *
 * @param locationId required PPLocationId Location ID of the device
 * @param deviceId required NSString Device ID of the device
 * @param spaceId required PPLocationSpaceId Space ID of the location space
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)unlinkSpace:(PPLocationId)locationId deviceId:(NSString *)deviceId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(spaceId != PPLocationSpaceIdNone, @"%s missing spaceId", __FUNCTION__);
        
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/devices/%@/spaces/%@", @(locationId), [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId], @(spaceId)]] resolvingAgainstBaseURL:NO];
        
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.devices.unlinkSpace()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

@end
