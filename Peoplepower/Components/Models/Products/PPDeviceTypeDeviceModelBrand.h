//
//  PPDeviceTypeDeviceModelBrand.h
//  PPiOSCore
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

@class PPDeviceTypeDeviceModelBrandName;
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrandName);

@class PPDeviceTypeDeviceModelBrandDesc;
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrandDesc);

@interface PPDeviceTypeDeviceModelBrand : RLMObject

@property (nonatomic, strong) NSString *brand;
@property (nonatomic) PPDeviceTypeDeviceModelBrandHidden hidden;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic) PPDeviceTypeDeviceModelBrandSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelBrandName *name;
@property (nonatomic, strong) PPDeviceTypeDeviceModelBrandDesc *desc;

- (id)initWithBrand:(NSString *)brand hidden:(PPDeviceTypeDeviceModelBrandHidden)hidden parentId:(NSString *)parentId sortId:(PPDeviceTypeDeviceModelBrandSortId)sortId name:(PPDeviceTypeDeviceModelBrandName *)name desc:(PPDeviceTypeDeviceModelBrandDesc *)desc;

+ (PPDeviceTypeDeviceModelBrand *)initWithDictionary:(NSDictionary *)brandDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelBrand *)brand;

@end

RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrand);

@interface PPDeviceTypeDeviceModelBrandName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelBrandName *)initWithDictionary:(NSDictionary *)dict;
@end

@interface PPDeviceTypeDeviceModelBrandDesc : PPRLMDictionary
+ (PPDeviceTypeDeviceModelBrandDesc *)initWithDictionary:(NSDictionary *)dict;
@end
