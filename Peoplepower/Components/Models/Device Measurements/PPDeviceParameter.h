//
//  PPDeviceParameter.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameterRobotVantagePoint.h"

@interface PPDeviceParameter : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSDate *lastUpdateDate;

- (id)initWithName:(NSString *)name value:(NSString *)value lastUpdateDate:(NSDate *)lastUpdateDate;
- (id)initWithName:(NSString *)name index:(NSString *)index value:(NSString *)value lastUpdateDate:(NSDate *)lastUpdateDate;
- (id)initWithName:(NSString *)name index:(NSString *)index value:(NSString *)value unit:(NSString *)unit lastUpdateDate:(NSDate *)lastUpdateDate;

+ (PPDeviceParameter *)initWithDictionary:(NSDictionary *)paramDict;

+ (NSString *)stringify:(PPDeviceParameter *)parameter;
+ (NSDictionary *)data:(PPDeviceParameter *)parameter;

#pragma mark - Helper methods

- (void)sync:(PPDeviceParameter *)parameter;

- (BOOL)isEqual:(PPDeviceParameter *)parameter;

@end
