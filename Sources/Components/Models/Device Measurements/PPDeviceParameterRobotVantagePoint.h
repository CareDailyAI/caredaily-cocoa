//
//  PPDeviceParameterRobotVantagePoint.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/5/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceParameterRobotVantagePoint : RLMObject

@property (nonatomic, strong) NSString *zoomLevel;
@property (nonatomic, strong) NSString *horizontalRotation;
@property (nonatomic, strong) NSString *verticalRotation;

- (id)initWithZoomLevel:(NSString *)zoomeLevel horizontalRotation:(NSString *)horizontalRotation verticalRotation:(NSString *)verticalRotation;

@end

RLM_ARRAY_TYPE(PPDeviceParameterRobotVantagePoint);
