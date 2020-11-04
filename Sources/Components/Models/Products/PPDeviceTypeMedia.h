//
//  PPDeviceTypeMedia.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPDeviceTypeMediaDesc;

typedef NS_OPTIONS(NSInteger, PPDeviceTypeMediaType) {
    PPDeviceTypeMediaTypeNone = -1,
    PPDeviceTypeMediaTypeVideo = 1,
    PPDeviceTypeMediaTypeImage = 2,
    PPDeviceTypeMediaTypeAudio = 3,
    PPDeviceTypeMediaTypeTextDocument = 4
};

@interface PPDeviceTypeMedia : PPBaseModel

@property (nonatomic, strong) NSString * _Nonnull mediaId;
@property (nonatomic) PPDeviceTypeMediaType mediaType;
@property (nonatomic, strong) NSString * _Nonnull url;
@property (nonatomic, strong) NSString * _Nonnull contentType;
@property (nonatomic, strong) PPDeviceTypeMediaDesc * _Nonnull desc;

- (id _Nonnull )initWithId:(NSString * _Nonnull )mediaId
       mediaType:(PPDeviceTypeMediaType)mediaType
             url:(NSString * _Nonnull )url
     contentType:(NSString * _Nonnull )contentType
            desc:(PPDeviceTypeMediaDesc * _Nonnull )desc;

+ (PPDeviceTypeMedia * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )mediaDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeMedia * _Nonnull )media;

#pragma mark - Helper methods

- (BOOL)isEqualToMedia:(PPDeviceTypeMedia * _Nonnull )media;

- (void)sync:(PPDeviceTypeMedia * _Nonnull )media;

@end

@interface PPDeviceTypeMediaDesc : PPRLMDictionary
+ (PPDeviceTypeMediaDesc * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end
