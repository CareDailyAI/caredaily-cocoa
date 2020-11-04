//
//  PPApplicationFileManagement.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPApplicationFile.h"

@interface PPApplicationFileManagement : PPBaseModel

#pragma mark - Session Management

/**
 * Shared applicationFiles across the entire application
 */
+ (NSArray *)sharedApplicationFilesForUser:(PPUserId)userId;


/**
 * Add application files.
 * Add application files to local reference.
 *
 * @param applicationFiles NSArray Array of applicationFiles to add.
 * @param userId Required PPUserId User Id to associate these applicationFiles with
 **/
+ (void)addApplicationFiles:(NSArray *)applicationFiles userId:(PPUserId)userId;

/**
 * Remove applicationFiles.
 * Remove applicationFiles from local reference.
 *
 * @param applicationFiles NSArray Array of applicationFiles to remove.
 * @param userId Required PPNotificationsUserId User Id to associate these applicationFiles with
 **/
+ (void)removeApplicationFiles:(NSArray *)applicationFiles userId:(PPUserId)userId;

#pragma mark Files Management

/**
 * Upload File Content.
 * The "Content-Type" header must be like "image/...", "video/...", "audio/..." or "application/octet-stream"
 * For example: image/jpeg, video/mp4, audio/mp3.
 *
 * @param fileId PPApplicationFileId Existing file ID to replace the content and properties
 * @param type Requried PPApplicationFileFileType File type
 * @param userId PPUserId User ID associated with this file. It can be used by organization administrators to upload files on other user acccount.s
 * @param locationId PPLocationId Location ID associated with this file
 * @param deviceId NSString Device ID associated with this file
 * @param name NSString File name
 * @param publicAccess PPApplicationFilePublicAccess Publicly available file
 * @param contentType Required NSString Content-Type header.
 * @param data Required NSData File data
 * @param progressBlock PPApplicationFileManagementProgressBlock File upload progress block
 * @param callback PPApplicationFileManagementUploadFileBlock Upload file callback block containing file id
 **/
+ (void)uploadFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name publicAccess:(PPApplicationFilePublicAccess)publicAccess contentType:(NSString *)contentType data:(NSData *)data progressBlock:(PPApplicationFileManagementProgressBlock)progressBlock callback:(PPApplicationFileManagementUploadFileBlock)callback;
+ (void)uploadFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name publicAccess:(PPApplicationFilePublicAccess)publicAccess contentType:(NSString *)contentType data:(NSData *)data callback:(PPApplicationFileManagementUploadFileBlock)callback __attribute__((deprecated));

/**
 * Get Files.
 * Return a list of the user's files filtered by query parameters.
 *
 * @param fileId PPApplicationFileId File ID Filter
 * @param type PPApplicationFileFileType File type
 * @param userId PPUserId User ID associated with this file. It can be used by organization administrators to upload files on other user acccount.s
 * @param locationId PPLocationId Location ID associated with this file
 * @param deviceId NSString Device ID associated with this file
 * @param name NSString File name
 * @param isPublic PPApplicationFilePublicAccess True - Do not include api key in authorization header
 * @param callback PPApplicationFileManagementFilesBlock Files callback containing list of files, along with temp key and temp key expiry
 **/
+ (void)getFiles:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name isPublic:(PPApplicationFilePublicAccess)isPublic callback:(PPApplicationFileManagementFilesBlock)callback;

#pragma mark - Single File Management

/**
 * Download File.
 * The Range HTTP Header is optional, and will only return a chunk of the total content.
 * A temporary API key provided in the query parameter may be used to forward a link to other part of the app. A temporary API key can be obtained by calling the loginByKey API. It is expired soon after receiving.
 * The response will include:
 *      - The file content
 *      - A Content-Type HTTP Header containing the file's content type
 * HTTP Status Codes:
 *      - 200 (OK): The file content is returned in full.
 *      - 401 (Unauthorized): The API key is wrong.
 *      - 404 (Not Found): The file does not exists.
 *      - 500 (Internal error): Something went wrong on the server side.
 *
 * @param fileId Required PPApplicationFileId File ID to download
 * @param apiKey NSString Temporary API key
 * @param userId PPUserId User ID to download file as administrator.
 * @param locationId PPLocationId Location ID to download file as administrator.
 * @param isPublic PPApplicationFilePublicAccess True - Do not include api key in authorization header
 * @param attach PPApplicationFileAttach Download the file content as an attachments with the Content-Disposition header
 * @param range NSRange Range of bytes to download
 * @param callback PPApplicationFileManagementContentBlock File content block
 **/
+ (void)downloadFile:(PPApplicationFileId)fileId apiKey:(NSString *)apiKey userId:(PPUserId)userId locationId:(PPLocationId)locationId isPublic:(PPApplicationFilePublicAccess)isPublic attach:(PPApplicationFileAttach)attach range:(NSRange)range callback:(PPApplicationFileManagementContentBlock)callback;

/**
 * Delete a File.
 *
 * @param fileId Required PPApplicationFileId File ID to delete
 * @param userId PPUserId User ID to delete file as administrator.
 * @param locationId PPLocationId Location ID to delete file as administrator.
 * @param callback PPErrorBlock callback
 **/
+ (void)deleteFile:(PPApplicationFileId)fileId apiKey:(NSString *)apiKey userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback;

@end
