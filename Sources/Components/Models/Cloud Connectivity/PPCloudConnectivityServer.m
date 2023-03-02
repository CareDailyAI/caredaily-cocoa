//
//  PPCloudConnectivityServer.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCloudConnectivityServer.h"

@implementation PPCloudConnectivityServer

- (id)initWithType:(NSString *)type host:(NSString *)host path:(NSString *)path port:(PPCloudConnectivityPort)port altPort:(PPCloudConnectivityPort)altPort ssl:(PPCloudConnectivitySSL)ssl altSsl:(PPCloudConnectivitySSL)altSsl brand:(NSString *)brand {
    self = [super init];
    if(self) {
        self.type = type;
        self.host = host;
        self.path = path;
        self.port = port;
        self.altPort = altPort;
        self.ssl = ssl;
        self.altSsl = altSsl;
        self.brand = brand;
    }
    return self;
}

+ (PPCloudConnectivityServer *)initWithDictionary:(NSDictionary *)serverDict {
    NSString *type = [serverDict objectForKey:@"type"];
    NSString *host = [serverDict objectForKey:@"host"];
    NSString *path = [serverDict objectForKey:@"path"];
    
    PPCloudConnectivityPort port = PPCloudConnectivityPortNone;
    if([serverDict objectForKey:@"port"]) {
        port = (PPCloudConnectivityPort)((NSString *)[serverDict objectForKey:@"port"]).integerValue;
    }
    
    PPCloudConnectivityPort altPort = PPCloudConnectivityPortNone;
    if([serverDict objectForKey:@"altPort"]) {
        altPort = (PPCloudConnectivityPort)((NSString *)[serverDict objectForKey:@"altPort"]).integerValue;
    }
    
    PPCloudConnectivitySSL ssl = PPCloudConnectivitySSLNone;
    if([serverDict objectForKey:@"ssl"]) {
        ssl = (PPCloudConnectivitySSL)((NSString *)[serverDict objectForKey:@"ssl"]).integerValue;
    }
    
    PPCloudConnectivitySSL altSsl = PPCloudConnectivitySSLNone;
    if([serverDict objectForKey:@"altSsl"]) {
        altSsl = (PPCloudConnectivitySSL)((NSString *)[serverDict objectForKey:@"altSsl"]).integerValue;
    }
    
    NSString *brand = [serverDict objectForKey:@"brand"];
    
    PPCloudConnectivityServer *server = [[PPCloudConnectivityServer alloc] initWithType:type host:host path:path port:port altPort:altPort ssl:ssl altSsl:altSsl brand:brand];
    return server;
}

#pragma mark - Helper methods

- (NSString *)URLString {
    NSString *protocol = @"http";
    if ([self.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_WS_API]) {
        protocol = @"ws";
    }
    
    NSString *serverURLString = [NSString stringWithFormat:@"http%@://%@%@%@", (self.ssl == PPCloudConnectivitySSLTrue) ? @"s": @"", self.host, (self.port) ? [NSString stringWithFormat:@":%li", (long)self.port] : @"", (self.path) ? self.path : @""];
    return serverURLString;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.type = [decoder decodeObjectForKey:@"type"];
        self.host = [decoder decodeObjectForKey:@"host"];
        self.path = [decoder decodeObjectForKey:@"path"];
        self.port = (PPCloudConnectivityPort)((NSNumber *)[decoder decodeObjectForKey:@"port"]).integerValue;
        self.altPort = (PPCloudConnectivityPort)((NSNumber *)[decoder decodeObjectForKey:@"altPort"]).integerValue;
        self.ssl = (PPCloudConnectivitySSL)((NSNumber *)[decoder decodeObjectForKey:@"ssl"]).integerValue;
        self.altSsl = (PPCloudConnectivitySSL)((NSNumber *)[decoder decodeObjectForKey:@"altSsl"]).integerValue;
        self.brand = [decoder decodeObjectForKey:@"brand"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_type forKey:@"type"];
    [encoder encodeObject:_host forKey:@"host"];
    [encoder encodeObject:_path forKey:@"path"];
    [encoder encodeObject:@(_port) forKey:@"port"];
    [encoder encodeObject:@(_altPort) forKey:@"altPort"];
    [encoder encodeObject:@(_ssl) forKey:@"ssl"];
    [encoder encodeObject:@(_altSsl) forKey:@"altSsl"];
    [encoder encodeObject:_brand forKey:@"brand"];
}

@end
