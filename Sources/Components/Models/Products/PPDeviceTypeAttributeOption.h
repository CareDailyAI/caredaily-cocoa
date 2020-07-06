//
//  PPDeviceTypeAttributeOption.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceTypeAttributeOption : RLMObject

@property (nonatomic, strong) NSString *optionId;
@property (nonatomic, strong) NSString *value;

- (id)initWithId:(NSString *)optionId value:(NSString *)value;

+ (PPDeviceTypeAttributeOption *)initWithDictionary:(NSDictionary *)optionDict;

#pragma mark - Helper methods

- (void)sync:(PPDeviceTypeAttributeOption *)option;

@end

RLM_ARRAY_TYPE(PPDeviceTypeAttributeOption);
