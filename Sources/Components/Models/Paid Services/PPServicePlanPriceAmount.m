//
//  PPServicePlanPriceAmount.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPServicePlanPriceAmount.h"

@implementation PPServicePlanPriceAmount

- (id)initWithCurrencySymbol:(NSString *)currencySymbol currencyCode:(NSString *)currencyCode value:(NSString *)value {
    self = [super init];
    if(self) {
        self.currencySymbol = currencySymbol;
        self.currencyCode = currencyCode;
        self.value = value;
    }
    return self;
}

+ (PPServicePlanPriceAmount *)initWithDictionary:(NSDictionary *)amountDict {
    NSString *currencySymbol = [amountDict objectForKey:@"currencySymbol"];
    NSString *currencyCode = [amountDict objectForKey:@"currencyCode"];
    NSString *value = [amountDict objectForKey:@"value"];
    
    PPServicePlanPriceAmount *priceAmount = [[PPServicePlanPriceAmount alloc] initWithCurrencySymbol:currencySymbol currencyCode:currencyCode value:value];
    return priceAmount;
}

@end
