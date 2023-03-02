//
//  PPCloudsIntegrationHost.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCloudsIntegrationHost : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic) PPCloudsIntegrationHostAutoRefresh autoRefresh;
@property (nonatomic, strong) NSDate *expiry;

- (id)initWithUserClient:(NSString *)appName appId:(NSString *)appId autoRefresh:(PPCloudsIntegrationHostAutoRefresh)autoRefresh expiry:(NSDate *)expiry;

+ (PPCloudsIntegrationHost *)initWithDictionary:(NSDictionary *)hostDict;

#pragma mark - Helpers

- (void)sync:(PPCloudsIntegrationHost *)host;

@end
