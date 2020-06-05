//
//  PPEnergyManagementDeviceUsageAggregatedEnergy.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementDeviceUsageAggregatedEnergy : NSObject

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *value;

- (id)initWithIndex:(NSString *)index value:(NSString *)value;

+ (PPEnergyManagementDeviceUsageAggregatedEnergy *)initWithDictionary:(NSDictionary *)aggregatedEnergyDict;

@end
