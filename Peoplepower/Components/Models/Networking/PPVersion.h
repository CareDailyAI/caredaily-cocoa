//
//  PPVersion.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

@class PPVersion;

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface PPVersion : NSObject

+ (PPVersion *)myVersion;

- (id)initWithVersion:(NSString *)versionString;
- (BOOL)isOlderThan:(PPVersion *)version;
- (BOOL)isNewerThan:(PPVersion *)version;
- (BOOL)isNewerThanOrEqualTo:(PPVersion *)version;
- (BOOL)isOlderThanMyVersion;
- (BOOL)isNewerThanMyVersion;
- (NSString *)toNSString;

@property (readonly, nonatomic) NSInteger major;
@property (readonly, nonatomic) NSInteger minor;
@property (readonly, nonatomic) NSInteger build;
@property (readonly, nonatomic) NSString *commit;

@end
