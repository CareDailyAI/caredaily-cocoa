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

@interface PPDeviceTypeDeviceModelCategory : PPBaseModel

@property (nonatomic) NSString * _Nonnull categoryId;
@property (nonatomic) NSString * _Nullable parentId;
@property (nonatomic, strong) NSArray * _Nullable brands;
@property (nonatomic, strong) NSString * _Nullable icon;
@property (nonatomic, strong) NSArray * _Nullable search;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) NSDictionary * _Nonnull name;
@property (nonatomic, strong) NSArray * _Nullable stories;
@property (nonatomic, strong) NSArray * _Nullable models;

- (id _Nonnull )initWithId:(NSString * _Nonnull )categoryId
        parentId:(NSString * _Nullable )parentId
          brands:(NSArray * _Nullable )brands
            icon:(NSString * _Nullable )icon
          search:(NSArray * _Nullable )search
          hidden:(PPDeviceTypeDeviceModelHidden)hidden
          sortId:(PPDeviceTypeDeviceModelSortId)sortId
            name:(NSDictionary * _Nonnull )name
         stories:(NSArray * _Nullable )stories
          models:(NSArray * _Nullable )models;

+ (PPDeviceTypeDeviceModelCategory * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )categoryDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

#pragma mark - Helper Methods

- (BOOL)isEqualToCategory:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

- (void)sync:(PPDeviceTypeDeviceModelCategory * _Nonnull )category;

@end
