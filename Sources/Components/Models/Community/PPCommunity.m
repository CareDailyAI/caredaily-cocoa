//
//  PPCommunity.m
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCommunity.h"

@implementation PPCommunity

#pragma mark - Community Posts

/** Create post.
 * Create a new community post.
 *
 * @param post required PPCommunityPost Post to create
 * @param callback PPCommunityCreatePostBlock Post creation callback block
 */
+ (void)createPost:(PPCommunityPost *)post notification:(BOOL)notification callback:(nonnull PPCommunityCreatePostBlock)callback {
    NSAssert1(post != nil, @"%s missing post", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"communityPosts"];
    
    if (notification) {
        [requestString appendString:@"?notification=true"];
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"post":[PPCommunityPost dataFromPost:post]} options:0 error:&dataError];
    if(dataError) {
        callback(PPCommunityPostIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.createPost()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCommunityPostId postId = PPCommunityPostIdNone;
            if ([root objectForKey:@"postId"]) {
                postId = ((NSNumber *)[root objectForKey:@"postId"]).integerValue;
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(postId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPCommunityPostIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)createPost:(PPCommunityPost *)post callback:(PPCommunityCreatePostBlock)callback {
    NSLog(@"%s deprecated. Use +createPost:notification:callback:", __FUNCTION__);
    [PPCommunity createPost:post notification:NO callback:callback];
}

/** Update post.
 * Update the entire community post by ID. All post fields will be changed including reminders. Reminders will be rescheduled.
 * Post type, location ID and community ID cannot be changed for existing posts.
 *
 * @param postId required PPCommunityPostId Post ID to update
 * @param post required PPCommunityPost Post to create
 * @param callback PPErrorBlock Error callback block
  */
 + (void)updatePost:(PPCommunityPostId)postId post:(PPCommunityPost *)post callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(post != nil, @"%s missing post", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"communityPosts?postId=%li", (long)postId];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"post":[PPCommunityPost dataFromPost:post]} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.updatePost()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/** Get posts.
 *
 * @param postId PPCommunityPost Get specific post by ID
 * @param postTypes NSArray Post types filter. Multiple values supported.
 * @param locationId PPLocationId Filter by location ID
 * @param communityId PPCommunityId Filter by community ID
 * @param communityLocationId PPLocationId Filter community posts by location ID
 * @param startDate NSDate Filter by post creation date
 * @param endDate NSDate Filter by post creation date
 * @param status PPCommunityPostStatus Filter by status
 * @param callback PPCommunityPostsBlock Post creation callback block
 */
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId communityLocationId:(PPLocationId)communityLocationId startDate:(NSDate * _Nullable)startDate endDate:(NSDate * _Nullable)endDate status:(PPCommunityPostStatus)status callback:(nonnull PPCommunityPostsBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"communityPosts?"];
    if (postId != PPCommunityPostIdNone) {
        [requestString appendFormat:@"postId=%li&", (long)postId];
    }
    if (postTypes != nil) {
        for (NSNumber *postType in postTypes) {
            [requestString appendFormat:@"postType=%li&", (long)postType.integerValue];
        }
    }
    if (locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if (communityId != PPCommunityIdNone) {
        [requestString appendFormat:@"communityId=%li&", (long)communityId];
    }
    if (communityLocationId != PPLocationIdNone) {
        [requestString appendFormat:@"communityLocationId=%li&", (long)communityLocationId];
    }
    if(startDate) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        NSString *formattedDateString = [dateFormatter stringFromDate:startDate];
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:formattedDateString]];
    }
    if(endDate) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        NSString *formattedDateString = [dateFormatter stringFromDate:endDate];
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:formattedDateString]];
    }
    if (status != PPCommunityPostStatusNone) {
        [requestString appendFormat:@"status=%li&", (long)status];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.getPosts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *posts;
            
            if(!error) {
                posts = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *postDict in [root objectForKey:@"posts"]) {
                    PPCommunityPost *post = [PPCommunityPost initWithDictionary:postDict];
                    [posts addObject:post];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(posts, error);
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
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId communityLocationId:(PPLocationId)communityLocationId startDate:(NSDate * _Nullable)startDate endDate:(NSDate * _Nullable)endDate callback:(nonnull PPCommunityPostsBlock)callback {
    NSLog(@"%s deprecated. Use +getPosts:postTypes:locationId:communityId:communityLocationId:startDate:endDate:status:callback:", __FUNCTION__);
    [PPCommunity getPosts:postId postTypes:postTypes locationId:locationId communityId:communityId communityLocationId:PPLocationIdNone startDate:startDate endDate:endDate status:PPCommunityPostStatusNone callback:callback];
}
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray  * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPCommunityPostsBlock)callback __attribute__((deprecated)) {
   NSLog(@"%s deprecated. Use +getPosts:postTypes:locationId:communityId:communityLocationId:startDate:endDate:status:callback:", __FUNCTION__);
    [PPCommunity getPosts:postId postTypes:postTypes locationId:locationId communityId:communityId communityLocationId:PPLocationIdNone startDate:startDate endDate:endDate status:PPCommunityPostStatusNone callback:callback];
}

/** Delete post.
 * If called by the post's author, the post will be deleted. If called by the community moderator, the post will be rejected.
 *
 * @param postId required PPCommunityPostId Post ID to delete
 * @param callback PPErrorBlock Error callback block
 */
+ (void)deletePost:(PPCommunityPostId)postId callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"communityPosts?postId=%li", (long)postId];

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.deletePost()", DISPATCH_QUEUE_SERIAL);
    
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

#pragma mark - Community Post Files

/** Upload File
 * A client requests only a creation of the file record without immediate uploading of the file or thumbnail content. The API will return temporary content and thumbnail upload URL's, where data can be uploaded, and upload request headers, which must be used in each upload. After finishing data upload the client must update the file as completed.
 *
 * @param postId required Post ID
 * @param type required File type
 * @param contentType required File content type
 * @param ext required File extension (For example, mp4 or png)
 * @param duration Duration of the video in seconds
 rotate
 * @param Rotation in degrees. The UI is expected to manually rotate the video back to being upright, if this is set.
 * @param size Total size in bytes of the file content, if available
 * @param thumbnail Request thumbnail URL
 * @param m3u8 Request m3u8 URL
 * @param expiration Upload expiration in milliseconds since the current time
 * @param callback PPCommunityUploadFileBlock File upload callback block
 */
+ (void)uploadFile:(PPCommunityPostId)postId type:(PPFileFileType)type contentType:(NSString * _Nonnull )contentType ext:(NSString * _Nonnull )ext duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate size:(PPFileSize)size thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 expiration:(PPFileURLExpiration)expiration callback:(PPCommunityUploadFileBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(type != PPFileFileTypeNone, @"%s missing fileType", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(ext != nil, @"%s missing ext", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"communityPosts/%@/files", @(postId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(type).stringValue]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"contentType" value:contentType]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"ext" value:ext]];
    
    if (duration != PPFileDurationNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"duration" value:@(duration).stringValue]];
    }
    if (rotate != PPFileRotateNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"rotate" value:@(rotate).stringValue]];
    }
    if (size != PPFileSizeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"size" value:@(size).stringValue]];
    }
    if (thumbnail != PPFileThumbnailNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"thumbnail" value:(thumbnail == PPFileThumbnailTrue) ? @"true": @"false"]];
    }
    if (m3u8 != PPFileM3U8None) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"m3u8" value:(m3u8 == PPFileM3U8True) ? @"true": @"false"]];
    }
    if (expiration != PPFileURLExpirationNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"expiration" value:@(expiration).stringValue]];
    }
    
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.UploadFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] POST:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPFileId fileId = PPFileIdNone;
            NSString *contentUrl;
            NSString *thumbnailUrl;
            NSString *m3u8Url;
            NSDictionary *uploadHeaders;
            
            if(!error) {
                
                if ([root objectForKey:@"fileId"]) {
                    fileId = ((NSNumber *)root[@"fileId"]).integerValue;
                }
                if ([root objectForKey:@"contentUrl"]) {
                    contentUrl = root[@"contentUrl"];
                }
                if ([root objectForKey:@"thumbnailUrl"]) {
                    thumbnailUrl = root[@"thumbnailUrl"];
                }
                if ([root objectForKey:@"m3u8Url"]) {
                    m3u8Url = root[@"m3u8Url"];
                }
                uploadHeaders = root[@"uploadHeaders"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(fileId, contentUrl, thumbnailUrl, m3u8Url, uploadHeaders, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
        
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
        
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPFileIdNone, nil, nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/** Update File
 * Update file as completed.
 *
 * @param postId required PPCommunityPostId Post ID
 * @param fileId required PPFileId File ID
 * @param complete PPCommunityFileComplete true - This file is complete
 * @param callback PPErrorBlock Error callback block
 */
+ (void)updateFile:(PPCommunityPostId)postId fileId:(PPFileId)fileId complete:(PPCommunityFileComplete)complete callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"communityPosts/%@/files", @(postId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"fileId" value:@(fileId).stringValue]];
    if (complete != PPCommunityFileCompleteNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"complete" value:(complete == PPCommunityFileCompleteTrue) ? @"true" : @"false"]];
    }
    
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.UpdateFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
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

/** Get File URLs
 * Request files info and content and thumbnail download URL's by a post ID.
 *
 * @param postId required PPCommunityPostId Post ID
 * @param fileId PPFileId File ID
 * @param content PPFileContent Request content URL
 * @param thumbnail PPFileThumbnail Request thumbnail URL
 * @param m3u8 PPFileM3U8 Request m3u8 URL
 * @param expiration PPFileURLExpiration URL's expiration in milliseconds since the current time
 * @param callback PPCommunityFilesBlock Files callback block
 */
+ (void)getFileURLs:(PPCommunityPostId)postId fileId:(PPFileId)fileId content:(PPFileContent)content thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 expiration:(PPFileURLExpiration)expiration callback:(PPCommunityFilesBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"communityPosts/%@/files", @(postId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (fileId != PPFileIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"fileId" value:@(fileId).stringValue]];
    }
    if (content != PPFileContentNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"content" value:(content == PPFileContentTrue) ? @"true": @"false"]];
    }
    if (thumbnail != PPFileThumbnailNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"thumbnail" value:(thumbnail == PPFileThumbnailTrue) ? @"true": @"false"]];
    }
    if (m3u8 != PPFileM3U8None) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"m3u8" value:(m3u8 == PPFileM3U8True) ? @"true": @"false"]];
    }
    if (expiration != PPFileURLExpirationNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"expiration" value:@(expiration).stringValue]];
    }
    
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.GetFileURLS()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *files;
            
            if(!error) {
                files = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileDict in [root objectForKey:@"files"]) {
                    PPCommunityFile *file = [PPCommunityFile initWithDictionary:fileDict];
                    [files addObject:file];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(files, error);
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

/** Delete File
 *
 * @param postId required PPCommunityPostId Post Id
 * @param fileId required PPFileId File ID
 * @param callback PPErrorBlock Callback block
 */
+ (void)deleteFile:(PPCommunityPostId)postId fileId:(PPFileId)fileId callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"communityPosts/%@/files", @(postId)]] resolvingAgainstBaseURL:NO];
    components.queryItems = @[[[NSURLQueryItem alloc] initWithName:@"fileId" value:@(fileId).stringValue]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.DeleteFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
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

#pragma mark - Community Post Comments

/** Comment
 * Create or update community post comment.
 *
 * @ param postId PPCommunityPostId Post ID for a new comment
 * @ param commentId PPCommunutyCommentId Comment ID to update existing comment
 * @ param replyCommentId PPCommunutyCommentId Comment ID to reply on existing comment
  * @param comment required NSString Comment
  */
+ (void)comment:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId replyCommentId:(PPCommunityCommentId)replyCommentId comment:(NSString * _Nonnull )comment callback:(PPCommunityCreateCommentBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone || replyCommentId != PPCommunityCommentIdNone, @"%s missing postId or replyCommentId", __FUNCTION__);
    NSAssert1(comment != nil, @"%s missing comment", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"communityPostComments?"];
    
    if (postId != PPCommunityPostIdNone) {
        [requestString appendFormat:@"postId=%li&", (long)postId];
    }
    
    if (commentId != PPCommunityCommentIdNone) {
        [requestString appendFormat:@"commentId=%li&", (long)commentId];
    }
    
    if (replyCommentId != PPCommunityCommentIdNone) {
        [requestString appendFormat:@"replyCommentId=%li&", (long)replyCommentId];
    }

    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"commentText": comment} options:0 error:&dataError];
    if (dataError) {
        callback(PPCommunityCommentIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.comment()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCommunityCommentId commentId = PPCommunityCommentIdNone;
            if ([root objectForKey:@"commentId"]) {
                commentId = ((NSNumber *)[root objectForKey:@"commentId"]).integerValue;
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(commentId, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
        
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
        
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPCommunityCommentIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/** Delete Comment
 * Delete a community post comment.
 *
 * @ param postId required PPCommunityPostId Post ID of the comment
 * @ param commentId required PPCommunityCommentId Comment ID to delete
 */
+ (void)deleteComment:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(commentId != PPCommunityCommentIdNone, @"%s missing commentId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"communityPostComments?postId=%li&commentId=%li", (long)postId, (long)commentId];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.DeleteComment()", DISPATCH_QUEUE_SERIAL);
    
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

#pragma mark - Community Post Reaction

/** Reaction
 *
 * @ param postId required PPCommunityPostId Post ID
 * @ param commentId PPCommunutyCommentId Comment ID to update existing comment
 * @ param reaction PPCommunityReactionType Reaction
 */
+ (void)reaction:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId reaction:(PPCommunityReactionType)reaction callback:(PPErrorBlock)callback {
    NSAssert1(postId != PPCommunityPostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(reaction != PPCommunityReactionTypeNone, @"%s missing reaction", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"communityPostReaction?postId=%li&reaction=%li&", (long)postId, (long)reaction];

    if (commentId != PPCommunityCommentIdNone) {
        [requestString appendFormat:@"commentId=%li&", (long)commentId];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.community.reaction()", DISPATCH_QUEUE_SERIAL);
    
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

@end
