//
//  PPDeviceMeasurementsReading.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameter.h"

@class PPDevice;

@interface PPDeviceMeasurementsReading : PPBaseModel

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) NSArray *params;

- (id)initWithDeviceId:(NSString *)deviceId timeStamp:(NSDate *)timeStamp params:(NSArray *)params;

+ (PPDeviceMeasurementsReading *)initWithDictionary:(NSDictionary *)measurementReadingDict;

@end
