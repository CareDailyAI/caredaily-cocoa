//
//  PPVayyarRoom.m
//  Peoplepower iOS
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPVayyarRoom.h"

@implementation PPVayyarRoom

- (id)initWithDeviceId:(NSString *)deviceId
                  xMin: (NSNumber *)xMin
                  xMax: (NSNumber *)xMax
                  yMin: (NSNumber *)yMin
                  yMax: (NSNumber *)yMax
                  zMin: (NSNumber *)zMin
                  zMax: (NSNumber *)zMax {
    self = [super init];
    if (self) {
        self.deviceId = deviceId;
        self.xMin = xMin;
        self.xMax = xMax;
        self.yMin = yMin;
        self.yMax = yMax;
        self.zMin = zMin;
        self.zMax = zMax;
    }
    return self;
}

+ (PPVayyarRoom *)initWithDeviceId:(NSString *)deviceId data:(NSDictionary *)data {
    NSNumber *xMin = @-1.9;
    if ([data objectForKey:@"x_left_meters"]) {
        xMin = [data objectForKey:@"x_left_meters"];
    }
    NSNumber *xMax = @1.9;
    if ([data objectForKey:@"x_right_meters"]) {
        xMax = [data objectForKey:@"x_right_meters"];
    }
    NSNumber *yMin = @0.3;
    if ([data objectForKey:@"y_min_meters"]) {
        yMin = [data objectForKey:@"y_min_meters"];
    }
    NSNumber *yMax = @3.9;
    if ([data objectForKey:@"y_max_meters"]) {
        yMax = [data objectForKey:@"y_max_meters"];
    }
    NSNumber *zMin = @0;
    if ([data objectForKey:@"z_min_meters"]) {
        zMin = [data objectForKey:@"z_min_meters"];
    }
    NSNumber *zMax = @2.5;
    if ([data objectForKey:@"z_max_meters"]) {
        zMax = [data objectForKey:@"z_max_meters"];
    }
    PPVayyarRoom *room = [[PPVayyarRoom alloc] initWithDeviceId:deviceId
                                                           xMin:xMin
                                                           xMax:xMax
                                                           yMin:yMin
                                                           yMax:yMax
                                                           zMin:zMin
                                                           zMax:zMax];
    return room;
}

@end
