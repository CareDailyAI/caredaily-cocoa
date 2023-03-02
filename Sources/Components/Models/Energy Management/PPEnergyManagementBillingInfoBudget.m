//
//  PPEnergyManagementBillingInfoBudget.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementBillingInfoBudget.h"

@implementation PPEnergyManagementBillingInfoBudget

- (id)initWithMonth:(PPEnergyManagementBillingInfoBudgetMonth)month budget:(NSString *)budget {
    self = [super init];
    if(self) {
        self.month = month;
        self.budget = budget;
    }
    return self;
}

+ (PPEnergyManagementBillingInfoBudget *)initWithDictionary:(NSDictionary *)budgetDict {
    PPEnergyManagementBillingInfoBudgetMonth month = PPEnergyManagementBillingInfoBudgetMonthNone;
    if([budgetDict objectForKey:@"month"]) {
        month = (PPEnergyManagementBillingInfoBudgetMonth)((NSString *)[budgetDict objectForKey:@"month"]).integerValue;
    }
    NSString *budget = [budgetDict objectForKey:@"budget"];
    
    PPEnergyManagementBillingInfoBudget *infoBudget = [[PPEnergyManagementBillingInfoBudget alloc] initWithMonth:month budget:budget];
    return infoBudget;
}

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBudget *)budget {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(budget.month != PPEnergyManagementBillingInfoBudgetMonthNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"month\":\"%li\"", (long)budget.month];
        appendComma = YES;
    }
    
    if(budget.budget) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"content\": %@", budget.budget];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}
@end
