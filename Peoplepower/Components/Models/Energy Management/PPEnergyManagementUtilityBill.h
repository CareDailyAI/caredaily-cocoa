//
//  PPEnergyManagementUtilityBill.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPLocation.h"

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUtilityBillId) {
    PPEnergyManagementUtilityBillIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUtilityBillDaysNumber) {
    PPEnergyManagementUtilityBillDaysNumberNone = -1,
};

@interface PPEnergyManagementUtilityBill : NSObject

/* Location ID */
@property (nonatomic) PPLocationId locationId;

/* Specifies / updates a specific bill */
@property (nonatomic) PPEnergyManagementUtilityBillId billId;

/* The date of the bill */
@property (nonatomic, strong) NSDate *billingDate;

/* Number of days in the billing period */
@property (nonatomic) PPEnergyManagementUtilityBillDaysNumber daysNumber;

/* Energy consumed in kWh */
@property (nonatomic) float energy;

/* Monetary cost of the bill, in the local units of currency */
@property (nonatomic) float amount;

- (id)initWithLocationId:(PPLocationId)locationId billId:(PPEnergyManagementUtilityBillId)billId billingDate:(NSDate *)billingDate daysNumber:(PPEnergyManagementUtilityBillDaysNumber )daysNumber energy:(float )energy amount:(float )amount;

+ (PPEnergyManagementUtilityBill *)initWithDictionary:(NSDictionary *)billDict;

+ (NSString *)stringify:(PPEnergyManagementUtilityBill *)bill;

@end
