//
//  PPDeviceTypeRuleComponentTemplate.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeRuleComponentTemplate.h"

@implementation PPDeviceTypeRuleComponentTemplate

+(NSString *)primaryKey {
    return @"templateId";
}

- (id)initWithTemplateId:(PPDeviceTypeRuleComponentTemplateId)templateId name:(NSString *)name type:(PPRuleComponentType)type display:(PPRuleComponentDisplayType)display timezone:(PPRuleComponentTimezone)timezone desc:(NSString *)desc past:(NSString *)past source:(NSString *)source sourceType:(PPDeviceTypeRuleComponentTemplateSourceType)sourceType conditionData:(PPDeviceTypeRuleComponentTemplateConditionData)conditionData updateDate:(NSDate *)updateDate products:(NSArray *)products parameters:(NSArray *)parameters {
    self = [super init];
    if(self) {
        self.templateId = templateId;
        self.name = name;
        self.type = type;
        self.display = display;
        self.timezone = timezone;
        self.desc = desc;
        self.past = past;
        self.source = source;
        self.sourceType = sourceType;
        self.conditionData = conditionData;
        self.updateDate = updateDate;
        self.products = (RLMArray<PPDeviceTypeRuleComponentTemplateProduct *><PPDeviceTypeRuleComponentTemplateProduct> *)products;
        self.parameters = (RLMArray<PPRuleComponentParameter *><PPRuleComponentParameter> *)parameters;
    }
    return self;
}

+ (PPDeviceTypeRuleComponentTemplate *)initWithDictionary:(NSDictionary *)componentDict {
    
    PPDeviceTypeRuleComponentTemplateId templateId = PPDeviceTypeRuleComponentTemplateIdNone;
    if([componentDict objectForKey:@"templateId"]) {
        templateId = (PPDeviceTypeRuleComponentTemplateId)((NSString *)[componentDict objectForKey:@"templateId"]).integerValue;
    }
    NSString *name = [componentDict objectForKey:@"name"];
    PPRuleComponentType type = PPRuleComponentTypeNone;
    if([componentDict objectForKey:@"type"]) {
        type = (PPRuleComponentType)((NSString *)[componentDict objectForKey:@"type"]).integerValue;
    }
    PPRuleComponentDisplayType display = PPRuleComponentDisplayTypeNone;
    if([componentDict objectForKey:@"display"]) {
        display = (PPRuleComponentDisplayType)((NSString *)[componentDict objectForKey:@"display"]).integerValue;
    }
    PPRuleComponentTimezone timezone = PPRuleComponentTimezoneNone;
    if([componentDict objectForKey:@"timezone"]) {
        timezone = (PPRuleComponentTimezone)((NSString *)[componentDict objectForKey:@"timezone"]).integerValue;
    }
    NSString *desc = [componentDict objectForKey:@"desc"];
    NSString *past = [componentDict objectForKey:@"past"];
    NSString *source = [componentDict objectForKey:@"source"];
    PPDeviceTypeRuleComponentTemplateSourceType sourceType = PPDeviceTypeRuleComponentTemplateSourceTypeNone;
    if([componentDict objectForKey:@"sourceType"]) {
        sourceType = (PPDeviceTypeRuleComponentTemplateSourceType)((NSString *)[componentDict objectForKey:@"sourceType"]).integerValue;
    }
    PPDeviceTypeRuleComponentTemplateConditionData conditionData = PPDeviceTypeRuleComponentTemplateConditionDataNone;
    if([componentDict objectForKey:@"conditionData"]) {
        conditionData = (PPDeviceTypeRuleComponentTemplateConditionData)((NSString *)[componentDict objectForKey:@"conditionData"]).integerValue;
    }
    NSDate *updateDate = [componentDict objectForKey:@"updateDate"];
    
    NSMutableArray *products;
    if([componentDict objectForKey:@"products"]) {
        products = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *productDict in [componentDict objectForKey:@"products"]) {
            PPDeviceTypeRuleComponentTemplateProduct *product = [PPDeviceTypeRuleComponentTemplateProduct initWithDictionary:productDict];
            [products addObject:product];
        }
    }
    
    NSMutableArray *parameters;
    if([componentDict objectForKey:@"parameters"]) {
        parameters = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *parameterDict in [componentDict objectForKey:@"parameters"]) {
            PPRuleComponentParameter *parameter = [PPRuleComponentParameter initWithDictionary:parameterDict];
            [parameters addObject:parameter];
        }
    }
    
    PPDeviceTypeRuleComponentTemplate *component = [[PPDeviceTypeRuleComponentTemplate alloc] initWithTemplateId:templateId name:name type:type display:display timezone:timezone desc:desc past:past source:source sourceType:sourceType conditionData:conditionData updateDate:updateDate products:(RLMArray *)products parameters:(RLMArray *)parameters];
    return component;
}

+ (NSString *)stringify:(PPDeviceTypeRuleComponentTemplate *)component {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(component.templateId != PPDeviceTypeRuleComponentTemplateIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"templateId\":%li", (long)component.templateId];
        appendComma = YES;
    }
    if(component.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", component.name];
        appendComma = YES;
    }
    if(component.type != PPRuleComponentTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":%li", (long)component.type];
        appendComma = YES;
    }
    if(component.display != PPRuleComponentDisplayTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"display\":%li", (long)component.display];
        appendComma = YES;
    }
    if(component.timezone != PPRuleComponentTimezoneNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"timezone\":%li", (long)component.timezone];
        appendComma = YES;
    }
    if(component.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"desc\":\"%@\"", component.desc];
        appendComma = YES;
    }
    if(component.past) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"past\":\"%@\"", component.past];
        appendComma = YES;
    }
    if(component.source) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"source\":\"%@\"", component.source];
        appendComma = YES;
    }
    if(component.sourceType != PPDeviceTypeRuleComponentTemplateSourceTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sourceType\":%li", (long)component.sourceType];
        appendComma = YES;
    }
    if(component.conditionData != PPDeviceTypeRuleComponentTemplateConditionDataNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"conditionData\":%li", (long)component.conditionData];
        appendComma = YES;
    }
    if(component.updateDate) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendFormat:@"\"updateDate\":\"%@\"", [PPNSDate apiFriendStringFromDate:component.updateDate]];
        appendComma = YES;
    }
    if(component.products) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"products\": ["];
        
        BOOL appendBudgetComma = NO;
        for(PPDeviceTypeRuleComponentTemplateProduct *product in component.products) {
            if(appendBudgetComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeRuleComponentTemplateProduct stringify:product]];
            appendBudgetComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    if(component.parameters) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"parameters\": ["];
        
        BOOL appendBudgetComma = NO;
        for(PPRuleComponentParameter *parameter in component.parameters) {
            if(appendBudgetComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPRuleComponentParameter stringify:parameter]];
            appendBudgetComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
