//
//  PPVideoToken.m
//  AFNetworking
//
//  Created by Destry Teeter on 7/26/18.
//

#import "PPVideoToken.h"

static PPVideoTokenProvider kDefaultProvider = PPVideoTokenProviderVidyo;

@implementation PPVideoToken

- (id)initWithToken:(NSString *)token expiration:(NSDate *)expiration {
    self = [super init];
    if(self) {
        self.token = token;
        self.expiration = expiration;
    }
    return self;
}

+ (PPVideoToken *)initWithDictionary:(NSDictionary *)tokenDict {
    NSString *token = [tokenDict objectForKey:@"token"];
    
    NSTimeInterval expireTime = ((NSString *)[tokenDict objectForKey:@"expire"]).integerValue;
    NSDate *expiration = [NSDate dateWithTimeIntervalSinceNow:expireTime];
    
    return [[PPVideoToken alloc] initWithToken:token expiration:expiration];
}

+ (NSString *)appId:(PPVideoTokenProvider)provider {
    NSString *appId;
    NSObject *providerDict = [PPAppResources getPlistEntry:[NSString stringWithFormat:@"%@.%li", PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_PROVIDER_ID, (long)provider] filename:PP_PLIST_FILE_CONFIG];
    
    if(providerDict && [providerDict isKindOfClass:[NSDictionary class]]) {
        if([(NSDictionary *)providerDict objectForKey:PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_ID]) {
            appId = [(NSDictionary *)providerDict objectForKey:PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_ID];
        }
    }
    return appId;
}

+ (NSString *)appName:(PPVideoTokenProvider)provider {
    NSString *appId;
    NSObject *providerDict = [PPAppResources getPlistEntry:[NSString stringWithFormat:@"%@.%li", PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_PROVIDER_ID, (long)provider] filename:PP_PLIST_FILE_CONFIG];
    
    if(providerDict && [providerDict isKindOfClass:[NSDictionary class]]) {
        if([(NSDictionary *)providerDict objectForKey:PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_NAME]) {
            appId = [(NSDictionary *)providerDict objectForKey:PP_PLIST_KEY_CONFIG_VIDEO_TOKEN_APP_NAME];
        }
    }
    return appId;
}

+ (PPVideoTokenProvider)defaultProvider {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"proxy.defaultProvider"]) {
        PPVideoTokenProvider provider = (PPVideoTokenProvider)((NSString *)[defaults objectForKey:@"proxy.defaultProvider"]).integerValue;
        return provider;
    }
    return kDefaultProvider;
}

+ (void)setDefaultProvider:(PPVideoTokenProvider)provider {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(provider).stringValue forKey:@"proxy.defaultProvider"];
    [defaults synchronize];
}

@end
