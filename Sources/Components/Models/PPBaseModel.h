//
//  PPBaseModel.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

@class PPFile;

typedef void (^PPBasicBlock)(void);
typedef void (^PPErrorBlock)(NSError * _Nullable error);
typedef void (^PPBooleanBlock)(BOOL b);
typedef void (^PPNSIntegerBlock)(NSInteger i);
typedef void (^PPNSStringBlock)(NSString * _Nullable s);
typedef void (^PPNSURLBlock)(NSURL * _Nullable u);
typedef void (^PPNSArrayBlock)(NSArray * _Nullable a);
typedef void (^PPNSDictionaryBlock)(NSDictionary * _Nullable a);
typedef void (^PPFileBlock)(PPFile * _Nullable f);

@interface PPBaseModel : NSObject

+ (void)disableTracking:(BOOL)disabled;

+ (NSString * _Nonnull )appName:(BOOL)apiFriendly;
+ (NSString * _Nonnull )brandName;
+ (NSString * _Nonnull )urlScheme;

+ (void)setLoginNeededBlock:(PPBasicBlock _Nonnull )loginBlock;
+ (void)throwLoginBlock;

+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode argument:(NSString * _Nullable )argument;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString * _Nullable )originatingClass;
+ (NSError * _Nullable )resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString * _Nullable )originatingClass argument:(NSString * _Nullable )argument;

+ (NSDictionary * _Nullable )processJSONResponse:(NSData * _Nullable )operation error:(NSError * _Nullable * _Nullable )error;
+ (NSDictionary * _Nullable )processJSONResponse:(NSData * _Nullable )operation originatingClass:(NSString * _Nullable )originatingClass error:(NSError * _Nullable * _Nullable)error;

@end
