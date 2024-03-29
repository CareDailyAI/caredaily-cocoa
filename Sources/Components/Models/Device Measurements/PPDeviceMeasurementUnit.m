//
//  PPDeviceMeasurementUnit.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceMeasurementUnit.h"

@implementation PPDeviceMeasurementUnit

- (id)initWithUnit:(NSString *)unit desc:(NSString *)desc {
    self = [super init];
    if(self) {
        self.unit = unit;
        self.desc = desc;
    }
    return self;
}

+ (PPDeviceMeasurementUnit *)initWithDictionary:(NSDictionary *)measurementUnit {
    NSString *unit = [measurementUnit objectForKey:@"unit"];
    NSString *desc = [measurementUnit objectForKey:@"description"];
    
    PPDeviceMeasurementUnit *alert = [[PPDeviceMeasurementUnit alloc] initWithUnit:unit desc:desc];
    return alert;
}

@end
