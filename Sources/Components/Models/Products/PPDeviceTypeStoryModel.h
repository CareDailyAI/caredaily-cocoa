//
//  PPDeviceTypeStoryModel.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceTypeStoryModel : PPBaseModel

@property (nonatomic, strong) NSString * _Nonnull modelId;
@property (nonatomic, strong) NSString * _Nonnull brand;

- (id _Nonnull )initWithId:(NSString * _Nonnull )modelId
           brand:(NSString * _Nonnull )brand;

+ (PPDeviceTypeStoryModel * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )modelDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeStoryModel * _Nonnull )model;

@end
