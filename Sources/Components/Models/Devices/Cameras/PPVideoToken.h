//
//  PPVideoToken.h
//  AFNetworking
//
//  Created by Destry Teeter on 7/26/18.
//

@interface PPVideoToken : PPBaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDate *expiration;

- (id)initWithToken:(NSString *)token expiration:(NSDate *)expiration;

+ (PPVideoToken *)initWithDictionary:(NSDictionary *)tokenDict;

+ (NSString *)appId:(PPVideoTokenProvider)provider;
+ (NSString *)appName:(PPVideoTokenProvider)provider;

+ (PPVideoTokenProvider)defaultProvider;
+ (void)setDefaultProvider:(PPVideoTokenProvider)provider;

@end
