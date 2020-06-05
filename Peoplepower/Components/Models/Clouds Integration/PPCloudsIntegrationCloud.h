//
//  PPCloudsIntegrationCloud.h
//  PPiOSCore
//
//  Created by Destry Teeter on 12/5/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroService) {
    PPCloudsIntegrationCloudMicroServiceNone = -1,
    PPCloudsIntegrationCloudMicroServiceFalse = 0,
    PPCloudsIntegrationCloudMicroServiceTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroServiceRuntime) {
    PPCloudsIntegrationCloudMicroServiceRuntimePython_2_7 = 1,
    PPCloudsIntegrationCloudMicroServiceRuntimePython_3_6 = 2,
    PPCloudsIntegrationCloudMicroServiceRuntimeNodeJS_4_3 = 3
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroServiceVersionStatus) {
    PPCloudsIntegrationCloudMicroServiceVersionStatusDevelopment = 1,
    PPCloudsIntegrationCloudMicroServiceVersionStatusSubmittedForReview = 2,
    PPCloudsIntegrationCloudMicroServiceVersionStatusUnderReview = 3,
    PPCloudsIntegrationCloudMicroServiceVersionStatusPublished = 4,
    PPCloudsIntegrationCloudMicroServiceVersionStatusAdminRejected = 5,
    PPCloudsIntegrationCloudMicroServiceVersionStatusDeveloperRejected = 6,
    PPCloudsIntegrationCloudMicroServiceVersionStatusReplacedByNewerVersion = 7
};

@interface PPCloudsIntegrationCloud : NSObject

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
