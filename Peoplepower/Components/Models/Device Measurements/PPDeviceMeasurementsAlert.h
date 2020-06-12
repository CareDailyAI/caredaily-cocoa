//
//  PPDeviceMeasurementsAlert.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameter.h"

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsAlertId) {
    PPDeviceMeasurementsAlertIdNone = -1
};

@interface PPDeviceMeasurementsAlert : RLMObject <NSCopying>

@property (nonatomic) PPDeviceMeasurementsAlertId alertId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *alertType;
@property (nonatomic, strong) NSDate *receivingDate;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> *params;

- (id)initWithAlertId:(PPDeviceMeasurementsAlertId)alertId deviceId:(NSString *)deviceId alertType:(NSString *)alertType receivingDate:(NSDate *)receivingDate params:(RLMArray *)params;

+ (PPDeviceMeasurementsAlert *)initWithDictionary:(NSDictionary *)measurementAlertDict;

@end

RLM_ARRAY_TYPE(PPDeviceMeasurementsAlert);
