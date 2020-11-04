//
//  PPEnergyManagementBillingInfoUtility.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementBillingInfoUtility : PPBaseModel

@property (nonatomic) PPEnergyManagementBillingInfoUtilityId utilityId;
@property (nonatomic, strong) NSString *name;

- (id)initWithId:(PPEnergyManagementBillingInfoUtilityId)utilityId name:(NSString *)name;

+ (PPEnergyManagementBillingInfoUtility *)initWithDictionary:(NSDictionary *)utilityDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoUtility *)utility;

@end
