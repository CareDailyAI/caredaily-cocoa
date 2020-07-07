//
//  PPDeviceActivationInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPDeviceActivationInfoPort) {
    PPDeviceActivationInfoPortNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceActivationInfoSSL) {
    PPDeviceActivationInfoSSLNone = -1,
    PPDeviceActivationInfoSSLFalse = 0,
    PPDeviceActivationInfoSSLTrue
};

@interface PPDeviceActivationInfo : PPBaseModel

@property (nonatomic, strong) NSString *deviceActivationKey;
@property (nonatomic, strong) NSString *deviceActivationUrl;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *host;
@property (nonatomic) PPDeviceActivationInfoPort port;
@property (nonatomic, strong) NSString *uri;
@property (nonatomic) PPDeviceActivationInfoSSL ssl;

- (id)initWithDeviceActivationKey:(NSString *)deviceActivationKey deviceActivationUrl:(NSString *)deviceActivationUrl message:(NSString *)message host:(NSString *)host port:(PPDeviceActivationInfoPort)port uri:(NSString *)uri ssl:(PPDeviceActivationInfoSSL)ssl;

+ (PPDeviceActivationInfo *)initWithDictionary:(NSDictionary *)activationInfoDict;

@end
