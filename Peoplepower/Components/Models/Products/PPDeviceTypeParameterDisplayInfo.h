//
//  PPDeviceTypeParameterDisplayInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/27/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeParameterDisplayInfo : NSObject

@property (nonatomic, strong) NSDictionary *info;

- (id)initWithInfo:(NSDictionary *)info;

+ (PPDeviceTypeParameterDisplayInfo *)initWithDictionary:(NSDictionary *)displayInfoDict;

+ (NSString *)stringify:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

@end
