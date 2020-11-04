//
//  PPRLMDictionary.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPRLMDictionary : PPBaseModel

@property (nonatomic, strong) RLMArray<RLMString> *keys;
@property (nonatomic, strong) RLMArray<RLMString> *values;

- (id)initWithKeys:(RLMArray *)keys value:(RLMArray *)values;

- (NSString *)stringValueForKey:(NSString *)key;
- (NSArray *)arrayValueForKey:(NSString *)key;
- (NSDictionary *)dictValueForKey:(NSString *)key;

+ (PPRLMDictionary *)initWithDictionary:(NSDictionary *)dict;

+ (NSString *)stringify:(PPRLMDictionary *)model;
+ (NSDictionary *)data:(PPRLMDictionary *)model;

@end
