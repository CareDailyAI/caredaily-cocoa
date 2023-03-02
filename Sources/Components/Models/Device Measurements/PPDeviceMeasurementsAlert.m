//
//  PPDeviceMeasurementsAlert.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceMeasurementsAlert.h"

@implementation PPDeviceMeasurementsAlert

- (id)initWithAlertId:(PPDeviceMeasurementsAlertId)alertId deviceId:(NSString *)deviceId alertType:(NSString *)alertType receivingDate:(NSDate *)receivingDate params:(NSArray *)params {
    self = [super init];
    if(self) {
        self.alertId = alertId;
        self.deviceId = deviceId;
        self.alertType = alertType;
        self.receivingDate = receivingDate;
        self.params = params;
    }
    return self;
}

+ (PPDeviceMeasurementsAlert *)initWithDictionary:(NSDictionary *)measurementAlertDict {
    
    PPDeviceMeasurementsAlertId alertId = PPDeviceMeasurementsAlertIdNone;
    if([measurementAlertDict objectForKey:@"alertId"]) {
        alertId = (PPDeviceMeasurementsAlertId)((NSString *)[measurementAlertDict objectForKey:@"alertId"]);
    }
    
    NSString *deviceId = [measurementAlertDict objectForKey:@"deviceId"];
    if(deviceId == nil) {
        deviceId = [measurementAlertDict objectForKey:@"id"];
    }
    NSString *alertType = [measurementAlertDict objectForKey:@"alertType"];
    
    NSString *receivingDateString = [measurementAlertDict objectForKey:@"receivingDate"];
    NSDate *receivingDate = [NSDate date];
    
    if(receivingDateString != nil) {
        if(![receivingDateString isEqualToString:@""]) {
            receivingDate = [PPNSDate parseDateTime:receivingDateString];
        }
    }
    
    NSMutableArray *params;
    if([measurementAlertDict objectForKey:@"parameters"]) {
            params = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *paramDict in [measurementAlertDict objectForKey:@"parameters"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:paramDict];
            [params addObject:parameter];
        }
    }
    
    PPDeviceMeasurementsAlert *alert = [[PPDeviceMeasurementsAlert alloc] initWithAlertId:alertId deviceId:deviceId alertType:alertType receivingDate:receivingDate params:params];
    return alert;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPDeviceMeasurementsAlert *alert = [[PPDeviceMeasurementsAlert allocWithZone:zone] init];
    
    alert.alertId = self.alertId;
    alert.deviceId = [self.deviceId copyWithZone:zone];
    alert.alertType = [self.alertType copyWithZone:zone];
    alert.receivingDate = [self.receivingDate copyWithZone:zone];
    alert.params = self.params;
    
    return alert;
}
@end
