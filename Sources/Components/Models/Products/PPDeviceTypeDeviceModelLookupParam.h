//
//  PPDeviceTypeDeviceModelLookupParam.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeDeviceModelLookupParam : PPBaseModel

@property (nonatomic) PPDeviceTypeId deviceType;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> * _Nullable params;

- (id _Nonnull )initWithDeviceType:(PPDeviceTypeId)deviceType
                            params:(RLMArray * _Nullable )params;

+ (PPDeviceTypeDeviceModelLookupParam * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )lookupParamDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModelLookupParam * _Nonnull )lookupParam;

@end
