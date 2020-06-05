//
//  PPEnergyManagementBillingInfoBillingRate.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPEnergyManagementBillingInfoBillingRate.h"

@implementation PPEnergyManagementBillingInfoBillingRate

- (id)initWithId:(PPEnergyManagementBillingInfoBillingRateId)billingRateId type:(PPEnergyManagementBillingInfoBillingRateType)type typical:(PPEnergyManagementBillingInfoBillingRateTypical)typical value:(NSString *)value {
    self = [super init];
    if(self) {
        self.billingRateId = billingRateId;
        self.type = type;
        self.typical = typical;
        self.value = value;
    }
    return self;
}

+ (PPEnergyManagementBillingInfoBillingRate *)initWithDictionary:(NSDictionary *)rateDict {
    PPEnergyManagementBillingInfoBillingRateId billingRateId = PPEnergyManagementBillingInfoBillingRateIdNone;
    if([rateDict objectForKey:@"id"]) {
        billingRateId = (PPEnergyManagementBillingInfoBillingRateId)((NSString *)[rateDict objectForKey:@"id"]).integerValue;
    }
    PPEnergyManagementBillingInfoBillingRateType type = PPEnergyManagementBillingInfoBillingRateTypeNone;
    if([rateDict objectForKey:@"type"]) {
        type = (PPEnergyManagementBillingInfoBillingRateType)((NSString *)[rateDict objectForKey:@"type"]).integerValue;
    }
    PPEnergyManagementBillingInfoBillingRateTypical typical = PPEnergyManagementBillingInfoBillingRateTypicalNone;
    if([rateDict objectForKey:@"typical"]) {
        typical = (PPEnergyManagementBillingInfoBillingRateTypical)((NSString *)[rateDict objectForKey:@"typical"]).integerValue;
    }
    NSString *value = [rateDict objectForKey:@"value"];
    
    PPEnergyManagementBillingInfoBillingRate *rate = [[PPEnergyManagementBillingInfoBillingRate alloc] initWithId:billingRateId type:type typical:typical value:value];
    return rate;
}

+ (NSString *)stringify:(PPEnergyManagementBillingInfoBillingRate *)billingRate {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(billingRate.billingRateId != PPEnergyManagementBillingInfoBillingRateIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%li\"", (long)billingRate.billingRateId];
        appendComma = YES;
    }
    
    if(billingRate.type != PPEnergyManagementBillingInfoBillingRateTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":\"%li\"", (long)billingRate.type];
        appendComma = YES;
    }
    
    if(billingRate.typical != PPEnergyManagementBillingInfoBillingRateTypicalNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"typical\":\"%li\"", (long)billingRate.typical];
        appendComma = YES;
    }
    
    if(billingRate.value) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"value\": %@", billingRate.value];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
