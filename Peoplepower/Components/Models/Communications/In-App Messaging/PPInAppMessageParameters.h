//
//  PPInAppMessageParameters.h
//  PPiOSCore
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPInAppMessageParameters : RLMObject

@property (nonatomic, strong) RLMArray<RLMString> *keys;
@property (nonatomic, strong) RLMArray<RLMString> *values;

- (id)initWithKeys:(RLMArray *)keys value:(RLMArray *)values;

+ (PPInAppMessageParameters *)initWithDictionary:(NSDictionary *)paramsDict;

+ (NSString *)stringify:(PPInAppMessageParameters *)parameters;
+ (NSDictionary *)data:(PPInAppMessageParameters *)parameters;

@end

RLM_ARRAY_TYPE(PPInAppMessageParameters);
