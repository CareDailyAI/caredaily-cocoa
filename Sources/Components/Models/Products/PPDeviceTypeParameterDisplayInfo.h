//
//  PPDeviceTypeParameterDisplayInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/27/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeParameterDisplayInfo : PPBaseModel

@property (nonatomic, strong) PPRLMDictionary *info;

- (id)initWithInfo:(PPRLMDictionary *)info;

+ (PPDeviceTypeParameterDisplayInfo *)initWithDictionary:(PPRLMDictionary *)displayInfoDict;

+ (NSString *)stringify:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

@end
