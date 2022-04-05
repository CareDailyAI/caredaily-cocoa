//
//  PPVersion.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPVersion : NSObject

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
@property (readonly, nonatomic) NSString *commit;

@end
