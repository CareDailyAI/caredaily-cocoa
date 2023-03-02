//
//  PPEnergyManagementUsage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementUsage.h"

@implementation PPEnergyManagementUsage

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(NSString *)energy cost:(NSString *)cost external:(PPEnergyManagementUsageExternal)external {
    self = [super init];
    if(self) {
        self.startDate = startDate;
        self.endDate = endDate;
        self.energy = energy;
        self.cost = cost;
        self.external = external;
    }
    return self;
}

+ (PPEnergyManagementUsage *)initWithDictionary:(NSDictionary *)usageDict {
    
    NSString *startDateString = [usageDict objectForKey:@"startDate"];
    NSString *endDateString = [usageDict objectForKey:@"endDate"];
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSDate *endDate = [NSDate date];
    if(endDateString != nil) {
        if(![endDateString isEqualToString:@""]) {
            endDate = [PPNSDate parseDateTime:endDateString];
        }
    }
    
    NSString *energy = [usageDict objectForKey:@"energy"];
    NSString *cost = [usageDict objectForKey:@"cost"];
    PPEnergyManagementUsageExternal external = PPEnergyManagementUsageExternalNone;
    if([usageDict objectForKey:@"external"]) {
        external = (PPEnergyManagementUsageExternal)((NSString *)[usageDict objectForKey:@"external"]).integerValue;
    }
    
    PPEnergyManagementUsage *usage = [[PPEnergyManagementUsage alloc] initWithStartDate:startDate endDate:endDate energy:energy cost:cost external:external];
    return usage;
}

@end
