//
//  PPEnergyManagementBillingInfoBillingRate.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementBillingInfoBillingRate : PPBaseModel

@property (nonatomic) PPEnergyManagementBillingInfoBillingRateId billingRateId;
@property (nonatomic) PPEnergyManagementBillingInfoBillingRateType type;
@property (nonatomic) PPEnergyManagementBillingInfoBillingRateTypical typical;
@property (nonatomic, strong) NSString *value;

- (id)initWithId:(PPEnergyManagementBillingInfoBillingRateId)billingRateId type:(PPEnergyManagementBillingInfoBillingRateType)type typical:(PPEnergyManagementBillingInfoBillingRateTypical)typical value:(NSString *)value;

+ (PPEnergyManagementBillingInfoBillingRate *)initWithDictionary:(NSDictionary *)rateDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBillingRate *)billingRate;

@end
