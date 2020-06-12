//
//  PPEnergyManagementUsage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUsageExternal) {
    PPEnergyManagementUsageExternalNone = -1,
    PPEnergyManagementUsageExternalPreferExternallyUploadedData = 0, // Default
    PPEnergyManagementUsageExternalPreferInternallyGeneratedData = 1,
    PPEnergyManagementUsageExternalReturnOnlyExternallyUploadedData = 2,
    PPEnergyManagementUsageExternalReturnOnlyInternallyGeneratedData = 3,
    PPEnergyManagementUsageExternalReturnBothInternallyAndExternallyGeneratedData = 4
};

@interface PPEnergyManagementUsage : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *energy;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic) PPEnergyManagementUsageExternal external;

- (id)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate energy:(NSString *)energy cost:(NSString *)cost external:(PPEnergyManagementUsageExternal)external;

+ (PPEnergyManagementUsage *)initWithDictionary:(NSDictionary *)usageDict;

@end
