//
//  PPCommunity.h
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCommunityPost.h"
#import "PPLocationCommunity.h"
#import "PPUserCommunity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunity : PPBaseModel

#pragma mark - Community Posts

/** Create post.
 * Create a new community post.
 *
 * @param post required PPCommunityPost Post to create
 * @param notification BOOL Send notifications to users for new location/community post.
 * @param callback PPCommunityCreatePostBlock Post creation callback block
 */
+ (void)createPost:(PPCommunityPost * _Nonnull )post notification:(BOOL)notification callback:(PPCommunityCreatePostBlock)callback;
+ (void)createPost:(PPCommunityPost * _Nonnull )post callback:(PPCommunityCreatePostBlock)callback __attribute__ ((deprecated));

/** Update post.
 * Update the entire community post by ID. All post fields will be changed including reminders. Reminders will be rescheduled.
 * Post type, location ID and community ID cannot be changed for existing posts.
 *
 * @param postId required PPCommunityPostId Post ID to update
 * @param post required PPCommunityPost Post to create
 * @param callback PPErrorBlock Error callback block
 */
+ (void)updatePost:(PPCommunityPostId)postId post:(PPCommunityPost * _Nonnull )post callback:(PPErrorBlock)callback;

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
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray  * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId communityLocationId:(PPLocationId)communityLocationId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate status:(PPCommunityPostStatus)status callback:(PPCommunityPostsBlock)callback;
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray  * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId communityLocationId:(PPLocationId)communityLocationId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPCommunityPostsBlock)callback __attribute__((deprecated));
+ (void)getPosts:(PPCommunityPostId)postId postTypes:(NSArray  * _Nullable )postTypes locationId:(PPLocationId)locationId communityId:(PPCommunityId)communityId startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPCommunityPostsBlock)callback __attribute__((deprecated));

/** Delete post.
 * If called by the post's author, the post will be deleted. If called by the community moderator, the post will be rejected.
 *
 * @param postId required PPCommunityPostId Post ID to delete
 * @param callback PPErrorBlock Error callback block
 */
+ (void)deletePost:(PPCommunityPostId)postId callback:(PPErrorBlock)callback;

#pragma mark - Community Post Files
/**
 * type Type of file.
    - 0 - any
    - 1 - video
    - 2 - image
    - 3 - audio
 * contentType Content type
 * size Size of the file in bytes
 *
 * The content type must be like video/ *, image/ *, audio/ * or application/octet-stream (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values). For example: video/mp4, image/jpeg, audio/mp3. The content type of a thumbnail image is always image/jpeg.
 */

/** Upload File
 * A client requests only a creation of the file record without immediate uploading of the file or thumbnail content. The API will return temporary content and thumbnail upload URL's, where data can be uploaded, and upload request headers, which must be used in each upload. After finishing data upload the client must update the file as completed.
 *
 * @param postId required PPCommunityPostId Post ID
 * @param type required PPFileFileType File type
 * @param contentType required NSString File content type
 * @param ext required NSString File extension (For example, mp4 or png)
 * @param duration PPFileDuration Duration of the video in seconds
 * @param rotate PPFileRotate Rotation in degrees. The UI is expected to manually rotate the video back to being upright, if this is set.
 * @param size PPFileSize Total size in bytes of the file content, if available
 * @param thumbnail PPFileThumbnail Request thumbnail URL
 * @param m3u8 PPFileM3U8 Request m3u8 URL
 * @param expiration PPFileURLExpiration Upload expiration in milliseconds since the current time
 * @param callback PPCommunityUploadFileBlock File upload callback block
 */
+ (void)uploadFile:(PPCommunityPostId)postId type:(PPFileFileType)type contentType:(NSString * _Nonnull )contentType ext:(NSString * _Nonnull )ext duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate size:(PPFileSize)size thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 expiration:(PPFileURLExpiration)expiration callback:(PPCommunityUploadFileBlock)callback;

/** Update File
 * Update file as completed.
 *
 * @param postId required PPCommunityPostId Post ID
 * @param fileId required PPFileId File ID
 * @param complete PPCommunityFileComplete true - This file is complete
 * @param callback PPErrorBlock Error callback block
 */
+ (void)updateFile:(PPCommunityPostId)postId fileId:(PPFileId)fileId complete:(PPCommunityFileComplete)complete callback:(PPErrorBlock)callback;

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
+ (void)getFileURLs:(PPCommunityPostId)postId fileId:(PPFileId)fileId content:(PPFileContent)content thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 expiration:(PPFileURLExpiration)expiration callback:(PPCommunityFilesBlock)callback;

/** Delete File
 *
 * @param postId required PPCommunityPostId Post Id
 * @param fileId required PPFileId File ID
 * @param callback PPErrorBlock Callback block
 */
+ (void)deleteFile:(PPCommunityPostId)postId fileId:(PPFileId)fileId callback:(PPErrorBlock)callback;

#pragma mark - Community Post Comments

/** Comment
 * Create or update community post comment.
 *
 * @param postId PPCommunityPostId Post ID for a new comment
 * @param commentId PPCommunutyCommentId Comment ID to update existing comment
 * @param replyCommentId PPCommunutyCommentId Comment ID to reply on existing comment
 * @param comment required NSString Comment
 */
+ (void)comment:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId replyCommentId:(PPCommunityCommentId)replyCommentId comment:(NSString * _Nonnull )comment callback:(PPCommunityCreateCommentBlock)callback;

/** Delete Comment
 * Delete a community post comment.
 *
 * @param postId required PPCommunityPostId Post ID of the comment
 * @param commentId required PPCommunityCommentId Comment ID to delete
 */
+ (void)deleteComment:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId callback:(PPErrorBlock)callback;

#pragma mark - Community Post Reaction

/** Reaction
 *
 * @param postId required PPCommunityPostId Post ID
 * @param commentId PPCommunutyCommentId Comment ID to update existing comment
 * @param reaction PPCommunityReactionType Reaction
 */
+ (void)reaction:(PPCommunityPostId)postId commentId:(PPCommunityCommentId)commentId reaction:(PPCommunityReactionType)reaction callback:(PPErrorBlock)callback;

@end

NS_ASSUME_NONNULL_END
