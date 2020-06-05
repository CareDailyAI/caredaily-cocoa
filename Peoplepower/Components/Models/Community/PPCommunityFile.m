//
//  PPCommunityFile.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/10/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCommunityFile.h"

@implementation PPCommunityFile

- (id)initWithFileId:(PPFileId)fileId
                type:(PPFileFileType)type
         contentType:(NSString *)contentType
                 ext:(NSString *)ext
            duration:(PPFileDuration)duration
              rotate:(PPFileRotate)rotate
                size:(PPFileSize)size
           thumbnail:(PPFileThumbnail)thumbnail
                m3u8:(PPFileM3U8)m3u8
          contentUrl:(NSString * _Nullable)contentUrl
contentUrlExpiration:(NSDate * _Nullable)contentUrlExpiration
        thumbnailUrl:(NSString * _Nullable)thumbnailUrl
thumbnailUrlExpiration:(NSDate * _Nullable)thumbnailUrlExpiration
             m3u8Url:(NSString * _Nullable)m3u8Url
   m3u8UrlExpiration:(NSDate * _Nullable)m3u8UrlExpiration
         contentData:(NSData * _Nullable)contentData
       thumbnailData:(NSData * _Nullable)thumbnailData
            m3u8Data:(NSData * _Nullable)m3u8Data {
    self = [super init];
    if (self) {
        self.fileId = fileId;
        self.type = type;
        self.contentType = contentType;
        self.ext = ext;
        self.duration = duration;
        self.rotate = rotate;
        self.size = size;
        self.thumbnail = thumbnail;
        self.m3u8 = m3u8;
        self.contentUrl = contentUrl;
        self.contentUrlExpiration = contentUrlExpiration;
        self.thumbnailUrl = thumbnailUrl;
        self.thumbnailUrlExpiration = thumbnailUrlExpiration;
        self.m3u8Url = m3u8Url;
        self.m3u8UrlExpiration = m3u8UrlExpiration;
        self.contentData = contentData;
        self.thumbnailData = thumbnailData;
        self.m3u8Data = m3u8Data;
    }
    return self;
}

+ (PPCommunityFile *)initWithDictionary:(NSDictionary *)fileDict {
    PPFileId fileId = PPFileIdNone;
    if ([fileDict objectForKey:@"id"]) {
        fileId = ((NSNumber *)[fileDict objectForKey:@"id"]).integerValue;
    }
    PPFileFileType type = PPFileFileTypeNone;
    if ([fileDict objectForKey:@"type"]) {
        type = ((NSNumber *)[fileDict objectForKey:@"type"]).integerValue;
    }
    NSString *contentType = [fileDict objectForKey:@"contentType"];
    NSString *ext = [fileDict objectForKey:@"ext"];
    PPFileDuration duration = PPFileDurationNone;
    if ([fileDict objectForKey:@"duration"]) {
        duration = ((NSNumber *)[fileDict objectForKey:@"duration"]).integerValue;
    }
    PPFileRotate rotate = PPFileRotateNone;
    if ([fileDict objectForKey:@"rotate"]) {
        rotate = ((NSNumber *)[fileDict objectForKey:@"rotate"]).integerValue;
    }
    PPFileSize size = PPFileSizeNone;
    if ([fileDict objectForKey:@"size"]) {
        size = ((NSNumber *)[fileDict objectForKey:@"size"]).integerValue;
    }
    PPFileThumbnail thumbnail = PPFileThumbnailNone;
    if ([fileDict objectForKey:@"thumbnail"]) {
        thumbnail = ((NSNumber *)[fileDict objectForKey:@"thumbnail"]).integerValue;
    }
    PPFileM3U8 m3u8 = PPFileM3U8None;
    if ([fileDict objectForKey:@"m3u8"]) {
        m3u8 = ((NSNumber *)[fileDict objectForKey:@"m3u8"]).integerValue;
    }
    NSString *contentUrl;
    NSDate *contentUrlExpiration;
    if ([fileDict objectForKey:@"contentUrl"]) {
        contentUrl = [fileDict objectForKey:@"contentUrl"];
        contentUrlExpiration = [PPCommunityFile expirationForS3Url:contentUrl];
    }
    NSString *thumbnailUrl;
    NSDate *thumbnailUrlExpiration;
    if ([fileDict objectForKey:@"thumbnailUrl"]) {
        thumbnailUrl = [fileDict objectForKey:@"thumbnailUrl"];
        thumbnailUrlExpiration = [PPCommunityFile expirationForS3Url:thumbnailUrl];
    }
    NSString *m3u8Url;
    NSDate *m3u8UrlExpiration;
    if ([fileDict objectForKey:@"m3u8Url"]) {
        m3u8Url = [fileDict objectForKey:@"m3u8Url"];
        m3u8UrlExpiration = [PPCommunityFile expirationForS3Url:m3u8Url];
    }
    NSData *contentData;
    if ([fileDict objectForKey:@"contentData"]) {
        contentData = [fileDict objectForKey:@"contentData"];
    }
    NSData *thumbnailData;
    if ([fileDict objectForKey:@"thumbnailData"]) {
        thumbnailData = [fileDict objectForKey:@"thumbnailData"];
    }
    NSData *m3u8Data;
    if ([fileDict objectForKey:@"m3u8Data"]) {
        m3u8Data = [fileDict objectForKey:@"m3u8Data"];
    }
    
    PPCommunityFile *file = [[PPCommunityFile alloc] initWithFileId:fileId
                                                               type:type
                                                        contentType:contentType
                                                                ext:ext
                                                           duration:duration
                                                             rotate:rotate
                                                               size:size
                                                          thumbnail:thumbnail
                                                               m3u8:m3u8
                                                         contentUrl:contentUrl
                                               contentUrlExpiration:contentUrlExpiration
                                                       thumbnailUrl:thumbnailUrl
                                             thumbnailUrlExpiration:thumbnailUrlExpiration
                                                            m3u8Url:m3u8Url
                                                  m3u8UrlExpiration:m3u8UrlExpiration
                                                        contentData:contentData
                                                      thumbnailData:thumbnailData
                                                           m3u8Data:m3u8Data];
    return file;
}

// Private

+ (NSDate *)expirationForS3Url:(NSString *)url {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    NSDate *date;
    NSNumber *timeInterval;
    for (NSURLQueryItem *queryItem in urlComponents.queryItems) {
        if ([queryItem.name isEqualToString:@"X-Amz-Date"]) {
            date = [PPNSDate parseAWSDateTime:queryItem.value];
        }
        else if ([queryItem.name isEqualToString:@"X-Amz-Expires"]) {
            timeInterval = @(queryItem.value.integerValue);
        }
    }
    if (date != nil && timeInterval != nil) {
        return [date dateByAddingTimeInterval:timeInterval.integerValue];
    }
    return nil;
}

@end
