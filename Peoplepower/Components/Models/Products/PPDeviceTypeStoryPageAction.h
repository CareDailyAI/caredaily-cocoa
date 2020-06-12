//
//  PPDeviceTypeStoryPageAction.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/25/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionIndex) {
    PPDeviceTypeStoryPageActionIndexActionNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionType) {
    PPDeviceTypeStoryPageActionTypeNone         = -1,
    PPDeviceTypeStoryPageActionTypeStoryLink    = 1, // Link to another story
    PPDeviceTypeStoryPageActionTypeInAppLink    = 2, // In-app link
    PPDeviceTypeStoryPageActionTypeTakePhoto    = 3, // Make photo
    PPDeviceTypeStoryPageActionTypeRecordAudio  = 4, // Record audio
    PPDeviceTypeStoryPageActionTypeOpenContacts = 5, // Open Contacts
    PPDeviceTypeStoryPageActionTypeWiFiConfig   = 6, // Configure WiFi
    PPDeviceTypeStoryPageActionTypeSupport      = 7, // Contact Support
    PPDeviceTypeStoryPageActionTypeScanQR       = 8, // Open QR scanner
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionStyle) {
    PPDeviceTypeStoryPageActionStyleNone = -1,
    PPDeviceTypeStoryPageActionStyleButton = 1,
    PPDeviceTypeStoryPageActionStyleLink = 2,
};

@interface PPDeviceTypeStoryPageAction : PPBaseModel

@property (nonatomic) PPDeviceTypeStoryPageActionIndex index;
@property (nonatomic) PPDeviceTypeStoryPageActionType type;
@property (nonatomic) PPDeviceTypeStoryPageActionStyle style;
@property (nonatomic, strong) NSString *storyId;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *desc;

- (id)initWithIndex:(PPDeviceTypeStoryPageActionIndex)index type:(PPDeviceTypeStoryPageActionType)type style:(PPDeviceTypeStoryPageActionStyle)style storyId:(NSString *)storyId desc:(NSString *)desc;
- (id)initWithIndex:(PPDeviceTypeStoryPageActionIndex)index type:(PPDeviceTypeStoryPageActionType)type style:(PPDeviceTypeStoryPageActionStyle)style storyId:(NSString *)storyId url:(NSString *)url desc:(NSString *)desc;

+ (PPDeviceTypeStoryPageAction *)initWithDictionary:(NSDictionary *)actionDict;
+ (NSString *)stringify:(PPDeviceTypeStoryPageAction *)action;

@end

NS_ASSUME_NONNULL_END
