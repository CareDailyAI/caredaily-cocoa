//
//  PPInAppMessageParameters.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

@interface PPInAppMessageParameters : PPBaseModel

@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSArray *values;

- (id)initWithKeys:(NSArray *)keys value:(NSArray *)values;

+ (PPInAppMessageParameters *)initWithDictionary:(NSDictionary *)paramsDict;

+ (NSString *)stringify:(PPInAppMessageParameters *)parameters;
+ (NSDictionary *)data:(PPInAppMessageParameters *)parameters;

@end
