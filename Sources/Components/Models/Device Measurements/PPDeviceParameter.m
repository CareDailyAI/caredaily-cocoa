//
//  PPDeviceParameter.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceParameter.h"

@implementation PPDeviceParameter

- (id)initWithName:(NSString *)name value:(NSString *)value lastUpdateDate:(NSDate *)lastUpdateDate {
    return [[PPDeviceParameter alloc] initWithName:name index:nil value:value unit:nil lastUpdateDate:lastUpdateDate];
}

- (id)initWithName:(NSString *)name index:(NSString *)index value:(NSString *)value lastUpdateDate:(NSDate *)lastUpdateDate {
    return [[PPDeviceParameter alloc] initWithName:name index:index value:value unit:nil lastUpdateDate:lastUpdateDate];
}

- (id)initWithName:(NSString *)name index:(NSString *)index value:(NSString *)value unit:(NSString *)unit lastUpdateDate:(NSDate *)lastUpdateDate {
    self = [super init];
    if(self) {
        self.name = name;
        self.value = value;
        self.index = index;
        self.unit = unit;
        self.lastUpdateDate = lastUpdateDate;
    }
    return self;
}

+ (PPDeviceParameter *)initWithDictionary:(NSDictionary *)paramDict {
    NSString *name = [paramDict objectForKey:@"name"];
    NSString *index = [paramDict objectForKey:@"index"];
    NSString *value = [paramDict objectForKey:@"value"];
    NSString *unit = [paramDict objectForKey:@"unit"];
    
    NSString *lastUpdateTimeString = [paramDict objectForKey:@"lastUpdateTime"];
    NSDate *lastUpdateTime = [NSDate date];
    
    if(lastUpdateTimeString != nil) {
        if(![lastUpdateTimeString isEqualToString:@""]) {
            lastUpdateTime = [PPNSDate parseDateTime:lastUpdateTimeString];
        }
    }
    
    PPDeviceParameter *parameter = [[PPDeviceParameter alloc] initWithName:name index:index value:value unit:unit lastUpdateDate:lastUpdateTime];
    return parameter;
}

+ (NSString *)stringify:(PPDeviceParameter *)parameter {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(parameter.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\": \"%@\"", parameter.name];
        appendComma = YES;
    }
    
    if(parameter.value) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"value\": \"%@\"", parameter.value];
        appendComma = YES;
    }
    
    if(parameter.index) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"index\": \"%@\"", parameter.index];
        appendComma = YES;
    }
    
    if(parameter.unit) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"unit\": \"%@\"", parameter.unit];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPDeviceParameter *)parameter {
    NSMutableDictionary *data = @{}.mutableCopy;
    if(parameter.name) {
        data[@"name"] = parameter.name;
    }
    
    if(parameter.value) {
        data[@"value"] = parameter.value;
    }
    
    if(parameter.index) {
        data[@"index"] = parameter.index;
    }
    
    if(parameter.unit) {
        data[@"unit"] = parameter.unit;
    }
    
    return data;
}

#pragma mark - Helper methods

- (void)sync:(PPDeviceParameter *)parameter {
    if(parameter.name) {
        _name = parameter.name;
    }
    if(parameter.index) {
        _index = parameter.index;
    }
    if(parameter.lastUpdateDate) {
        _lastUpdateDate = parameter.lastUpdateDate;
    }
    if(parameter.value) {
        _value = parameter.value;
    }
    if(parameter.unit) {
        _unit = parameter.unit;
    }
}

- (BOOL)isEqual:(PPDeviceParameter *)parameter {
    return [self.name isEqual:parameter.name] && [self.index isEqualToString:parameter.index];
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPDeviceParameter *parameter = [[PPDeviceParameter allocWithZone:zone] init];
    parameter.name = [self.name copyWithZone:zone];
    parameter.value = [self.value copyWithZone:zone];
    parameter.index = [self.index copyWithZone:zone];
    parameter.unit = [self.unit copyWithZone:zone];
    parameter.lastUpdateDate = [self.lastUpdateDate copyWithZone:zone];
    return parameter;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.index = [decoder decodeObjectForKey:@"index"];
        self.unit = [decoder decodeObjectForKey:@"unit"];
        self.lastUpdateDate = [decoder decodeObjectForKey:@"lastUpdateDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_value forKey:@"value"];
    [encoder encodeObject:_index forKey:@"index"];
    [encoder encodeObject:_unit forKey:@"unit"];
    [encoder encodeObject:_lastUpdateDate forKey:@"lastUpdateDate"];
}

@end

