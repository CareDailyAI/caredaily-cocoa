//
//  PPDeviceTypeRuleComponentTemplateProduct.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceType.h"

@interface PPDeviceTypeRuleComponentTemplateProduct : RLMObject

@property (nonatomic) PPDeviceTypeId typeId;
@property (nonatomic, strong) NSString *paramName;
@property (nonatomic, strong) NSString *paramValue;

- (id)initWithTypeId:(PPDeviceTypeId)typeId paramName:(NSString *)paramName paramValue:(NSString *)paramValue;

+ (PPDeviceTypeRuleComponentTemplateProduct *)initWithDictionary:(NSDictionary *)productDict;

+ (NSString *)stringify:(PPDeviceTypeRuleComponentTemplateProduct *)product;

@end

RLM_ARRAY_TYPE(PPDeviceTypeRuleComponentTemplateProduct);
