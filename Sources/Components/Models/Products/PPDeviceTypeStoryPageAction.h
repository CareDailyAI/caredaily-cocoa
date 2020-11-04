//
//  PPDeviceTypeStoryPageAction.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/25/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPDeviceTypeStoryPageAction : PPBaseModel

@property (nonatomic) PPDeviceTypeStoryPageActionIndex index;
@property (nonatomic) PPDeviceTypeStoryPageActionType type;
@property (nonatomic) PPDeviceTypeStoryPageActionStyle style;
@property (nonatomic, strong) NSString * _Nullable storyId;
@property (nonatomic, strong) NSString * _Nullable url;
@property (nonatomic, strong) NSString * _Nullable desc;

- (id _Nonnull )initWithIndex:(PPDeviceTypeStoryPageActionIndex)index
               type:(PPDeviceTypeStoryPageActionType)type
              style:(PPDeviceTypeStoryPageActionStyle)style
            storyId:(NSString * _Nullable )storyId
                url:(NSString * _Nullable )url
               desc:(NSString * _Nullable )desc;

+ (PPDeviceTypeStoryPageAction * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )actionDict;
+ (NSString * _Nonnull )stringify:(PPDeviceTypeStoryPageAction * _Nonnull )action;

@end

NS_ASSUME_NONNULL_END
