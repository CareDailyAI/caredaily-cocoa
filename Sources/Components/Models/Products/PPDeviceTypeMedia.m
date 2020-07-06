//
//  PPDeviceTypeMedia.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeMedia.h"

@implementation PPDeviceTypeMedia

+ (NSString *)primaryKey {
    return @"mediaId";
}

- (id)initWithId:(NSString *)mediaId mediaType:(PPDeviceTypeMediaType)mediaType url:(NSString *)url contentType:(NSString *)contentType desc:(PPDeviceTypeMediaDesc *)desc {
    self = [super init];
    if(self) {
        self.mediaId = mediaId;
        self.mediaType = mediaType;
        self.url = url;
        self.contentType = contentType;
        self.desc = desc;
    }
    return self;
}

+ (PPDeviceTypeMedia *)initWithDictionary:(NSDictionary *)mediaDict {
    NSString *mediaId = [mediaDict objectForKey:@"id"];
    PPDeviceTypeMediaType mediaType = PPDeviceTypeMediaTypeNone;
    if([mediaDict objectForKey:@"mediaType"]) {
        mediaType = (PPDeviceTypeMediaType)((NSString *)[mediaDict objectForKey:@"mediaType"]).integerValue;
    }
    NSString *url = [mediaDict objectForKey:@"url"];
    NSString *contentType = [mediaDict objectForKey:@"contentType"];
    PPDeviceTypeMediaDesc *desc = [PPDeviceTypeMediaDesc initWithDictionary:[mediaDict objectForKey:@"desc"]];
    
    PPDeviceTypeMedia *media = [[PPDeviceTypeMedia alloc] initWithId:mediaId mediaType:mediaType url:url contentType:contentType desc:desc];
    return media;
}

+ (NSString *)stringify:(PPDeviceTypeMedia *)media {
    
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(media.mediaId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", media.mediaId];
        appendComma = YES;
    }
    
    if(media.mediaType != PPDeviceTypeMediaTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"mediaType\":%li", (long)media.mediaType];
        appendComma = YES;
    }
    
    if(media.url) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"url\":\"%@\"", media.url];
        appendComma = YES;
    }
    
    if(media.contentType) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"contentType\":\"%@\"", media.contentType];
        appendComma = YES;
    }
    
    if(media.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendFormat:@"\"desc\": {%@}", [PPDeviceTypeMediaDesc stringify:media.desc]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper methods

- (BOOL)isEqualToMedia:(PPDeviceTypeMedia *)media {
    BOOL equal = NO;
    
    if(media.mediaId && media) {
        if([media.mediaId isEqualToString:_mediaId]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDeviceTypeMedia *)media {

    if(media.mediaId) {
        _mediaId = media.mediaId;
    }
    if(media.mediaType != PPDeviceTypeMediaTypeNone) {
        _mediaType = media.mediaType;
    }
    if(media.url) {
        _url = media.url;
    }
    if(media.contentType) {
        _contentType = media.contentType;
    }
    if(media.desc) {
        _desc = media.desc;
    }
}

@end

@implementation PPDeviceTypeMediaDesc

+ (PPDeviceTypeMediaDesc *)initWithDictionary:(NSDictionary *)dict {
    PPRLMDictionary *RLMDictionary = [super initWithDictionary:dict];
    return [[PPDeviceTypeMediaDesc alloc] initWithKeys:RLMDictionary.keys value:RLMDictionary.values];
}

@end
