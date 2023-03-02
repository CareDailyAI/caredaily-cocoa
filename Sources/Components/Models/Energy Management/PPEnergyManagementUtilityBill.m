//
//  PPEnergyManagementUtilityBill.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementUtilityBill.h"

@implementation PPEnergyManagementUtilityBill

- (id)initWithLocationId:(PPLocationId)locationId billId:(PPEnergyManagementUtilityBillId)billId billingDate:(NSDate *)billingDate daysNumber:(PPEnergyManagementUtilityBillDaysNumber)daysNumber energy:(float)energy amount:(float)amount {
    self = [super init];
    if(self) {
        self.billId = billId;
        self.billingDate = billingDate;
        self.daysNumber = daysNumber;
        self.energy = energy;
        self.amount = amount;
    }
    return self;
}

+ (PPEnergyManagementUtilityBill *)initWithDictionary:(NSDictionary *)billDict {
    
    PPLocationId locationId = PPLocationIdNone;
    if([billDict objectForKey:@"locationId"]) {
        locationId = (PPLocationId)((NSString *)[billDict objectForKey:@"locationId"]).integerValue;
    }
    
    PPEnergyManagementUtilityBillId billId = PPEnergyManagementUtilityBillIdNone;
    if([billDict objectForKey:@"billId"]) {
        billId = (PPEnergyManagementUtilityBillId)((NSString *)[billDict objectForKey:@"billId"]).integerValue;
    }
    
    NSString *billingDateString = [billDict objectForKey:@"billingDate"];
    
    NSDate *billingDate = [NSDate date];
    if(billingDateString != nil) {
        if(![billingDateString isEqualToString:@""]) {
            billingDate = [PPNSDate parseDateTime:billingDateString];
        }
    }
    
    PPEnergyManagementUtilityBillDaysNumber daysNumber = PPEnergyManagementUtilityBillDaysNumberNone;
    if([billDict objectForKey:@"daysNumber"]) {
        daysNumber = (PPEnergyManagementUtilityBillDaysNumber)((NSString *)[billDict objectForKey:@"daysNumber"]).integerValue;
    }
    float energy = ((NSString *)[billDict objectForKey:@"energy"]).floatValue;
    float amount = ((NSString *)[billDict objectForKey:@"amount"]).floatValue;
    
    PPEnergyManagementUtilityBill *bill = [[PPEnergyManagementUtilityBill alloc] initWithLocationId:locationId billId:billId billingDate:billingDate daysNumber:daysNumber energy:energy amount:amount];
    return bill;
}

+ (NSString *)stringify:(PPEnergyManagementUtilityBill *)bill {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(bill.locationId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"locationId\":%li", (long)bill.locationId];
        appendComma = YES;
    }
    
    if(bill.billId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"billId\":\"%li\"", (long)bill.billId];
        appendComma = YES;
    }
    
    if(bill.billingDate) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"billingDate\":\"%@\"", [PPNSDate apiFriendStringFromDate:bill.billingDate]];
        appendComma = YES;
    }
    
    if(bill.daysNumber != PPEnergyManagementUtilityBillDaysNumberNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"daysNumber\":\"%li\"", (long)bill.daysNumber];
        appendComma = YES;
    }
    
    if(appendComma) {
        [JSONString appendString:@","];
    }
    [JSONString appendFormat:@"\"energy\":\"%.3f\"", bill.energy];
    appendComma = YES;
    
    if(appendComma) {
        [JSONString appendString:@","];
    }
    [JSONString appendFormat:@"\"amount\":\"%.3f\"", bill.amount];
    appendComma = YES;
    
    [JSONString appendString:@"}"];
    return JSONString;
}
@end
