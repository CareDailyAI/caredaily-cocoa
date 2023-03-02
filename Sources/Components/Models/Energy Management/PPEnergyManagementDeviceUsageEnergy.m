//
//  PPEnergyManagementDeviceUsageEnergy.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementDeviceUsageEnergy.h"

@implementation PPEnergyManagementDeviceUsageEnergy

- (id)initWithAmount:(NSString *)amount kwh:(NSString *)kwh amountYTD:(NSString *)amountYTD kwhYTD:(NSString *)kwhYTD amountDTD:(NSString *)amountDTD kwhDTD:(NSString *)kwhDTD {
    self = [super init];
    if(self) {
        self.amount = amount;
        self.kwh = kwh;
        self.amountYTD = amountYTD;
        self.kwhYTD = kwhYTD;
        self.amountDTD = amountDTD;
        self.kwhDTD = kwhDTD;
    }
    return self;
}

+ (PPEnergyManagementDeviceUsageEnergy *)initWithDictionary:(NSDictionary *)energyDict {
    NSString *amount = [energyDict objectForKey:@"amount"];
    NSString *kwh = [energyDict objectForKey:@"kwh"];
    NSString *amountYTD = [energyDict objectForKey:@"amountYTD"];
    NSString *kwhYTD = [energyDict objectForKey:@"kwhYTD"];
    NSString *amountDTD = [energyDict objectForKey:@"amountDTD"];
    NSString *kwhDTD = [energyDict objectForKey:@"kwhDTD"];
    
    PPEnergyManagementDeviceUsageEnergy *energyUsage = [[PPEnergyManagementDeviceUsageEnergy alloc] initWithAmount:amount kwh:kwh amountYTD:amountYTD kwhYTD:kwhYTD amountDTD:amountDTD kwhDTD:kwhDTD];
    return energyUsage;
}

@end
