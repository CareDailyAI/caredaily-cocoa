//
//  PPDeviceTypeParameterDisplayInfo.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/27/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeParameterDisplayInfo : RLMObject

@property (nonatomic, strong) PPRLMDictionary *info;

- (id)initWithInfo:(PPRLMDictionary *)info;

+ (PPDeviceTypeParameterDisplayInfo *)initWithDictionary:(NSDictionary *)displayInfoDict;

+ (NSString *)stringify:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

@end

RLM_ARRAY_TYPE(PPDeviceTypeParameterDisplayInfo);
