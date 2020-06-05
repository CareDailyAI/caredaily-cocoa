//
//  PPDeviceActivationInfo.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceActivationInfo.h"

@implementation PPDeviceActivationInfo

- (id)initWithDeviceActivationKey:(NSString *)deviceActivationKey deviceActivationUrl:(NSString *)deviceActivationUrl message:(NSString *)message host:(NSString *)host port:(PPDeviceActivationInfoPort)port uri:(NSString *)uri ssl:(PPDeviceActivationInfoSSL)ssl {
    self = [super init];
    if(self) {
        self.deviceActivationKey = deviceActivationKey;
        self.deviceActivationUrl = deviceActivationUrl;
        self.message = message;
        self.host = host;
        self.port = port;
        self.uri = uri;
        self.ssl = ssl;
    }
    return self;
}

+ (PPDeviceActivationInfo *)initWithDictionary:(NSDictionary *)activationInfoDict {
    NSString *deviceActivationKey = [activationInfoDict objectForKey:@"deviceActivationKey"];
    NSString *deviceActivationUrl = [activationInfoDict objectForKey:@"deviceActivationUrl"];
    NSString *message = [activationInfoDict objectForKey:@"message"];
    NSString *host = [activationInfoDict objectForKey:@"host"];
    PPDeviceActivationInfoPort port = PPDeviceActivationInfoPortNone;
    if([activationInfoDict objectForKey:@"port"]) {
        port = (PPDeviceActivationInfoPort)((NSString *)[activationInfoDict objectForKey:@"port"]).integerValue;
    }
    NSString *uri = [activationInfoDict objectForKey:@"uri"];
    PPDeviceActivationInfoSSL ssl = PPDeviceActivationInfoSSLNone;
    if([activationInfoDict objectForKey:@"ssl"]) {
        ssl = (PPDeviceActivationInfoSSL)((NSString *)[activationInfoDict objectForKey:@"ssl"]).boolValue;
    }
    PPDeviceActivationInfo *activationInfo = [[PPDeviceActivationInfo alloc] initWithDeviceActivationKey:deviceActivationKey deviceActivationUrl:deviceActivationUrl message:message host:host port:port uri:uri ssl:ssl];
    return activationInfo;
}

@end
