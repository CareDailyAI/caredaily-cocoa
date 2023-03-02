//
//  PPCloudsIntegrationCloud.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/5/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCloudsIntegrationCloud : PPBaseModel

// Application ID used in the API to gain access to the cloud/application
@property (nonatomic) PPCloudsIntegrationClientApplicationId appId;
// Cloud/application name
@property (nonatomic, strong) NSString *name;
// A boolean flag, if this cloud supports microservice code upload
@property (nonatomic) PPCloudsIntegrationCloudMicroService microService;
// Icon file location
@property (nonatomic, strong) NSString *icon;

- (id)initWithId:(PPCloudsIntegrationClientApplicationId)appId name:(NSString *)name microService:(PPCloudsIntegrationCloudMicroService)microservice icon:(NSString *)icon;

+ (PPCloudsIntegrationCloud *)initWithDictionary:(NSDictionary *)cloudDict;

@end
