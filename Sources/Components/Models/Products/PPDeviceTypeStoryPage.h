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

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageIndex) {
    PPDeviceTypeStoryPageIndexNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageDismissible) {
    PPDeviceTypeStoryPageDismissibleNone = -1,
    PPDeviceTypeStoryPageDismissibleFalse = 0,
    PPDeviceTypeStoryPageDismissibleTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageHidden) {
    PPDeviceTypeStoryPageHiddenNone = -1,
    PPDeviceTypeStoryPageHiddenFalse = 0,
    PPDeviceTypeStoryPageHiddenTrue = 1
};

extern NSString * _Nonnull PPDeviceTypeStoryPageStyleDefault;
extern NSString * _Nonnull PPDeviceTypeStoryPageStyleInfo;
extern NSString * _Nonnull PPDeviceTypeStoryPageStyleConnect;
extern NSString * _Nonnull PPDeviceTypeStoryPageStylePicture;
extern NSString * _Nonnull PPDeviceTypeStoryPageStyleCalibrate;

@interface PPDeviceTypeStoryPage : NSObject

@property (nonatomic) PPDeviceTypeStoryPageIndex index;
@property (nonatomic) PPDeviceTypeStoryPageHidden hidden;
@property (nonatomic) PPDeviceTypeStoryPageDismissible dismissible;
@property (nonatomic, strong) NSString * _Nonnull subtitle;
@property (nonatomic, strong) NSString * _Nullable desc;
@property (nonatomic, strong) NSString * _Nonnull style;
@property (nonatomic, strong) NSString * _Nonnull content;
@property (nonatomic, strong) NSArray * _Nullable actions;
@property (nonatomic, strong) NSArray * _Nullable media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo * _Nullable displayInfo;

- (id _Nonnull )initWithIndex:(PPDeviceTypeStoryPageIndex)index
             hidden:(PPDeviceTypeStoryPageHidden)hidden
        dismissible:(PPDeviceTypeStoryPageDismissible)dismissible
           subtitle:(NSString * _Nonnull )subtitle
               desc:(NSString * _Nullable )desc
              style:(NSString * _Nonnull )style
            content:(NSString * _Nonnull )content
            actions:(NSArray * _Nullable )actions
              media:(NSArray * _Nullable )media
        displayInfo:(PPDeviceTypeParameterDisplayInfo * _Nullable )displayInfo;

+ (PPDeviceTypeStoryPage * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )pageDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeStoryPage * _Nonnull )page;

@end
