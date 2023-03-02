//
//  PPDeviceTypeAttribute.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeAttribute.h"

@implementation PPDeviceTypeAttribute

- (id)initWithName:(NSString *)name value:(NSString *)value extended:(PPDeviceTypeAttributeExtended)extended defaultValue:(NSString *)defaultValue options:(RLMArray *)options {
    self = [super init];
    if(self) {
        self.name = name;
        self.value = value;
        self.extended = extended;
        self.defaultValue = defaultValue;
        self.options = (RLMArray<PPDeviceTypeAttributeOption *><PPDeviceTypeAttributeOption> *)options;
    }
    return self;
}

+ (PPDeviceTypeAttribute *)initWithDictionary:(NSDictionary *)attributeDict {
    NSString *name = [attributeDict objectForKey:@"name"];
    NSString *value = [attributeDict objectForKey:@"value"];
    PPDeviceTypeAttributeExtended extended = PPDeviceTypeAttributeExtendedNone;
    if([attributeDict objectForKey:@"extended"]) {
        extended = (PPDeviceTypeAttributeExtended)((NSString *)[attributeDict objectForKey:@"extended"]).integerValue;
    }
    NSString *defaultValue = [attributeDict objectForKey:@"defaultValue"];
    
    
    NSMutableArray *options;
    if([attributeDict objectForKey:@"options"]) {
        options = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *optionDict in [attributeDict objectForKey:@"options"]) {
            PPDeviceTypeAttributeOption *option = [PPDeviceTypeAttributeOption initWithDictionary:optionDict];
            [options addObject:option];
        }
    }
    
    PPDeviceTypeAttribute *attribute = [[PPDeviceTypeAttribute alloc] initWithName:name value:value extended:extended defaultValue:defaultValue options:(RLMArray<PPDeviceTypeAttributeOption *><PPDeviceTypeAttributeOption> *)options];
    return attribute;
}

+ (NSString *)stringify:(PPDeviceTypeAttribute *)attribute {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(attribute.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", attribute.name];
        appendComma = YES;
    }
    
    if(attribute.value) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"content\":\"%@\"", attribute.value];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper methods

- (BOOL)isEqualToAttribute:(PPDeviceTypeAttribute *)attribute {
    BOOL equal = NO;
    
    if(attribute.name && _name) {
        if([attribute.name isEqualToString:_name]) {
            equal = YES;
        }
    }
    return equal;
}

- (void)sync:(PPDeviceTypeAttribute *)attribute {
    if(attribute.name) {
        _name = attribute.name;
    }
    if(attribute.value) {
        _value = attribute.value;
    }
    if(attribute.extended) {
        _extended = attribute.extended;
    }
    if(attribute.defaultValue) {
        _defaultValue = attribute.defaultValue;
    }
    if(attribute.options) {
        _options = attribute.options;
    }
}

@end
