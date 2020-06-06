//
//  PPCloudConnectivityServer.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"


typedef NS_OPTIONS(NSInteger, PPCloudConnectivityVersion) {
    PPCloudConnectivityVersionNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCloudConnectivityPort) {
    PPCloudConnectivityPortNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCloudConnectivitySSL) {
    PPCloudConnectivitySSLNone = -1,
    PPCloudConnectivitySSLFalse = 0,
    PPCloudConnectivitySSLTrue = 1
};

extern NSString *CLOUD_CONNECTIVITY_SERVER_TYPE_APP_API;
extern NSString *CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO;
extern NSString *CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_WS;
extern NSString *CLOUD_CONNECTIVITY_SERVER_TYPE_STREAMING;
extern NSString *CLOUD_CONNECTIVITY_SERVER_TYPE_WEB_APP;

@interface PPCloudConnectivityServer : RLMObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *path;
@property (nonatomic) PPCloudConnectivityPort port;
@property (nonatomic) PPCloudConnectivityPort altPort;
@property (nonatomic) PPCloudConnectivitySSL ssl;
@property (nonatomic) PPCloudConnectivitySSL altSsl;
@property (nonatomic, strong) NSString *brand;

- (id)initWithType:(NSString *)type host:(NSString *)host path:(NSString *)paht port:(PPCloudConnectivityPort)port altPort:(PPCloudConnectivityPort)altPort ssl:(PPCloudConnectivitySSL)ssl altSsl:(PPCloudConnectivitySSL)altSsl brand:(NSString *)brand;

+ (PPCloudConnectivityServer *)initWithDictionary:(NSDictionary *)serverDict;

#pragma mark - Helper methods

- (NSString *)URLString;

@end

RLM_ARRAY_TYPE(PPCloudConnectivityServer);
