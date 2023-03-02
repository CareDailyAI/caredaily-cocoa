//
//  PPDeviceTypeDeviceModelCategory.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeDeviceModel.h"

@class PPDeviceTypeStory;
@class PPDeviceTypeDeviceModelCategoryName;

@interface PPDeviceTypeDeviceModelCategory : PPBaseModel

@property (nonatomic) NSString * _Nonnull categoryId;
@property (nonatomic) NSString * _Nullable parentId;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> * _Nullable brands;
@property (nonatomic, strong) NSString * _Nullable icon;
@property (nonatomic, strong) RLMArray<RLMString> * _Nullable search;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelCategoryName * _Nonnull name;
@property (nonatomic, strong) RLMArray<PPDeviceTypeStory *><PPDeviceTypeStory> * _Nullable stories;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModel *><PPDeviceTypeDeviceModel> * _Nullable models;

- (id _Nonnull )initWithId:(NSString * _Nonnull )categoryId
        parentId:(NSString * _Nullable )parentId
          brands:(RLMArray * _Nullable )brands
            icon:(NSString * _Nullable )icon
          search:(RLMArray * _Nullable )search
          hidden:(PPDeviceTypeDeviceModelHidden)hidden
          sortId:(PPDeviceTypeDeviceModelSortId)sortId
            name:(PPDeviceTypeDeviceModelCategoryName * _Nonnull )name
         stories:(RLMArray * _Nullable )stories
          models:(RLMArray * _Nullable )models;

+ (PPDeviceTypeDeviceModelCategory * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )categoryDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

#pragma mark - Helper Methods

- (BOOL)isEqualToCategory:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

- (void)sync:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

@end

@interface PPDeviceTypeDeviceModelCategoryName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelCategoryName * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end

