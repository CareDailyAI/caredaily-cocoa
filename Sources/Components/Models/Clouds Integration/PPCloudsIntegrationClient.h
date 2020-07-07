//
//  PPCloudsIntegrationClient.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientApplicationId) {
    PPCloudsIntegrationClientApplicationIdNone = -1,
    PPCloudsIntegrationClientApplicationIdUnknown = 0,
    PPCloudsIntegrationClientApplicationIdSAMI = 1,
    PPCloudsIntegrationClientApplicationIdTwitter = 2,
    PPCloudsIntegrationClientApplicationIdLondonHydro = 3,
    PPCloudsIntegrationClientApplicationIdPresence = 4,
    PPCloudsIntegrationClientApplicationIdLondonHydroTestLab = 5,
    PPCloudsIntegrationClientApplicationIdNetatmo = 6,
    PPCloudsIntegrationClientApplicationIdSensibo = 7,
    PPCloudsIntegrationClientApplicationIdHoneywell = 8,
    PPCloudsIntegrationClientApplicationIdLogitech = 9,
    PPCloudsIntegrationClientApplicationIdEcobee = 10
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientActive) {
    PPCloudsIntegrationClientActiveNone = -1,
    PPCloudsIntegrationClientActiveFalse = 0,
    PPCloudsIntegrationClientActiveTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientAutoRefresh) {
    PPCloudsIntegrationClientAutoRefreshNone = -1,
    PPCloudsIntegrationClientAutoRefreshFalse = 0,
    PPCloudsIntegrationClientAutoRefreshTrue = 1
};

@interface PPCloudsIntegrationClient : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *appName;
@property (nonatomic) PPCloudsIntegrationClientApplicationId appId;
@property (nonatomic) PPCloudsIntegrationClientActive active;
@property (nonatomic) PPCloudsIntegrationClientAutoRefresh autoRefresh;
@property (nonatomic, strong) NSDate *expiry;
@property (nonatomic, strong) NSString *username;

- (id)initWithAuth:(NSString *)appName appId:(PPCloudsIntegrationClientApplicationId)appId active:(PPCloudsIntegrationClientActive)active autoRefresh:(PPCloudsIntegrationClientAutoRefresh)autoRefresh expiry:(NSDate *)expiry username:(NSString *)username;

+ (PPCloudsIntegrationClient *)initWithDictionary:(NSDictionary *)clientDict;

#pragma mark - Helpers

- (void)sync:(PPCloudsIntegrationClient *)client;

@end

