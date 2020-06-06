//
//  PPDeviceTypeStoryModel.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceTypeStoryModel : RLMObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSString *brand;

- (id)initWithId:(NSString *)modelId brand:(NSString *)brand;

+ (PPDeviceTypeStoryModel *)initWithDictionary:(NSDictionary *)modelDict;

+ (NSString *)stringify:(PPDeviceTypeStoryModel *)model;

@end

RLM_ARRAY_TYPE(PPDeviceTypeStoryModel);
