//
//  PPCloudsIntegrationHost.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

extern NSString *OAUTH_HOST_ERROR_ACCESS_DENIED;
extern NSString *OAUTH_HOST_ERROR_UNSUPPORTED_RESPONSE_TYPE;
extern NSString *OAUTH_HOST_ERROR_SERVER_ERROR;

extern NSString *OAUTH_HOST_CLIENT_ID_AMAZON_ECHO;
extern NSString *OAUTH_HOST_CLIENT_ID_GOOGLE_HOME;

extern NSString *OAUTH_HOST_RESPONSE_TYPE_CODE;

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationHostApproved) {
    PPCloudsIntegrationHostApprovedNone = -1,
    PPCloudsIntegrationHostApprovedFalse = 0,
    PPCloudsIntegrationHostApprovedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationHostAutoRefresh) {
    PPCloudsIntegrationHostAutoRefreshNone = -1,
    PPCloudsIntegrationHostAutoRefreshFalse = 0,
    PPCloudsIntegrationHostAutoRefreshTrue = 1
};

@interface PPCloudsIntegrationHost : RLMObject <NSCopying>

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic) PPCloudsIntegrationHostAutoRefresh autoRefresh;
@property (nonatomic, strong) NSDate *expiry;

- (id)initWithUserClient:(NSString *)appName appId:(NSString *)appId autoRefresh:(PPCloudsIntegrationHostAutoRefresh)autoRefresh expiry:(NSDate *)expiry;

+ (PPCloudsIntegrationHost *)initWithDictionary:(NSDictionary *)hostDict;

#pragma mark - Helpers

- (void)sync:(PPCloudsIntegrationHost *)host;

@end

RLM_ARRAY_TYPE(PPCloudsIntegrationHost);
