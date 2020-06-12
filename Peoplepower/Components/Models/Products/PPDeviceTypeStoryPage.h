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

extern NSString *PPDeviceTypeStoryPageStyleDefault;
extern NSString *PPDeviceTypeStoryPageStyleInfo;
extern NSString *PPDeviceTypeStoryPageStyleConnect;
extern NSString *PPDeviceTypeStoryPageStylePicture;
extern NSString *PPDeviceTypeStoryPageStyleCalibrate;

@interface PPDeviceTypeStoryPage : NSObject

@property (nonatomic) PPDeviceTypeStoryPageIndex index;
@property (nonatomic) PPDeviceTypeStoryPageHidden hidden;
@property (nonatomic) PPDeviceTypeStoryPageDismissible dismissible;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSArray *media;

- (id)initWithIndex:(PPDeviceTypeStoryPageIndex)index hidden:(PPDeviceTypeStoryPageHidden)hidden dismissible:(PPDeviceTypeStoryPageDismissible)dismissible subtitle:(NSString *)subtitle desc:(NSString *)desc style:(NSString *)style content:(NSString *)content actions:(NSArray *)actions media:(NSArray *)media;

+ (PPDeviceTypeStoryPage *)initWithDictionary:(NSDictionary *)pageDict;

+ (NSString *)stringify:(PPDeviceTypeStoryPage *)page;

@end
