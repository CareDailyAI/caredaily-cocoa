//
//  PPOAuthHost.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2018 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

extern NSString *OAUTH_HOST_ERROR_ACCESS_DENIED;
extern NSString *OAUTH_HOST_ERROR_UNSUPPORTED_RESPONSE_TYPE;
extern NSString *OAUTH_HOST_ERROR_SERVER_ERROR;

extern NSString *OAUTH_HOST_CLIENT_ID_AMAZON_ECHO;
extern NSString *OAUTH_HOST_CLIENT_ID_GOOGLE_HOME;

extern NSString *OAUTH_HOST_RESPONSE_TYPE_CODE;

typedef NS_OPTIONS(BOOL, PPOAuthHostApproved) {
    PPOAuthHostApprovedFalse = 0,
    PPOAuthHostApprovedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPOAuthHostAutoRefresh) {
    PPOAuthHostAutoRefreshNone = -1,
    PPOAuthHostAutoRefreshFalse = 0,
    PPOAuthHostAutoRefreshTrue = 1
};

@interface PPOAuthHost : RLMObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic) PPOAuthHostAutoRefresh autoRefresh;
@property (nonatomic, strong) NSDate *expiry;

- (id)initWithUserClient:(NSString *)appName appId:(NSString *)appId autoRefresh:(PPOAuthHostAutoRefresh)autoRefresh expiry:(NSDate *)expiry;

+ (PPOAuthHost *)initWithDictionary:(NSDictionary *)hostDict;

#pragma mark - Helpers

- (void)sync:(PPOAuthHost *)host;

@end

RLM_ARRAY_TYPE(PPOAuthHost);
