//
//  PPDeviceMeasurementUnit.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceMeasurementUnit : NSObject

@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *desc;

- (id)initWithUnit:(NSString *)unit desc:(NSString *)desc;

+ (PPDeviceMeasurementUnit *)initWithDictionary:(NSDictionary *)measurementUnit;

@end
