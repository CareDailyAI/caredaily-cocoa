//
//  PPDeviceTypeDeviceModelBrand.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeDeviceModelBrand.h"

@implementation PPDeviceTypeDeviceModelBrand
- (id)initWithBrand:(NSString *)brand hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden parentId:(NSString *)parentId sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId name:(PPDeviceTypeDeviceModelBrandName *)name desc:(PPDeviceTypeDeviceModelBrandDesc *)desc {
    self = [super init];
    if(self) {
        self.brand = brand;
        self.hidden = hidden;
        self.parentId = parentId;
        self.sortId = sortId;
        self.name = name;
        self.desc = desc;
    }
    return self;
}

+ (PPDeviceTypeDeviceModelBrand *)initWithDictionary:(NSDictionary *)brandDict {
    
    NSString *brandName = [brandDict objectForKey:@"brand"];
    
    PPDeviceTypeDeviceModelBrandHidden hidden = PPDeviceTypeDeviceModelBrandHiddenNone;
    if([brandDict objectForKey:@"hidden"]) {
        hidden = (PPDeviceTypeDeviceModelBrandHidden)((NSString *)[brandDict objectForKey:@"hidden"]).integerValue;
    }
    NSString *parentId = [brandDict objectForKey:@"parentId"];
    
    PPDeviceTypeDeviceModelBrandSortId sortId = PPDeviceTypeDeviceModelBrandSortIdNone;
    if([brandDict objectForKey:@"sortId"]) {
        sortId = (PPDeviceTypeDeviceModelBrandSortId)((NSString *)[brandDict objectForKey:@"sortId"]).integerValue;
    }
    
    PPDeviceTypeDeviceModelBrandName *name = [PPDeviceTypeDeviceModelBrandName initWithDictionary:[brandDict objectForKey:@"name"]];
    PPDeviceTypeDeviceModelBrandDesc *desc = [PPDeviceTypeDeviceModelBrandDesc initWithDictionary:[brandDict objectForKey:@"desc"]];
    
    PPDeviceTypeDeviceModelBrand *brand = [[PPDeviceTypeDeviceModelBrand alloc] initWithBrand:brandName hidden:hidden parentId:parentId sortId:sortId name:name desc:desc];
    return brand;
}

// TODO: Enable stringify for device models so we can create them
+ (NSString *)stringify:(PPDeviceTypeDeviceModelBrand *)brand {
    
    
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(brand.brand) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"brand\":\"%@\"", brand.brand];
        appendComma = YES;
    }
    
    if(brand.hidden != PPDeviceTypeDeviceModelBrandHiddenNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"hidden\":%li", (long)brand.hidden];
        appendComma = YES;
    }
    
    if(brand.parentId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"parentId\":\"%@\"", brand.parentId];
        appendComma = YES;
    }
    
    if(brand.sortId != PPDeviceTypeDeviceModelBrandSortIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sortId\":%li", (long)brand.sortId];
        appendComma = YES;
    }
    
    if(brand.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\": {%@}", [PPDeviceTypeDeviceModelBrandName stringify:brand.name]];
        appendComma = YES;
    }
    
    if(brand.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"desc\": {%@}", [PPDeviceTypeDeviceModelBrandDesc stringify:brand.desc]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end

@implementation PPDeviceTypeDeviceModelBrandName

+ (PPDeviceTypeDeviceModelBrandName *)initWithDictionary:(NSDictionary *)dict {
    PPRLMDictionary *RLMDictionary = [super initWithDictionary:dict];
    return [[PPDeviceTypeDeviceModelBrandName alloc] initWithKeys:RLMDictionary.keys value:RLMDictionary.values];
}

@end

@implementation PPDeviceTypeDeviceModelBrandDesc

+ (PPDeviceTypeDeviceModelBrandDesc *)initWithDictionary:(NSDictionary *)dict {
    PPRLMDictionary *RLMDictionary = [super initWithDictionary:dict];
    return [[PPDeviceTypeDeviceModelBrandDesc alloc] initWithKeys:RLMDictionary.keys value:RLMDictionary.values];
}

@end
