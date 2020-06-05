//
//  PPEnergyManagementBillingInfoBudget.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBudgetMonth) {
    PPEnergyManagementBillingInfoBudgetMonthNone = -1,
    PPEnergyManagementBillingInfoBudgetMonthJanuary = 1,
    PPEnergyManagementBillingInfoBudgetMonthFebruary = 2,
    PPEnergyManagementBillingInfoBudgetMonthMarch = 3,
    PPEnergyManagementBillingInfoBudgetMonthApril = 4,
    PPEnergyManagementBillingInfoBudgetMonthMay = 5,
    PPEnergyManagementBillingInfoBudgetMonthJune = 6,
    PPEnergyManagementBillingInfoBudgetMonthJuly = 7,
    PPEnergyManagementBillingInfoBudgetMonthAugust = 8,
    PPEnergyManagementBillingInfoBudgetMonthSeptember = 9,
    PPEnergyManagementBillingInfoBudgetMonthOctober = 10,
    PPEnergyManagementBillingInfoBudgetMonthNovember = 11,
    PPEnergyManagementBillingInfoBudgetMonthDecember = 12
};

@interface PPEnergyManagementBillingInfoBudget : NSObject

@property (nonatomic) PPEnergyManagementBillingInfoBudgetMonth month;
@property (nonatomic, strong) NSString *budget;

- (id)initWithMonth:(PPEnergyManagementBillingInfoBudgetMonth)month budget:(NSString *)budget;

+ (PPEnergyManagementBillingInfoBudget *)initWithDictionary:(NSDictionary *)budgetDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBudget *)budget;

@end
