//
//  PPDeviceMeasurementsReading.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceMeasurementsReading.h"
#import "PPDevice.h"

@implementation PPDeviceMeasurementsReading

- (id)initWithDeviceId:(NSString *)deviceId timeStamp:(NSDate *)timeStamp params:(RLMArray *)params {
    self = [super init];
    if(self) {
        self.deviceId = deviceId;
        self.timeStamp = timeStamp;
        self.params = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)params;
    }
    return self;
}

+ (PPDeviceMeasurementsReading *)initWithDictionary:(NSDictionary *)measurementReadingDict {
    NSString *deviceId = [measurementReadingDict objectForKey:@"deviceId"];
    if(deviceId == nil) {
        deviceId = [measurementReadingDict objectForKey:@"id"];
    }
    NSString *timeStampString = [measurementReadingDict objectForKey:@"timeStamp"];
    NSDate *timeStamp = [NSDate date];
    
    if(timeStampString != nil) {
        if(![timeStampString isEqualToString:@""]) {
            timeStamp = [PPNSDate parseDateTime:timeStampString];
        }
    }
    
    NSMutableArray *params;
    if([measurementReadingDict objectForKey:@"params"]) {
        params = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *paramDict in [measurementReadingDict objectForKey:@"params"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:paramDict];
            parameter.lastUpdateDate = timeStamp;
            [params addObject:parameter];
        }
    }
    
    PPDeviceMeasurementsReading *reading = [[PPDeviceMeasurementsReading alloc] initWithDeviceId:deviceId timeStamp:timeStamp params:(RLMArray *)params];
    return reading;
}

@end
