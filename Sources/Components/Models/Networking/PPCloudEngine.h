//
//  PPCloudEngine.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPUrl.h"
#import "PPAFHTTPBridge.h"

@interface PPCloudEngine : PPAFHTTPBridge <NSCopying>

+ (PPCloudEngine *)sharedDefaultEngine;
+ (PPCloudEngine *)sharedAppEngine;
+ (PPCloudEngine *)sharedAppWebsocketEngine;
+ (PPCloudEngine *)sharedAppStrippedEngine;
+ (PPCloudEngine *)sharedAdminEngine;
+ (PPCloudEngine *)sharedProxyEngine;
+ (PPCloudEngine *)sharedStreamingEngine;
+ (PPCloudEngine *)sharedReportEngine;

+ (void)setSessionKey:(NSString *)sessionKey;

- (id)initSingleton:(PPCloudEngineType)type;

@end
