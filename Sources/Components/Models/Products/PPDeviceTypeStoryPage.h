//
//  PPDeviceTypeStoryPage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeMedia.h"
#import "PPDeviceTypeStoryPageAction.h"

@interface PPDeviceTypeStoryPage : PPBaseModel

@property (nonatomic) PPDeviceTypeStoryPageIndex index;
@property (nonatomic) PPDeviceTypeStoryPageHidden hidden;
@property (nonatomic) PPDeviceTypeStoryPageDismissible dismissible;
@property (nonatomic, strong) NSString * _Nonnull subtitle;
@property (nonatomic, strong) NSString * _Nullable desc;
@property (nonatomic, strong) NSString * _Nonnull style;
@property (nonatomic, strong) NSString * _Nonnull content;
@property (nonatomic, strong) RLMArray<PPDeviceTypeStoryPageAction *><PPDeviceTypeStoryPageAction> * _Nullable actions;
@property (nonatomic, strong) RLMArray<PPDeviceTypeMedia *><PPDeviceTypeMedia> * _Nullable media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo * _Nullable displayInfo;

- (id _Nonnull )initWithIndex:(PPDeviceTypeStoryPageIndex)index
             hidden:(PPDeviceTypeStoryPageHidden)hidden
        dismissible:(PPDeviceTypeStoryPageDismissible)dismissible
           subtitle:(NSString * _Nonnull )subtitle
               desc:(NSString * _Nullable )desc
              style:(NSString * _Nonnull )style
            content:(NSString * _Nonnull )content
            actions:(RLMArray * _Nullable )actions
              media:(RLMArray * _Nullable )media
        displayInfo:(PPDeviceTypeParameterDisplayInfo * _Nullable )displayInfo;

+ (PPDeviceTypeStoryPage * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )pageDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeStoryPage * _Nonnull )page;

@end