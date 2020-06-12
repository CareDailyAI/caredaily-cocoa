//
//  PPApplicationFileManagement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// The IoT Software Suite allows to store application specific binary files associated with users, locations or devices. For example, apps can store user images (avatars), location plans, device installation pictures.
// Files may be named. Also they are distinguished by types.
//

#import "PPApplicationFileManagement.h"
#import "PPCloudEngine.h"
#import "PPCurlDebug.h"

@implementation PPApplicationFileManagement


#pragma mark - Session Management

#pragma mark - Notification ApplicationFiles

__strong static NSMutableDictionary*_sharedApplicationFiles = nil;

/**
 * Shared applicationFiles across the entire application
 */
+ (NSArray *)sharedApplicationFilesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedApplicationFiles) {
        [PPApplicationFileManagement initializeSharedApplicationFiles];
    }
    NSMutableArray *sharedApplicationFiles = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *applicationFilesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedApplicationFiles.allKeys) {
        for(PPApplicationFile *applicationFile in [_sharedApplicationFiles objectForKey:userIdKey]) {
            NSMutableDictionary *applicationFileIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [applicationFileIdentifiers setValue:@(applicationFile.fileId) forKey:@"type"];
            if(applicationFile.name) {
                [applicationFileIdentifiers setValue:applicationFile.name forKey:@"name"];
            }
            [applicationFilesArray addObject:applicationFileIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedApplicationFiles addObject:applicationFile];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedApplicationFiles=%@", __PRETTY_FUNCTION__, applicationFilesArray);
#endif
#endif
    return sharedApplicationFiles;
}

+ (void)initializeSharedApplicationFiles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedApplicationFiles = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedApplicationFilesData = [defaults objectForKey:@"user.notificationApplicationFiles"];
//    if(storedApplicationFilesData) {
//        _sharedApplicationFiles = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedApplicationFilesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add applicationFiles.
 * Add applicationFiles from local reference.
 *
 * @param applicationFiles NSArray Array of applicationFiles to remove.
 * @param userId Required PPUserId User Id to associate these applicationFiles with
 **/
+ (void)addApplicationFiles:(NSArray *)applicationFiles userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s applicationFiles=%@", __PRETTY_FUNCTION__, applicationFiles);
#endif
#endif
    if(!_sharedApplicationFiles) {
        [PPApplicationFileManagement initializeSharedApplicationFiles];
    }
    
    NSMutableArray *applicationFilesArray = [_sharedApplicationFiles objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!applicationFilesArray) {
        applicationFilesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPApplicationFile *applicationFile in applicationFiles) {
        
        BOOL found = NO;
        for(PPApplicationFile *sharedApplicationFile in applicationFilesArray) {
            if([sharedApplicationFile isEqualToFile:applicationFile]) {
                [sharedApplicationFile sync:applicationFile];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[applicationFiles indexOfObject:applicationFile]];
        }
    }
    
    [applicationFilesArray addObjectsFromArray:[applicationFiles objectsAtIndexes:indexSet]];
    [_sharedApplicationFiles setObject:applicationFilesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedApplicationFileData = [NSKeyedArchiver archivedDataWithRootObject:_sharedApplicationFiles];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedApplicationFileData forKey:@"user.notificationApplicationFiles"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s applicationFilesArray=%@", __PRETTY_FUNCTION__, applicationFilesArray);
#endif
#endif
}

/**
 * Remove applicationFiles.
 * Remove applicationFiles from local reference.
 *
 * @param applicationFiles NSArray Array of applicationFiles to remove.
 * @param userId Required PPUserId User Id to associate these applicationFiles with
 **/
+ (void)removeApplicationFiles:(NSArray *)applicationFiles userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s applicationFiles=%@", __PRETTY_FUNCTION__, applicationFiles);
#endif
#endif
    
    if(!_sharedApplicationFiles) {
        [PPApplicationFileManagement initializeSharedApplicationFiles];
    }
    
    NSMutableArray *applicationFilesArray = [_sharedApplicationFiles objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!applicationFilesArray) {
        applicationFilesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPApplicationFile *applicationFile in applicationFiles) {
        for(PPApplicationFile *sharedApplicationFile in applicationFilesArray) {
            if([sharedApplicationFile isEqualToFile:applicationFile]) {
                [indexSet addIndex:[applicationFilesArray indexOfObject:sharedApplicationFile]];
                break;
            }
        }
    }
    
    [applicationFilesArray removeObjectsAtIndexes:indexSet];
    [_sharedApplicationFiles setObject:applicationFilesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedApplicationFileData = [NSKeyedArchiver archivedDataWithRootObject:_sharedApplicationFiles];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedApplicationFileData forKey:@"user.notificationApplicationFiles"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s applicationFilesArray=%@", __PRETTY_FUNCTION__, applicationFilesArray);
#endif
#endif
}

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
+ (void)uploadFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name publicAccess:(PPApplicationFilePublicAccess)publicAccess contentType:(NSString *)contentType data:(NSData *)data progressBlock:(PPApplicationFileManagementProgressBlock)progressBlock callback:(PPApplicationFileManagementUploadFileBlock)callback {
    NSAssert1(type != PPApplicationFileFileTypeNone, @"%s missing type", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(data != nil, @"%s missing data", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"appfiles?type=%li&", (long)type];
    
    if(fileId != PPApplicationFileIdNone) {
        [requestString appendFormat:@"fileId=%li&", (long)fileId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    if(name) {
        [requestString appendFormat:@"name=%@&", name];
    }
    if(publicAccess != PPApplicationFilePublicAccessNone) {
        [requestString appendFormat:@"publicAccess=%@&", (publicAccess) ? @"true" : @"false"];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];

    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    [request setHTTPBody:data];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.applicationfilemanagement.uploadFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request progressBlock:^(NSProgress *progress) {
        
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
            
            PPApplicationFileId fileId = PPApplicationFileIdNone;
            if(!error) {
                fileId = PPApplicationFileIdNone;
                if([root objectForKey:@"fileId"]) {
                    fileId = (PPApplicationFileId)((NSString *)[root objectForKey:@"fileId"]).integerValue;
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(fileId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPApplicationFileIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)uploadFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name publicAccess:(PPApplicationFilePublicAccess)publicAccess contentType:(NSString *)contentType data:(NSData *)data callback:(PPApplicationFileManagementUploadFileBlock)callback {
    [PPApplicationFileManagement uploadFile:fileId type:type userId:userId locationId:locationId deviceId:deviceId name:name publicAccess:publicAccess contentType:contentType data:data progressBlock:nil callback:callback];
}

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
+ (void)getFiles:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId name:(NSString *)name isPublic:(PPApplicationFilePublicAccess)isPublic callback:(PPApplicationFileManagementFilesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"appfiles?"];
    
    
    if(fileId != PPApplicationFileIdNone) {
        [requestString appendFormat:@"fileId=%li&", (long)type];
    }
    if(type != PPApplicationFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(deviceId) {
        [requestString appendFormat:@"deviceId=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    }
    
    PPCloudEngine *cloudEngine;
    if(isPublic != PPApplicationFilePublicAccessTrue) {
        cloudEngine = [PPCloudEngine sharedAppEngine];
    }
    else {
        cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.applicationfilemanagement.getFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *files;
            NSString *tempKey;
            NSDate *tempKeyExpire;
            
            if(!error) {
                files = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileDict in [root objectForKey:@"files"]) {
                    PPApplicationFile *file = [PPApplicationFile initWithDictionary:fileDict];
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
+ (void)downloadFile:(PPApplicationFileId)fileId apiKey:(NSString *)apiKey userId:(PPUserId)userId locationId:(PPLocationId)locationId isPublic:(PPApplicationFilePublicAccess)isPublic attach:(PPApplicationFileAttach)attach range:(NSRange)range callback:(PPApplicationFileManagementContentBlock)callback {
    NSAssert1(fileId != PPApplicationFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"appfiles/%li?", (long)fileId];
    
    if(apiKey) {
        [requestString appendFormat:@"API_KEY=%@&", apiKey];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(attach != PPApplicationFileAttachNone) {
        [requestString appendFormat:@"attach=%@&", (attach) ? @"true" : @"false"];
    }
    NSError *error;
    PPCloudEngine *cloudEngine;
    if(isPublic != PPApplicationFilePublicAccessTrue) {
        cloudEngine = [PPCloudEngine sharedAppEngine];
    }
    else {
        cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    }
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(range.location != 0 && range.length != 0) {
        [request setValue:[NSString stringWithFormat:@"bytes=%li-%li", (long)range.location, (long)range.length] forHTTPHeaderField:HTTP_HEADER_RANGE];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.applicationfilemanagement.downloadFile()", DISPATCH_QUEUE_SERIAL);
    
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
 * Delete a File.
 *
 * @param fileId Required PPApplicationFileId File ID to delete
 * @param userId PPUserId User ID to delete file as administrator.
 * @param locationId PPLocationId Location ID to delete file as administrator.
 * @param callback PPErrorBlock callback
 **/
+ (void)deleteFile:(PPApplicationFileId)fileId apiKey:(NSString *)apiKey userId:(PPUserId)userId locationId:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(fileId != PPApplicationFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"appfiles/%li?", (long)fileId];
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.applicationfilemanagement.deleteFile()", DISPATCH_QUEUE_SERIAL);
    
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

@end

