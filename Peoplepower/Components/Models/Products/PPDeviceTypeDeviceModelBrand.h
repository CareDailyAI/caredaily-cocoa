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

@property (nonatomic, strong) NSString *brand;
@property (nonatomic) PPDeviceTypeDeviceModelBrandHidden hidden;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic) PPDeviceTypeDeviceModelBrandSortId sortId;
@property (nonatomic, strong) NSDictionary *name;
@property (nonatomic, strong) NSDictionary *desc;

- (id)initWithBrand:(NSString *)brand hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden parentId:(NSString *)parentId sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId name:(NSDictionary *)name desc:(NSDictionary *)desc;

+ (PPDeviceTypeDeviceModelBrand *)initWithDictionary:(NSDictionary *)brandDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelBrand *)brand;

@end
