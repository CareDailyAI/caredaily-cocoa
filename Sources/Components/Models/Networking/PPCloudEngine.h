//
//  PPCloudEngine.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPDevice.h"
#import "PPUrl.h"
#import "PPAFHTTPBridge.h"

typedef NS_OPTIONS(NSInteger, PPCloudEngineType) {
    PPCloudEngineTypeDefault,
    PPCloudEngineTypeApp,
    PPCloudEngineTypeAppStripped,
    PPCloudEngineTypeAdmin,
    PPCloudEngineTypeProxy,
    PPCloudEngineTypeStreaming,
    PPCloudEngineTypeReport
};

@class PPUser;
@class PPDeviceProxy;

@interface PPCloudEngine : PPAFHTTPBridge <NSCopying>

+ (PPCloudEngine *)sharedDefaultEngine;
+ (PPCloudEngine *)sharedAppEngine;
+ (PPCloudEngine *)sharedAppStrippedEngine;
+ (PPCloudEngine *)sharedAdminEngine;
+ (PPCloudEngine *)sharedProxyEngine;
+ (PPCloudEngine *)sharedStreamingEngine;
+ (PPCloudEngine *)sharedReportEngine;

+ (void)setUser:(PPUser *)user;

- (id)initSingleton:(PPCloudEngineType)type;

@end
