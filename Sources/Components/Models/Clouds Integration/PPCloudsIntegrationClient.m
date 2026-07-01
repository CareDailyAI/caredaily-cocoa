//
//  PPCloudsIntegrationClient.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCloudsIntegrationClient.h"

@implementation PPCloudsIntegrationClient

+ (NSString *)primaryKey {
    return @"appId";
}

- (id)initWithAuth:(NSString *)appName
             appId:(PPCloudsIntegrationClientApplicationId)appId
            active:(PPCloudsIntegrationClientActive)active
       autoRefresh:(PPCloudsIntegrationClientAutoRefresh)autoRefresh
            expiry:(NSDate *)expiry
          username:(NSString *)username
            authId:(PPCloudsIntegrationAuthorizationId)authId
            userId:(PPUserId)userId
         appUserId:(NSString *)appUserId {
    self = [super init];
    if(self) {
        self.appName = appName;
        self.appId = appId;
        self.active = active;
        self.autoRefresh = autoRefresh;
        self.expiry = expiry;
        self.username = username;
        self.authId = authId;
        self.userId = userId;
        self.appUserId = appUserId;
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
    
    PPCloudsIntegrationAuthorizationId authId = PPCloudsIntegrationAuthorizationIdNone;
    if([clientDict objectForKey:@"authId"]) {
        authId = (PPCloudsIntegrationAuthorizationId)((NSString *)[clientDict objectForKey:@"authId"]).integerValue;
    }
    PPUserId userId = PPUserIdNone;
    if([clientDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[clientDict objectForKey:@"userId"]).integerValue;
    }
    NSString *appUserId = [clientDict objectForKey:@"appUserId"];
    
    PPCloudsIntegrationClient *client = [[PPCloudsIntegrationClient alloc] initWithAuth:appName
                                                                                  appId:appId
                                                                                 active:active
                                                                            autoRefresh:autoRefresh
                                                                                 expiry:expiry
                                                                               username:username
                                                                                 authId:authId
                                                                                 userId:userId
                                                                              appUserId:appUserId];
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
    if(client.authId != PPCloudsIntegrationAuthorizationIdNone) {
        _authId = client.authId;
    }
    if(client.userId != PPUserIdNone) {
        _userId = client.userId;
    }
    if(client.appUserId) {
        _appUserId = client.appUserId;
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
    client.authId = self.authId;
    client.userId = self.userId;
    client.appUserId = [self.appUserId copyWithZone:zone];
    
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
        self.authId = (PPCloudsIntegrationAuthorizationId)((NSNumber *)[decoder decodeObjectForKey:@"authId"]).integerValue;
        self.userId = (PPUserId)((NSNumber *)[decoder decodeObjectForKey:@"userId"]).integerValue;
        self.appUserId = [decoder decodeObjectForKey:@"appUserId"];
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
    [encoder encodeObject:@(_authId) forKey:@"authId"];
    [encoder encodeObject:@(_userId) forKey:@"userId"];
    [encoder encodeObject:_appUserId forKey:@"appUserId"];
}

@end
