//
//  PPEnergyManagementDeviceUsageAggregatedEnergy.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementDeviceUsageAggregatedEnergy.h"

@implementation PPEnergyManagementDeviceUsageAggregatedEnergy

- (id)initWithIndex:(NSString *)index value:(NSString *)value {
    self = [super init];
    if(self) {
        self.index = index;
        self.value = value;
    }
    return self;
}

+ (PPEnergyManagementDeviceUsageAggregatedEnergy *)initWithDictionary:(NSDictionary *)aggregatedEnergyDict {
    NSString *index = [aggregatedEnergyDict objectForKey:@"index"];
    NSString *value = [aggregatedEnergyDict objectForKey:@"value"];
    
    PPEnergyManagementDeviceUsageAggregatedEnergy *energy = [[PPEnergyManagementDeviceUsageAggregatedEnergy alloc] initWithIndex:index value:value];
    return energy;
}

@end
