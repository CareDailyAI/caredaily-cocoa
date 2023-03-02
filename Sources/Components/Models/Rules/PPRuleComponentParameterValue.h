//
//  PPRuleComponentParameterValue.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPRuleComponentParameterValue : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *valueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *selectorValue;

- (id)initWithValueId:(NSString *)valueId name:(NSString *)name value:(NSString *)value selectorValue:(NSString *)selectorValue;

+ (PPRuleComponentParameterValue *)initWithDictionary:(NSDictionary *)valueDict;

#pragma marker - Helper Methods

- (BOOL)isEqualToParameterValue:(PPRuleComponentParameterValue *)parameterValue;

- (void)sync:(PPRuleComponentParameterValue *)parameterValue;

@end
