//
//  PPEnergyManagementBillingInfoBudget.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPEnergyManagementBillingInfoBudget : PPBaseModel

@property (nonatomic) PPEnergyManagementBillingInfoBudgetMonth month;
@property (nonatomic, strong) NSString *budget;

- (id)initWithMonth:(PPEnergyManagementBillingInfoBudgetMonth)month budget:(NSString *)budget;

+ (PPEnergyManagementBillingInfoBudget *)initWithDictionary:(NSDictionary *)budgetDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBudget *)budget;

@end
