//
//  PPDeviceTypeDeviceModelBrand.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeDeviceModelBrand.h"

@implementation PPDeviceTypeDeviceModelBrand
- (id)initWithBrand:(NSString *)brand hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden parentId:(NSString *)parentId sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId name:(NSDictionary *)name desc:(NSDictionary *)desc {
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
    
    NSDictionary *name = [brandDict objectForKey:@"name"];
    NSDictionary *desc = [brandDict objectForKey:@"desc"];
    
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
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:brand.name options:0 error:&err];
        [JSONString appendFormat:@"\"name\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    if(brand.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:brand.desc options:0 error:&err];
        [JSONString appendFormat:@"\"desc\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
