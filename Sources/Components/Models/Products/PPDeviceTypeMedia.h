//
//  PPDeviceTypeMedia.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPDeviceTypeMediaType) {
    PPDeviceTypeMediaTypeNone = -1,
    PPDeviceTypeMediaTypeVideo = 1,
    PPDeviceTypeMediaTypeImage = 2,
    PPDeviceTypeMediaTypeAudio = 3,
    PPDeviceTypeMediaTypeTextDocument = 4
};
@interface PPDeviceTypeMedia : NSObject

@property (nonatomic, strong) NSString * _Nonnull mediaId;
@property (nonatomic) PPDeviceTypeMediaType mediaType;
@property (nonatomic, strong) NSString * _Nonnull url;
@property (nonatomic, strong) NSString * _Nonnull contentType;
@property (nonatomic, strong) NSDictionary * _Nonnull desc;

- (id _Nonnull )initWithId:(NSString * _Nonnull )mediaId
       mediaType:(PPDeviceTypeMediaType)mediaType
             url:(NSString * _Nonnull )url
     contentType:(NSString * _Nonnull )contentType
            desc:(NSDictionary * _Nonnull )desc;

+ (PPDeviceTypeMedia * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )mediaDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeMedia * _Nonnull )media;

#pragma mark - Helper methods

- (BOOL)isEqualToMedia:(PPDeviceTypeMedia * _Nonnull )media;

- (void)sync:(PPDeviceTypeMedia * _Nonnull )media;

@end
