//
//  PPDeviceMeasurementsReading.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameter.h"

@class PPDevice;

@interface PPDeviceMeasurementsReading : RLMObject

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> *params;

- (id)initWithDeviceId:(NSString *)deviceId timeStamp:(NSDate *)timeStamp params:(RLMArray *)params;

+ (PPDeviceMeasurementsReading *)initWithDictionary:(NSDictionary *)measurementReadingDict;

@end

RLM_ARRAY_TYPE(PPDeviceMeasurementsReading);
