//
//  PPDeviceTypeRuleComponentTemplateProduct.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeRuleComponentTemplateProduct.h"

@implementation PPDeviceTypeRuleComponentTemplateProduct

- (id)initWithTypeId:(PPDeviceTypeId)typeId paramName:(NSString *)paramName paramValue:(NSString *)paramValue {
    self = [super init];
    if(self) {
        self.typeId = typeId;
        self.paramName = paramName;
        self.paramValue = paramValue;
    }
    return self;
}

+ (PPDeviceTypeRuleComponentTemplateProduct *)initWithDictionary:(NSDictionary *)productDict {
    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
    if([productDict objectForKey:@"id"]) {
        typeId = (PPDeviceTypeId)((NSString *)[productDict objectForKey:@"id"]).integerValue;
    }
    NSString *paramName = [productDict objectForKey:@"paramName"];
    NSString *paramValue = [productDict objectForKey:@"paramValue"];
    
    PPDeviceTypeRuleComponentTemplateProduct *product = [[PPDeviceTypeRuleComponentTemplateProduct alloc] initWithTypeId:typeId paramName:paramName paramValue:paramValue];
    return product;
}

+ (NSString *)stringify:(PPDeviceTypeRuleComponentTemplateProduct *)product {
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(product.typeId != PPDeviceTypeIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":%li", (long)product.typeId];
        appendComma = YES;
    }
    if(product.paramName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"paramName\":\"%@\"", product.paramName];
        appendComma = YES;
    }
    if(product.paramValue) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"paramValue\":\"%@\"", product.paramValue];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
