//
//  PPDeviceTypeDeviceModel.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeDeviceModel.h"

@implementation PPDeviceTypeDeviceModel

- (id)initWithModelId:(NSString *)modelId brands:(NSArray *)brands manufacturer:(NSDictionary *)manufacturer pairingType:(PPDeviceTypeDeviceModelPairingType)pairingType OAuthAppId:(PPCloudsIntegrationClientApplicationId)OAuthAppId dependencyDeviceTypes:(NSArray *)dependencyDeviceTypes hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(NSDictionary *)name desc:(NSDictionary *)desc lookupParams:(NSArray *)lookupParams modelTemplate:(NSString *)modelTemplate media:(NSArray *)media displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo {
    self = [super init];
    if(self) {
        self.modelId = modelId;
        self.brands = brands;
        self.manufacturer = manufacturer;
        self.pairingType = pairingType;
        self.OAuthAppId = OAuthAppId;
        self.dependencyDeviceTypes = dependencyDeviceTypes;
        self.hidden = hidden;
        self.sortId = sortId;
        self.name = name;
        self.desc = desc;
        self.lookupParams = lookupParams;
        self.modelTemplate = modelTemplate;
        self.media = media;
        self.displayInfo = displayInfo;
    }
    return self;
}

+ (PPDeviceTypeDeviceModel *)initWithDictionary:(NSDictionary *)modelDict {
    
    NSString *modelId = [modelDict objectForKey:@"id"];
    
    NSMutableArray *brands;
    if([modelDict objectForKey:@"brands"]) {
        brands = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *brandDict in [modelDict objectForKey:@"brands"]) {
            PPDeviceTypeDeviceModelBrand *brand = [PPDeviceTypeDeviceModelBrand initWithDictionary:brandDict];
            [brands addObject:brand];
        }
    }
    
    NSDictionary *manufacturer = [modelDict objectForKey:@"manufacturer"];
    PPDeviceTypeDeviceModelPairingType pairingType = PPDeviceTypeDeviceModelPairingTypeNone;
    if([modelDict objectForKey:@"pairingType"]) {
        pairingType = (PPDeviceTypeDeviceModelPairingType)((NSString *)[modelDict objectForKey:@"pairingType"]).integerValue;
    }
    PPCloudsIntegrationClientApplicationId OAuthAppId = PPCloudsIntegrationClientApplicationIdNone;
    if([modelDict objectForKey:@"oauthAppId"]) {
        OAuthAppId = (PPCloudsIntegrationClientApplicationId)((NSString *)[modelDict objectForKey:@"oauthAppId"]).integerValue;
    }

    NSMutableArray *dependencyDeviceTypes;
    if([modelDict objectForKey:@"dependencyDeviceTypes"]) {
        dependencyDeviceTypes = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSNumber *type in [modelDict objectForKey:@"dependencyDeviceTypes"]) {
            [dependencyDeviceTypes addObject:type];
        }
    }
    
    PPDeviceTypeDeviceModelHidden hidden = PPDeviceTypeDeviceModelHiddenNone;
    if([modelDict objectForKey:@"hidden"]) {
        hidden = (PPDeviceTypeDeviceModelHidden)((NSString *)[modelDict objectForKey:@"hidden"]).integerValue;
    }
    PPDeviceTypeDeviceModelSortId sortId = PPDeviceTypeDeviceModelSortIdNone;
    if([modelDict objectForKey:@"sortId"]) {
        sortId = (PPDeviceTypeDeviceModelSortId)((NSString *)[modelDict objectForKey:@"sortId"]).integerValue;
    }
    NSDictionary *name = [modelDict objectForKey:@"name"];
    NSDictionary *desc = [modelDict objectForKey:@"desc"];
    
    NSMutableArray *lookupParams;
    if([modelDict objectForKey:@"lookupParams"]) {
        lookupParams = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *lookupParamDict in [modelDict objectForKey:@"lookupParams"]) {
            PPDeviceTypeDeviceModelLookupParam *lookupParam = [PPDeviceTypeDeviceModelLookupParam initWithDictionary:lookupParamDict];
            [lookupParams addObject:lookupParam];
        }
    }
    
    NSString *modelTemplate = [modelDict objectForKey:@"template"];
    
    NSMutableArray *medias;
    if([modelDict objectForKey:@"media"]) {
        medias = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *mediaDict in [modelDict objectForKey:@"media"]) {
            PPDeviceTypeMedia *media = [PPDeviceTypeMedia initWithDictionary:mediaDict];
            [medias addObject:media];
        }
    }
    
    PPDeviceTypeParameterDisplayInfo *displayInfo;
    if([modelDict objectForKey:@"displayInfo"]) {
        displayInfo = [PPDeviceTypeParameterDisplayInfo initWithDictionary:[modelDict objectForKey:@"displayInfo"]];
    }
    
    PPDeviceTypeDeviceModel *model = [[PPDeviceTypeDeviceModel alloc] initWithModelId:modelId brands:brands manufacturer:manufacturer pairingType:pairingType OAuthAppId:OAuthAppId dependencyDeviceTypes:dependencyDeviceTypes hidden:hidden sortId:sortId name:name desc:desc lookupParams:lookupParams modelTemplate:modelTemplate media:medias displayInfo:displayInfo];
    return model;
}

+ (NSString *)stringify:(PPDeviceTypeDeviceModel *)model {
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(model.modelId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", model.modelId];
        appendComma = YES;
    }
    
    if([model.brands count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"brands\":["];
        
        BOOL appendBrandComma = NO;
        for(PPDeviceTypeDeviceModelBrand *brand in model.brands) {
            if(appendBrandComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeDeviceModelBrand stringify:brand]];
            appendBrandComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(model.manufacturer) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:model.manufacturer options:0 error:&err];
        [JSONString appendFormat:@"\"manufacturer\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    if(model.pairingType != PPDeviceTypeDeviceModelPairingTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"pairingType\":%li", (long)model.pairingType];
        appendComma = YES;
    }
    
    if(model.OAuthAppId != PPCloudsIntegrationClientApplicationIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"OAuthAppId\":%li", (long)model.OAuthAppId];
        appendComma = YES;
    }
    
    if([model.dependencyDeviceTypes count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"dependencyDeviceTypes\":["];
        
        BOOL appendBrandComma = NO;
        for(NSNumber *type in model.dependencyDeviceTypes) {
            if(appendBrandComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:type.stringValue];
            appendBrandComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(model.hidden != PPDeviceTypeDeviceModelHiddenNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"hidden\":%li", (long)model.hidden];
        appendComma = YES;
    }
    
    if(model.sortId != PPDeviceTypeDeviceModelSortIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sortId\":%li", (long)model.sortId];
        appendComma = YES;
    }
    
    if(model.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:model.name options:0 error:&err];
        [JSONString appendFormat:@"\"name\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    if(model.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:model.desc options:0 error:&err];
        [JSONString appendFormat:@"\"desc\": %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        appendComma = YES;
    }
    
    if([model.lookupParams count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"lookupParams\": ["];
        for(PPDeviceTypeDeviceModelLookupParam *lookupParam in model.lookupParams) {
            [JSONString appendString:[PPDeviceTypeDeviceModelLookupParam stringify:lookupParam]];
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(model.modelTemplate) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"template\":%@", model.modelTemplate];
        appendComma = YES;
    }
    
    if(model.displayInfo) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"displayInfo\":%@", [PPDeviceTypeParameterDisplayInfo stringify:model.displayInfo]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
