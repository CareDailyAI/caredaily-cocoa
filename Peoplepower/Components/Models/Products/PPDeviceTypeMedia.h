//
//  PPDeviceTypeMedia.h
//  PPiOSCore
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
@interface PPDeviceTypeMedia : NSArray

@property (nonatomic, strong) NSString *mediaId;
@property (nonatomic) PPDeviceTypeMediaType mediaType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSDictionary *desc;

- (id)initWithId:(NSString *)mediaId mediaType:(PPDeviceTypeMediaType)mediaType url:(NSString *)url contentType:(NSString *)contentType desc:(NSDictionary *)desc;

+ (PPDeviceTypeMedia *)initWithDictionary:(NSDictionary *)mediaDict;

+ (NSString *)stringify:(PPDeviceTypeMedia *)media;

#pragma mark - Helper methods

- (BOOL)isEqualToMedia:(PPDeviceTypeMedia *)media;

- (void)sync:(PPDeviceTypeMedia *)media;

@end
