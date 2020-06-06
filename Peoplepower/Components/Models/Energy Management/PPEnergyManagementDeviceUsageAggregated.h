//
//  PPEnergyManagementDeviceUsageAggregated.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPEnergyManagementDeviceUsageAggregatedEnergy.h"
#import "PPEnergyManagementDeviceUsageAggregatedCost.h"

@interface PPEnergyManagementDeviceUsageAggregated : RLMObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) RLMArray<PPEnergyManagementDeviceUsageAggregatedEnergy *><PPEnergyManagementDeviceUsageAggregatedEnergy> *energy;
@property (nonatomic, strong) RLMArray<PPEnergyManagementDeviceUsageAggregatedCost *><PPEnergyManagementDeviceUsageAggregatedCost> *cost;

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(RLMArray *)energy cost:(RLMArray *)cost;

+ (PPEnergyManagementDeviceUsageAggregated *)initWithDictionary:(NSDictionary *)aggregatedDict;

@end

RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsageAggregated);
