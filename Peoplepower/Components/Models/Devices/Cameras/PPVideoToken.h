//
//  PPVideoToken.h
//  AFNetworking
//
//  Created by Destry Teeter on 7/26/18.
//

typedef NS_OPTIONS(NSInteger, PPVideoTokenProvider) {
    PPVideoTokenProviderNone = -1,
    PPVideoTokenProviderUndefined = 0,
    PPVideoTokenProviderVidyo = 1,
    PPVideoTokenProviderTwilio = 2
};

typedef NS_OPTIONS(NSInteger, PPVideoTokenAuthType) {
    PPVideoTokenAuthTypeNone = -1,
    PPVideoTokenAuthTypeDeviceAuthToken = 0,
    PPVideoTokenAuthTypeStreamingId = 1
};

typedef NS_OPTIONS(NSInteger, PPVideoTokenExpireTimeInterval) {
    PPVideoTokenExpireTimeIntervalNone = -1,
    PPVideoTokenExpireTimeIntervalDefault = 3600
};

extern NSString *PLIST_KEY_CONFIG_VIDEO_TOKEN_PROVIDER_ID;
extern NSString *PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_ID;
extern NSString *PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_NAME;

@interface PPVideoToken : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDate *expiration;

- (id)initWithToken:(NSString *)token expiration:(NSDate *)expiration;

+ (PPVideoToken *)initWithDictionary:(NSDictionary *)tokenDict;

+ (NSString *)appId:(PPVideoTokenProvider)provider;
+ (NSString *)appName:(PPVideoTokenProvider)provider;

+ (PPVideoTokenProvider)defaultProvider;
+ (void)setDefaultProvider:(PPVideoTokenProvider)provider;

@end
