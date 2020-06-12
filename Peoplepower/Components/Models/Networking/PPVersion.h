//
//  PPVersion.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#ifndef PPVersion_h
#define PPVersion_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif // PPVersion_h
@interface PPVersion : RLMObject

+ (PPVersion * _Nonnull )myVersion;

+ (PPVersion * _Nonnull )appVersion;
+ (PPVersion * _Nonnull )bundleVersion;

- (id _Nonnull )initWithVersion:(NSString * _Nullable )versionString;
- (BOOL)isOlderThan:(PPVersion * _Nonnull )version;
- (BOOL)isNewerThan:(PPVersion * _Nonnull )version;
- (BOOL)isNewerThanOrEqualTo:(PPVersion * _Nonnull )version;
- (BOOL)isOlderThanMyVersion;
- (BOOL)isNewerThanMyVersion;
- (NSString * _Nonnull )toNSString;

@property (readonly, nonatomic) NSInteger major;
@property (readonly, nonatomic) NSInteger minor;
@property (readonly, nonatomic) NSInteger build;
@property (readonly, nonatomic) NSString * _Nullable commit;

@end

RLM_ARRAY_TYPE(PPVersion);
