//
//  PPCloudsIntegrationHostAccessToken.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCloudsIntegrationHostAccessToken : PPBaseModel

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *tokenType;
@property (nonatomic) NSInteger expiresIn;
@property (nonatomic, strong) NSString *refreshToken;

- (id)initWithToken:(NSString *)accessToken tokenType:(NSString *)tokenType expiresIn:(NSInteger)expiresIn refreshToken:(NSString *)refreshToken;

+ (PPCloudsIntegrationHostAccessToken *)initWithDictionary:(NSDictionary *)tokenDict;

@end
