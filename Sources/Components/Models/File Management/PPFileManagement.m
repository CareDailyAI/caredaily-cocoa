//
//  PPFileManagement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPFileManagement.h"
#import "PPCloudEngine.h"
#import "PPCurlDebug.h"

@implementation PPFileManagement

#pragma mark - Session Management

#pragma mark - Notification Files

__strong static NSMutableDictionary*_sharedFiles = nil;

/**
 * Shared files across the entire application
 */
+ (NSArray *)sharedFilesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedFiles) {
        [PPFileManagement initializeSharedFiles];
    }
    NSMutableArray *sharedFiles = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *filesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedFiles.allKeys) {
        for(PPFile *file in [_sharedFiles objectForKey:userIdKey]) {
            NSMutableDictionary *fileIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [fileIdentifiers setValue:@(file.fileId) forKey:@"ID"];
            if(file.name) {
                [fileIdentifiers setValue:file.name forKey:@"name"];
            }
            [filesArray addObject:fileIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedFiles addObject:file];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFiles=%@", __PRETTY_FUNCTION__, filesArray);
#endif
#endif
    return sharedFiles;
}

+ (void)initializeSharedFiles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedFiles = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedFilesData = [defaults objectForKey:@"user.notificationFiles"];
//    if(storedFilesData) {
//        _sharedFiles = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedFilesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add files.
 * Add files from local reference.
 *
 * @param files NSArray Array of files to remove.
 * @param userId Required PPUserId User Id to associate these files with
 **/
+ (void)addFiles:(NSArray *)files userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s files=%@", __PRETTY_FUNCTION__, files);
#endif
#endif
    if(!_sharedFiles) {
        [PPFileManagement initializeSharedFiles];
    }
    
    NSMutableArray *filesArray = [_sharedFiles objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!filesArray) {
        filesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPFile *file in files) {
        
        BOOL found = NO;
        for(PPFile *sharedFile in filesArray) {
            if([sharedFile isEqualToFile:file]) {
                [sharedFile sync:file];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[files indexOfObject:file]];
        }
    }
    
    [filesArray addObjectsFromArray:[files objectsAtIndexes:indexSet]];
    [_sharedFiles setObject:filesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedFileData = [NSKeyedArchiver archivedDataWithRootObject:_sharedFiles];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedFileData forKey:@"user.notificationFiles"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s filesArray=%@", __PRETTY_FUNCTION__, filesArray);
#endif
#endif
}

/**
 * Remove files.
 * Remove files from local reference.
 *
 * @param files NSArray Array of files to remove.
 * @param userId Required PPUserId User Id to associate these files with
 **/
+ (void)removeFiles:(NSArray *)files userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s files=%@", __PRETTY_FUNCTION__, files);
#endif
#endif
    
    if(!_sharedFiles) {
        [PPFileManagement initializeSharedFiles];
    }
    
    NSMutableArray *filesArray = [_sharedFiles objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!filesArray) {
        filesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPFile *file in files) {
        for(PPFile *sharedFile in filesArray) {
            if([sharedFile isEqualToFile:file]) {
                [indexSet addIndex:[filesArray indexOfObject:sharedFile]];
                break;
            }
        }
    }
    
    [filesArray removeObjectsAtIndexes:indexSet];
    [_sharedFiles setObject:filesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
}

#pragma mark Summaries

/**
 * Shared file summaries across the entire application
 *
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedFileSummariesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    NSArray *sharedFileSummaries = @[];
    
    NSMutableArray *sharedFileSummariesArray = [[NSMutableArray alloc] initWithCapacity:[sharedFileSummaries count]];
    NSMutableArray *fileSummariesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPFileSummary *fileSummary in sharedFileSummaries) {
        [sharedFileSummariesArray addObject:fileSummary];
        
        [fileSummariesArrayDebug addObject:@{@"date": fileSummary.date}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFileSummaries=%@", __PRETTY_FUNCTION__, fileSummariesArrayDebug);
#endif
#endif
    return sharedFileSummariesArray;
}

/**
 * Add file summaries.
 * Add file summaries to local reference.
 *
 * @param fileSummaries NSArray Array of file summaries to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addFileSummaries:(NSArray *)fileSummaries userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s fileSummaries=%@", __PRETTY_FUNCTION__, fileSummaries);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove file summaries.
 * Remove file summaries from local reference.
 *
 * @param fileSummaries NSArray Array of file summaries to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeFilesSummaries:(NSArray *)fileSummaries userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s fileSummaries=%@", __PRETTY_FUNCTION__, fileSummaries);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

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
 * @param data Required NSData File data
 * @param progressBlock PPFileManagementProgressBlock File upload progress block
 * @param callback PPFileManagementFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, twitter account (if any), storage policy, and uploadHeaders
 **/
+ (void)uploadNewFile:(NSString *)proxyId deviceId:(NSString *)deviceId fileExtension:(NSString *)fileExtension expectedSize:(PPFileSize)expectedSize duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate fileId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete type:(PPFileFileType)type contentType:(NSString *)contentType authorizationType:(PPFileManagementAuthorizationType)authorizationType token:(NSString *)token sessionId:(NSString *)sessionId data:(NSData *)data uploadUrl:(PPFileUploadUrl)uploadUrl progressBlock:(PPFileManagementProgressBlock)progressBlock callback:(PPFileManagementFragmentBlock)callback {
    NSAssert1(proxyId != nil, @"%s missing proxyId", __FUNCTION__);
    NSAssert1(fileExtension != nil, @"%s missing fileExtension", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(authorizationType != PPFileManagementAuthorizationTypeNone, @"%s missing authorizationType", __FUNCTION__);
    if(authorizationType == PPFileManagementAuthorizationTypeDeviceAuthenticationToken) {
        NSAssert1(token != nil, @"%s missing token", __FUNCTION__);
    }
    if(authorizationType == PPFileManagementAuthorizationTypeStreamingSessionId) {
        NSAssert1(sessionId != nil, @"%s missing sessionId", __FUNCTION__);
    }
    if(uploadUrl == PPFileUploadUrlTrue) {
        NSAssert1(data != nil, @"%s missing data", __FUNCTION__);
    }
    
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files?proxyId=%@&ext=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:proxyId], fileExtension];
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    if(expectedSize != PPFileSizeNone) {
        [requestString appendFormat:@"expectedSize=%lli&", expectedSize];
    }
    if(duration != PPFileDurationNone) {
        [requestString appendFormat:@"duration=%li&", (long)duration];
    }
    if(rotate != PPFileRotateNone) {
        [requestString appendFormat:@"rotate=%li&", (long)rotate];
    }
    if(fileId != PPFileIdNone) {
        [requestString appendFormat:@"fileId=%li&", (long)fileId];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(incomplete != PPFileIncompleteNone) {
        [requestString appendFormat:@"incomplete=%@&", (incomplete) ? @"true" : @"false"];
    }
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(uploadUrl != PPFileUploadUrlNone) {
        [requestString appendFormat:@"uploadUrl=%@&", (uploadUrl) ? @"true" : @"false"];
    }
    
    NSError *error;
    PPCloudEngine *cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(authorizationType == PPFileManagementAuthorizationTypeDeviceAuthenticationToken) {
        [request setValue:[NSString stringWithFormat:@"esp token=%@", token] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    else {
        [request setValue:[NSString stringWithFormat:@"stream session=%@", sessionId] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    [request setValue:nil forHTTPHeaderField:HTTP_HEADER_API_KEY];
    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    if(uploadUrl != PPFileUploadUrlTrue) {
        [request setHTTPBody:data];
        [request setValue:[NSString stringWithFormat:@"%li", (long)data.length] forHTTPHeaderField:HTTP_HEADER_CONTENT_LENGTH];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.uploadNewFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request progressBlock:^(NSProgress *progress) {
        
        dispatch_async(queue, ^{
        
            PPLogAPI(@"> %s %@", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), progress);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(progressBlock) {
                    progressBlock(progress);
                }
            });
        });
        
    } success:^(NSData *responseData, NSObject *response) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *status;
            PPFile *file;
            PPFileTotalFileSpace totalFilesSpace = PPFileTotalFileSpaceNone;
            PPFileUsedFileSpace usedFilesSpace = PPFileUsedFileSpaceNone;
            PPFileTwitterShare twitterShare = PPFileTwitterShareNone;
            NSString *twitterAccount;
            NSString *contentUrl;
            PPFileStoragePolicy storagePolicy = PPFileStoragePolicyNone;
            NSDictionary *uploadHeaders;
            
            if(!error) {
                status = [root objectForKey:@"status"];
                file = [PPFile initWithDictionary:root];
                if([root objectForKey:@"totalFilesSpace"]) {
                    totalFilesSpace = (PPFileTotalFileSpace)((NSString *)[root objectForKey:@"totalFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"usedFilesSpace"]) {
                    usedFilesSpace = (PPFileUsedFileSpace)((NSString *)[root objectForKey:@"usedFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"twitterShare"]) {
                    twitterShare = (PPFileTwitterShare)((NSString *)[root objectForKey:@"twitterShare"]).integerValue;
                }
                twitterAccount = [root objectForKey:@"twitterAccount"];
                contentUrl = [root objectForKey:@"contentUrl"];
                if([root objectForKey:@"storagePolicy"]) {
                    storagePolicy = (PPFileStoragePolicy)((NSString *)[root objectForKey:@"storagePolicy"]).integerValue;
                }
                if([root objectForKey:@"uploadHeaders"]) {
                    uploadHeaders = [root objectForKey:@"uploadHeaders"];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(status, file, totalFilesSpace, usedFilesSpace, twitterShare, twitterAccount, contentUrl, storagePolicy, uploadHeaders, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, PPFileTotalFileSpaceNone, PPFileUsedFileSpaceNone, PPFileTwitterShareNone, nil, nil, PPFileStoragePolicyNone, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)getFiles:(PPLocationId)locationId type:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId deviceId:(NSString *)deviceId deviceDesc:(NSString *)deviceDesc startDate:(NSDate *)startDate endDate:(NSDate *)endDate searchTag:(NSString *)searchTag callback:(PPFileManagementFilesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(owners != PPFileOwnersNone) {
        [requestString appendFormat:@"owners=%li&", (long)owners];
    }
    if(ownerId != PPUserIdNone) {
        [requestString appendFormat:@"ownerId=%li&", (long)ownerId];
    }
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    if(deviceDesc) {
        [requestString appendFormat:@"deviceDesc=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceDesc]];
    }
    if(startDate) {
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    if(searchTag) {
        [requestString appendFormat:@"searchTag=%@&", searchTag];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *files;
            PPFileTotalFileSpace totalFilesSpace = PPFileTotalFileSpaceNone;
            PPFileUsedFileSpace usedFilesSpace = PPFileUsedFileSpaceNone;
            NSString *tempKey;
            NSDate *tempKeyExpire;
            
            if(!error) {
                files = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileDict in [root objectForKey:@"files"]) {
                    PPFile *file = [PPFile initWithDictionary:fileDict];
                    [files addObject:file];
                }
                if([root objectForKey:@"totalFilesSpace"]) {
                    totalFilesSpace = (PPFileTotalFileSpace)((NSString *)[root objectForKey:@"totalFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"usedFilesSpace"]) {
                    usedFilesSpace = (PPFileUsedFileSpace)((NSString *)[root objectForKey:@"usedFilesSpace"]).integerValue;
                }
                tempKey = [root objectForKey:@"tempKey"];
            
                NSString *tempKeyExpireString = [root objectForKey:@"tempKeyExpire"];
            
                if(tempKeyExpireString != nil) {
                    if(![tempKeyExpireString isEqualToString:@""]) {
                        tempKeyExpire = [PPNSDate parseDateTime:tempKeyExpireString];
                    }
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(files, totalFilesSpace, usedFilesSpace, tempKey, tempKeyExpire, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, PPFileTotalFileSpaceNone, PPFileUsedFileSpaceNone, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getFiles:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId deviceId:(NSString *)deviceId deviceDesc:(NSString *)deviceDesc startDate:(NSDate *)startDate endDate:(NSDate *)endDate searchTag:(NSString *)searchTag callback:(PPFileManagementFilesBlock)callback {
    NSLog(@"%s deprecated. Use +getFiles:type:owners:ownerId:deviceId:deviceId:deviceDesc:startDate:endDate:searchTags:callback:", __FUNCTION__);
    [PPFileManagement getFiles:PPLocationIdNone type:type owners:owners ownerId:ownerId deviceId:deviceId deviceDesc:deviceDesc startDate:startDate endDate:endDate searchTag:searchTag callback:callback];
}

/**
 * Delete all files
 * This action will delete all files that are not marked as favorite.
 *
 * @param locationId Required PPLocationId Files location ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteAllFiles:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.deleteAllFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteAllFiles:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deletaAllFiles:callback:", __FUNCTION__);
    [PPFileManagement deleteAllFiles:PPLocationIdNone callback:callback];
}

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
+ (void)getLastNFiles:(PPFileCount)count startDate:(NSDate *)startDate endDate:(NSDate *)endDate type:(PPFileFileType)type deviceId:(NSString *)deviceId deviceDescription:(NSString *)deviceDescription callback:(PPFileManagementLastNFilesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"filesByCount/%li?", (long)count];
    
    if(startDate) {
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    
    if(deviceDescription) {
        [requestString appendFormat:@"deviceDescription=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceDescription]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getLastNFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *files;
            NSString *tempKey;
            NSDate *tempKeyExpire;
            
            if(!error) {
                files = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileDict in [root objectForKey:@"files"]) {
                    PPFile *file = [PPFile initWithDictionary:fileDict];
                    [files addObject:file];
                }
                tempKey = [root objectForKey:@"tempKey"];
            
                NSString *tempKeyExpireString = [root objectForKey:@"tempKeyExpire"];
                tempKeyExpire = [NSDate date];
            
                if(tempKeyExpireString != nil) {
                    if(![tempKeyExpireString isEqualToString:@""]) {
                        tempKeyExpire = [PPNSDate parseDateTime:tempKeyExpireString];
                    }
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(files, tempKey, tempKeyExpire, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)uploadFileFragment:(PPFileId)fileId proxyId:(NSString *)proxyId fileExtension:(NSString *)fileExtension thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)index contentType:(NSString *)contentType authorizationType:(PPFileManagementAuthorizationType)authorizationType token:(NSString *)token sessionId:(NSString *)sessionId data:(NSData *)data callback:(PPFileManagementFragmentBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(proxyId != nil, @"%s missing proxyId", __FUNCTION__);
    NSAssert1(fileExtension != nil, @"%s missing fileExtension", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(authorizationType != PPFileManagementAuthorizationTypeNone, @"%s missing authorizationType", __FUNCTION__);
    if(authorizationType == PPFileManagementAuthorizationTypeDeviceAuthenticationToken) {
        NSAssert1(token != nil, @"%s missing token", __FUNCTION__);
    }
    if(authorizationType == PPFileManagementAuthorizationTypeStreamingSessionId) {
        NSAssert1(sessionId != nil, @"%s missing sessionId", __FUNCTION__);
    }
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li?proxyId=%@&ext=%@&", (long)fileId, proxyId, fileExtension];
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(incomplete != PPFileIncompleteNone) {
        [requestString appendFormat:@"incomplete=%@&", (incomplete) ? @"true" : @"false"];
    }
    if(index != PPFileFragmentIndexNone) {
        [requestString appendFormat:@"index=%li&", (long)index];
    }
    
    NSError *error;
    PPCloudEngine *cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(authorizationType == PPFileManagementAuthorizationTypeDeviceAuthenticationToken) {
        [request setValue:[NSString stringWithFormat:@"esp token=%@", token] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    else {
        [request setValue:[NSString stringWithFormat:@"stream session=%@", sessionId] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    [request setValue:nil forHTTPHeaderField:HTTP_HEADER_API_KEY];
    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%li", (long)data.length] forHTTPHeaderField:HTTP_HEADER_CONTENT_LENGTH];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.uploadFileFragment()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSString *status;
            PPFile *file;
            PPFileTotalFileSpace totalFilesSpace = PPFileTotalFileSpaceNone;
            PPFileUsedFileSpace usedFilesSpace = PPFileUsedFileSpaceNone;
            PPFileTwitterShare twitterShare = PPFileTwitterShareNone;
            NSString *twitterAccount;
            NSString *contentUrl;
            PPFileStoragePolicy storagePolicy = PPFileStoragePolicyNone;
            NSDictionary *uploadHeaders;
            
            if(!error) {
                status = [root objectForKey:@"status"];
                file = [PPFile initWithDictionary:root];
                if([root objectForKey:@"totalFilesSpace"]) {
                    totalFilesSpace = (PPFileTotalFileSpace)((NSString *)[root objectForKey:@"totalFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"usedFilesSpace"]) {
                    usedFilesSpace = (PPFileUsedFileSpace)((NSString *)[root objectForKey:@"usedFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"twitterShare"]) {
                    twitterShare = (PPFileTwitterShare)((NSString *)[root objectForKey:@"twitterShare"]).integerValue;
                }
                twitterAccount = [root objectForKey:@"twitterAccount"];
                contentUrl = [root objectForKey:@"contentUrl"];
                if([root objectForKey:@"storagePolicy"]) {
                    storagePolicy = (PPFileStoragePolicy)((NSString *)[root objectForKey:@"storagePolicy"]).integerValue;
                }
                if([root objectForKey:@"uploadHeaders"]) {
                    uploadHeaders = [root objectForKey:@"uploadHeaders"];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(status, file, totalFilesSpace, usedFilesSpace, twitterShare, twitterAccount, contentUrl, storagePolicy, uploadHeaders, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, PPFileTotalFileSpaceNone, PPFileUsedFileSpaceNone, PPFileTwitterShareNone, nil, nil, PPFileStoragePolicyNone, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)downloadFile:(PPFileId)fileId apiKey:(NSString *)apiKey thumbnail:(PPFileThumbnail)thumbnail isPublic:(PPFilePublicAccess)isPublic attach:(PPFileAttach)attach range:(NSRange)range callback:(PPFileManagementContentBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li?", (long)fileId];
    
    if(apiKey) {
        [requestString appendFormat:@"API_KEY=%@&", apiKey];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(attach != PPFileAttachNone) {
        [requestString appendFormat:@"attach=%@&", (attach) ? @"true" : @"false"];
    }
    NSError *error;
    PPCloudEngine *cloudEngine;
    if(isPublic != PPFilePublicAccessTrue) {
        cloudEngine = [PPCloudEngine sharedAppEngine];
    }
    else {
        cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    }
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setValue:nil forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    if(range.location != 0 && range.length != 0) {
        [request setValue:[NSString stringWithFormat:@"bytes=%li-%li", (long)range.location, (long)range.length] forHTTPHeaderField:HTTP_HEADER_RANGE];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.downloadFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequestIncludingResponse:request success:^(NSData *responseData, NSObject *response) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSInteger statusCode = 0;
            NSDictionary *responseHeaders;
            
            NSString *contentType;
            NSString *contentRange;
            NSString *acceptRanges;
            NSString *contentDisposition;
            
            if(!error) {
                statusCode = ((NSHTTPURLResponse *)response).statusCode;
                responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
            
                contentType = [responseHeaders objectForKey:@"Content-Type"];
                contentRange = [responseHeaders objectForKey:@"Content-Range"];
                acceptRanges = [responseHeaders objectForKey:@"Accept-Ranges"];
                contentDisposition = [responseHeaders objectForKey:@"Content-Disposition"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(responseData, contentType, contentRange, acceptRanges, contentDisposition, statusCode, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, nil, nil, -1, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)getDownloadURL:(PPFileId)fileId locationId:(PPLocationId)locationId content:(PPFileContent)content thumbnail:(PPFileThumbnail)thumbnail expiration:(PPFileURLExpiration)expiration callback:(PPFileManagementDownloadURLBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li/url?locationId=%li", (long)fileId, (long)locationId];
    if(content != PPFileContentNone) {
        [requestString appendFormat:@"content=%@&", (content) ? @"true" : @"false"];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(expiration != PPFileURLExpirationNone) {
        [requestString appendFormat:@"expiration=%@&", (expiration) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getDownloadURL()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSURL *contentUrl;
            NSURL *thumbnailUrl;
            
            if(!error) {
                if([root objectForKey:@"contentUrl"]) {
                    contentUrl = [NSURL URLWithString:[root objectForKey:@"contentUrl"]];
                }
                if([root objectForKey:@"thumbnailUrl"]) {
                    thumbnailUrl = [NSURL URLWithString:[root objectForKey:@"thumbnailUrl"]];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(contentUrl, thumbnailUrl, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)updateFileAttribute:(PPFileId)fileId proxyId:(NSString *)proxyId incomplete:(PPFileIncomplete)incomplete recover:(PPFileRecover)recover userId:(PPUserId)userId viewed:(PPFileViewed)viewed favourite:(PPFileFavourite)favourite publicAccess:(PPFilePublicAccess)publicAccess callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li?", (long)fileId];
    if(proxyId) {
        [requestString appendFormat:@"proxyId=%@&", proxyId];
    }
    if(incomplete != PPFileIncompleteNone) {
        [requestString appendFormat:@"incomplete=%@&", (incomplete) ? @"true" : @"false"];
    }
    if(recover != PPFileRecoverNone) {
        [requestString appendFormat:@"recover=%@&", (recover) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }

    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    PPFile *file = [[PPFile alloc] initWithStatus:nil fileId:PPFileIdNone filesAction:PPFileFilesActionNone thumbnail:PPFileThumbnailNone fragments:PPFileFragmentsNone name:nil type:PPFileFileTypeNone publicAccess:publicAccess creationDate:nil size:PPFileSizeNone duration:PPFileDurationNone shared:PPFileSharedNone rotate:PPFileRotateNone device:nil user:nil viewCount:PPFileViewCountNone viewed:viewed favourite:favourite tags:nil data:nil];
    [JSONString appendFormat:@"\"file\": %@", [PPFile stringify:file]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.updateFileAttribute()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete a file
 *
 * @param fileId Required PPFileId File ID to delete
 * @param locationId Required PPLocationId File location ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteFile:(PPFileId)fileId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li?", (long)fileId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.deleteFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteFile:(PPFileId)fileId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteFile:locationId:callback:", __FUNCTION__);
    [PPFileManagement deleteFile:fileId locationId:PPLocationIdNone callback:callback];
}
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
 * @param callback PPFileManagementFilesSummaryBlock Files Summary callback block containing list of file summaries, total file space, used file space, start date, and end date
 **/
+ (void)getAggregatedListOfFiles:(PPFileSummaryAggregation)aggregation locationId:(PPLocationId)locationId details:(PPFileSummaryDetails)details timezone:(NSString *)timezone type:(PPFileFileType)type startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPFileManagementFilesSummaryBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(aggregation != PPFileSummaryAggregationNone, @"%s missing aggregation", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"filesSummary/%li?", (long)aggregation];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(timezone) {
        [requestString appendFormat:@"timezone=%@&", timezone];
    }
    if(details != PPFileSummaryDetailsNone) {
        [requestString appendFormat:@"details=%li&", (long)details];
    }
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(startDate) {
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getAggregatedListOfFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            
            NSMutableArray *fileSummaries;
            PPFileTotalFileSpace totalFilesSpace = PPFileTotalFileSpaceNone;
            PPFileUsedFileSpace usedFilesSpace = PPFileUsedFileSpaceNone;
            NSDate *responseStartDate;
            NSDate *responseEndDate;
            PPFileCount filesCount = PPFileCountNone;
            
            if(!error) {
            
                fileSummaries = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileSummaryDict in [root objectForKey:@"summaries"]) {
                    PPFileSummary *fileSummary = [PPFileSummary initWithDictionary:fileSummaryDict];
                    [fileSummaries addObject:fileSummary];
                }
                if([root objectForKey:@"totalFilesSpace"]) {
                    totalFilesSpace = (PPFileTotalFileSpace)((NSString *)[root objectForKey:@"totalFilesSpace"]).integerValue;
                }
                if([root objectForKey:@"usedFilesSpace"]) {
                    usedFilesSpace = (PPFileUsedFileSpace)((NSString *)[root objectForKey:@"usedFilesSpace"]).integerValue;
                }
            
                NSString *responseStartDateString = [root objectForKey:@"startDate"];
                responseStartDate = [NSDate date];
            
                if(responseStartDateString != nil) {
                    if(![responseStartDateString isEqualToString:@""]) {
                        responseStartDate = [PPNSDate parseDateTime:responseStartDateString];
                    }
                }
            
                NSString *responseEndDateString = [root objectForKey:@"endDate"];
                responseEndDate = [NSDate date];
            
                if(responseEndDateString != nil) {
                    if(![responseEndDateString isEqualToString:@""]) {
                        responseEndDate = [PPNSDate parseDateTime:responseEndDateString];
                    }
                }
                if([root objectForKey:@"filesCount"]) {
                    filesCount = (PPFileCount)((NSString *)[root objectForKey:@"filesCount"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(fileSummaries, totalFilesSpace, usedFilesSpace, responseStartDate, responseEndDate, filesCount, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, PPFileTotalFileSpaceNone, PPFileUsedFileSpaceNone, nil, nil, PPFileCountNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getAggregatedListOfFiles:(PPFileSummaryAggregation)aggregation details:(PPFileSummaryDetails)details timezone:(NSString *)timezone type:(PPFileFileType)type owners:(PPFileOwners)owners ownerId:(PPUserId)ownerId startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPFileManagementFilesSummaryBlock)callback {
    NSLog(@"%s deprecated. Use +getAggregatedListOfFiles:locationId:details:timezone:type:startDate:endDate:callback:", __FUNCTION__);
    [PPFileManagement getAggregatedListOfFiles:aggregation locationId:PPLocationIdNone details:details timezone:timezone type:type startDate:startDate endDate:endDate callback:callback];
}

#pragma mark - File devices

/**
 * Get list of file devices
 * Return all combinations of device ID's and device descriptions from existing user files.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPFileManagementFileDevicesBlock File devices callback block containing list of file devices
 **/
+ (void)getListOfFileDevices:(PPLocationId)locationId callback:(PPFileManagementFileDevicesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"fileDevices?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getListOfFileDevices()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *fileDevices;
            
            if(!error) {
                fileDevices = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *deviceDict in [root objectForKey:@"devices"]) {
                    PPDevice *device = [PPDevice initWithDictionary:deviceDict];
                    [fileDevices addObject:device];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(fileDevices, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getListOfFileDevices:(PPFileManagementFileDevicesBlock)callback {
    NSLog(@"%s deprecated. Use +getListOfFiles:callback:", __FUNCTION__);
    [PPFileManagement getListOfFileDevices:PPLocationIdNone callback:callback];
}

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
+ (void)getFileInformation:(PPFileId)fileId isPublic:(PPFilePublicAccess)isPublic locationId:(PPLocationId)locationId callback:(PPFileManagementFileInformationBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"filesInfo/%li?", (long)fileId];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    
    NSError *error;
    PPCloudEngine *cloudEngine;
    if(isPublic != PPFilePublicAccessTrue) {
        cloudEngine = [PPCloudEngine sharedAppEngine];
    }
    else {
        cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    }
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.getFileInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPFile *file;
            NSString *tempKey;
            NSDate *tempKeyExpire;
            
            if(!error) {
                file = [PPFile initWithDictionary:[root objectForKey:@"file"]];
                tempKey = [root objectForKey:@"tempKey"];
            
                NSString *tempKeyExpireString = [root objectForKey:@"tempKeyExpire"];
                tempKeyExpire = [NSDate date];
                
                if(tempKeyExpireString != nil) {
                    if(![tempKeyExpireString isEqualToString:@""]) {
                        tempKeyExpire = [PPNSDate parseDateTime:tempKeyExpireString];
                    }
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(file, tempKey, tempKeyExpire, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getFileInformation:(PPFileId)fileId isPublic:(PPFilePublicAccess)isPublic callback:(PPFileManagementFileInformationBlock)callback {
    NSLog(@"%s deprecated. Use +getFileInformation:isPublic:locationId:callback:", __FUNCTION__);
    [PPFileManagement getFileInformation:fileId isPublic:isPublic locationId:PPLocationIdNone callback:callback];
}

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
+ (void)applyTag:(PPFileId)fileId tag:(NSString *)tag locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(tag != nil, @"%s missing tag", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li/tags/%@?", (long)fileId, tag];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.applyTag()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)applyTag:(PPFileId)fileId tag:(NSString *)tag callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +applyTag:tag:locationId:callback:", __FUNCTION__);
    [PPFileManagement applyTag:fileId tag:tag locationId:PPLocationIdNone callback:callback];
}

/**
 * Delet tag.
 *
 * @param fileId Required PPFileId File ID
 * @param tag Required NSString Tag value
 * @param locationId Required PPLocationId LocationId
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteTag:(PPFileId)fileId tag:(NSString *)tag locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(tag != nil, @"%s missing tag", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"files/%li/tags/%@?", (long)fileId, tag];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.deleteTag()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteTag:(PPFileId)fileId tag:(NSString *)tag callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +deleteFile:tag:locationId:callback:", __FUNCTION__);
    [PPFileManagement deleteTag:fileId tag:tag locationId:PPLocationIdNone callback:callback];
}

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
+ (void)reportAbuse:(PPFileId)fileId reportType:(NSString *)reportType isPublic:(PPFilePublicAccess)isPublic callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(reportType != nil, @"%s missing reportType", __FUNCTION__);
    NSString *requestString = [NSString stringWithFormat:@"files/%li/report/%@?", (long)fileId, reportType];
    
    NSError *error;
    PPCloudEngine *cloudEngine;
    if(isPublic != PPFilePublicAccessTrue) {
        cloudEngine = [PPCloudEngine sharedAppEngine];
    }
    else {
        cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    }
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.reportAbuse()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)uploadS3File:(PPFileFileType)type contentType:(NSString *)contentType data:(NSData *)data contentUrl:(NSString *)contentUrl uploadHeaders:(NSDictionary *)uploadHeaders progressBlock:(PPFileManagementProgressBlock)progressBlock callback:(PPErrorBlock)callback {
    NSAssert1(type != PPFileFileTypeNone, @"%s missing file type", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing conteType", __FUNCTION__);
    NSAssert1(data != nil, @"%s missing data", __FUNCTION__);
    NSAssert1(contentUrl != nil, @"%s missing contentUrl", __FUNCTION__);
    NSAssert1(uploadHeaders != nil, @"%s missing uploadHeaders", __FUNCTION__);
    NSError *error;
    PPCloudEngine *cloudEngine = [[PPCloudEngine alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:contentUrl].absoluteString parameters:nil error:&error];
    for(NSString *key in uploadHeaders) {
        [request setValue:[uploadHeaders valueForKey:key] forHTTPHeaderField:key];
    }
    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%li", (long)data.length] forHTTPHeaderField:HTTP_HEADER_CONTENT_LENGTH];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.filemanagement.uploadS3File()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request progressBlock:^(NSProgress *progress) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"> %s %@", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), progress);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(progressBlock) {
                    progressBlock(progress);
                }
            });
        });
        
    } success:^(NSData *responseData, NSObject *response) {
        
        dispatch_async(queue, ^{
#warning Need to include error handling
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}
+ (void)uploadS3File:(PPFile *)file contentUrl:(NSString *)contentUrl uploadHeaders:(NSDictionary *)uploadHeaders progressBlock:(PPFileManagementProgressBlock)progressBlock callback:(PPErrorBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +uploadS3File:contentType:data:contentUrl:uploadHeaders:progressBlock:callback:", __FUNCTION__);
    NSString *contentType = @"image/jpeg";
    switch (file.type) {
        case PPFileFileTypeVideo:
            contentType = @"video/mp4";
            break;
        case PPFileFileTypeImage:
            contentType = @"image/jpeg";
            break;
        case PPFileFileTypeAudio:
            contentType = @"audio/mp4";
            break;
        default:
            break;
    }
    [PPFileManagement uploadS3File:file.type contentType:contentType data:file.data contentUrl:contentUrl uploadHeaders:uploadHeaders progressBlock:progressBlock callback:callback];
}

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
+ (NSURL *)fileThumbnailURL:(PPFile *)file tempKey:(NSString *)tempKey {
    NSAssert1(file != nil, @"%s missing file", __FUNCTION__);
    NSMutableString *URLString = [[NSMutableString alloc] initWithFormat:@"%@", [[PPCloudEngine sharedAppEngine] getBaseURL]];
    
    if(tempKey) {
        [URLString appendFormat:@"files/%@/%ld?thumbnail=true", tempKey, (long)file.fileId];
    }
    else {
        [URLString appendFormat:@"files/%ld?thumbnail=true", (long)file.fileId];
    }
    return [NSURL URLWithString:URLString];
}

@end

