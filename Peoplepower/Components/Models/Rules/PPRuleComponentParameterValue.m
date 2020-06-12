//
//  PPRuleComponentParameterValue.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponentParameterValue.h"

@implementation PPRuleComponentParameterValue

- (id)initWithValueId:(NSString *)valueId name:(NSString *)name value:(NSString *)value selectorValue:(NSString *)selectorValue {
    self = [super init];
    if(self) {
        self.valueId = valueId;
        self.name = name;
        self.value = value;
        self.selectorValue = selectorValue;
    }
    return self;
}

+ (PPRuleComponentParameterValue *)initWithDictionary:(NSDictionary *)valueDict {
    NSString *valueId = [valueDict objectForKey:@"id"];
    NSString *name = [valueDict objectForKey:@"name"];
    NSString *value = [valueDict objectForKey:@"value"];
    NSString *selectorValue = [valueDict objectForKey:@"selectorValue"];
    
    PPRuleComponentParameterValue *parameterValue = [[PPRuleComponentParameterValue alloc] initWithValueId:valueId name:name value:value selectorValue:selectorValue];
    return parameterValue;
}

#pragma marker - Helper Methods

- (BOOL)isEqualToParameterValue:(PPRuleComponentParameterValue *)parameterValue {
    BOOL equal = NO;
    if(parameterValue.valueId && _valueId) {
        if([parameterValue.valueId isEqualToString:_valueId]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPRuleComponentParameterValue *)parameterValue {
    if(parameterValue.valueId) {
        _valueId = parameterValue.valueId;
    }
    if(parameterValue.name) {
        _name = parameterValue.name;
    }
    if(parameterValue.value) {
        _value = parameterValue.value;
    }
    if(parameterValue.selectorValue) {
        _selectorValue = parameterValue.selectorValue;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleComponentParameterValue *value = [[[self class] allocWithZone:zone] init];
    value.valueId = [self.valueId copyWithZone:zone];
    value.name = [self.name copyWithZone:zone];
    value.value = [self.value copyWithZone:zone];
    value.selectorValue = [self.selectorValue copyWithZone:zone];
    return value;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.valueId = [decoder decodeObjectForKey:@"valueId"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.selectorValue = [decoder decodeObjectForKey:@"selectorValue"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_valueId forKey:@"valueId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_value forKey:@"value"];
    [encoder encodeObject:_selectorValue forKey:@"selectorValue"];
}

@end
