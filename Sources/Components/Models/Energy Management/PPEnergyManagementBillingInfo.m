//
//  PPEnergyManagementBillingInfo.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPEnergyManagementBillingInfo.h"

@implementation PPEnergyManagementBillingInfo

- (id)initWithBillingDay:(PPEnergyManagementBillingInfoBillingDay)billingDay budgets:(NSArray *)budgets utility:(PPEnergyManagementBillingInfoUtility *)utility billingRate:(PPEnergyManagementBillingInfoBillingRate *)billingRate {
    self = [super init];
    if(self) {
        self.billingDay = billingDay;
        self.budgets = budgets;
        self.utility = utility;
        self.billingRate = billingRate;
    }
    return self;
}

+ (PPEnergyManagementBillingInfo *)initWithDictionary:(NSDictionary *)infoDict {
    
    PPEnergyManagementBillingInfoBillingDay billingDay = PPEnergyManagementBillingInfoBillingDayNone;
    if([infoDict objectForKey:@"billingDay"]) {
        billingDay = (PPEnergyManagementBillingInfoBillingDay)((NSString *)[infoDict objectForKey:@"billingDay"]).integerValue;
    }
    
    NSArray *budgetsArray;
    if([[infoDict objectForKey:@"budgets"] isKindOfClass:[NSDictionary class]]) {
        budgetsArray = [[infoDict objectForKey:@"budgets"] objectForKey:@"budget"];
    }
    else {
        budgetsArray = [infoDict objectForKey:@"budgets"];
    }
    
    NSMutableArray *budgets;
    if(budgetsArray) {
        budgets = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *budgetDict in budgetsArray) {
            PPEnergyManagementBillingInfoBudget *budget = [PPEnergyManagementBillingInfoBudget initWithDictionary:budgetDict];
            [budgets addObject:budget];
        }
    }
    
    PPEnergyManagementBillingInfoUtility *utility;
    if([[infoDict objectForKey:@"utility"] isKindOfClass:[NSString class]]) {
        utility = [PPEnergyManagementBillingInfoUtility initWithDictionary:@{@"name": [infoDict objectForKey:@"utility"]}];
    }
    else {
        utility = [PPEnergyManagementBillingInfoUtility initWithDictionary:[infoDict objectForKey:@"utility"]];
    }
    PPEnergyManagementBillingInfoBillingRate *billingRate = [PPEnergyManagementBillingInfoBillingRate initWithDictionary:[infoDict objectForKey:@"billingRate"]];
    
    PPEnergyManagementBillingInfo *info = [[PPEnergyManagementBillingInfo alloc] initWithBillingDay:billingDay budgets:budgets utility:utility billingRate:billingRate];
    return info;
}

+ (NSString *)stringify:(PPEnergyManagementBillingInfo *)bill {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(bill.billingDay != PPEnergyManagementBillingInfoBillingDayNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"billingDay\":\"%li\"", (long)bill.billingDay];
        appendComma = YES;
    }
    
    if(bill.billingRate) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"billingRate\": %@", [PPEnergyManagementBillingInfoBillingRate stringify:bill.billingRate]];
        appendComma = YES;
    }
    
    if(bill.budgets) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"budgets\": {\"budget\":["];
        
        BOOL appendBudgetComma = NO;
        for(PPEnergyManagementBillingInfoBudget *budget in bill.budgets) {
            if(appendBudgetComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPEnergyManagementBillingInfoBudget stringify:budget]];
            appendBudgetComma = YES;
        }
        
        [JSONString appendString:@"]}"];
        appendComma = YES;
    }
    
    if(bill.utility.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"utility\":\"%@\"", bill.utility.name];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}
@end
