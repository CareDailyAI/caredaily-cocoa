//
//  PPVayyarSubregion.m
//  Peoplepower
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPVayyarSubregion.h"

@implementation PPVayyarSubregion

- (id)initWithDeviceId:(NSString *)deviceId
           subregionId:(PPVayyarSubregionId)subregionId
             contextId:(PPVayyarContextId)contextId
              uniqueId:(NSString *)uniqueId
                  name:(NSString *)name
                  xMin:(NSNumber *)xMin
                  xMax:(NSNumber *)xMax
                  yMin:(NSNumber *)yMin
                  yMax:(NSNumber *)yMax
           detectFalls:(BOOL)detectFalls
        detectPresence:(BOOL)detectPresence
         enterDuration:(NSNumber *)enterDuration
          exitDuration:(NSNumber *)exitDuration {
    self = [super init];
    if (self) {
        self.deviceId = deviceId;
        self.subregionId = subregionId;
        self.contextId = contextId;
        self.uniqueId = uniqueId;
        self.name = name;
        self.xMin = xMin;
        self.xMax = xMax;
        self.yMin = yMin;
        self.yMax = yMax;
        self.detectFalls = detectFalls;
        self.detectPresence = detectPresence;
        self.enterDuration = enterDuration;
        self.exitDuration = exitDuration;
    }
    return self;
}

+ (PPVayyarSubregion *)initWithDeviceId:(NSString *)deviceId
                                   data:(NSDictionary *)data {
    PPVayyarSubregionId subregionId = PPVayyarSubregionIdNone;
    if ([data valueForKey:@"subregion_id"]) {
        subregionId = ((NSNumber *)[data valueForKey:@"subregion_id"]).intValue;
    }
    NSString *uniqueId = [data valueForKey:@"unique_id"];
    NSString *name = [data valueForKey:@"name"];
    PPVayyarContextId contextId = PPVayyarContextIdNone;
    if ([data valueForKey:@"context_id"]) {
        contextId = ((NSNumber *)[data valueForKey:@"context_id"]).intValue;
    }
    NSNumber *xMin = [data valueForKey:@"x_min_meters"];
    NSNumber *xMax = [data valueForKey:@"x_max_meters"];
    NSNumber *yMin = [data valueForKey:@"y_min_meters"];
    NSNumber *yMax = [data valueForKey:@"y_max_meters"];
    BOOL detectFalls = true;
    if ([data valueForKey:@"detect_falls"]) {
        detectFalls = ((NSNumber *)[data valueForKey:@"detect_falls"]).boolValue;
    }
    BOOL detectPresence = true;
    if ([data valueForKey:@"detect_presence"]) {
        detectPresence = ((NSNumber *)[data valueForKey:@"detect_presence"]).boolValue;
    }
    NSNumber *enterDuration = [data valueForKey:@"enter_duration_s"];
    NSNumber *exitDuration = [data valueForKey:@"exit_duration_s"];
    
    PPVayyarSubregion *subregion = [[PPVayyarSubregion alloc] initWithDeviceId:deviceId
                                                                   subregionId:subregionId
                                                                     contextId:contextId
                                                                      uniqueId:uniqueId
                                                                          name:name
                                                                          xMin:xMin
                                                                          xMax:xMax
                                                                          yMin:yMin
                                                                          yMax:yMax
                                                                   detectFalls:detectFalls
                                                                detectPresence:detectPresence
                                                                 enterDuration:enterDuration
                                                                  exitDuration:exitDuration];
    return subregion;
}

@end
