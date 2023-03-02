//
//  PPCloudsIntegrationClient.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

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
