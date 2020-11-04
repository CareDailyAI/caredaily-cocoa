//
//  PPCloudsIntegrationHost.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCloudsIntegrationHost.h"

@implementation PPCloudsIntegrationHost

- (id)initWithUserClient:(NSString *)appName appId:(NSString *)appId autoRefresh:(PPCloudsIntegrationHostAutoRefresh)autoRefresh expiry:(NSDate *)expiry {
    self = [super init];
    if(self) {
        self.appName = appName;
        self.appId = appId;
        self.autoRefresh = autoRefresh;
        self.expiry = expiry;
    }
    return self;
}

+ (PPCloudsIntegrationHost *)initWithDictionary:(NSDictionary *)hostDict {
    NSString *appName;
    if([hostDict objectForKey:@"appName"]) {
        appName = [hostDict objectForKey:@"appName"];
    }
    else if([hostDict objectForKey:@"name"]) {
        appName = [hostDict objectForKey:@"name"];
    }
    NSString *appId;
    if([hostDict objectForKey:@"appId"]) {
        appId = [hostDict objectForKey:@"appId"];
    }
    else if([hostDict objectForKey:@"id"]) {
        appId = [hostDict objectForKey:@"id"];
    }
    PPCloudsIntegrationHostAutoRefresh autoRefresh = PPCloudsIntegrationHostAutoRefreshNone;
    if([hostDict objectForKey:@"autoRefresh"]) {
        autoRefresh = (PPCloudsIntegrationHostAutoRefresh)((NSString *)[hostDict objectForKey:@"autoRefresh"]).integerValue;
    }
    NSString *expiryString = [hostDict objectForKey:@"expiry"];
    
    NSDate *expiry = [NSDate date];
    if(expiryString != nil) {
        if(![expiryString isEqualToString:@""]) {
            expiry = [PPNSDate parseDateTime:expiryString];
        }
    }
    
    PPCloudsIntegrationHost *host = [[PPCloudsIntegrationHost alloc] initWithUserClient:appName appId:appId autoRefresh:autoRefresh expiry:expiry];
    return host;
}

#pragma mark - Helpers

- (void)sync:(PPCloudsIntegrationHost *)host {
    if(host.appName) {
        _appName = host.appName;
    }
    if(host.appId) {
        _appId = host.appId;
    }
    if(host.autoRefresh != PPCloudsIntegrationHostAutoRefreshNone) {
        _autoRefresh = host.autoRefresh;
    }
    if(host.expiry) {
        _expiry = host.expiry;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPCloudsIntegrationHost *host = [[PPCloudsIntegrationHost allocWithZone:zone] init];
    
    host.appName = [self.appName copyWithZone:zone];
    host.appId = [self.appId copyWithZone:zone];
    host.autoRefresh = self.autoRefresh;
    host.expiry = [self.expiry copyWithZone:zone];
    
    return host;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.appName = [decoder decodeObjectForKey:@"appName"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.autoRefresh = (PPCloudsIntegrationHostAutoRefresh)((NSNumber *)[decoder decodeObjectForKey:@"autoRefresh"]).integerValue;
        self.expiry = [decoder decodeObjectForKey:@"expiry"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_appName forKey:@"appName"];
    [encoder encodeObject:_appId forKey:@"appId"];
    [encoder encodeObject:@(_autoRefresh) forKey:@"autoRefresh"];
    [encoder encodeObject:_expiry forKey:@"expiry"];
}

@end
