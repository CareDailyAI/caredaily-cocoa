//
//  PPEnergyManagementDeviceUsageAggregatedCost.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPEnergyManagementDeviceUsageAggregatedCost.h"

@implementation PPEnergyManagementDeviceUsageAggregatedCost

- (id)initWithIndex:(NSString *)index value:(NSString *)value {
    self = [super init];
    if(self) {
        self.index = index;
        self.value = value;
    }
    return self;
}

+ (PPEnergyManagementDeviceUsageAggregatedCost *)initWithDictionary:(NSDictionary *)aggregatedCostDict {
    NSString *index = [aggregatedCostDict objectForKey:@"index"];
    NSString *value = [aggregatedCostDict objectForKey:@"value"];
    
    PPEnergyManagementDeviceUsageAggregatedCost *cost = [[PPEnergyManagementDeviceUsageAggregatedCost alloc] initWithIndex:index value:value];
    return cost;
}

@end
