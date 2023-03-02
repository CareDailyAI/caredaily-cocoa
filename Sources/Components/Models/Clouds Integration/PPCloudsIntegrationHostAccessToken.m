//
//  PPCloudsIntegrationHostAccessToken.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCloudsIntegrationHostAccessToken.h"

@implementation PPCloudsIntegrationHostAccessToken

- (id)initWithToken:(NSString *)accessToken tokenType:(NSString *)tokenType expiresIn:(NSInteger)expiresIn refreshToken:(NSString *)refreshToken {
    self = [super init];
    if(self) {
        self.accessToken = accessToken;
        self.tokenType = tokenType;
        self.expiresIn = expiresIn;
        self.refreshToken = refreshToken;
    }
    return self;
}

+ (PPCloudsIntegrationHostAccessToken *)initWithDictionary:(NSDictionary *)tokenDict {
    NSString *accessToken = [tokenDict objectForKey:@"accessToken"];
    NSString *tokenType = [tokenDict objectForKey:@"tokenType"];
    NSInteger expiresIn = (NSInteger)((NSString *)[tokenDict objectForKey:@"expiresIn"]).integerValue;
    NSString *refreshToken = [tokenDict objectForKey:@"refreshToken"];

    PPCloudsIntegrationHostAccessToken *token = [[PPCloudsIntegrationHostAccessToken alloc] initWithToken:accessToken tokenType:tokenType expiresIn:expiresIn refreshToken:refreshToken];
    return token;
}
@end
