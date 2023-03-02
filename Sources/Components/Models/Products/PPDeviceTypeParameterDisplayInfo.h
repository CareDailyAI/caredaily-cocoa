//
//  PPDeviceTypeParameterDisplayInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/27/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

@interface PPDeviceTypeParameterDisplayInfo : PPBaseModel

@property (nonatomic, strong) NSDictionary *info;

- (id)initWithInfo:(NSDictionary *)info;

+ (PPDeviceTypeParameterDisplayInfo *)initWithDictionary:(NSDictionary *)displayInfoDict;

+ (NSString *)stringify:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

@end
