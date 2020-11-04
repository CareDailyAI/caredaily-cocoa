//
//  PPDeviceProxy.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPDeviceProxy.h"
#import <sys/utsname.h>
#import "PPCloudEngine.h"
#import "PPDeviceProxyLocal.h"
#import "PPUserAccounts.h"
#import "PPFileManagement.h"

@interface PPDeviceProxy ()
- (void)processServerResponse:(NSDictionary *)responseData;
- (void)processCommand:(PPDeviceCommand *)command;
- (void)listenToCommands:(BOOL)listen;
- (void)drainProxyQueue;

@property (nonatomic, strong) NSMutableDictionary *commandBlocks;
@property (nonatomic, strong) NSMutableArray *commandResponses;
@property (nonatomic, strong) NSMutableArray *pendingMeasurements;
@property (nonatomic, strong) NSMutableArray *pendingAlerts;
@property (nonatomic, strong) NSMutableArray *outstandingCommands;
@property (nonatomic, strong) NSMutableDictionary *reliabilityBuffer;
@property (nonatomic, strong) NSMutableArray *userServicesCallbackBuffer;
@property (nonatomic) BOOL proVideoQueryInProgress;
@property (nonatomic) NSMutableArray *userServices;
@property (nonatomic, strong) NSDate *userServicesSyncTimestamp;
@property (nonatomic) BOOL listeningToCommands;
@property (nonatomic) BOOL drainingProxyQueue;
@property (nonatomic) BOOL highSpeedMode;
@property (nonatomic) BOOL cleanConnection;
@property (nonatomic) PPLocationId lastLocationId;
@property (nonatomic, strong) NSMutableURLRequest *commandsNetWrapper;
@property (nonatomic, strong) PPHTTPOperation *proxyNetworkOperation;
@property (nonatomic, strong) NSLock *proxyNetworkOperationLock;

@end

@implementation PPDeviceProxy

#pragma mark - Session Management

__strong static PPDeviceProxy *_currentProxy = nil;

/**
 * Current active user
 */
+ (PPDeviceProxy *)currentProxy {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(_currentProxy == nil) {
        _currentProxy = [PPDeviceProxy initProxyWithCachedAuthToken:[[PPUserAccounts currentUser] currentLocation].locationId];
    }
    if(_currentProxy) {
        if(_currentProxy.localDevice == nil) {
            _currentProxy.localDevice = [[PPDeviceProxyLocal alloc] init];
        }
//        if(_currentProxy.localDevice.device == nil) {
//            _currentProxy.localDevice.device = [PPDevices localDeviceForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId];
//        }
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s currentProxy=%@ localDevice=%@ device=%@", __PRETTY_FUNCTION__, _currentProxy, _currentProxy.localDevice, _currentProxy.localDevice.device);
#endif
#endif
    return _currentProxy;
}

+ (PPDeviceProxy *)initProxyWithCachedAuthToken:(PPLocationId)locationId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSString *authToken = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.authToken", (long)locationId]];
    NSString *host = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.host", (long)locationId]];
    PPDevicesPort port = ((NSString *)[UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.port", (long)locationId]]).integerValue;
    PPDevicesUseSSL useSsl = ((NSString *)[UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.useSsl", (long)locationId]]).integerValue;
    
    if(authToken && host && port) {
        PPCloudConnectivityServer *server = [[PPCloudConnectivityServer alloc] initWithType:CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO host:host path:@"/deviceio" port:(PPCloudConnectivityPort)port altPort:PPCloudConnectivityPortNone ssl:(PPCloudConnectivitySSL)useSsl altSsl:PPCloudConnectivitySSLNone brand:nil];
        if(!_currentProxy) {
            _currentProxy = [[PPDeviceProxy alloc] initWithAuthToken:authToken server:server localDevice:[[PPDeviceProxyLocal alloc] init]];
        }
        
        _currentProxy.authToken = authToken;
        _currentProxy.server = server;
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s currentProxy=%@ localDevice=%@ device=%@", __PRETTY_FUNCTION__, _currentProxy, _currentProxy.localDevice, _currentProxy.localDevice.device);
#endif
#endif
    return _currentProxy;
}

/**
 * Set proxy.
 *
 * @param proxy PPDeviceProxy New proxy
 **/
+ (void)setProxy:(PPDeviceProxy *)proxy {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s proxy=%@ localDevice=%@ device=%@", __PRETTY_FUNCTION__, proxy, proxy.localDevice, proxy.localDevice.device);
#endif
#endif
    if(proxy) {
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.authToken", (long)proxy.localDevice.device.locationId]] = proxy.authToken;
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.host", (long)proxy.localDevice.device.locationId]] = proxy.server.host;
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.port", (long)proxy.localDevice.device.locationId]] = [NSString stringWithFormat:@"%li", (long)proxy.server.port];
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.useSsl", (long)proxy.localDevice.device.locationId]] = [NSString stringWithFormat:@"%li", (long)proxy.server.ssl];
    }
    else {
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.authToken", (long)proxy.localDevice.device.locationId]] = nil;
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.host", (long)proxy.localDevice.device.locationId]] = nil;
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.port", (long)proxy.localDevice.device.locationId]] = nil;
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"proxy.%li.useSsl", (long)proxy.localDevice.device.locationId]] = nil;
    }
         _currentProxy = proxy;
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

- (void)setLocalDevice:(PPDeviceProxyLocal *)localDevice {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"%s localDevice=%@", __PRETTY_FUNCTION__, localDevice);
    NSLog(@"%s localDevice.device=%@", __PRETTY_FUNCTION__, localDevice.device);
#endif
#endif
}
#pragma mark - Initialization

+ (NSDictionary *)constructSetParamaterJSON:(NSString *)name value:(NSString *)value index:(NSString *)index {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:0];
    [param setValue:name forKey:@"name"];
    [param setValue:value forKey:@"value"];
    if(index != nil) {
        [param setValue:index forKey:@"index"];
    }
    
    return param;
}

- (id)initWithAuthToken:(NSString *)authToken server:(PPCloudConnectivityServer *)server localDevice:(PPDeviceProxyLocal *)localDevice {
	self = [super init];
	if(self) {
        _authToken = authToken;
        _server = server;
        _localDevice = localDevice;
		_highSpeedMode = NO;
		_proVideoQueryInProgress = NO;
		_persistentTimeout = HTTP_DEFAULT_PERSISTENT_CONNECTION_TIMEOUT;
		self.proxyNetworkOperationLock = [[NSLock alloc] init];
        _postFileRetryInterval = PROXY_DEFAULT_POST_FILE_RETRY_INTERVAL;
	}

	return self;
}

- (void)turnOn:(NSObject<PPDeviceProxyLocalDelegate> *)delegate {
    NSMutableArray *measurements = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:0];
    PPDeviceParameter *parameter;

    // Log the system name as the model
    struct utsname systemInfo;
    uname(&systemInfo);
    
    parameter = [[PPDeviceParameter alloc] initWithName:MODEL index:nil value:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] lastUpdateDate:[NSDate date]];
    [parameters addObject:parameter];
    
    if([UIDevice currentDevice].batteryState != UIDeviceBatteryStateUnknown) {
        parameter = [[PPDeviceParameter alloc] initWithName:CHARGING index:nil value:[NSString stringWithFormat:@"%d", ([UIDevice currentDevice].batteryState == UIDeviceBatteryStateCharging || [UIDevice currentDevice].batteryState == UIDeviceBatteryStateFull)] lastUpdateDate:[NSDate date]];
        [parameters addObject:parameter];
        
        parameter = [[PPDeviceParameter alloc] initWithName:BATTERY_LEVEL index:nil value:[NSString stringWithFormat:@"%li", (long)(int)([UIDevice currentDevice].batteryLevel * 100)] lastUpdateDate:[NSDate date]];
        [parameters addObject:parameter];
    }
    parameter = [[PPDeviceParameter alloc] initWithName:TIMEZONE_ID index:nil value:[NSTimeZone localTimeZone].name lastUpdateDate:[NSDate date]];
    [parameters addObject:parameter];
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    parameter = [[PPDeviceParameter alloc] initWithName:VERSION index:nil value:[NSString stringWithFormat:@"%@.%@",[infoDict objectForKey:@"CFBundleShortVersionString"], [infoDict objectForKey:@"CFBundleVersion"]] lastUpdateDate:[NSDate date]];
    [parameters addObject:parameter];
    
    parameter = [[PPDeviceParameter alloc] initWithName:FIRMWARE index:nil value:[[UIDevice currentDevice] systemVersion] lastUpdateDate:[NSDate date]];
    [parameters addObject:parameter];
    
    parameter = [[PPDeviceParameter alloc] initWithName:AVAILABLE_BYTES index:nil value:[NSString stringWithFormat:@"%llu", [PPStorage availableBytes]] lastUpdateDate:[NSDate date]];
    [parameters addObject:parameter];
    
    
    
    if([_localDevice isKindOfClass:[PPDeviceProxyLocalCamera class]]) {
        parameter = [[PPDeviceParameter alloc] initWithName:MOTION_ACTIVITY index:nil value:@"0" lastUpdateDate:[NSDate date]];
        [parameters addObject:parameter];
        
        parameter = [[PPDeviceParameter alloc] initWithName:AUDIO_ACTIVITY index:nil value:@"0" lastUpdateDate:[NSDate date]];
        [parameters addObject:parameter];
        
        parameter = [[PPDeviceParameter alloc] initWithName:RECORD_STATUS index:nil value:@"0" lastUpdateDate:[NSDate date]];
        [parameters addObject:parameter];
    }
    
    for(PPDeviceParameter *param in parameters) {
        [_localDevice.device setParameter:param.name value:param.value index:param.index lastUpdateDate:param.lastUpdateDate];
    }
    
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:_localDevice.device.deviceId lastDataReceivedDate:[NSDate date] lastMeasureDate:[NSDate date] params:parameters];
    [measurements addObject:measurement];
    
    [self setHighSpeedMode:NO];
    [self sendMeasurements:measurements];
    
    [_localDevice turnOn:delegate proxyDelegate:self];
}

- (BOOL)isOn {
    return _listeningToCommands;
}


- (void)turnOff {
    [_localDevice turnOff];
}

+ (BOOL)wasProxyOn {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *proxyWasOn = [defaults stringForKey:@"proxy.wasOn"];
    return [@"1" isEqualToString:proxyWasOn];
}

- (void)setHighSpeedMode:(BOOL)highSpeed {
#ifdef DEBUG
	NSLog(@"%s setting high speed mode to %d", __PRETTY_FUNCTION__, highSpeed);
#endif
	_highSpeedMode = highSpeed;
}

- (void)setCleanConnection:(BOOL)cleanConnection {
#ifdef DEBUG
    NSLog(@"%s setting clean connection marker to %d", __PRETTY_FUNCTION__, cleanConnection);
#endif
    
    _cleanConnection = cleanConnection;
    
    if(_cleanConnection == YES) {
        if([_pendingMeasurements count]) {
            [_pendingMeasurements removeAllObjects];
        }
        if([_pendingAlerts count]) {
            [_pendingAlerts removeAllObjects];
        }
        if([_commandResponses count]) {
            [_commandResponses removeAllObjects];
        }
        _listeningToCommands = NO;
        [self drainProxyQueue];
    }
}

- (void)commandsForDeviceId:(NSString *)deviceId sendToBlock:(PPDeviceProxyDeviceCommandBlock)commandBlock {
    if(!deviceId || [deviceId isEqualToString:@""]) {
#ifdef DEBUG
        NSLog(@"%s Missing Device ID", __PRETTY_FUNCTION__);
#endif
        return;
    }
	[self.commandBlocks setObject:[commandBlock copy] forKey:deviceId];
#ifdef DEBUG
    NSLog(@"%s Device ID : %@", __PRETTY_FUNCTION__, deviceId);
#endif
	[self listenToCommands:YES];
}

- (void)stopCommandsForDeviceId:(NSString *)deviceId {
    if(!deviceId || [deviceId isEqualToString:@""]) {
#ifdef DEBUG
        NSLog(@"%s Missing Device ID", __PRETTY_FUNCTION__);
#endif
        return;
    }
#ifdef DEBUG
	NSLog(@"PPDeviceProxy: stopCommandsForDevice: %@", deviceId);
#endif
	[self.commandBlocks removeObjectForKey:deviceId];
	if(self.commandBlocks.count == 0) {
		[self listenToCommands:NO];
	}
}

/**
 * Get user by device.
 * With the Device API and no API key, determine if this is a Pro Video subscriber, to enable Pro Video features at the device
 * See http://docs.iotapps.apiary.io/#reference/user-accounts/get-user-by-device/get-user-by-device
 * This uses the Cloud API while passing in the authentication token of this proxy.
 * Responses are cached.
 *
 * A gateway or proxy can request some information about an owner. Currently only assigned paid services are returned.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:Using a Device Authentication Token:
 *      PPCAuthorization: esp token="ABC12345"
 *      Using a Streaming Session ID: PPCAuthorization: stream session="DEF67890"
 *
 * @param proxyId NSString Device ID of the gateway or proxy
 * @param callback PPUserAccountsServicesBlock Callback method provides PPUser object and optional error
 */
- (void)getUserByDevice:(NSString *)proxyId callback:(PPUserAccountsServicesBlock)callback {
#ifdef DEBUG
	NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
	
#if VIP_TREATMENT_ENABLED
	isSubscriber(YES);
	return;
#endif
	
	// Verify we're still dealing with the same user
	if(_lastLocationId != _location.locationId) {
		_userServicesSyncTimestamp = nil;
	}
	_lastLocationId = _location.locationId;
	
	if(_userServicesSyncTimestamp != nil) {
		if([_userServicesSyncTimestamp timeIntervalSinceNow] > -(PROVIDEO_CACHE_REFRESH_TIME_SECONDS)) {
#ifdef DEBUG
			NSLog(@"%s Returning cached value %@", __PRETTY_FUNCTION__, _userServices);
#endif
            for(PPUserAccountsServicesBlock callback in _userServicesCallbackBuffer) {
                callback(_userServices, nil);
            }
			return;
		}
	}
	
	
	
	if(_userServicesCallbackBuffer == nil) {
		self.userServicesCallbackBuffer = [[NSMutableArray alloc] initWithCapacity:2];
	}
    @try {
	if(callback != nil && ![self.userServicesCallbackBuffer containsObject:callback]) {
		[self.userServicesCallbackBuffer addObject:callback];
	}
    }
    @catch (NSException *e) {
        NSLog(@"%s e: %@", __PRETTY_FUNCTION__, e);
    }
	if(_proVideoQueryInProgress) {
		return;
	}
	_proVideoQueryInProgress = YES;
    __weak typeof(self)wself = self;
    [PPUserAccounts getServicesByDevice:_localDevice.device.deviceId authorizationType:PPUserAccountAuthorizationTypeDeviceAuthenticationToken token:self.authToken sessionId:nil callback:^(NSMutableArray *services, NSError *error) {
		if(error) {
			// Unable to gather pro status, continue to use our latest property
            wself.proVideoQueryInProgress = NO;
            
            for(PPUserAccountsServicesBlock callback in wself.userServicesCallbackBuffer) {
                callback(wself.userServices, error);
            }
			return;
		}
		
        wself.userServices = services;
		
		wself.userServicesSyncTimestamp = [NSDate date];
		
		for(PPUserAccountsServicesBlock callback in wself.userServicesCallbackBuffer) {
			callback(wself.userServices, nil);
		}
		
		[wself.userServicesCallbackBuffer removeAllObjects];
		
		wself.proVideoQueryInProgress = NO;
    }];
}

/**
 * Force our Pro Video state to re-evaluate itself
 */
- (void)forceUserServicesRefresh {
	self.userServicesSyncTimestamp = nil;
}

- (void)sendMeasurement:(PPDeviceMeasurement *)measurement {
    [self sendMeasurements:@[measurement]];
}

- (void)sendMeasurements:(NSArray *)measurements {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for(PPDeviceMeasurement *measurement in measurements) {
            @try{
                [self.pendingMeasurements addObject:measurement];
            }
            @catch (NSException *e) {
#ifdef DEBUG
                NSLog(@"%s - Error adding measurementEl to pending measurements: %@", __PRETTY_FUNCTION__, e);
#endif
            }
        }
		[self cancelCurrentCommandRequest];
		[self drainProxyQueue];
	});
}

- (void)sendAlert:(PPDeviceMeasurementsAlert *)alert {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
#ifdef DEBUG
		NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
        [self.pendingAlerts addObject:alert];
        
		[self cancelCurrentCommandRequest];
		[self drainProxyQueue];
	});
}

- (void)sendFile:(NSData *)data
        fileType:(PPFileFileType)fileType
		isThumbnail:(BOOL)isThumbnail
		rotation:(NSInteger)degrees
		totalDuration:(NSInteger)totalDuration
		fromDevice:(PPDevice *)device
		incomplete:(BOOL)incomplete
		fragmentIndex:(NSInteger)fragmentIndex
		expectedTotalBytes:(unsigned long long)expectedTotalBytes
		fileRef:(NSString *)fileRef
		replacementFileId:(NSString *)replacementFileId
        attempt:(NSInteger)attempt
		callback:(PPFileAcknowledgmentBlock)callback {
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
#ifdef DEBUG
		NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
        if(attempt > FILE_UPLOAD_ATTEMPT_LIMIT) {
#ifdef DEBUG
            NSLog(@"PPDeviceProxy sendFile: attempt limit reached, so abort");
#endif
            callback(PPFileIdNone, PPFileFragmentsNone, PPFileUsedFileSpaceNone, PPFileTotalFileSpaceNone, PPFileFilesActionNone, PPFileThumbnailNone, PPFileTwitterShareNone, [PPBaseModel resultCodeToNSError:10041 originatingClass:NSStringFromClass([self class])]);
            return;
        }
		/*
		 // This was used to test that all our bytes get from here to the other side
		 uint8_t *bytes = malloc(sizeof(*bytes) * 256);
		 
		 unsigned i;
		 for (i = 0; i < 256; i++) {
		 bytes[i] = (uint8_t) i;
		 }
		 
		 data = [NSData dataWithBytesNoCopy:bytes length:256 freeWhenDone:YES];
		 // End of test
		 */
#ifdef DEBUG
		NSLog(@"Expected file size = %lld", expectedTotalBytes);
#endif
		if(data.length <= 0) {
#ifdef DEBUG
			NSLog(@"PPDeviceProxy sendFile: data.length <= 0 so abort");
#endif
            callback(PPFileIdNone, PPFileFragmentsNone, PPFileUsedFileSpaceNone, PPFileTotalFileSpaceNone, PPFileFilesActionNone, PPFileThumbnailNone, PPFileTwitterShareNone, [PPBaseModel resultCodeToNSError:10017 originatingClass:NSStringFromClass([self class])]);
			return;
		}
		
		NSString *extension = @"";
        NSString *contentType = @"";
        PPFileFileType mediaType = fileType;
		if((!isThumbnail && fileType == PPFileFileTypeVideo) || (isThumbnail && fileType == PPFileFileTypeImage && incomplete)) {
			extension = @"mp4";
            contentType = @"video/mp4";
            mediaType = PPFileFileTypeVideo;
		}
        else if(fileType == PPFileFileTypeImage) {
            extension = @"jpg";
            contentType = @"image/jpeg";
        }
        else if(fileType == PPFileFileTypeAudio) {
            extension = @"m4a";
            contentType = @"audio/mpeg";
        }
		
		__weak typeof(self)wself = self;
  
        [self sendFileOrFileFragment:(fileRef) ? (PPFileId)fileRef.integerValue : PPFileIdNone replacementFileId:(replacementFileId) ? (PPFileId)replacementFileId.integerValue : PPFileIdNone deviceId:device.deviceId proxyId:self.localDevice.device.deviceId fileExtension:extension expectedSize:(PPFileSize)expectedTotalBytes duration:(PPFileDuration)totalDuration rotate:(PPFileRotate)degrees type:mediaType thumbnail:(PPFileThumbnail)isThumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)fragmentIndex contentType:contentType data:data callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
           
            if(error) {
                // Keep trying
#ifdef DEBUG
                NSLog(@"PPDeviceProxy sendFile: Error sending; keep trying: %@", error);
#endif
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(wself.postFileRetryInterval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    [wself sendFile:data fileType:mediaType isThumbnail:isThumbnail rotation:degrees totalDuration:totalDuration fromDevice:device incomplete:incomplete fragmentIndex:fragmentIndex expectedTotalBytes:expectedTotalBytes fileRef:fileRef replacementFileId:replacementFileId attempt:attempt callback:callback];
                });
                return;
             }
            
            if(!incomplete && !isThumbnail) {
                [wself trackRecording:totalDuration];
            }
            if(status) {
                [wself processServerResponse:@{@"status": status}];
            }
            callback(fileFragment.fileId, fileFragment.fragments, usedFileSpace, totalFileSpace, fileFragment.filesAction, fileFragment.thumbnail, twitterShare, error);
            
        }];
    });
}


- (void)sendFileOrFileFragment:(PPFileId)fileId replacementFileId:(PPFileId)replacementFileId deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId fileExtension:(NSString *)fileExtension expectedSize:(PPFileSize)expectedSize duration:(PPFileDuration)fileDuration rotate:(PPFileRotate)rotate type:(PPFileFileType)type thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)fragmentIndex contentType:(NSString *)contentType data:(NSData *)data callback:(PPFileManagementFragmentBlock)callback {
    
    if(fileId != PPFileIdNone) {
        [PPFileManagement uploadFileFragment:fileId proxyId:_localDevice.device.deviceId fileExtension:fileExtension thumbnail:thumbnail incomplete:incomplete index:fragmentIndex contentType:contentType authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:_authToken sessionId:nil data:data callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
            callback(status, fileFragment, totalFileSpace, usedFileSpace, twitterShare, twitterAccount, contentUrl, storagePolicy, uploadHeaders, error);
        }];
        
    }
    else {
        [PPFileManagement uploadNewFile:_localDevice.device.deviceId deviceId:_localDevice.device.deviceId fileExtension:fileExtension expectedSize:expectedSize duration:fileDuration rotate:rotate fileId:replacementFileId thumbnail:thumbnail incomplete:incomplete type:type contentType:contentType authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:_authToken sessionId:nil data:data uploadUrl:PPFileUploadUrlNone progressBlock:^(NSProgress *progress) {
            
#ifdef DEBUG
            NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
#endif
            
        } callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
            callback(status, fileFragment, totalFileSpace, usedFileSpace, twitterShare, twitterAccount, contentUrl, storagePolicy, uploadHeaders, error);
        }];
    }
}

- (void)trackRecording:(PPFileDuration)totalDuration {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"video_total_recordings"] == nil) {
        [defaults setObject:@"0" forKey:@"video_total_recordings"];
        [defaults synchronize];
    }
    
    if([defaults objectForKey:@"video_total_sec"] == nil) {
        [defaults setObject:@"0" forKey:@"video_total_sec"];
        [defaults synchronize];
    }
    
    NSInteger totalSecondsEverRecorded = ((NSString *)[defaults objectForKey:@"video_total_sec"]).integerValue;
    totalSecondsEverRecorded += totalDuration;
    [defaults setObject:[NSString stringWithFormat:@"%ld", (long)totalSecondsEverRecorded] forKey:@"video_total_sec"];
    [defaults synchronize];
    
    NSInteger totalRecordings = ((NSString *)[defaults objectForKey:@"video_total_recordings"]).integerValue;
    
    totalRecordings++;
    [defaults setObject:[NSString stringWithFormat:@"%ld", (long)totalRecordings] forKey:@"video_total_recordings"];
    
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:6];
    [properties setObject:NSStringFromClass([self class]) forKey:@"Location"];
    [properties setObject:@"Video recorded" forKey:@"Description"];
    [properties setObject:[NSString stringWithFormat:@"%ld", (long)totalDuration] forKey:@"$video_delta_sec"];
    [properties setObject:[NSString stringWithFormat:@"%ld", (long)totalSecondsEverRecorded] forKey:@"$video_total_sec"];
    [properties setObject:@"1" forKey:@"$video_delta_recordings"];
    [properties setObject:[NSString stringWithFormat:@"%ld", (long)totalRecordings] forKey:@"$video_total_recordings"];
    [PPUserAnalytics track:@"ioscamera" properties:properties logLevel:ANALYTICS_LEVEL_DEBUG];
}

/* private */

- (void)cancelCurrentCommandRequest {
    [_proxyNetworkOperationLock lock];
    if(_proxyNetworkOperation) {
        [_proxyNetworkOperation cancel];
    }
    [_proxyNetworkOperationLock unlock];
}

- (void)listenToCommands:(BOOL)listen {
	if(_listeningToCommands && listen) {
		return;
	}
	_listeningToCommands = listen;
	if(_listeningToCommands == NO) {
		[self cancelCurrentCommandRequest];
		return;
	}

	[self drainProxyQueue];
}

- (void)drainProxyQueue {
	if(self.drainingProxyQueue) {
		return;
	}
	
	self.drainingProxyQueue = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self doPersistentConnection];
    });
}

- (void)doPersistentConnection {
	__weak PPDeviceProxy *weakSelf = self;
//    if(_localDevice.device == nil) {
//        _localDevice.device = [PPDevices localDeviceForLocation:[[PPUserAccounts currentUser] currentLocation] userId:[PPUserAccounts currentUser].userId];
//    }
	dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.proxy", DISPATCH_QUEUE_SERIAL);
	dispatch_async(queue, ^{
		if(weakSelf.listeningToCommands || weakSelf.commandResponses.count || weakSelf.pendingMeasurements.count || weakSelf.pendingAlerts.count) {
            if(weakSelf.commandResponses.count || weakSelf.pendingMeasurements.count || weakSelf.pendingAlerts.count) {
                NSMutableDictionary *JSON = [[NSMutableDictionary alloc] initWithCapacity:0];
                NSString *seqNumber = [PPDeviceProxy uniqueSequenceNumber];
                [JSON setValue:seqNumber forKey:@"seq"];
                PPDevice *device = weakSelf.localDevice.device;
                [JSON setValue:device.deviceId forKey:@"proxyId"];
                NSMutableArray *responses = [[NSMutableArray alloc] initWithCapacity:0];
                for(PPDeviceCommand *response in [weakSelf.commandResponses copy]) {
                    [weakSelf addObjectToReliabilityBuffer:[response copy] type:PPDeviceProxyReliabilityBufferTypeCommandResponses];
                    
                    NSMutableDictionary *commandDict = [[NSMutableDictionary alloc] initWithCapacity:2];
                    if(response.commandId != PPDeviceCommandIdNone) {
                        [commandDict setValue:@(response.commandId).stringValue forKey:@"commandId"];
                    }
                    if(response.deviceId) {
                        [commandDict setValue:response.deviceId forKey:@"deviceId"];
                    }
                    if(response.typeId != PPDeviceTypeIdNone) {
                        [commandDict setValue:@(response.typeId).stringValue forKey:@"deviceType"];
                    }
                    if(response.creationDate) {
                        [commandDict setValue:[PPNSDate apiFriendStringFromDate:response.creationDate] forKey:@"creationDate"];
                    }
                    
                    if(response.type != PPDeviceCommandTypeNone) {
                        [commandDict setValue:@(response.commandId).stringValue forKey:@"commandId"];
                    }
                    
                    if(response.result != PPDeviceCommandResultNone) {
                        [commandDict setValue:@(response.result).stringValue forKey:@"result"];
                    }
                    
                    if(response.parameters) {
                        NSMutableArray *paramsArray = [[NSMutableArray alloc] initWithCapacity:0];
                        
                        for(PPDeviceParameter *param in response.parameters) {
                            NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithCapacity:3];
                            if(param.name) {
                                [paramDict setValue:param.name forKey:@"name"];
                            }
                            if(param.value) {
                                [paramDict setValue:param.value forKey:@"value"];
                            }
                            if(param.index) {
                                [paramDict setValue:param.index forKey:@"index"];
                            }
                            [paramsArray addObject:paramDict];
                        }
                        if([paramsArray count]) {
                            [commandDict setValue:paramsArray forKey:@"measures"];
                        }
                    }
                    
                    [responses addObject:commandDict];
                }
                if ([responses count] > 0) {
                    [JSON setValue:responses forKey:@"responses"];
                }
				
				weakSelf.commandResponses = [[NSMutableArray alloc] initWithCapacity:3];

				// Only send one measurement at a time, so the server records each one.
				// Otherwise, if we send 2 parameters at once, the server will only pay attention to one,
				// when both might be needed to run rules.
                
                NSMutableArray *measurements = [[NSMutableArray alloc] initWithCapacity:0];
                for(int i = 0; i < [weakSelf.pendingMeasurements count]; i++) {
                    @try {
                        if([weakSelf.pendingMeasurements objectAtIndex:i] != nil) {
                            PPDeviceMeasurement *measurement = [weakSelf.pendingMeasurements objectAtIndex:i];
                            [weakSelf addObjectToReliabilityBuffer:[measurement copy] type:PPDeviceProxyReliabilityBufferTypeMeasurement];
                            
                            NSMutableDictionary *measurementDict = [[NSMutableDictionary alloc] initWithCapacity:2];
                            [measurementDict setValue:measurement.deviceId forKey:@"deviceId"];
                            
                            if (measurement.lastMeasureDate != nil) {
                                [measurementDict setValue:[NSString stringWithFormat:@"%li", (long)measurement.lastMeasureDate.timeIntervalSince1970 * 1000] forKey:@"timestamp"];
                            }
                            
                            NSMutableArray *paramsArray = [[NSMutableArray alloc] initWithCapacity:0];
                            
                            for(PPDeviceParameter *param in measurement.parameters) {
                                NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithCapacity:3];
                                if(param.name) {
                                    [paramDict setValue:param.name forKey:@"name"];
                                }
                                if(param.value) {
                                    [paramDict setValue:param.value forKey:@"value"];
                                }
                                if(param.index) {
                                    [paramDict setValue:param.index forKey:@"index"];
                                }
                                [paramsArray addObject:paramDict];
                            }
                            [measurementDict setValue:paramsArray forKey:@"params"];
                            
                            [measurements addObject:measurementDict];
                            
                            if(weakSelf.delegate) {
                                if([weakSelf.delegate respondsToSelector:@selector(willSendMeasurement:measurement:)]) {
                                    [weakSelf.delegate willSendMeasurement:seqNumber measurement:measurement];
                                }
                            }
                        }
                        [weakSelf.pendingMeasurements removeObjectAtIndex:i];
                    }
                    @catch (NSException *e) {
#ifdef DEBUG
                        NSLog(@"%s - Error adding pending measurement to root: %@", __PRETTY_FUNCTION__, e);
#endif
                    }
					break;
				}
                if ([measurements count] > 0) {
                    [JSON setValue:measurements forKey:@"measures"];
                }
                
                NSMutableArray *alerts = [[NSMutableArray alloc] initWithCapacity:0];
                for(int i = 0; i < [weakSelf.pendingAlerts count]; i++) {
                    @try {
                        if([weakSelf.pendingAlerts objectAtIndex:i] != nil) {
                            PPDeviceMeasurementsAlert *alert = [weakSelf.pendingAlerts objectAtIndex:i];
                            [weakSelf addObjectToReliabilityBuffer:[alert copy] type:PPDeviceProxyReliabilityBufferTypeAlert];
                            
                            NSMutableDictionary *alertDict = [[NSMutableDictionary alloc] initWithCapacity:2];
                            
                            if(alert.deviceId) {
                                [alertDict setValue:alert.deviceId forKey:@"deviceId"];
                            }
                            if(alert.alertType) {
                                [alertDict setValue:alert.alertType forKey:@"alertType"];
                            }
                            if(alert.alertId != PPDeviceMeasurementsAlertIdNone) {
                                [alertDict setValue:@(alert.alertId).stringValue forKey:@"alertId"];
                            }
                            
                            if(alert.receivingDate) {
                                [alertDict setValue:@(floor(alert.receivingDate.timeIntervalSince1970)).stringValue forKey:@"timestamp"];
                            }
                            
                            if(alert.params) {
                                NSMutableArray *paramsArray = [[NSMutableArray alloc] initWithCapacity:0];
                                
                                for(PPDeviceParameter *param in alert.params) {
                                    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithCapacity:3];
                                    if(param.name) {
                                        [paramDict setValue:param.name forKey:@"name"];
                                    }
                                    if(param.value) {
                                        [paramDict setValue:param.value forKey:@"value"];
                                    }
                                    if(param.index) {
                                        [paramDict setValue:param.index forKey:@"index"];
                                    }
                                    [paramsArray addObject:paramDict];
                                }
                                
                                [alertDict setValue:paramsArray forKey:@"params"];
                            }
                            
                            [alerts addObject:alertDict];
                        }
                        [weakSelf.pendingAlerts removeObjectAtIndex:i];
                    }
                    @catch (NSException *e) {
#ifdef DEBUG
                        NSLog(@"%s - Error adding pending alert to root: %@", __PRETTY_FUNCTION__, e);
#endif
                    }
                    break;
                }
                if ([alerts count] > 0) {
                    [JSON setValue:alerts forKey:@"alerts"];
                }
				
				// Measurements and responses should go through quickly no matter what. Make it happen or die quickly.
				NSInteger timeout = HTTP_TIMEOUT_WITH_ACTIVE_CAMERA;
				
				NSError *error;
				
                weakSelf.commandsNetWrapper = [[[PPCloudEngine sharedProxyEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:[PPUrl deviceIOServerURLString:weakSelf.server]].absoluteString parameters:nil error:&error];
                weakSelf.commandsNetWrapper.timeoutInterval = timeout;
                // Trying to avoid a crash that occurred in our production baseline in Presence 4.0.8
                @try {
                    NSError * error;
                    [weakSelf.commandsNetWrapper setHTTPBody:[NSJSONSerialization  dataWithJSONObject:JSON options:0 error:&error]];
                    if(error) {
                        @throw error;
                    }
                } @catch (NSException *exception) {
#ifdef DEBUG
                    NSLog(@"%s ERROR=%@", __PRETTY_FUNCTION__, exception);
#endif
                }
			}
			else {
				NSInteger timeout = weakSelf.persistentTimeout;
				
				if(timeout < 30 || timeout > 360) {
					timeout = HTTP_DEFAULT_PERSISTENT_CONNECTION_TIMEOUT;
				}
				
				if(weakSelf.highSpeedMode) {
					timeout = HTTP_TIMEOUT_WITH_ACTIVE_CAMERA;
				}
				
				NSError *error;
                PPDevice *device = weakSelf.localDevice.device;
                weakSelf.commandsNetWrapper = [[[PPCloudEngine sharedProxyEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString: [NSString stringWithFormat:@"%@?id=%@&timeout=%ld", [PPUrl deviceIOServerURLString:weakSelf.server], device.deviceId, (long)timeout]].absoluteString parameters:nil error:&error];
				[weakSelf.commandsNetWrapper setTimeoutInterval:timeout];
			}
			[weakSelf.commandsNetWrapper setValue:[NSString stringWithFormat:@"esp token=%@", self.authToken] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
            weakSelf.proxyNetworkOperation = [[PPCloudEngine sharedProxyEngine] operationWithRequest:weakSelf.commandsNetWrapper success:^(NSData *responseData) {
#ifdef DEBUG
                NSLog(@"%s SUCCESS: %@", __PRETTY_FUNCTION__, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
#endif
				[weakSelf.proxyNetworkOperationLock lock];
				weakSelf.proxyNetworkOperation = nil;
				[weakSelf.proxyNetworkOperationLock unlock];
				
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
					[weakSelf.outstandingCommands removeAllObjects];
					
					
					// HTTP operation completed successfully
					
					NSError *error = nil;
                    NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([weakSelf class]) error:&error];
                    if(!error && root) {
						// Successfully contacted the server, continue to process the results
						[weakSelf.reliabilityBuffer removeAllObjects];
						dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf processServerResponse:root];
                            [weakSelf doPersistentConnection];
						});
						
					}
					else {
						// If sending, there was an h2s error. Pull our elements out of our reliability buffer and try sending them again.
                        for(NSString *bufferKey in weakSelf.reliabilityBuffer.allKeys) {
                            for(NSObject *element in [weakSelf.reliabilityBuffer objectForKey:bufferKey]) {
                                if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeCommandResponses).stringValue]) {
                                    [weakSelf.commandResponses insertObject:(PPDeviceCommand *)element atIndex:0];
                                }
                                else if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeMeasurement).stringValue]) {
                                    [weakSelf.pendingMeasurements insertObject:(PPDeviceMeasurement *)element atIndex:0];
                                }
                                else if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeAlert).stringValue]) {
                                    [weakSelf.pendingAlerts insertObject:(PPDeviceMeasurementsAlert *)element atIndex:0];
                                }
                            }
						}
                        [weakSelf.reliabilityBuffer removeAllObjects];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf doPersistentConnection];
                        });
					}
				});
				
			} failure:^(NSError *error) {
				[weakSelf.proxyNetworkOperationLock lock];
				weakSelf.proxyNetworkOperation = nil;
				[weakSelf.proxyNetworkOperationLock unlock];
				
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
#ifdef DEBUG
					NSLog(@"%s command listener - request error: %@", __PRETTY_FUNCTION__, error);
#endif
					
					// If sending, there was an h2s error. Pull our elements out of our reliability buffer and try sending them again.
                    for(NSString *bufferKey in weakSelf.reliabilityBuffer.allKeys) {
                        for(NSObject *element in [weakSelf.reliabilityBuffer objectForKey:bufferKey]) {
                            if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeCommandResponses).stringValue]) {
                                [weakSelf.commandResponses insertObject:(PPDeviceCommand *)element atIndex:0];
                            }
                            else if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeMeasurement).stringValue]) {
                                [weakSelf.pendingMeasurements insertObject:(PPDeviceMeasurement *)element atIndex:0];
                            }
                            else if([bufferKey isEqualToString:@(PPDeviceProxyReliabilityBufferTypeAlert).stringValue]) {
                                [weakSelf.pendingAlerts insertObject:(PPDeviceMeasurementsAlert *)element atIndex:0];
                            }
                        }
                    }
                    [weakSelf.reliabilityBuffer removeAllObjects];
					
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [weakSelf doPersistentConnection];
                    });
				});
			}];
			
		}
		else {
			weakSelf.drainingProxyQueue = NO;
            if(weakSelf.cleanConnection) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf cleanProxyConnection];
                });
            }
		}
	});
	
}

- (void)cleanProxyConnection {
    __weak PPDeviceProxy *weakSelf = self;

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.proxy", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSInteger timeout = 0;

        NSError *error;
        PPDevice *device = weakSelf.localDevice.device;
        weakSelf.commandsNetWrapper = [[[PPCloudEngine sharedProxyEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString: [NSString stringWithFormat:@"%@?id=%@&timeout=%ld", [PPUrl deviceIOServerURLString:weakSelf.server], device.deviceId, (long)timeout]].absoluteString parameters:nil error:&error];
        [weakSelf.commandsNetWrapper setTimeoutInterval:timeout];
        [weakSelf.commandsNetWrapper setValue:[NSString stringWithFormat:@"esp token=%@", weakSelf.authToken] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
        
        weakSelf.proxyNetworkOperation = [[PPCloudEngine sharedProxyEngine] operationWithRequest:weakSelf.commandsNetWrapper success:^(NSData *responseData) {
            
#ifdef DEBUG
            NSLog(@"%s SUCCESS: %@", __PRETTY_FUNCTION__, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
#endif
            [weakSelf.proxyNetworkOperationLock lock];
            weakSelf.proxyNetworkOperation = nil;
            [weakSelf.proxyNetworkOperationLock unlock];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                [weakSelf.outstandingCommands removeAllObjects];
                
                // HTTP operation completed successfully
                
                NSError *error = nil;
                NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([weakSelf class]) error:&error];
#ifdef DEBUG
                NSLog(@"%s SUCCESS=%@", __PRETTY_FUNCTION__, root);
#endif
            });
            
        } failure:^(NSError *error) {
#ifdef DEBUG
                NSLog(@"%s ERROR=%@", __PRETTY_FUNCTION__, error);
#endif
        }];
    });
}

- (void)processServerResponse:(NSDictionary *)response {

    NSString *status = [response objectForKey:@"status"];
    NSString *seq = [response objectForKey:@"seq"];
    
    if([status isEqualToString:@"ACK"] || [status isEqualToString:@"CONT"]) {
        for(NSDictionary *commandDict in [response objectForKey:@"commands"]) {
            PPDeviceCommand *command = [PPDeviceCommand initWithDictionary:commandDict];
            [self processCommand:command];
        }
	}
	else if([status isEqualToString:@"UNAUTHORIZED"]) {
//        [PPDeviceProxy registerDeviceType:_deviceTypeId location:_location proxyId:_proxyId callback:^(PPDeviceProxy *device, NSError *error) {
//            // TODO - is there anything we can do if our API key is invalid?
//        }];
		
		// Fall through
	}
	else {
#ifdef DEBUG
		NSLog(@"PPDeviceProxy: s2h response unknown: %@", response);
#endif
		
		// Fall through
	}
    if(_delegate) {
        if([_delegate respondsToSelector:@selector(proxyDidSendMeasurement:status:)]) {
            [_delegate proxyDidSendMeasurement:seq status:status];
        }
    }
}

- (void)processCommand:(PPDeviceCommand *)command {
    if([self.outstandingCommands containsObject:@(command.commandId)]) {
#ifdef DEBUG
        NSLog(@"%s Duplicate command: %@", __PRETTY_FUNCTION__, @(command.commandId).stringValue);
#endif
        return;
    }
    
    [self.outstandingCommands addObject:@(command.commandId)];
    
    NSMutableArray *returnElements = [NSMutableArray arrayWithCapacity:10];
    if(command.type == PPDeviceCommandTypeDelete) {
        [returnElements addObject:command.parameters];
    }
    else if(command.type == PPDeviceCommandTypeSet) {
        PPDeviceProxyDeviceCommandBlock commandBlock = [self.commandBlocks objectForKey:command.deviceId];
        if(commandBlock == nil) {
#ifdef DEBUG
            NSLog(@"%s Could not find a command block for device: %@ (commandId=%li)", __PRETTY_FUNCTION__, command.deviceId, (long)command.commandId);
#endif
            return;
        }
        
        for(PPDeviceParameter *param in command.parameters) {
            
            NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:3];
            [properties setObject:NSStringFromClass([self class]) forKey:@"Location"];
            [properties setObject:[NSString stringWithFormat:@"command-%@", (command.type == PPDeviceCommandTypeSet) ? @"set" : @"delete"] forKey:@"Description"];
            // Stream ID's can be sensitive, so don't track them.
            if([param.name isEqualToString:STREAM_ID]) {
                if([param.value isEqualToString:@""]) {
                    [properties setObject:@"[disconnect]" forKey:@"Value"];
                }
                else {
                    [properties setObject:@"[connect]" forKey:@"Value"];
                }
            }
            else {
                [properties setObject:param.value forKey:@"Value"];
            }
            
            if(param.name) {
                [properties setObject:param.name forKey:@"Parameter"];
            }
            
            if(param.index) {
                [properties setObject:param.index forKey:@"index"];
            }
            
            [PPUserAnalytics track:@"ioscamera" properties:properties logLevel:ANALYTICS_LEVEL_ALERT];
        }
        
        NSDictionary *returnElement = commandBlock(command.parameters);
        if(returnElement) {
            [returnElements addObject:returnElement];
        }
    }
    else {
        return;
    }
//    NSMutableDictionary *response = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [response setValue:@(command.commandId).stringValue forKey:@"commandId"];
//    [response setValue:@"1" forKey:@"result"];
    
    PPDeviceCommand *responseCommand = [[PPDeviceCommand alloc] initWithCommandId:command.commandId deviceId:nil creationDate:nil typeId:PPDeviceTypeIdNone parameters:nil type:PPDeviceCommandTypeNone result:(PPDeviceCommandResult)1 commandTimeout:PPDeviceCommandTimeoutNone comment:nil];
    
    [self.commandResponses addObject:responseCommand];
    
    if(returnElements.count > 0) {
        PPDeviceCommand *returnCommand = [[PPDeviceCommand alloc] initWithCommandId:command.commandId deviceId:command.deviceId creationDate:command.creationDate typeId:command.typeId parameters:returnElements type:command.type result:PPDeviceCommandResultNone commandTimeout:PPDeviceCommandTimeoutNone comment:nil];
        [self.commandResponses addObject:returnCommand];
    }
}

- (NSMutableDictionary *)commandBlocks {
	if(_commandBlocks == nil) {
		_commandBlocks = [[NSMutableDictionary alloc] initWithCapacity:3];
	}

	return _commandBlocks;
}

- (NSMutableArray *)commandResponses {
	if(_commandResponses == nil) {
		_commandResponses = [[NSMutableArray alloc] initWithCapacity:3];
	}

	return _commandResponses;
}

- (NSMutableArray *)outstandingCommands {
	if(_outstandingCommands == nil) {
		_outstandingCommands = [[NSMutableArray alloc] initWithCapacity:3];
	}

	return _outstandingCommands;
}

- (NSMutableArray *)pendingMeasurements {
	if(_pendingMeasurements == nil) {
		_pendingMeasurements = [[NSMutableArray alloc] initWithCapacity:3];
	}

	return _pendingMeasurements;
}

- (NSMutableArray *)pendingAlerts {
    if(_pendingAlerts == nil) {
        _pendingAlerts = [[NSMutableArray alloc] initWithCapacity:3];
    }
    
    return _pendingAlerts;
}

- (NSMutableDictionary *)reliabilityBuffer {
	if(_reliabilityBuffer == nil) {
		_reliabilityBuffer = [[NSMutableDictionary alloc] initWithCapacity:3];
	}
	
	return _reliabilityBuffer;
}

- (void)addObjectToReliabilityBuffer:(NSDictionary *)object type:(PPDeviceProxyReliabilityBufferType)type {
    NSMutableArray *buffer = [_reliabilityBuffer objectForKey:@(type).stringValue];
    if(buffer == nil) {
        buffer = [[NSMutableArray alloc] initWithCapacity:3];
    }
    [buffer addObject:object];
}


+ (NSString *)uniqueSequenceNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger seqNum = ((NSString *)[defaults objectForKey:[NSString stringWithFormat:@"%@.mobileProxySequenceNumber", [[PPBaseModel appName:YES] lowercaseString]]]).integerValue;
    seqNum += 1;
    [defaults setObject:[NSString stringWithFormat:@"%ld", (long)seqNum] forKey:[NSString stringWithFormat:@"%@.mobileProxySequenceNumber", [[PPBaseModel appName:YES] lowercaseString]]];
    [defaults synchronize];
    return [NSString stringWithFormat:@"%ld", (long)seqNum];
}

+ (PPDeviceMeasurementsAlertId)uniqueAlertId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger alertId = ((NSString *)[defaults objectForKey:[NSString stringWithFormat:@"%@.mobileHubAlertIdReference", [[PPBaseModel appName:YES] lowercaseString]]]).integerValue;
    alertId += 1;
    if(alertId > DEFAULT_DEVICE_PROXY_ALERT_ID_LIMIT) {
        alertId = 1;
    }
    [defaults setObject:[NSString stringWithFormat:@"%ld", (long)alertId] forKey:[NSString stringWithFormat:@"%@.mobileHubAlertIdReference", [[PPBaseModel appName:YES] lowercaseString]]];
    [defaults synchronize];
    return (PPDeviceMeasurementsAlertId)alertId;
}


#pragma mark - Local Device Delegate

- (void)localDeviceInitialized {
    [self commandsForDeviceId:_localDevice.device.deviceId sendToBlock:^NSDictionary *(NSArray *parameters) {
        // This block always runs as long as our hub is connected and enabled, accepting commands and forwarding them to the method that executes them.
        [self.localDevice executeCommands:parameters];
        return nil;
    }];
}

- (void)localDeviceDidTurnOff:(NSString *)deviceId {
    [self stopCommandsForDeviceId:deviceId];
    [self setHighSpeedMode:NO];
    [self setCleanConnection:YES];
}

- (void)localDeviceDidExecuteCommand:(NSArray *)parameters {
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:_localDevice.device.deviceId lastDataReceivedDate:[NSDate date] lastMeasureDate:[NSDate date] params:parameters];
    
#ifdef DEBUG
    NSLog(@"%s command=%@", __PRETTY_FUNCTION__, parameters);
#endif
    [self sendMeasurement:measurement];
}

- (NSString *)localDeviceDidRequestAuthToken {
    return self.authToken;
}

- (void)localDeviceDidUpdateDeviceProperty:(NSString *)name value:(NSString *)value index:(NSString *)index {
    [PPDevices setDeviceProperty:_localDevice.device.deviceId name:name value:value index:index userId:PPUserIdNone locationId:PPLocationIdNone callback:^(NSError *error) {}];
}

- (void)localDeviceDidUpdateDeviceName:(NSString *)name {
    [PPDevices updateDevice:_localDevice.device.deviceId locationId:_location.locationId desc:_localDevice.device.name goalId:PPDeviceTypeGoalIdNone newDevice:PPDeviceNewDeviceNone newLocationId:PPLocationIdNone startDate:nil callback:^(NSError *error) {}];
}

@end
