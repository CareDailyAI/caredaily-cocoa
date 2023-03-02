//
//  PPDeviceParameter.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameterRobotVantagePoint.h"

@interface PPDeviceParameter : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString * _Nonnull name;
@property (nonatomic, strong) NSString * _Nullable index;
@property (nonatomic, strong) NSString * _Nullable value;
@property (nonatomic, strong) NSString * _Nullable unit;
@property (nonatomic, strong) NSDate * _Nullable lastUpdateDate;

- (id)initWithName:(NSString * _Nonnull )name value:(NSString * _Nullable )value lastUpdateDate:(NSDate * _Nullable )lastUpdateDate;
- (id)initWithName:(NSString * _Nonnull )name index:(NSString * _Nullable )index value:(NSString * _Nullable )value lastUpdateDate:(NSDate * _Nullable )lastUpdateDate;
- (id)initWithName:(NSString * _Nonnull )name index:(NSString * _Nullable )index value:(NSString * _Nullable )value unit:(NSString * _Nullable )unit lastUpdateDate:(NSDate * _Nullable )lastUpdateDate;

+ (PPDeviceParameter * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )paramDict;

+ (NSString * _Nonnull )stringify:(PPDeviceParameter * _Nonnull )parameter;
+ (NSDictionary * _Nonnull )data:(PPDeviceParameter * _Nonnull )parameter;

#pragma mark - Helper methods

- (void)sync:(PPDeviceParameter *)parameter;

- (BOOL)isEqual:(PPDeviceParameter *)parameter;

@end
