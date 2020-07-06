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

typedef NS_OPTIONS(NSInteger, PPFileId) {
    PPFileIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileFilesAction) {
    PPFileFilesActionNone = -1,
    PPFileFilesActionOldFileDeleted = 1,
    PPFileFilesActionNotEnoughSpace = 2
};

typedef NS_OPTIONS(NSInteger, PPFileContent) {
    PPFileContentNone = -1,
    PPFileContentFalse = 0,
    PPFileContentTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileThumbnail) {
    PPFileThumbnailNone = -1,
    PPFileThumbnailFalse = 0,
    PPFileThumbnailTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileIncomplete) {
    PPFileIncompleteNone = -1,
    PPFileIncompleteFalse = 0,
    PPFileIncompleteTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFragments) {
    PPFileFragmentsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileFragmentIndex) {
    PPFileFragmentIndexNone = -1
};

typedef NS_OPTIONS(signed long long, PPFileTotalFileSpace) {
    PPFileTotalFileSpaceNone = -1
};

typedef NS_OPTIONS(signed long long, PPFileUsedFileSpace) {
    PPFileUsedFileSpaceNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileTwitterShare) {
    PPFileTwitterShareNone = -1,
    PPFileTwitterShareFalse = 0,
    PPFileTwitterShareTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFilePublicAccess) {
    PPFilePublicAccessNone = -1,
    PPFilePublicAccessFalse = 0,
    PPFilePublicAccessTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileAttach) {
    PPFileAttachNone = -1,
    PPFileAttachFalse = 0,
    PPFileAttachTrue = 1
};

typedef NS_OPTIONS(long long, PPFileSize) {
    PPFileSizeNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileDuration) {
    PPFileDurationNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileShared) {
    PPFileSharedNone = -1,
    PPFileSharedCurrentUserFileNotShared = 0,
    PPFileSharedSharedUserFileNotDeletable = 1,
    PPFileSharedSharedUserFileDeletable = 2
};

typedef NS_OPTIONS(NSInteger, PPFileRotate) {
    PPFileRotateNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileViewCount) {
    PPFileViewCountNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileViewed) {
    PPFileViewedNone = -1,
    PPFileViewedFalse = 0,
    PPFileViewedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFavourite) {
    PPFileFavouriteNone = -1,
    PPFileFavouriteFalse = 0,
    PPFileFavouriteTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFileType) {
    PPFileFileTypeNone = -1,
    PPFileFileTypeAny = 0,
    PPFileFileTypeVideo = 1,
    PPFileFileTypeImage = 2,
    PPFileFileTypeAudio = 3,
    PPFileFileTypeBitmapMask = 4,
    PPFileFileTypeTextLog = 5
};

typedef NS_OPTIONS(NSInteger, PPFileCount) {
    PPFileCountNone = 0,
};

typedef NS_OPTIONS(NSInteger, PPFileStoragePolicy) {
    PPFileStoragePolicyNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileUploadUrl) {
    PPFileUploadUrlNone = -1,
    PPFileUploadUrlFalse = 0,
    PPFileUploadUrlTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileM3U8) {
    PPFileM3U8None = -1,
    PPFileM3U8False = 0,
    PPFileM3U8True = 1
};

typedef NS_OPTIONS(NSInteger, PPFileURLExpiration) {
    PPFileURLExpirationNone = -1,
    PPFileURLExpirationFalse = 0,
    PPFileURLExpirationTrue = 1
};

@interface PPFile : NSObject

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
@property (nonatomic, strong) NSArray *tags;

/* File data */
@property (nonatomic, strong) NSData *data;

- (id)initWithStatus:(NSString *)status fileId:(PPFileId)fileId filesAction:(PPFileFilesAction)filesAction thumbnail:(PPFileThumbnail)thumbnail fragments:(PPFileFragments)fragments name:(NSString *)name type:(PPFileFileType)type publicAccess:(PPFilePublicAccess)publicAccess creationDate:(NSDate *)creationDate size:(PPFileSize)size duration:(PPFileDuration)duration shared:(PPFileShared)shared rotate:(PPFileRotate)rotate device:(PPDevice *)device user:(PPUser *)user viewCount:(PPFileViewCount)viewCount viewed:(PPFileViewed)viewed favourite:(PPFileFavourite)favourite tags:(NSArray *)tags data:(NSData *)data;

+ (PPFile *)initWithDictionary:(NSDictionary *)fileDict;

+ (NSString *)stringify:(PPFile *)file;

#pragma mark - Helper methods

- (BOOL)isEqualToFile:(PPFile *)file;

- (void)sync:(PPFile *)file;

@end
