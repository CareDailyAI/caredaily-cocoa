//
//  PPServicePlanPriceAmount.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPServicePlanPriceAmount : PPBaseModel

@property (nonatomic, strong) NSString *currencySymbol;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *value;

- (id)initWithCurrencySymbol:(NSString *)currencySymbol currencyCode:(NSString *)currencyCode value:(NSString *)value;

+ (PPServicePlanPriceAmount *)initWithDictionary:(NSDictionary *)amountDict;

@end
