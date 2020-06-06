//
//  PPDeviceTypeDeviceModelLookupParam.h
//  PPiOSCore-Framework
//
//  Created by Destry Teeter on 6/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeDeviceModelLookupParam : RLMObject

@property (nonatomic) PPDeviceTypeId deviceType;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> *params;

- (id)initWithDeviceType:(PPDeviceTypeId)deviceType params:(RLMArray *)params;

+ (PPDeviceTypeDeviceModelLookupParam *)initWithDictionary:(NSDictionary *)lookupParamDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelLookupParam *)lookupParam;

@end

RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelLookupParam);
