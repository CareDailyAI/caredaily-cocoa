//
//  PPDeviceTypeDeviceModelLookupParam.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPDeviceTypeDeviceModelLookupParam : NSObject

@property (nonatomic) PPDeviceTypeId deviceType;
@property (nonatomic, strong) NSArray *params;

- (id)initWithDeviceType:(PPDeviceTypeId)deviceType params:(NSArray *)params;

+ (PPDeviceTypeDeviceModelLookupParam *)initWithDictionary:(NSDictionary *)lookupParamDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelLookupParam *)lookupParam;

@end
