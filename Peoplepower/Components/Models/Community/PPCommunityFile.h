//
//  PPCommunityFile.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/10/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunityFile : NSObject

/* The File ID to reference this file later */
@property (nonatomic) PPFileId fileId;

/* Type of file.
 *      0 - any
 *      1 - video
 *      2 - image
 *      3 - audio
 *      4 - bitmap mask
 *      5 - text log*/
@property (nonatomic) PPFileFileType type;

/* The File content type */
@property (nonatomic) NSString * _Nonnull contentType;

/* The File extension */
@property (nonatomic) NSString * _Nonnull ext;

/* Duration of the video or audio file, in seconds */
@property (nonatomic) PPFileDuration duration;

/* Degrees this video has been rotated. It is up to the playback mechanism to rotate the video upright again, if necessary. */
@property (nonatomic) PPFileRotate rotate;

/* Size of the file in bytes */
@property (nonatomic) PPFileSize size;

/* true - This particular upload for the given file ID is a thumbnail image, false - This particular upload is not a thumbnail */
@property (nonatomic) PPFileThumbnail thumbnail;

/* true - This particular upload for the given file ID is a thumbnail image, false - This particular upload is not a thumbnail */
@property (nonatomic) PPFileM3U8 m3u8;

/* Content URL */
@property (nonatomic) NSString * _Nullable contentUrl;

/* Content URL Expiration */
@property (nonatomic) NSDate * _Nullable contentUrlExpiration;

/* Thumbnail URL */
@property (nonatomic) NSString * _Nullable thumbnailUrl;

/* Thumbnail URL Expiration */
@property (nonatomic) NSDate * _Nullable thumbnailUrlExpiration;

/* m3u8 URL */
@property (nonatomic) NSString * _Nullable m3u8Url;

/* m3u8 URL Expiration */
@property (nonatomic) NSDate * _Nullable m3u8UrlExpiration;

/* Content data */
@property (nonatomic, strong) NSData * _Nullable contentData;

/* Thumbnail data */
@property (nonatomic, strong) NSData * _Nullable thumbnailData;

/* m3u8 data */
@property (nonatomic, strong) NSData * _Nullable m3u8Data;

- (id)initWithFileId:(PPFileId)fileId
                type:(PPFileFileType)type
         contentType:(NSString * _Nonnull)contentType
                 ext:(NSString * _Nonnull)ext
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
            m3u8Data:(NSData * _Nullable)m3u8Data;

+ (PPCommunityFile *)initWithDictionary:(NSDictionary *)fileDict;

@end

NS_ASSUME_NONNULL_END
