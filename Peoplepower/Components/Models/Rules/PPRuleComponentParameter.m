//
//  PPRuleComponentParameter.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponentParameter.h"

@implementation PPRuleComponentParameter

- (id)initWithName:(NSString *)name category:(PPRuleComponentParameterCategory)category optional:(PPRuleComponentParameterOptional)optional desc:(NSString *)desc values:(NSArray *)values selectorName:(NSString *)selectorName value:(PPRuleComponentParameterValue *)value minValue:(PPRuleComponentParameterMinValue)minValue maxValue:(PPRuleComponentParameterMaxValue)maxValue valueType:(PPRuleComponentParameterInputType)valueType unit:(NSString *)unit {
    self = [super init];
    if(self) {
        self.name = name;
        self.category = category;
        self.optional = optional;
        self.desc = desc;
        self.values = values;
        self.selectorName = selectorName;
        self.value = value;
        self.minValue = minValue;
        self.maxValue = maxValue;
        self.valueType = valueType;
        self.unit = unit;
    }
    return self;
}

+ (PPRuleComponentParameter *)initWithDictionary:(NSDictionary *)parameterDict {
    NSString *name = [parameterDict objectForKey:@"name"];
    PPRuleComponentParameterCategory category = PPRuleComponentParameterCategoryNone;
    if([parameterDict objectForKey:@"category"]) {
        category = (PPRuleComponentParameterCategory)((NSString *)[parameterDict objectForKey:@"category"]).integerValue;
    }
    PPRuleComponentParameterOptional optional = PPRuleComponentParameterOptionalNone;
    if([parameterDict objectForKey:@"optional"]) {
        optional = (PPRuleComponentParameterOptional)((NSString *)[parameterDict objectForKey:@"optional"]).integerValue;
    }
    NSString *desc = [parameterDict objectForKey:@"desc"];
    
    NSMutableArray *values;
    if([parameterDict objectForKey:@"values"]) {
        values = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *valueDict in [parameterDict objectForKey:@"values"]) {
            PPRuleComponentParameterValue *value = [PPRuleComponentParameterValue initWithDictionary:valueDict];
            [values addObject:value];
        }
    }
    
    NSString *selectorName = [parameterDict objectForKey:@"selectorName"];
    
    PPRuleComponentParameterValue *value = [[PPRuleComponentParameterValue alloc] initWithValueId:nil name:nil value:[parameterDict objectForKey:@"value"] selectorValue:nil];
    
    PPRuleComponentParameterMinValue minValue = PPRuleComponentParameterMinValueNone;
    if([parameterDict objectForKey:@"minValue"]) {
        minValue = (PPRuleComponentParameterMinValue)((NSString *)[parameterDict objectForKey:@"minValue"]).integerValue;
    }
    PPRuleComponentParameterMaxValue maxValue = PPRuleComponentParameterMaxValueNone;
    if([parameterDict objectForKey:@"maxValue"]) {
        maxValue = (PPRuleComponentParameterMaxValue)((NSString *)[parameterDict objectForKey:@"maxValue"]).integerValue;
    }
    PPRuleComponentParameterInputType valueType = PPRuleComponentParameterInputTypeNone;
    if([parameterDict objectForKey:@"valueType"]) {
        valueType = (PPRuleComponentParameterInputType)((NSString *)[parameterDict objectForKey:@"valueType"]).integerValue;
    }
    NSString *unit = [parameterDict objectForKey:@"unit"];
    
    PPRuleComponentParameter *parameter = [[PPRuleComponentParameter alloc] initWithName:name category:category optional:optional desc:desc values:values selectorName:selectorName value:value minValue:minValue maxValue:maxValue valueType:valueType unit:unit];
    return parameter;
}

+ (NSString *)stringify:(PPRuleComponentParameter *)parameter {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    if (parameter.name) {
        [JSONString appendFormat:@"\"name\":\"%@\"", [PPNetworkUtilities makeAPIFriendly:parameter.name]];
        appendComma = YES;
    }
    
    if (parameter.value.value) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"value\":\"%@\"", [PPNetworkUtilities makeAPIFriendly:parameter.value.value]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPRuleComponentParameter *)parameter {
    NSMutableDictionary *data = @{}.mutableCopy;
    if (parameter.name) {
        data[@"name"] = [PPNetworkUtilities makeAPIFriendly:parameter.name];
    }
    
    if (parameter.value.value) {
        data[@"value"] = [PPNetworkUtilities makeAPIFriendly:parameter.value.value];
    }
    
    return data;
}

#pragma marker - Helper Methods

- (BOOL)isEqualToParameter:(PPRuleComponentParameter *)parameter {
    BOOL equal = NO;
    
    if(parameter.name) {
        if([parameter.name isEqualToString:_name]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPRuleComponentParameter *)parameter {
    if(parameter.name) {
        _name = parameter.name;
    }
    if(parameter.category != PPRuleComponentParameterCategoryNone) {
        _category = parameter.category;
    }
    if(parameter.optional != PPRuleComponentParameterOptionalNone) {
        _optional = parameter.optional;
    }
    if(parameter.desc) {
        _desc = parameter.desc;
    }
    if(parameter.values) {
        for(PPRuleComponentParameterValue *newValue in parameter.values) {
            for(PPRuleComponentParameterValue *value in _values) {
                [value sync:newValue];
            }
        }
    }
    if(parameter.selectorName) {
        _selectorName = parameter.selectorName;
    }
    if(parameter.value) {
        [_value sync:parameter.value];
    }
    if(parameter.minValue != PPRuleComponentParameterMinValueNone) {
        _minValue = parameter.minValue;
    }
    if(parameter.maxValue != PPRuleComponentParameterMaxValueNone) {
        _maxValue = parameter.maxValue;
    }
    if(parameter.valueType != PPRuleComponentParameterInputTypeNone) {
        _valueType = parameter.valueType;
    }
    if(parameter.unit) {
        _unit = parameter.unit;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleComponentParameter *parameter = [[[self class] allocWithZone:zone] init];
    parameter.name = [self.name copyWithZone:zone];
    parameter.category = self.category;
    parameter.optional = self.optional;
    parameter.desc = [self.desc copyWithZone:zone];
    parameter.values = [self.values copyWithZone:zone];
    parameter.selectorName = [self.selectorName copyWithZone:zone];
    parameter.value = [self.value copyWithZone:zone];
    parameter.minValue = self.minValue;
    parameter.maxValue = self.maxValue;
    parameter.valueType = self.valueType;
    parameter.unit = [self.unit copyWithZone:zone];
    
    return parameter;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.category = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"category"]).integerValue;
        self.optional = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"optional"]).integerValue;
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.values = [decoder decodeObjectForKey:@"values"];
        self.selectorName = [decoder decodeObjectForKey:@"selectorName"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.minValue = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"minValue"]).integerValue;
        self.maxValue = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"maxValue"]).integerValue;
        self.valueType = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"valueType"]).integerValue;
        self.unit = [decoder decodeObjectForKey:@"unit"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_category) forKey:@"category"];
    [encoder encodeObject:@(_optional) forKey:@"optional"];
    [encoder encodeObject:_desc forKey:@"desc"];
    [encoder encodeObject:_values forKey:@"values"];
    [encoder encodeObject:_selectorName forKey:@"selectorName"];
    [encoder encodeObject:_value forKey:@"value"];
    [encoder encodeObject:@(_minValue) forKey:@"minValue"];
    [encoder encodeObject:@(_maxValue) forKey:@"maxValue"];
    [encoder encodeObject:@(_valueType) forKey:@"valueType"];
    [encoder encodeObject:_unit forKey:@"unit"];
}

@end
