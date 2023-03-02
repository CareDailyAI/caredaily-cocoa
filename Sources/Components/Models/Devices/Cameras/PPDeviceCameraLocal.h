//
//  PPDeviceCameraLocal.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/2/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceCamera.h"

@interface PPDeviceCameraLocal : PPDeviceCamera

+ (PPDeviceCameraLocal *)initWithDictionary:(NSDictionary *)deviceDict;

@end
