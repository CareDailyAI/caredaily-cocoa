//
//  PPCloudEngine.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPDevice.h"
#import "PPUrl.h"
#import "PPAFHTTPBridge.h"

@class PPUser;
@class PPDeviceProxy;

@interface PPCloudEngine : PPAFHTTPBridge <NSCopying>

+ (PPCloudEngine *)sharedDefaultEngine;
+ (PPCloudEngine *)sharedAppEngine;
+ (PPCloudEngine *)sharedAppWebsocketEngine;
+ (PPCloudEngine *)sharedAppStrippedEngine;
+ (PPCloudEngine *)sharedAdminEngine;
+ (PPCloudEngine *)sharedProxyEngine;
+ (PPCloudEngine *)sharedStreamingEngine;
+ (PPCloudEngine *)sharedReportEngine;

+ (void)setUser:(PPUser *)user;

- (id)initSingleton:(PPCloudEngineType)type;

@end
