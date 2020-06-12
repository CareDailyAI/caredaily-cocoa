//
//  PPEnergyManagementDeviceUsageEnergy.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementDeviceUsageEnergy : NSObject

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *kwh;
@property (nonatomic, strong) NSString *amountYTD;
@property (nonatomic, strong) NSString *kwhYTD;
@property (nonatomic, strong) NSString *amountDTD;
@property (nonatomic, strong) NSString *kwhDTD;

- (id)initWithAmount:(NSString *)amount kwh:(NSString *)kwh amountYTD:(NSString *)amountYTD kwhYTD:(NSString *)kwhYTD amountDTD:(NSString *)amountDTD kwhDTD:(NSString *)kwhDTD;

+ (PPEnergyManagementDeviceUsageEnergy *)initWithDictionary:(NSDictionary *)energyDict;

@end
