//
//  PPUrl.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPCloudConnectivityServer.h"
#import "PPCloudConnectivityCloud.h"

@interface PPUrl : NSObject


#ifndef HTTP_TIMEOUT_WITH_ACTIVE_CAMERA
#define HTTP_TIMEOUT_WITH_ACTIVE_CAMERA 10
#endif

#ifndef HTTP_VIDEO_TIMEOUT
#define HTTP_VIDEO_TIMEOUT 10
#endif

#ifndef HTTP_DEFAULT_TIMEOUT
#define HTTP_DEFAULT_TIMEOUT 45
#endif

#ifndef HTTP_DEFAULT_PERSISTENT_CONNECTION_TIMEOUT
#define HTTP_DEFAULT_PERSISTENT_CONNECTION_TIMEOUT 180
#endif

#ifndef HTTP_DEFAULT_WEBVIEW_VERSION
#define HTTP_DEFAULT_WEBVIEW_VERSION 4
#endif

#pragma mark - Cloud Configuration

+ (PPCloudConnectivityCloud *)defaultCloud;
+ (void)setCustomCloud:(PPCloudConnectivityCloud *)cloud;
+ (void)setCustomServer:(PPCloudConnectivityServer *)server;
+ (PPCloudConnectivityCloud *)getCustomCloud;
+ (BOOL)shouldUseCustomCloud;
+ (NSString *)serverName:(BOOL)devicesServer;

#pragma mark - Servers

+ (NSString *)appAPIServerURLString;
+ (NSString *)appWebsocketAPIServerURLString;
+ (NSString *)webappServerURLString;
+ (NSString *)streamingServerURLString:(PPCloudConnectivityServer *)server;
+ (NSString *)deviceIOServerURLString:(PPCloudConnectivityServer *)server;

#pragma mark - Webapp endpoints

+ (NSString *)feedbackURL;
+ (NSString *)problemURL;
+ (NSString *)FAQURL;
+ (NSString *)termsURL;
+ (NSString *)privacyURL;
+ (NSString *)emergencyServerURL;
+ (NSString *)supportUrl;

#pragma mark - Webapp language

+ (NSString *)languageCode;

#pragma mark - Developer Server

+ (void) setDeveloperServer:(BOOL)useDeveloper;
+ (BOOL) shouldUseDeveloperServer;

#pragma mark - Streaming File URLs

+ (NSURL *)streamingURLWithTempkey:(NSString *)tempKey withID:(NSString *)ID;
+ (NSURL *)keylessStreamingURL:(NSInteger)fileId;

@end
