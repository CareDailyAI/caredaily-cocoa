//
//  PPDeviceTypeAttributeOption.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeAttributeOption.h"

@implementation PPDeviceTypeAttributeOption

- (id)initWithId:(NSString *)optionId value:(NSString *)value {
    self = [super init];
    if(self) {
        self.optionId = optionId;
        self.value = value;
    }
    return self;
}

+ (PPDeviceTypeAttributeOption *)initWithDictionary:(NSDictionary *)optionDict {
    NSString *optionId = [optionDict objectForKey:@"id"];
    NSString *value = [optionDict objectForKey:@"value"];
    
    PPDeviceTypeAttributeOption *option = [[PPDeviceTypeAttributeOption alloc] initWithId:optionId value:value];
    return option;
}

#pragma mark - Helper methods

- (void)sync:(PPDeviceTypeAttributeOption *)option {
    _optionId = option.optionId;
    _value = option.value;
}

@end
