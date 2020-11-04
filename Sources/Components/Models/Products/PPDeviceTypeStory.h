//
//  PPDeviceTypeStory.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeStoryPage.h"
#import "PPDeviceTypeStoryModel.h"

@interface PPDeviceTypeStory : PPBaseModel

@property (nonatomic, strong) NSString * _Nonnull storyId;
@property (nonatomic, strong) NSArray * _Nullable models;
@property (nonatomic, strong) NSArray * _Nullable brands;
@property (nonatomic) PPDeviceTypeStoryType storyType;
@property (nonatomic, strong) NSString * _Nonnull lang;
@property (nonatomic, strong) NSString * _Nonnull title;
@property (nonatomic, strong) NSArray * _Nullable search;
@property (nonatomic) PPDeviceTypeStorySortId sortId;
@property (nonatomic, strong) NSArray * _Nonnull pages;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo * _Nullable displayInfo;

- (id _Nullable )initWithStoryId:(NSString * _Nonnull )storyId
               models:(NSArray * _Nullable )models
               brands:(NSArray * _Nullable )brands
            storyType:(PPDeviceTypeStoryType)storyType
                 lang:(NSString * _Nonnull )lang
                title:(NSString * _Nonnull )title
               search:(NSArray * _Nullable )search
               sortId:(PPDeviceTypeStorySortId)sortId
                pages:(NSArray * _Nonnull )pages
          displayInfo:(PPDeviceTypeParameterDisplayInfo * _Nullable )displayInfo;

+ (PPDeviceTypeStory * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )storyDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeStory * _Nonnull )story;

#pragma mark - Helper methods

- (BOOL)isEqualToStory:(PPDeviceTypeStory * _Nonnull )story;

- (void)sync:(PPDeviceTypeStory * _Nonnull )story;

@end
