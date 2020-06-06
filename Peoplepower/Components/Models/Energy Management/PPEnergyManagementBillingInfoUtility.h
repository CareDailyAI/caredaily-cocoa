//
//  PPEnergyManagementBillingInfoUtility.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoUtilityId) {
    PPEnergyManagementBillingInfoUtilityIdNone = -1,
};

@interface PPEnergyManagementBillingInfoUtility : RLMObject

@property (nonatomic) PPEnergyManagementBillingInfoUtilityId utilityId;
@property (nonatomic, strong) NSString *name;

- (id)initWithId:(PPEnergyManagementBillingInfoUtilityId)utilityId name:(NSString *)name;

+ (PPEnergyManagementBillingInfoUtility *)initWithDictionary:(NSDictionary *)utilityDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoUtility *)utility;

@end

RLM_ARRAY_TYPE(PPEnergyManagementBillingInfoUtility);
