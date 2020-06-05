//
//  PPEnergyManagementDeviceUsagePower.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPEnergyManagementDeviceUsagePower.h"

@implementation PPEnergyManagementDeviceUsagePower

- (id)initWithAmountPerHour:(NSString *)amountPerHour watts:(NSString *)watts currentRate:(NSString *)currentRate lastUpdateDate:(NSDate *)lastUpdateDate {
    self = [super init];
    if(self) {
        self.amountPerHour = amountPerHour;
        self.watts = watts;
        self.currentRate = currentRate;
        self.lastUpdateDate = lastUpdateDate;
    }
    return self;
}

+ (PPEnergyManagementDeviceUsagePower *)initWithDictionary:(NSDictionary *)powerDict {
    NSString *amountPerHour = [powerDict objectForKey:@"amountPerHour"];
    NSString *watts = [powerDict objectForKey:@"watts"];
    NSString *currentRate = [powerDict objectForKey:@"currentRate"];
    
    NSString *lastUpdateDateString = [powerDict objectForKey:@"lastUpdateDate"];
    
    NSDate *lastUpdateDate = [NSDate date];
    if(lastUpdateDateString != nil) {
        if(![lastUpdateDateString isEqualToString:@""]) {
            lastUpdateDate = [PPNSDate parseDateTime:lastUpdateDateString];
        }
    }
    
    PPEnergyManagementDeviceUsagePower *powerUsage = [[PPEnergyManagementDeviceUsagePower alloc] initWithAmountPerHour:amountPerHour watts:watts currentRate:currentRate lastUpdateDate:lastUpdateDate];
    return powerUsage;
}

@end
