//
//  PPBaseModel.h
//  Peoplepower
//
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPBaseModel : NSObject

+ (void)disableTracking:(BOOL)disabled;

+ (NSBundle *)bundle;

+ (NSString * _Nonnull )appName:(BOOL)apiFriendly;
+ (NSString * _Nonnull )brandName;
+ (NSString * _Nonnull )urlScheme;

// Pilot overrides
+ (NSString * _Nonnull )pilotFallbackAppName:(BOOL)apiFriendly;
+ (NSString * _Nonnull )pilotFallbackBrandName;

+ (void)setLoginNeededBlock:(PPBasicBlock _Nonnull )loginBlock;
+ (void)throwLoginBlock;

+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode argument:(NSString * _Nullable )argument;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString * _Nullable )originatingClass;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString * _Nullable )originatingClass argument:(NSString * _Nullable )argument;

+ (NSDictionary * _Nullable )processJSONResponse:(NSData * _Nullable )operation error:(NSError * _Nullable * _Nullable )error;
+ (NSDictionary * _Nullable )processJSONResponse:(NSData * _Nullable )operation originatingClass:(NSString * _Nullable )originatingClass error:(NSError * _Nullable * _Nullable)error;

@end
