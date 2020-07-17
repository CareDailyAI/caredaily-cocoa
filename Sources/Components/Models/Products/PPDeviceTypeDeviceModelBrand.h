//
//  PPDeviceTypeDeviceModelBrand.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelBrandHidden) {
    PPDeviceTypeDeviceModelBrandHiddenNone = -1,
    PPDeviceTypeDeviceModelBrandHiddenFalse = 0,
    PPDeviceTypeDeviceModelBrandHiddenTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelBrandSortId) {
    PPDeviceTypeDeviceModelBrandSortIdNone = -1,
};

@interface PPDeviceTypeDeviceModelBrand : NSObject

@property (nonatomic, strong) NSString * _Nonnull brand;
@property (nonatomic) PPDeviceTypeDeviceModelBrandHidden hidden;
@property (nonatomic, strong) NSString * _Nullable parentId;
@property (nonatomic) PPDeviceTypeDeviceModelBrandSortId sortId;
@property (nonatomic, strong) NSDictionary * _Nonnull name;
@property (nonatomic, strong) NSDictionary * _Nullable desc;

- (id _Nonnull )initWithBrand:(NSString * _Nonnull )brand
             hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden
           parentId:(NSString * _Nullable )parentId
             sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId
               name:(NSDictionary * _Nonnull )name
               desc:(NSDictionary * _Nullable )desc;

+ (PPDeviceTypeDeviceModelBrand * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )brandDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModelBrand * _Nonnull )brand;

@end
