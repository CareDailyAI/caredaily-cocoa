//
//  PPEnergyManagementDeviceUsageAggregated.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementDeviceUsageAggregated.h"

@implementation PPEnergyManagementDeviceUsageAggregated

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(NSArray *)energy cost:(NSArray *)cost {
    self = [super init];
    if(self) {
        self.startDate = startDate;
        self.endDate = endDate;
        self.energy = (RLMArray<PPEnergyManagementDeviceUsageAggregatedEnergy *><PPEnergyManagementDeviceUsageAggregatedEnergy> *)energy;
        self.cost = (RLMArray<PPEnergyManagementDeviceUsageAggregatedCost *><PPEnergyManagementDeviceUsageAggregatedCost> *)cost;
    }
    return self;
}

+ (PPEnergyManagementDeviceUsageAggregated *)initWithDictionary:(NSDictionary *)aggregatedDict {
   
    
    NSString *startDateString = [aggregatedDict objectForKey:@"startDate"];
    
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSString *endDateString = [aggregatedDict objectForKey:@"endDate"];
    
    NSDate *endDate = [NSDate date];
    if(endDateString != nil) {
        if(![endDateString isEqualToString:@""]) {
            endDate = [PPNSDate parseDateTime:endDateString];
        }
    }
    
    NSMutableArray *energyArray;
    if([aggregatedDict objectForKey:@"energy"]) {
        energyArray = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *energyDict in [aggregatedDict objectForKey:@"energy"]) {
            PPEnergyManagementDeviceUsageAggregatedEnergy *energy = [PPEnergyManagementDeviceUsageAggregatedEnergy initWithDictionary:energyDict];
            [energyArray addObject:energy];
        }
    }
    
    NSMutableArray *costArray;
    if([aggregatedDict objectForKey:@"cost"]) {
        costArray = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *costDict in [aggregatedDict objectForKey:@"cost"]) {
            PPEnergyManagementDeviceUsageAggregatedCost *cost = [PPEnergyManagementDeviceUsageAggregatedCost initWithDictionary:costDict];
            [costArray addObject:cost];
        }
    }
    
    PPEnergyManagementDeviceUsageAggregated *aggregatedUsage = [[PPEnergyManagementDeviceUsageAggregated alloc] initWithStartDate:startDate endDate:endDate energy:(RLMArray<PPEnergyManagementDeviceUsageAggregatedEnergy *><PPEnergyManagementDeviceUsageAggregatedEnergy> *)energyArray cost:(RLMArray<PPEnergyManagementDeviceUsageAggregatedCost *><PPEnergyManagementDeviceUsageAggregatedCost> *)costArray];
    return aggregatedUsage;
}
@end
