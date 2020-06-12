//
//  PPCloudsIntegrationCloud.m
//  Peoplepower
//
//  Created by Destry Teeter on 12/5/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCloudsIntegrationCloud.h"

@implementation PPCloudsIntegrationCloud

+ (NSString *)primaryKey {
    return @"appId";
}

- (id)initWithId:(PPCloudsIntegrationClientApplicationId)appId name:(NSString *)name microService:(PPCloudsIntegrationCloudMicroService)microservice icon:(NSString *)icon {
    self = [super init];
    if(self) {
        self.appId = appId;
        self.name = name;
        self.microService = microservice;
        self.icon = icon;
    }
    return self;
}

+ (PPCloudsIntegrationCloud *)initWithDictionary:(NSDictionary *)cloudDict {
    PPCloudsIntegrationClientApplicationId appId = PPCloudsIntegrationClientApplicationIdNone;
    if([cloudDict objectForKey:@"id"]) {
        appId = (PPCloudsIntegrationClientApplicationId)((NSNumber *)[cloudDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [cloudDict objectForKey:@"name"];
    
    PPCloudsIntegrationCloudMicroService microservice = PPCloudsIntegrationCloudMicroServiceNone;
    if([cloudDict objectForKey:@"microService"]) {
        microservice = (PPCloudsIntegrationCloudMicroService)((NSString *)[cloudDict objectForKey:@"microService"]).integerValue;
    }
    
    NSString *icon = [cloudDict objectForKey:@"icon"];
    
    PPCloudsIntegrationCloud *cloud = [[PPCloudsIntegrationCloud alloc] initWithId:appId name:name microService:microservice icon:icon];
    return cloud;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.appId = (PPCloudsIntegrationClientApplicationId)((NSNumber *)[decoder decodeObjectForKey:@"appId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.microService = (PPCloudsIntegrationCloudMicroService)((NSNumber *)[decoder decodeObjectForKey:@"microService"]).integerValue;
        self.icon = [decoder decodeObjectForKey:@"icon"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_appId) forKey:@"appId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_microService) forKey:@"microService"];
    [encoder encodeObject:_icon forKey:@"icon"];
}

@end
