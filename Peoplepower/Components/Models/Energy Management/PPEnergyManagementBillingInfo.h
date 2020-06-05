//
//  PPEnergyManagementBillingInfo.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPEnergyManagementBillingInfoBudget.h"
#import "PPEnergyManagementBillingInfoUtility.h"
#import "PPEnergyManagementBillingInfoBillingRate.h"


typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingDay) {
    PPEnergyManagementBillingInfoBillingDayNone = -1,
};

@interface PPEnergyManagementBillingInfo : NSObject

@property (nonatomic) PPEnergyManagementBillingInfoBillingDay billingDay;
@property (nonatomic, strong) NSArray *budgets;
@property (nonatomic, strong) PPEnergyManagementBillingInfoUtility *utility;
@property (nonatomic, strong) PPEnergyManagementBillingInfoBillingRate *billingRate;

- (id)initWithBillingDay:(PPEnergyManagementBillingInfoBillingDay)billingDay budgets:(NSArray *)budgets utility:(PPEnergyManagementBillingInfoUtility *)utility billingRate:(PPEnergyManagementBillingInfoBillingRate *)billingRate;

+ (PPEnergyManagementBillingInfo *)initWithDictionary:(NSDictionary *)infoDict;

+ (NSString *)stringify:(PPEnergyManagementBillingInfo *)bill;

@end
