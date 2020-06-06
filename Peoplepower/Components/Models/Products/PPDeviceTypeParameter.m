//
//  PPDeviceTypeParameter.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeParameter.h"

@implementation PPDeviceTypeParameter

+ (NSString *)primaryKey {
    return @"name";
}

- (id)initWithName:(NSString *)name editable:(PPDeviceTypeParameterEditable)editable systemUnit:(NSString *)systemUnit systemMultiplier:(NSString *)systemMultiplier numeric:(PPDeviceTypeParameterNumeric)numeric profiled:(PPDeviceTypeParameterProfiled)profiled configured:(PPDeviceTypeParameterConfigured)configured historical:(PPDeviceTypeParameterHistorical)historical scale:(PPDeviceTypeParameterScale)scale adjustment:(PPDeviceTypeParameterAdjustment)adjustment displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo {
    self = [super init];
    if(self) {
        self.name = name;
        self.editable = editable;
        self.systemUnit = systemUnit;
        self.systemMultiplier = systemMultiplier;
        self.numeric = numeric;
        self.profiled = profiled;
        self.configured = configured;
        self.historical = historical;
        self.scale = scale;
        self.adjustment = adjustment;
        self.displayInfo = displayInfo;
    }
    return self;
}

+ (PPDeviceTypeParameter *)initWithDictionary:(NSDictionary *)paramDict {
    NSString *name = [paramDict objectForKey:@"name"];
    PPDeviceTypeParameterEditable editable = PPDeviceTypeParameterEditableNone;
    if([paramDict objectForKey:@"editable"]) {
        editable = (PPDeviceTypeParameterEditable)((NSString *)[paramDict objectForKey:@"editable"]).integerValue;
    }
    NSString *systemUnit = [paramDict objectForKey:@"systemUnit"];
    NSString *systemMultiplier = [paramDict objectForKey:@"systemMultiplier"];
    PPDeviceTypeParameterNumeric numeric = PPDeviceTypeParameterNumericNone;
    if([paramDict objectForKey:@"numeric"]) {
        numeric = (PPDeviceTypeParameterNumeric)((NSString *)[paramDict objectForKey:@"numeric"]).integerValue;
    }
    PPDeviceTypeParameterProfiled profiled = PPDeviceTypeParameterProfiledNone;
    if([paramDict objectForKey:@"profiled"]) {
        profiled = (PPDeviceTypeParameterProfiled)((NSString *)[paramDict objectForKey:@"profiled"]).integerValue;
    }
    PPDeviceTypeParameterConfigured configured = PPDeviceTypeParameterConfiguredNone;
    if([paramDict objectForKey:@"configured"]) {
        configured = (PPDeviceTypeParameterConfigured)((NSString *)[paramDict objectForKey:@"configured"]).integerValue;
    }
    PPDeviceTypeParameterHistorical historical = PPDeviceTypeParameterHistoricalNone;
    if([paramDict objectForKey:@"historical"]) {
        historical = (PPDeviceTypeParameterHistorical)((NSString *)[paramDict objectForKey:@"historical"]).integerValue;
    }
    PPDeviceTypeParameterScale scale = PPDeviceTypeParameterScaleNone;
    if([paramDict objectForKey:@"scale"]) {
        scale = (PPDeviceTypeParameterScale)((NSString *)[paramDict objectForKey:@"scale"]).integerValue;
    }
    PPDeviceTypeParameterAdjustment adjustment = PPDeviceTypeParameterAdjustmentNone;
    if([paramDict objectForKey:@"adjustment"]) {
        adjustment = (PPDeviceTypeParameterAdjustment)((NSString *)[paramDict objectForKey:@"adjustment"]).integerValue;
    }
    
    PPDeviceTypeParameterDisplayInfo *displayInfo;
    if([paramDict objectForKey:@"displayInfo"]) {
        displayInfo = [PPDeviceTypeParameterDisplayInfo initWithDictionary:[paramDict objectForKey:@"displayInfo"]];
    }
    
    PPDeviceTypeParameter *param = [[PPDeviceTypeParameter alloc] initWithName:name editable:editable systemUnit:systemUnit systemMultiplier:systemMultiplier numeric:numeric profiled:profiled configured:configured historical:historical scale:scale adjustment:adjustment displayInfo:displayInfo];
    return param;
}

+ (NSString *)stringify:(PPDeviceTypeParameter *)parameter {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(parameter.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", parameter.name];
        appendComma = YES;
    }
    if(parameter.editable != PPDeviceTypeParameterEditableNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"editable\":%li", (long)parameter.editable];
        appendComma = YES;
    }
    if(parameter.systemUnit) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"systemUnit\":\"%@\"", parameter.systemUnit];
        appendComma = YES;
    }
    if(parameter.systemMultiplier) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"systemMultiplier\":\"%@\"", parameter.systemMultiplier];
        appendComma = YES;
    }
    if(parameter.numeric != PPDeviceTypeParameterNumericNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"numeric\":%li", (long)parameter.numeric];
        appendComma = YES;
    }
    if(parameter.profiled != PPDeviceTypeParameterProfiledNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"profiled\":%li", (long)parameter.profiled];
        appendComma = YES;
    }
    if(parameter.configured != PPDeviceTypeParameterConfiguredNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"configured\":%li", (long)parameter.configured];
        appendComma = YES;
    }
    if(parameter.historical != PPDeviceTypeParameterHistoricalNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"historical\":%li", (long)parameter.historical];
        appendComma = YES;
    }
    if(parameter.scale != PPDeviceTypeParameterScaleNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"scale\":%li", (long)parameter.scale];
        appendComma = YES;
    }
    if(parameter.adjustment != PPDeviceTypeParameterAdjustmentNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"adjustment\":%li", (long)parameter.adjustment];
        appendComma = YES;
    }
    if(parameter.displayInfo) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"displayInfo\":%@", [PPDeviceTypeParameterDisplayInfo stringify:parameter.displayInfo]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper methods

- (BOOL)isEqualToParameter:(PPDeviceTypeParameter *)parameter {
    BOOL equal = NO;
    
    if(parameter.name && _name) {
        if([parameter.name isEqualToString:_name]) {
            equal = YES;
        }
    }
    return equal;
}

- (void)sync:(PPDeviceTypeParameter *)parameter {

    if(parameter.name) {
        _name = parameter.name;
    }
    if(parameter.editable != PPDeviceTypeParameterEditableNone) {
        _editable = parameter.editable;
    }
    if(parameter.systemUnit) {
        _systemUnit = parameter.systemUnit;
    }
    if(parameter.systemMultiplier) {
        _systemMultiplier = parameter.systemMultiplier;
    }
    if(parameter.numeric != PPDeviceTypeParameterNumericNone) {
        _numeric = parameter.numeric;
    }
    if(parameter.profiled != PPDeviceTypeParameterProfiledNone) {
        _profiled = parameter.profiled;
    }
    if(parameter.configured != PPDeviceTypeParameterConfiguredNone) {
        _configured = parameter.configured;
    }
    if(parameter.historical != PPDeviceTypeParameterHistoricalNone) {
        _historical = parameter.historical;
    }
    if(parameter.scale != PPDeviceTypeParameterScaleNone) {
        _scale = parameter.scale;
    }
    if(parameter.adjustment != PPDeviceTypeParameterAdjustmentNone) {
        _adjustment = parameter.adjustment;
    }
}

@end
