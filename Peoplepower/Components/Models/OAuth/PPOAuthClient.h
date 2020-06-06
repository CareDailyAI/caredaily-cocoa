//
//  PPOAuthClient.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2018 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPOAuthClientApplicationId) {
    PPOAuthClientApplicationIdNone = -1,
    PPOAuthClientApplicationIdUnknown = 0,
    PPOAuthClientApplicationIdSAMI = 1,
    PPOAuthClientApplicationIdTwitter = 2,
    PPOAuthClientApplicationIdLondonHydro = 3,
    PPOAuthClientApplicationIdPresence = 4,
    PPOAuthClientApplicationIdLondonHydroTestLab = 5,
    PPOAuthClientApplicationIdNetatmo = 6,
    PPOAuthClientApplicationIdSensibo = 7,
    PPOAuthClientApplicationIdHoneywell = 8,
    PPOAuthClientApplicationIdLogitech = 9,
    PPOAuthClientApplicationIdEcobee = 10
};

typedef NS_OPTIONS(NSInteger, PPOAuthClientActive) {
    PPOAuthClientActiveNone = -1,
    PPOAuthClientActiveFalse = 0,
    PPOAuthClientActiveTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPOAuthClientAutoRefresh) {
    PPOAuthClientAutoRefreshNone = -1,
    PPOAuthClientAutoRefreshFalse = 0,
    PPOAuthClientAutoRefreshTrue = 1
};

@interface PPOAuthClient : RLMObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic) PPOAuthClientApplicationId appId;
@property (nonatomic) PPOAuthClientActive active;
@property (nonatomic) PPOAuthClientAutoRefresh autoRefresh;
@property (nonatomic, strong) NSDate *expiry;
@property (nonatomic, strong) NSString *username;

- (id)initWithAuth:(NSString *)appName appId:(PPOAuthClientApplicationId)appId active:(PPOAuthClientActive)active autoRefresh:(PPOAuthClientAutoRefresh)autoRefresh expiry:(NSDate *)expiry username:(NSString *)username;

+ (PPOAuthClient *)initWithDictionary:(NSDictionary *)clientDict;

#pragma mark - Helpers

- (void)sync:(PPOAuthClient *)client;

@end

RLM_ARRAY_TYPE(PPOAuthClient);
