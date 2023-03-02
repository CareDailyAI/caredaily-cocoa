//
//  PPInAppMessageParameters.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

@interface PPInAppMessageParameters : PPBaseModel

@property (nonatomic, strong) RLMArray<RLMString> *keys;
@property (nonatomic, strong) RLMArray<RLMString> *values;

- (id)initWithKeys:(RLMArray *)keys value:(RLMArray *)values;

+ (PPInAppMessageParameters *)initWithDictionary:(NSDictionary *)paramsDict;

+ (NSString *)stringify:(PPInAppMessageParameters *)parameters;
+ (NSDictionary *)data:(PPInAppMessageParameters *)parameters;

@end

