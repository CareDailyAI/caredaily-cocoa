//
//  PPFileManagement.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite securely manages sensitive binary files associated with a user's account. For example, these files may be videos, images, audio, or other types of data.
// The storage system has a 10,240 byte write size. When uploading large files, it is recommended that the file is uploaded in chunk sizes that are multiples of 10 KB.
// Files may also be replaced. For example, you may upload a preview video and later replace it with a full sized video when recording is complete.
// The file upload mechanism is compatible with devices; that is, you do not need a valid API key to upload a file.
// After uploading a file, a separate <alert> measurement from the device will trigger emails and push notifications to go out with the appropriate message to the user.
//

#import "PPBaseModel.h"
#import "PPFile.h"
#import "PPFileSummary.h"

typedef void (^PPFileManagementFragmentBlock)(NSString * _Nullable status, PPFile * _Nullable fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString * _Nullable twitterAccount, NSString * _Nullable contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error);
typedef void (^PPFileManagementFilesBlock)(NSArray * _Nullable files, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementContentBlock)(NSData * _Nullable fileContent, NSString * _Nullable contentType, NSString * _Nullable contentRange, NSString * _Nullable acceptRanges, NSString * _Nullable contentDisposition,NSInteger statusCode, NSError * _Nullable error);
typedef void (^PPFileManagementDownloadURLBlock)(NSURL * _Nullable contentURL, NSURL * _Nullable thumbnailURL, NSError * _Nullable error);
typedef void (^PPFileManagementFilesSummaryBlock)(NSArray * _Nullable summaries, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSDate * _Nullable startDate, NSDate * _Nullable endDate, PPFileCount filesCount, NSError * _Nullable error);
typedef void (^PPFileManagementFileDevicesBlock)(NSArray * _Nullable devices, NSError * _Nullable error);
typedef void (^PPFileManagementFileInformationBlock)(PPFile * _Nullable file, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementLastNFilesBlock)(NSArray * _Nullable files, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementProgressBlock)(NSProgress * _Nullable progress);

typedef NS_OPTIONS(NSInteger, PPFileManagementAuthorizationType) {
    PPFileManagementAuthorizationTypeNone = -1,
    PPFileManagementAuthorizationTypeDeviceAuthenticationToken = 0,
    PPFileManagementAuthorizationTypeStreamingSessionId = 1
};

typedef NS_OPTIONS(NSInteger, PPFileOwners) {
    PPFileOwnersNone = -1,
    PPFileOwnersOwnFiles = 1,
    PPFileOwnersSharedFiles = 2,
    PPFileOwnersOwnAndSharedFiles = 3,
    PPFileOwnersOwnDeletedFiles = 4
};

typedef NS_OPTIONS(NSInteger, PPFileRecover) {
    PPFileRecoverNone = -1,
    PPFileRecoverFalse = 0,
    PPFileRecoverTrue = 1
};

@interface PPFileManagement : PPBaseModel


/* The total space in the user's account for files, in bytes. Be sure to use a very large variable size to store this value (i.e. 'long long') */
@property (nonatomic) PPFileTotalFileSpace totalFilesSpace;

/* The space in the user's account that has already been consumed, in bytes. Be sure to use a very large variable size to store this value (i.e. 'long long') */
@property (nonatomic) PPFileUsedFileSpace usedFilesSpace;

/* Synchronize your local Twitter settings with what the server declares, because you might not have a valid API key to check otherwise.
 *      true - This file was shared on Twitter.
 *      false - This file was not shared on Twitter */
@property (nonatomic) PPFileTwitterShare twitterShare;

/* Name of the Twitter account this was shared to, without the '@' character */
@property (nonatomic, strong) NSString *twitterAccount;

#pragma mark - Session Management

#pragma mark Files

/**
 * Shared files across the entire application
 */
+ (NSArray *)sharedFilesForUser:(PPUserId)userId;

/**
 * Add files.
 * Add files to local reference.
 *
 * @param files NSArray Array of files to add.
 * @param userId Required PPUserId User Id to associate these files with
 **/
+ (void)addFiles:(NSArray *)files userId:(PPUserId)userId;

/**
 * Remove files.
 * Remove files from local reference.
 *
 * @param files NSArray Array of files to remove.
 * @param userId Required PPUserId User Id to associate these files with
 **/
+ (void)removeFiles:(NSArray *)files userId:(PPUserId)userId;

#pragma mark Summaries

/**
 * Shared file summaries across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedFileSummariesForUser:(PPUserId)userId;

/**
 * Add file summaries.
 * Add file summaries to local reference.
 *
 * @param fileSummaries NSArray Array of file summaries to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addFileSummaries:(NSArray *)fileSummaries userId:(PPUserId)userId;

/**
 * Remove file summaries.
 * Remove file summaries from local reference.
 *
 * @param fileSummaries NSArray Array of file summaries to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeFilesSummaries:(NSArray *)fileSummaries userId:(PPUserId)userId;

#pragma mark - Files Management

/**
 * Upload a new file
 * The "Content-Type" header must be like "video/...", "image/...", "audio/...", "text/plain" or "application/octet-stream" (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values).
 * For example:
 *      video/mp4
 *      image/jpeg
 *      audio/mp3.
 * The content type of a thumbnail image is always image/jpeg.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:
 *      Using a Device Authentication Token: 'PPCAuthorization: esp token="ABC12345"'
 *      Using a Streaming Session ID: 'PPCAuthorization: stream session="DEF67890"'
 *
 * @param proxyId Required NSString Device ID of the proxy that thsi file is being uploaded through
 * @param deviceId NSString Device ID of the dvice that generated this file, if different from the proxyId
 * @param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @param expectedSize PPFileSize Expected total size in bytes, if available
 * @param duration PPFileDuration Duration of the video in seconds, for reporting to the UI
 * @param rotate PPFileRotate Rotation in degrees. The UI is expected to manually rotat the video back to being upright if this is set.
 * @param fileId PPFileId Existing file ID to replace the content and properties
 * @param thumbnail PPFileThumbnail True - The content is a thumbnail image and the file content will be uploaded later
 * @param incomplete PPFileIncomplete True - This file content will be replaced or extended later. False - This file is complete
 * @param type PPFileFileType File type. By default it is defined from the content type. However this parameter is useful, if a thumbnail with different content type is uploaded frist.
 * @param contentType Required NSString Content-Type header.
 * @param authorizationType Required PPFileManagementAuthorizationType Authorization type used to identify the source device.
 * @param token Required if authorizationType set to PPFileManagementAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @param sessionId Required if authorizationType set to PPFileManagementAuthorizationTypeStreamingSessionId NSString Session ID.
 * @param data Required if uploadUrl set to PPFileUploadUrlTrue NSData File data
 * @param uploadUrl PPFileUploadUrl If it is set to true, the server does not need the file content. The server will create a file record in the database and request S3 to generate a presigned URL to upload the file content, which will be returned to the camera. These presigned URL's can be returned for both the file content and the thumbnail. The URL's are valid until some configurable timeout.
 * @param progressBlock PPFileManagementProgressBlock File upload progress block
 * @param callback PPFileManagementFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, twitter account (if any), storage policy, and uploadHeaders
 **/
+ (void)uploadNewFile:(NSString * _Nonnull )proxyId deviceId:(NSString * _Nullable )deviceId fileExtension:(NSString * _Nonnull )fileExtension expectedSize:(PPFileSize)expectedSize duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate fileId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete type:(PPFileFileType)type contentType:(NSString * _Nonnull )contentType authorizationType:(PPFileManagementAuthorizationType)authorizationType token:(NSString * _Nullable )token sessionId:(NSString * _Nullable )sessionId data:(NSData * _Nonnull )data uploadUrl:(PPFileUploadUrl)uploadUrl progressBlock:(PPFileManagementProgressBlock _Nullable )progressBlock callback:(PPFileManagementFragmentBlock _Nonnull )callback;;

/**
 * Get Files
 * Return a list of the user's files, and any files that have been shared with this user by other users.
 *
 * @param locationId Required PPLocationId Files location ID
 * @param type PPFileFileType Type of file to obtain in the list
 * @param owners PPFileOwners Filter files by owners bitmap
 * @param ownerId PPUserId User ID to filter files by the specific owner
 * @param deviceId NSString Camera dvice ID to filter files by the specific camera
 * @param deviceDesc NSString Camera device description to filter files by the specific camera
 * @param startDate NSDate Optional start date to start the list of files
 * @param endDate NSDate Optional end date to end the list of files
 * @param searchTag NSString Search by tag
 * @param callback PPFileManagementFilesBlock Files callback block containing list of files, used and total file space, temp key, and temp key expire date
 **/
+ (void)getFiles:(PPLocationId)locationId type:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId deviceId:(NSString * _Nullable )deviceId deviceDesc:(NSString * _Nullable )deviceDesc startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate searchTag:(NSString * _Nullable )searchTag callback:(PPFileManagementFilesBlock _Nonnull )callback;
+ (void)getFiles:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId deviceId:(NSString * _Nullable )deviceId deviceDesc:(NSString * _Nullable )deviceDesc startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate searchTag:(NSString * _Nullable )searchTag callback:(PPFileManagementFilesBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete all files
 * This action will delete all files on the location that are not marked as favorite.
 *
 * @param locationId Required PPLocationId Files location ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteAllFiles:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteAllFiles:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Last N Files

/**
 * Get Last N Files.
 * Return a list of last N user's files before specific date.
 *
 * @param count Required PPFileCount Maximum number of files to return
 * @param startDate NSDate Optional start date to start the list of files
 * @param endDate NSDate Optional end date to end the list of files, default is current date.
 * @param type PPFileFileType Type of file to obtain in the list
 * @param deviceId NSString Camera device ID to filter files by the specific camera
 * @param deviceDescription NSString Camera device description to filter files by the specific camera
 * @param callback PPFileManagementLastNFilesBlock Last N Files block containing list of files and temp key/expiry
 **/
+ (void)getLastNFiles:(PPFileCount)count startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate type:(PPFileFileType)type deviceId:(NSString * _Nullable )deviceId deviceDescription:(NSString * _Nullable )deviceDescription callback:(PPFileManagementLastNFilesBlock _Nonnull )callback;

#pragma mark - File Content Management

/**
 * Upload File Fragment or a Thumbnail
 * Allow to add a fragment to the content of the existing file or upload a thumbnail.
 * "Content-Type" and "PPCAuthorization" are same as for uploading a new file.
 *
 * @param fileId Required PPFileId Existing file ID
 * @param proxyId Required NSString Device ID of the proxy that this file is being uploaded through
 * @param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @param thumbnail PPFileThumbnail True - The content is a thumbnail image
 * @param incomplete PPFileIncomplete True - The file will be extended later, False - This file is complete
 * @param index PPFileFragmentIndex Fragmen index starting from 0 to identify unique file fragment. It is used for additional control over uploaded data.
 * @param contentType Required NSString Content-Type header.
 * @param authorizationType Required PPFileManagementAuthorizationType Authorization type used to identify the source device.
 * @param token Required if authorizationType set to PPFileManagementAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @param sessionId Required if authorizationType set to PPFileManagementAuthorizationTypeStreamingSessionId NSString Session ID.
 * @param data Required NSData File data
 * @param callback PPFileManagementFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
+ (void)uploadFileFragment:(PPFileId)fileId proxyId:(NSString * _Nonnull )proxyId fileExtension:(NSString * _Nonnull )fileExtension thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)index contentType:(NSString * _Nonnull )contentType authorizationType:(PPFileManagementAuthorizationType)authorizationType token:(NSString * _Nullable )token sessionId:(NSString * _Nullable )sessionId data:(NSData * _Nonnull )data callback:(PPFileManagementFragmentBlock _Nonnull )callback;

/**
 * Download File
 * The Range HTTP Header is optional, and will only return a chunk of the total content. If used, it is recommended to select a range that is a multiple of 10240 bytes.
 * A temporary API key provided in the query parameter may be used to forward a link to other part of the app. A temporary API key can be obtained by calling the loginByKey API. It is expired soon after receiving.
 * The response will include:
 *      - The file content
 *      - A Content-Type HTTP Header containing the file's content typeContent range in the
 *      - Content-Range header, if the Range of the content was requested. This will be in the format of bytes {start}-{end}/{total size}. For example: Content-Range: bytes 21010-47021/47022.
 *      - The Accept-Ranges header containing accepted content range values in bytes. For example "0-47022".
 *      - The Content-Disposition HTTP header that contains the filename when requesting a non-image, when the whole file is requested.
 *
 * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for a discussion on the header options.
 * HTTP Status Codes:
 *      - 200 (OK): The file content is returned in full.
 *      - 204 (No Content): The file exist, but the content is not available for this request.
 *      - 206 (Partial Content): The file content is partially returned.
 *      - 401 (Unauthorized): The API key is wrong.
 *      - 404 (Not Found): The file does not exists.
 *      - 500 (Internal error): Something went wrong on the server side.
 *
 * @param fileId Required PPFileId File ID to download
 * @param apiKey NSString Temporary API key
 * @param thumbnail PPFileThumbnail True - Download the thumbnail for this file, False - Download the actual file, not the thumbnail, default
 * @param isPublic PPFilePublicAccess True - Do not include api key in authorization header
 * @param attach PPFileAttach Download the file content as an attachments with the Content-Disposition header
 * @param range NSRange Range of bytes to download
 * @param callback PPFileManagementContentBlock File content block
 **/
+ (void)downloadFile:(PPFileId)fileId apiKey:(NSString * _Nullable )apiKey thumbnail:(PPFileThumbnail)thumbnail isPublic:(PPFilePublicAccess)isPublic attach:(PPFileAttach)attach range:(NSRange)range callback:(PPFileManagementContentBlock _Nonnull )callback;

/**
 * Get download URL's
 * A client can request temporary download URL's to get file and thumbnail content directly from S3 instead of copying it through the server.
 *
 * @param fileId Required PPFileId File ID to download
 * @param locationId Required PPLocationId File location ID
 * @param content PPFileContent True - Download the file content URL
 * @param thumbnail PPFileThumbnail True - Download the thumbnail content URL
 * @param expiration PPFileURLExpiration URL's expiration in milliseconds since the current time
 * @param callback PPFileManagementDownloadURLBlock File content block
 **/
+ (void)getDownloadURL:(PPFileId)fileId locationId:(PPLocationId)locationId content:(PPFileContent)content thumbnail:(PPFileThumbnail)thumbnail expiration:(PPFileURLExpiration)expiration callback:(PPFileManagementDownloadURLBlock _Nonnull )callback;
 
 /**
  * Update file attributes.
  * Update the file's attributes to declare, if the file has been viewed or not, if it's a favourite file and shouldn't be auto-deleted, and whether the file is available for public access.
  * The file publisher (camera) can update it as completed.
  * Also this API can be used to recover deleted files.
  *
  * @param fileId Required PPFileId File ID to update
  * @param proxyId NSString Device ID of the proxy that this file is being uploaded through
  * @param incomplete PPFileIncomplete Set it to false to udpate the file as completed
  * @param recover PPFileRecover Set it to tru to recover a deleted file
  * @param userId PPUserId User ID to update the file as an administrator
  * @param viewed PPFileViewed Mark file as viewed
  * @param favourite PPFileFavourite Mark file as favourite
  * @param publicAccess PPFilePublicAccess Mark file as being available publicly
  * @param callback PPErrorBlock Error callback block
  **/
+ (void)updateFileAttribute:(PPFileId)fileId proxyId:(NSString * _Nullable )proxyId incomplete:(PPFileIncomplete)incomplete recover:(PPFileRecover)recover userId:(PPUserId)userId viewed:(PPFileViewed)viewed favourite:(PPFileFavourite)favourite publicAccess:(PPFilePublicAccess)publicAccess callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete a file
 *
 * @param fileId Required PPFileId File ID to delete
 * @param locationId Required PPLocationId File location ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteFile:(PPFileId)fileId locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteFile:(PPFileId)fileId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Files Summary

/**
 * Get aggregated list of files
 * Users can collect a massive list of files. Even the plain text to describe these files can sometimes be megabytes long. This API helps describe what files exist on the server, so the user can drill into the data without downloading everything all at once.
 * This API will return a list of files sorted by creation date in descending order, providing summary information for the files within each aggregation period (day, week, month, etc.):
 *      - File creation date rounded to the beginning of an aggregation period
 *      - Total number of filesTotal size of the files
 *      - Total duration in secondsTotal viewed files
 *      - Total favourite files
 * In addition, each API call returns:
 *      - the user's total available space in bytes,
 *      - the space that's already been consumed in bytes,
 *      - the total number of files,
 *      - dates when the first and last files have been uploaded.
 * As the amount of space in a user's account is actually on the order of gigabytes, please be sure to use very large variable types to store this information, such as a "long long".
 * For better API performance request only own user files information with aggregation by days without details and for limited time period.
 *
 * @param aggregation Required PPFileSummaryAggregation The duration of time accross which to aggregate summary information
 * @param locationId Required PPLocationId Files location ID
 * @param details PPFileSummaryDetails If ture, the API will return detailed inormation - slow.  Otherwise only total number of files will be returned.
 * @param timezone NSString Time zone ID to separate aggreated summary information. For example, "America/Los_Angeles. See the discussion on Time Zones in IOT Suite documentation
 * @param type PPFileFileType Filter by type of file.
 * @param startDate NSDate Start date for which to begin returning agggregate summary information on the user's files.
 * @param endDate NSDate End date for which to stop returning agggregate summary information on the user's files.
 * @param callback PPFileManagementFilesSummaryBlock Files Summary callback block containing list of file summaries, total file space, used file space, start date, end date, and files count
 **/
+ (void)getAggregatedListOfFiles:(PPFileSummaryAggregation)aggregation locationId:(PPLocationId)locationId details:(PPFileSummaryDetails)details timezone:(NSString * _Nullable )timezone type:(PPFileFileType)type startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPFileManagementFilesSummaryBlock _Nonnull )callback;
+ (void)getAggregatedListOfFiles:(PPFileSummaryAggregation)aggregation details:(PPFileSummaryDetails)details timezone:(NSString * _Nullable )timezone type:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPFileManagementFilesSummaryBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - File devices

/**
 * Get list of file devices
 * Return all combinations of device ID's and device descriptions from existing user files.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPFileManagementFileDevicesBlock File devices callback block containing list of file devices
 **/
+ (void)getListOfFileDevices:(PPLocationId)locationId callback:(PPFileManagementFileDevicesBlock _Nonnull )callback;
+ (void)getListOfFileDevices:(PPFileManagementFileDevicesBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Get File Information

/**
 * Get File Information
 * For public files the API key header is optional.
 *
 * @param fileId Required PPFileId File ID of the file for which to retrieve information
 * @param isPublic PPFilePublicAccess True - Do not provide authorization token in header
 * @param locationId Required PPLocationId File location ID
 * @param callback PPFileManagementFileInformationBlock File information callback block containing file reference, temp key, and temp key expiration date
 **/
+ (void)getFileInformation:(PPFileId)fileId isPublic:(PPFilePublicAccess)isPublic locationId:(PPLocationId)locationId callback:(PPFileManagementFileInformationBlock _Nonnull )callback;
+ (void)getFileInformation:(PPFileId)fileId isPublic:(PPFilePublicAccess)isPublic callback:(PPFileManagementFileInformationBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - File Tags

/**
 * Apply tag.
 * Tags are a way to categorize sets of files. Tags can be generated automatically from Composer apps, or manually by the user.
 * Users can only see file tags but not other tags. File tags would be used to help them as they search for one of their private files.
 *
 * @param fileId Required PPFileId File ID
 * @param tag Required NSString Tag value
 * @param locationId Required PPLocationId LocationId
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)applyTag:(PPFileId)fileId tag:(NSString * _Nonnull )tag locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;
+ (void)applyTag:(PPFileId)fileId tag:(NSString * _Nonnull )tag callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delet tag.
 *
 * @param fileId Required PPFileId File ID
 * @param tag Required NSString Tag value
 * @param locationId Required PPLocationId LocationId
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteTag:(PPFileId)fileId tag:(NSString * _Nonnull )tag locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteTag:(PPFileId)fileId tag:(NSString * _Nonnull )tag callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Report Abuse

/**
 * Report Abuse
 * The API Key should only be used if a user is logged in and reporting abuse, and helps support / administrators understand and communicate with the person who is reporting the complaint. If the user is not logged into the system and is instead browsing publicly, then you do not have to include an API key in the header.
 *
 * @param fileId Required PPFileId File ID to report
 * @param reportType Required NSString Type of report. This is typically "abuse", but may be changed to trigger a different type of email template to support /administrators.
 * @param isPublic PPFilePublicAccess True - Do not provide authorization token in header
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)reportAbuse:(PPFileId)fileId reportType:(NSString * _Nonnull )reportType isPublic:(PPFilePublicAccess)isPublic callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Amazon S3

/**
 * Upload a file directly to Amazon S3
 * contentUrl and uploadHeaders returned from uploadNewFile:deviceId:fileExtension:expectedSize:duration:rotate:fileId:thumbnail:incomplete:type:contentType:authorizationType:token:sessionId:data:uploadUrl:callback: when uploadUrl=true
 *
 * @param type Required PPFileFileType Type of file
 * @param contentType Required NSString File content type
 * @param data Required NSData Content data
 * @param contentUrl Required NSString Content url to upload file to
 * @param uploadHeaders Required NSDictionary Headers to include in request
 * @param progressBlock PPFileManagementProgressBlock File upload progress block
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadS3File:(PPFileFileType)type contentType:(NSString *)contentType data:(NSData *)data contentUrl:(NSString *)contentUrl uploadHeaders:(NSDictionary *)uploadHeaders progressBlock:(PPFileManagementProgressBlock)progressBlock callback:(PPErrorBlock)callback;
+ (void)uploadS3File:(PPFile * _Nonnull )file contentUrl:(NSString * _Nonnull )contentUrl uploadHeaders:(NSDictionary * _Nonnull )uploadHeaders progressBlock:(PPFileManagementProgressBlock)progressBlock callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Helper methods

/**
 * File thumbnail URL.
 * Helper method for getting a file's thumbnail URL
 *
 * @param file Required PPFile File to get a thumbnail for
 * @param tempKey NSString Optional temporary API key.
 *
 * @return NSURL File thumnnail url.
 **/
+ (NSURL * _Nonnull )fileThumbnailURL:(PPFile * _Nonnull )file tempKey:(NSString * _Nullable )tempKey;

@end
