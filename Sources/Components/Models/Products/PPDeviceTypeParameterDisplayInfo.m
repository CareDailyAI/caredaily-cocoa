//
//  PPDeviceTypeParameterDisplayInfo.m
//  Peoplepower
//
//  Created by Destry Teeter on 8/27/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeParameterDisplayInfo.h"

@implementation PPDeviceTypeParameterDisplayInfo

- (id)initWithInfo:(NSDictionary *)info {
    self = [super init];
    if(self) {
        self.info = info;
    }
    return self;
}

+ (PPDeviceTypeParameterDisplayInfo *)initWithDictionary:(NSDictionary *)displayInfoDict {
    return [[PPDeviceTypeParameterDisplayInfo alloc] initWithInfo:displayInfoDict];
}

+ (NSString *)stringify:(PPDeviceTypeParameterDisplayInfo *)displayInfo {
    return @"{}";
}

@end
