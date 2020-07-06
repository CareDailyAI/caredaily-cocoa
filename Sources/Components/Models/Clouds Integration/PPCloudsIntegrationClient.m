//
//  PPCloudsIntegrationClient.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCloudsIntegrationClient.h"

@implementation PPCloudsIntegrationClient

+ (NSString *)primaryKey {
    return @"appId";
}

- (id)initWithAuth:(NSString *)appName appId:(PPCloudsIntegrationClientApplicationId)appId active:(PPCloudsIntegrationClientActive)active autoRefresh:(PPCloudsIntegrationClientAutoRefresh)autoRefresh expiry:(NSDate *)expiry username:(NSString *)username {
    self = [super init];
    if(self) {
        self.appName = appName;
        self.appId = appId;
        self.active = active;
        self.autoRefresh = autoRefresh;
        self.expiry = expiry;
        self.username = username;
    }
    return self;
}

+ (PPCloudsIntegrationClient *)initWithDictionary:(NSDictionary *)clientDict {
    NSString *appName;
    if([clientDict objectForKey:@"appName"]) {
        appName = [clientDict objectForKey:@"appName"];
    }
    else if([clientDict objectForKey:@"name"]) {
        appName = [clientDict objectForKey:@"name"];
    }
    PPCloudsIntegrationClientApplicationId appId = PPCloudsIntegrationClientApplicationIdNone;
    if([clientDict objectForKey:@"appId"]) {
        appId = (PPCloudsIntegrationClientApplicationId)((NSString *)[clientDict objectForKey:@"appId"]).integerValue;
    }
    else if([clientDict objectForKey:@"id"]) {
        appId = (PPCloudsIntegrationClientApplicationId)((NSString *)[clientDict objectForKey:@"id"]).integerValue;
    }
    PPCloudsIntegrationClientActive active = PPCloudsIntegrationClientActiveNone;
    if([clientDict objectForKey:@"active"]) {
        active = (PPCloudsIntegrationClientActive)((NSString *)[clientDict objectForKey:@"active"]).integerValue;
    }
    PPCloudsIntegrationClientAutoRefresh autoRefresh = PPCloudsIntegrationClientAutoRefreshNone;
    if([clientDict objectForKey:@"autoRefresh"]) {
        autoRefresh = (PPCloudsIntegrationClientAutoRefresh)((NSString *)[clientDict objectForKey:@"autoRefresh"]).integerValue;
    }
    NSString *expiryString = [clientDict objectForKey:@"expiry"];
    
    NSDate *expiry = [NSDate date];
    if(expiryString != nil) {
        if(![expiryString isEqualToString:@""]) {
            expiry = [PPNSDate parseDateTime:expiryString];
        }
    }
    
    NSString *username = [clientDict objectForKey:@"username"];
    
    PPCloudsIntegrationClient *client = [[PPCloudsIntegrationClient alloc] initWithAuth:appName appId:appId active:active autoRefresh:autoRefresh expiry:expiry username:username];
    return client;
}

#pragma mark - Helpers

- (void)sync:(PPCloudsIntegrationClient *)client {
    if(client.appName) {
        _appName = client.appName;
    }
    if(client.appId != PPCloudsIntegrationClientApplicationIdNone) {
        _appId = client.appId;
    }
    if(client.active != PPCloudsIntegrationClientActiveNone) {
        _active = client.active;
    }
    if(client.autoRefresh != PPCloudsIntegrationClientAutoRefreshNone) {
        _autoRefresh = client.autoRefresh;
    }
    if(client.expiry) {
        _expiry = client.expiry;
    }
    if(client.username) {
        _username = client.username;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPCloudsIntegrationClient *client = [[PPCloudsIntegrationClient allocWithZone:zone] init];
    
    client.appName = [self.appName copyWithZone:zone];
    client.appId = self.appId;
    client.active = self.active;
    client.autoRefresh = self.autoRefresh;
    client.expiry = [self.expiry copyWithZone:zone];
    client.username = [self.username copyWithZone:zone];
    
    return client;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.appName = [decoder decodeObjectForKey:@"appName"];
        self.appId = (PPCloudsIntegrationClientApplicationId)((NSNumber *)[decoder decodeObjectForKey:@"appId"]).integerValue;
        self.active = (PPCloudsIntegrationClientActive)((NSNumber *)[decoder decodeObjectForKey:@"active"]).integerValue;
        self.autoRefresh = (PPCloudsIntegrationClientAutoRefresh)((NSNumber *)[decoder decodeObjectForKey:@"autoRefresh"]).integerValue;
        self.expiry = [decoder decodeObjectForKey:@"expiry"];
        self.username = [decoder decodeObjectForKey:@"username"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_appName forKey:@"appName"];
    [encoder encodeObject:@(_appId) forKey:@"appId"];
    [encoder encodeObject:@(_active) forKey:@"active"];
    [encoder encodeObject:@(_autoRefresh) forKey:@"autoRefresh"];
    [encoder encodeObject:_expiry forKey:@"expiry"];
    [encoder encodeObject:_username forKey:@"username"];
}

@end
