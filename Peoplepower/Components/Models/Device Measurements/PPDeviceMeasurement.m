//
//  PPDeviceMeasurement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceMeasurement.h"

@implementation PPDeviceMeasurement

- (id)initWithDeviceId:(NSString *)deviceId lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate params:(RLMArray *)params {
    self = [super self];
    if(self) {
        self.deviceId = deviceId;
        self.lastDataReceivedDate = lastDataReceivedDate;
        self.lastMeasureDate = lastMeasureDate;
        self.parameters = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)params;
    }
    return self;
}

+ (PPDeviceMeasurement *)initWithMeasurementDict:(NSDictionary *)measurementDict {
    NSString *deviceId = [measurementDict objectForKey:@"id"];
    
    NSString *lastDataReceivedDateString = [measurementDict objectForKey:@"lastDataReceivedDate"];
    NSDate *lastDataReceivedDate = [NSDate date];
    
    if(lastDataReceivedDateString != nil) {
        if(![lastDataReceivedDateString isEqualToString:@""]) {
            lastDataReceivedDate = [PPNSDate parseDateTime:lastDataReceivedDateString];
        }
    }
    
    NSString *lastMeasureDateString = [measurementDict objectForKey:@"lastMeasureDate"];
    NSDate *lastMeasureDate = [NSDate date];
    
    if(lastMeasureDateString != nil) {
        if(![lastMeasureDateString isEqualToString:@""]) {
            lastMeasureDate = [PPNSDate parseDateTime:lastMeasureDateString];
        }
    }
    
    NSMutableArray *params;
    if([measurementDict objectForKey:@"parameters"]) {
        params = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *paramDict in [measurementDict objectForKey:@"parameters"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:paramDict];
            [params addObject:parameter];
        }
    }
    
    PPDeviceMeasurement *measurement = [[PPDeviceMeasurement alloc] initWithDeviceId:deviceId lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate params:(RLMArray *)params];
    return measurement;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPDeviceMeasurement *measurement = [[[self class] allocWithZone:zone] init];
    
    measurement.deviceId = [self.deviceId copyWithZone:zone];
    measurement.lastDataReceivedDate = [self.lastDataReceivedDate copyWithZone:zone];
    measurement.lastMeasureDate = [self.lastMeasureDate copyWithZone:zone];
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:self.parameters.count];
    for (PPDeviceParameter *parameter in self.parameters) {
        [parameters addObject:[parameter copyWithZone:zone]];
    }
    measurement.parameters = parameters;
    
    return measurement;
}

@end
