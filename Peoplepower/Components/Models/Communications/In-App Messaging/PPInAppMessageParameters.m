//
//  PPInAppMessageParameters.m
//  PPiOSCore
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPInAppMessageParameters.h"

@implementation PPInAppMessageParameters

- (id)initWithKeys:(NSArray *)keys value:(NSArray *)values {
    self = [super init];
    if(self) {
        self.keys = keys;
        self.values = values;
    }
    return self;
}

+ (PPInAppMessageParameters *)initWithDictionary:(NSDictionary *)paramsDict {
    
    
    NSArray *keys = paramsDict.allKeys;
    NSArray *values = paramsDict.allValues;
    
    PPInAppMessageParameters *parameters = [[PPInAppMessageParameters alloc] initWithKeys:keys value:values];
    return parameters;
}


+ (NSString *)stringify:(PPInAppMessageParameters *)parameters {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@""];
    
    BOOL appendComma = NO;
    for(NSInteger i = 0; i < parameters.keys.count; i++) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"%@\":\"%@\"", [parameters.keys objectAtIndex:i], [parameters.values objectAtIndex:i]];
        appendComma = YES;
    }
    
    return JSONString;
}

+ (NSDictionary *)data:(PPInAppMessageParameters *)parameters {
    NSMutableDictionary *data = @{}.mutableCopy;
    for(NSInteger i = 0; i < parameters.keys.count; i++) {
        [data setValue:parameters.values[i] forKey:parameters.keys[i]];
    }
    return data;
}

@end
