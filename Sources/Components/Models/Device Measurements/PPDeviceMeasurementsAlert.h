//
//  PPDeviceMeasurementsAlert.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceParameter.h"

@interface PPDeviceMeasurementsAlert : PPBaseModel <NSCopying>

@property (nonatomic) PPDeviceMeasurementsAlertId alertId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *alertType;
@property (nonatomic, strong) NSDate *receivingDate;
@property (nonatomic, strong) NSArray *params;

- (id)initWithAlertId:(PPDeviceMeasurementsAlertId)alertId deviceId:(NSString *)deviceId alertType:(NSString *)alertType receivingDate:(NSDate *)receivingDate params:(NSArray *)params;

+ (PPDeviceMeasurementsAlert *)initWithDictionary:(NSDictionary *)measurementAlertDict;

@end
