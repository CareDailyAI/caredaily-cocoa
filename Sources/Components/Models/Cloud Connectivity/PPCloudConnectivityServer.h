//
//  PPCloudConnectivityServer.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCloudConnectivityServer : PPBaseModel

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
