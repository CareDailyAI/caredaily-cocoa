//
//  PPEnergyManagementDeviceUsageAggregated.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPEnergyManagementDeviceUsageAggregatedEnergy.h"
#import "PPEnergyManagementDeviceUsageAggregatedCost.h"

@interface PPEnergyManagementDeviceUsageAggregated : PPBaseModel

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSArray *energy;
@property (nonatomic, strong) NSArray *cost;

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(NSArray *)energy cost:(NSArray *)cost;

+ (PPEnergyManagementDeviceUsageAggregated *)initWithDictionary:(NSDictionary *)aggregatedDict;

@end
