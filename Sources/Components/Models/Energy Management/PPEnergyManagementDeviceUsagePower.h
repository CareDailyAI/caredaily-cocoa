//
//  PPEnergyManagementDeviceUsagePower.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementDeviceUsagePower : PPBaseModel

@property (nonatomic, strong) NSString *amountPerHour;
@property (nonatomic, strong) NSString *watts;
@property (nonatomic, strong) NSString *currentRate;
@property (nonatomic, strong) NSDate *lastUpdateDate;

- (id)initWithAmountPerHour:(NSString *)amountPerHour watts:(NSString *)watts currentRate:(NSString *)currentRate lastUpdateDate:(NSDate *)lastUpdateDate;

+ (PPEnergyManagementDeviceUsagePower *)initWithDictionary:(NSDictionary *)powerDict;

@end
