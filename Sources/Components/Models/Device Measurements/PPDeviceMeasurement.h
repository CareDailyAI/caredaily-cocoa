//
//  PPDeviceMeasurement.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameter.h"

@interface PPDeviceMeasurement : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *lastDataReceivedDate;
@property (nonatomic, strong) NSDate *lastMeasureDate;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> *parameters;

- (id)initWithDeviceId:(NSString *)deviceId lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate params:(RLMArray *)params;

+ (PPDeviceMeasurement *)initWithMeasurementDict:(NSDictionary *)measurementDict;

@end

