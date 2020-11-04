//
//  PPEnergyManagementUsage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementUsage : PPBaseModel

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *energy;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic) PPEnergyManagementUsageExternal external;

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(NSString *)energy cost:(NSString *)cost external:(PPEnergyManagementUsageExternal)external;

+ (PPEnergyManagementUsage *)initWithDictionary:(NSDictionary *)usageDict;

@end
