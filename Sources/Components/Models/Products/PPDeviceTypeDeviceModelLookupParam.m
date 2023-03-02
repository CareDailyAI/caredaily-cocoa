//
//  PPDeviceTypeDeviceModelLookupParam.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/28/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeDeviceModelLookupParam.h"

@implementation PPDeviceTypeDeviceModelLookupParam

- (id)initWithDeviceType:(PPDeviceTypeId)deviceType params:(RLMArray *)params {
    self = [super init];
    if(self) {
        self.deviceType = deviceType;
        self.params = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)params;
    }
    return self;
}

+ (PPDeviceTypeDeviceModelLookupParam *)initWithDictionary:(NSDictionary *)lookupParamDict {
    
    PPDeviceTypeId deviceType = PPDeviceTypeIdNone;
    if([lookupParamDict objectForKey:@"deviceType"]) {
        deviceType = (PPDeviceTypeId)((NSNumber *)[lookupParamDict objectForKey:@"deviceType"]).integerValue;
    }
    
    NSMutableArray *params;
    if([lookupParamDict objectForKey:@"params"]) {
        params = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *paramDict in [lookupParamDict objectForKey:@"params"]) {
            PPDeviceParameter *param = [PPDeviceParameter initWithDictionary:paramDict];
            [params addObject:param];
        }
    }
    
    PPDeviceTypeDeviceModelLookupParam *lookupParam = [[PPDeviceTypeDeviceModelLookupParam alloc] initWithDeviceType:deviceType params:(RLMArray *)params];
    return lookupParam;
}

// TODO: Enable stringify for device models so we can create them
+ (NSString *)stringify:(PPDeviceTypeDeviceModelLookupParam *)lookupParam {
    
    
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(lookupParam.deviceType != PPDeviceTypeIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"deviceType\":\"%li\"", (long)lookupParam.deviceType];
        appendComma = YES;
    }
    
    if([lookupParam.params count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"params\": ["];
        
        BOOL appendParamComma = NO;
        for(PPDeviceParameter *param in lookupParam.params) {
            if(appendParamComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceParameter stringify:param]];
            appendParamComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
