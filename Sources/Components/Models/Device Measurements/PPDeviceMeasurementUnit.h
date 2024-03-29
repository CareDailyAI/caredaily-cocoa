//
//  PPDeviceMeasurementUnit.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceMeasurementUnit : PPBaseModel

@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *desc;

- (id)initWithUnit:(NSString *)unit desc:(NSString *)desc;

+ (PPDeviceMeasurementUnit *)initWithDictionary:(NSDictionary *)measurementUnit;

@end
