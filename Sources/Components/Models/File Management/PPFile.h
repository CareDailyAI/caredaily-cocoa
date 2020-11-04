//
//  PPFile.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDevice.h"
#import "PPUser.h"
#import "PPFileTag.h"

@interface PPFile : PPBaseModel

/* Server-to-Hardware Status Code (i.e. ACK) as described in the Device API doc */
@property (nonatomic, strong) NSString *status;

/* The File ID to reference this file later */
@property (nonatomic) PPFileId fileId;

/* 1 - Old files have been deleted to make room for this one
 * 2 - There isn't enough space to upload this file */
@property (nonatomic) PPFileFilesAction filesAction;

/* true - This particular upload for the given file ID is a thumbnail image, false - This particular upload is not a thumbnail */
@property (nonatomic) PPFileThumbnail thumbnail;

/* The total fragments that compose this file */
@property (nonatomic) PPFileFragments fragments;

/* Name of the file */
@property (nonatomic, strong) NSString *name;

/* Type of file.
 *      0 - any
 *      1 - video
 *      2 - image
 *      3 - audio
 *      4 - bitmap mask
 *      5 - text log*/
@property (nonatomic) PPFileFileType type;

/* true - This file is not encrypted and available for public access
 * false - This file is encrypted and can only be accessed by the owner */
@property (nonatomic) PPFilePublicAccess publicAccess;

/* The creation date / timestamp of the content */
@property (nonatomic, strong) NSDate *creationDate;

/* Size of the file in bytes */
@property (nonatomic) PPFileSize size;

/* Duration of the video or audio file, in seconds */
@property (nonatomic) PPFileDuration duration;

/* 0 - This file belongs to the current user and is not shared.
 * 1 - This file is shared by another user, and cannot be deleted.
 * 2 - This file is shared by another user, and can be deleted. */
@property (nonatomic) PPFileShared shared;

/* Degrees this video has been rotated. It is up to the playback mechanism to rotate the video upright again, if necessary. */
@property (nonatomic) PPFileRotate rotate;

/* Description of the device that generated this content, including the device ID, type, and name/description. */
@property (nonatomic, strong) PPDevice *device;

/* Description of the user that generated this content, including the user ID, first and last name, and possible email. */
@property (nonatomic, strong) PPUser *user;

/* Number of times the content has been viewed */
@property (nonatomic) PPFileViewCount viewCount;

/* true - This file has already been viewed
 * false - This is new content */
@property (nonatomic) PPFileViewed viewed;

/* true - This file has been favourited */
@property (nonatomic) PPFileFavourite favourite;

/* File tags */
@property (nonatomic, strong) RLMArray<PPFileTag *><PPFileTag> *tags;

/* File data */
@property (nonatomic, strong) NSData *data;

- (id)initWithStatus:(NSString *)status fileId:(PPFileId)fileId filesAction:(PPFileFilesAction)filesAction thumbnail:(PPFileThumbnail)thumbnail fragments:(PPFileFragments)fragments name:(NSString *)name type:(PPFileFileType)type publicAccess:(PPFilePublicAccess)publicAccess creationDate:(NSDate *)creationDate size:(PPFileSize)size duration:(PPFileDuration)duration shared:(PPFileShared)shared rotate:(PPFileRotate)rotate device:(PPDevice *)device user:(PPUser *)user viewCount:(PPFileViewCount)viewCount viewed:(PPFileViewed)viewed favourite:(PPFileFavourite)favourite tags:(RLMArray *)tags data:(NSData *)data;

+ (PPFile *)initWithDictionary:(NSDictionary *)fileDict;

+ (NSString *)stringify:(PPFile *)file;

#pragma mark - Helper methods

- (BOOL)isEqualToFile:(PPFile *)file;

- (void)sync:(PPFile *)file;

@end
