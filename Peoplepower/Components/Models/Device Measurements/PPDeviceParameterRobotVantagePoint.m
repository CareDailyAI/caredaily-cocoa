//
//  PPDeviceParameterRobotVantagePoint.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/5/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceParameterRobotVantagePoint.h"

@implementation PPDeviceParameterRobotVantagePoint

- (id)initWithZoomLevel:(NSString *)zoomeLevel horizontalRotation:(NSString *)horizontalRotation verticalRotation:(NSString *)verticalRotation {
    self = [super init];
    if(self) {
        self.zoomLevel = zoomeLevel;
        self.horizontalRotation = horizontalRotation;
        self.verticalRotation = verticalRotation;
    }
    return self;
}

@end
