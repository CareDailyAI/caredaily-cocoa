//
//  PPDeviceActivationInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

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
