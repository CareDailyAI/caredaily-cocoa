//
//  PPDeviceTypeDeviceModelBrand.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPDeviceTypeDeviceModelBrandName;
@class PPDeviceTypeDeviceModelBrandDesc;

@interface PPDeviceTypeDeviceModelBrand : PPBaseModel

@property (nonatomic, strong) NSString * _Nonnull brand;
@property (nonatomic) PPDeviceTypeDeviceModelBrandHidden hidden;
@property (nonatomic, strong) NSString * _Nullable parentId;
@property (nonatomic) PPDeviceTypeDeviceModelBrandSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelBrandName * _Nonnull name;
@property (nonatomic, strong) PPDeviceTypeDeviceModelBrandDesc * _Nullable desc;

- (id _Nonnull )initWithBrand:(NSString * _Nonnull )brand
             hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden
           parentId:(NSString * _Nullable )parentId
             sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId
               name:(PPDeviceTypeDeviceModelBrandName * _Nonnull )name
               desc:(PPDeviceTypeDeviceModelBrandDesc * _Nullable )desc;

+ (PPDeviceTypeDeviceModelBrand * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )brandDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModelBrand * _Nonnull )brand;

@end

@interface PPDeviceTypeDeviceModelBrandName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelBrandName * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end

@interface PPDeviceTypeDeviceModelBrandDesc : PPRLMDictionary
+ (PPDeviceTypeDeviceModelBrandDesc * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end