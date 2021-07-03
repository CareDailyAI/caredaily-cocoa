//
//  PPVayyarRoom.h
//  Peoplepower iOS
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * # Vayyar Room
 *
 * Parameters
 * - `deviceId` String Device ID to apply these room boundaries to.
 * - `xMin` Float Looking into the room from the device, this is the distance from the center of the device to the left wall of the room in meters. This is a negative number, and if a positive number is given, then it will be turned into a negative number.
 * - `xMax` Float Looking into the room from the device, this is the distance from the center of the device to the right wall of the room in meters. This is a positive number, and if a negative number is given, then it will be turned into a positive number.
 * - `yMin` Float Distance from the Vayyar Home to the opposite wall.
 */
@interface PPVayyarRoom : PPBaseModel

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic) NSNumber<RLMFloat> *xMin;
@property (nonatomic) NSNumber<RLMFloat> *xMax;
@property (nonatomic) NSNumber<RLMFloat> *yMin;
@property (nonatomic) NSNumber<RLMFloat> *yMax;
@property (nonatomic) NSNumber<RLMFloat> *zMin;
@property (nonatomic) NSNumber<RLMFloat> *zMax;

- (id)initWithDeviceId:(NSString *)deviceId
                  xMin: (NSNumber *)xMin
                  xMax: (NSNumber *)xMax
                  yMin: (NSNumber *)yMin
                  yMax: (NSNumber *)yMax
                  zMin: (NSNumber *)zMin
                  zMax: (NSNumber *)zMax;

+ (PPVayyarRoom *)initWithDeviceId:(NSString *)deviceId data:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
