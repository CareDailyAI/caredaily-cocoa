//
//  PPEnergyManagementBillingInfoBillingRate.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateId) {
    PPEnergyManagementBillingInfoBillingRateIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateType) {
    PPEnergyManagementBillingInfoBillingRateTypeNone = -3,
    PPEnergyManagementBillingInfoBillingRateTypeManual = -2,
    PPEnergyManagementBillingInfoBillingRateTypeUnknown = -1,
    PPEnergyManagementBillingInfoBillingRateTypeResidentialAndCommercial = 0,
    PPEnergyManagementBillingInfoBillingRateTypeResidential = 1,
    PPEnergyManagementBillingInfoBillingRateTypeCommercial = 2
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateTypical) {
    PPEnergyManagementBillingInfoBillingRateTypicalNone = -1,
    PPEnergyManagementBillingInfoBillingRateTypicalFalse = 0,
    PPEnergyManagementBillingInfoBillingRateTypicalTrue = 1
};

@interface PPEnergyManagementBillingInfoBillingRate : NSObject

@property (nonatomic) PPEnergyManagementBillingInfoBillingRateId billingRateId;
@property (nonatomic) PPEnergyManagementBillingInfoBillingRateType type;
@property (nonatomic) PPEnergyManagementBillingInfoBillingRateTypical typical;
@property (nonatomic, strong) NSString *value;

- (id)initWithId:(PPEnergyManagementBillingInfoBillingRateId)billingRateId type:(PPEnergyManagementBillingInfoBillingRateType)type typical:(PPEnergyManagementBillingInfoBillingRateTypical)typical value:(NSString *)value;

+ (PPEnergyManagementBillingInfoBillingRate *)initWithDictionary:(NSDictionary *)rateDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBillingRate *)billingRate;

@end
