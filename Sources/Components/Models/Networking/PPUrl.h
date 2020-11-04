//
//  PPUrl.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPCloudConnectivityServer.h"
#import "PPCloudConnectivityCloud.h"

@interface PPUrl : NSObject

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
