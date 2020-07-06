//
//  PPTCCircles.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPCircles.h>
#import <Peoplepower/PPCircle.h>
#import <Peoplepower/PPCircleFile.h>
#import <Peoplepower/PPCirclePost.h>
#import <Peoplepower/PPCommunityPost.h>

static NSString *moduleName = @"Circles";

@interface PPTCCircles : PPBaseTestCase

@property (strong, nonatomic) PPCircle *circle;
@property (strong, nonatomic) PPCircleMember *circleMember;
@property (strong, nonatomic) PPCircleFile *file;
@property (strong, nonatomic) PPCirclePost *post;

@end

@implementation PPTCCircles

- (void)setUp {
    [super setUp];
    NSDictionary *circleDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CIRCLES_CIRCLE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *memberDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CIRCLES_MEMBER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *fileDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FILE_MANAGEMENT_IMAGE filename:PLIST_FILE_UNIT_TESTS];
    NSArray *fileNameComponents = [[fileDict objectForKey:@"fileName"] componentsSeparatedByString:@"."];
    NSDictionary *postDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CIRCLES_POST filename:PLIST_FILE_UNIT_TESTS];
    
    self.circle = [PPCircle initWithDictionary:circleDict];
    self.circleMember = [PPCircleMember initWithDictionary:memberDict];
    self.file = [PPCircleFile initWithDictionary:fileDict];
    self.file.data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:[fileNameComponents firstObject] withExtension:[fileNameComponents lastObject]]];
    self.post = [PPCirclePost initWithDictionary:postDict];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Circles

/**
 * Create a Circle.
 * The person who creates a Circle is the Administrator, until someone upgrades the Circle into a Premium Circle (or higher). The people who pay for Premium services take over as the Administrator.
 * You are always an implied member of the Circle you create.
 * The request returns the ID of the Circle that was created, for future reference.
 * Remember that we can add email addresses without having a user account created on our system. Every user will get an email + push notification that they're part of the Circle.
 * Any accounts that are email address only will receive a daily update with the top 3 items from the conversation on what they missed out on, with an opportunity to sign up.
 *
 * @ param name NSString Name of the circle
 * @ param callback PPCircleCreationBlock Circle creation callback block
 **/
- (void)testCreatCircle {
    NSString *methodName = @"CreateCircle";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/circles" statusCode:200 headers:nil];
    
    [PPCircles createCircle:self.circle.name callback:^(PPCircleId circleId, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Circles.
 *
 * @ param circleId PPCircleId Circle ID
 * @ param callback PPCirclesBlock Circles callback block
 **/
- (void)testGetCircles {
    NSString *methodName = @"GetCircles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/circles" statusCode:200 headers:nil];
    
    [PPCircles getCirclesWithCircleIds:nil callback:^(NSArray *circles, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Modify a Circle.
 * Only a Circle Administrator may modify a Circle.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param name Required NSString Circle Name
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testModifyCircle {
    NSString *methodName = @"ModifyCircle";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/circles" statusCode:200 headers:nil];
    
    [PPCircles modifyCircle:self.circle.circleId name:self.circle.name callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a Circle.
 * Only a Circle Administrator may delete a Circle.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteCircle {
    NSString *methodName = @"DeleteCircle";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/circles" statusCode:200 headers:nil];
    
    [PPCircles deleteCircle:self.circle.circleId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Manage Circle Members

/**
 * Add Members.
 * Any member of a circle may add more members to a circle, not just the administrator. We want to help its utility grow organically.
 * Remember that we can add email addresses without having a user account created on our system. Every user will get an email + push notification that they're part of the Circle. Any accounts that are email address only will receive a daily update with the top 3 items from the conversation on what they missed out on, with an opportunity to sign up.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param members Required NSArray Member emails
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testAddMembers {
    NSString *methodName = @"AddMembers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/members", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles addMembers:self.circle.circleId members:@[self.circleMember] callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Update Member Status.
 * A circle member can opt-in or opt-out from circle notifications.
 *
 * @ param circleUserId NSString Circle User ID.  Use in place of API Key to manage a circle member.
 * @ param circleId Required PPCircleId Circle ID
 * @ param status PPCircleMemberStatus Member emails
 * @ param nickname NSString Member nickname
 * @ param userId PPUserId User ID to access by administrator
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateMemberStatus {
    NSString *methodName = @"UpdateMemberStatus";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/members", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles updateMemberStatus:nil circleUserId:nil circleId:self.circle.circleId status:self.circleMember.status nickname:self.circleMember.nickname admin:PPCircleMemberAdminNone userId:PPUserIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Remove Members.
 * Only a Circle Administrator may delete other members. Registered users may delete themselves.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param userId PPUserId User ID to delete from the circle
 * @ param circleUserId NSString Circle User ID to delete from the circle
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testRemoveMembers {
    NSString *methodName = @"RemoveMembers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/members", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles removeMembers:self.circle.circleId userId:PPUserIdNone circleUserId:self.circleMember.circleUserId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Circle Files

/**
 * Upload File.
 * The client have to upload the file content first and then add a thumbnail. The API will return the thumbnail field equals true, if the cloud was able to generate the thumbnail from the file content.
 * The "Content-Type" header must be like video/..., image/..., audio/... or application/octet-stream (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values). For example: video/mp4, image/jpeg, audio/mp3. The content type of a thumbnail image is always image/jpeg.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param type PPFileFileType File type. By default it is defined from the content type. However this parameter is useful, if a thumbnail with different content type is uploaded frist.
 * @ param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @ param duration PPFileDuration Duration of the video in seconds, for reporting to the UI
 * @ param rotate PPFileRotate Rotation in degrees. The UI is expected to manually rotat the video back to being upright if this is set.
 * @ param thumbnail PPFileThumbnail True - The content is a thumbnail image and the file content will be uploaded later
 * @ param expectedSize PPFileSize Expected total size in bytes, if available
 * @ param incomplete PPFileIncomplete True - This file content will be replaced or extended later. False - This file is complete
 * @ param contentType Required NSString Content-Type header.
 * @ param data Required NSData File data
 * @ param progressBlock PPCircleFileProgressBlock File upload progress block
 * @ param callback PPCircleFileUploadBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
- (void)testUploadFile {
    NSString *methodName = @"UploadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles uploadFile:self.circle.circleId type:self.file.type fileExtension:@"jpeg" duration:self.file.duration rotate:self.file.rotate thumbanil:self.file.thumbnail expectedSize:self.file.size incomplete:PPFileIncompleteFalse contentType:@"image/jpeg" data:self.file.data progressBlock:^(NSProgress *progress) {
        
    } callback:^(PPFileId fileId, PPFileThumbnail thumbnail, PPCircleData monthlyDataIn, PPCircleData monthlyDataMax, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Files.
 * Return a list of files in the circle.
 *
 * @ param circleId Required PPCircleId CircleId
 * @ param fileId PPFileId File ID filter
 * @ param type PPFileFileType File type
 * @ param ownerId PPUserId User ID of the file's owner
 * @ param startDate NSDate Start date of the files list
 * @ param endDate NSDate End date of the files list
 * @ param callback PPCircleFilesBlock Files callback block
 **/
- (void)testGetFiles {
    NSString *methodName = @"GetFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles getFiles:self.circle.circleId fileId:PPFileIdNone type:PPFileFileTypeNone ownerId:PPUserIdNone startDate:nil endDate:nil callback:^(NSArray *files, NSString *tempKey, NSDate *tempKeyExpire, PPCircleData monthlyDataIn, PPCircleData monthlyDataMax, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Single File Access

/**
 * Upload File Fragment or Thumbnail.
 * Allow to add a fragment to the content of the existing file or upload a thumbnail.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param fileId Required PPFileId Existing file ID
 * @ param thumbnail PPFileThumbnail True - The content is a thumbnail image
 * @ param incomplete PPFileIncomplete True - The file will be extended later, False - This file is complete
 * @ param index PPFileFragmentIndex Fragmen index starting from 0 to identify unique file fragment. It is used for additional control over uploaded data.
 * @ param contentType Required NSString Content-Type header.
 * @ param data Required NSData File data
 * @ param progressBlock PPCircleFileProgressBlock File upload progress block
 * @ param callback PPCircleFileUploadFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
- (void)testUploadFileFragment {
    NSString *methodName = @"UploadFileFragment";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files/%@", @(self.circle.circleId), @(self.file.fileId)] statusCode:200 headers:nil];
        
    [PPCircles uploadFileFragment:self.circle.circleId fileId:self.file.fileId thumbnail:PPFileThumbnailTrue incomplete:PPFileIncompleteFalse index:0 contentType:@"image/jpeg" data:self.file.data progressBlock:^(NSProgress *progress) {

    } callback:^(PPFileThumbnail thumbnail, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
     
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Download File.
 * The Range HTTP Header is optional, and will only return a chunk of the total content. If used, it is recommended to select a range that is a multiple of 10240 bytes.
 * A temporary API key provided in the query parameter may be used to forward a link to other part of the app. A temporary API key can be obtained by calling the loginByKey API. It is expired soon after receiving.
 * The response will include:
 *      - The file content
 *      - A Content-Type HTTP Header containing the file's content type
 *      - Content range in the Content-Range header, if the Range of the content was requested. This will be in the format of bytes {start}-{end}/{total size}. For example: Content-Range: bytes 21010-47021/47022.
 *      - The Accept-Ranges header containing accepted content range values in bytes. For example "0-47022".
 *      - The Content-Disposition HTTP header that contains the filename when requested.
 * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for a discussion on the header options.
 * HTTP Status Codes:
 *      - 200 (OK): The file content is returned in full.
 *      - 204 (No Content): The file exist, but the content is not available for this request.
 *      - 206 (Partial Content): The file content is partially returned.
 *      - 401 (Unauthorized): The API key is wrong.
 *      - 404 (Not Found): The file does not exists.
 *      - 500 (Internal error): Something went wrong on the server side.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param fileId Required PPFileId File ID to download
 * @ param apiKey NSString Temporary API key
 * @ param thumbnail PPFileThumbnail True - Download the thumbnail for this file, False - Download the actual file, not the thumbnail, default
 * @ param m3u8 PPFileM3U8 True - Download m3u8 file instead of the file content
 * @ param attach PPFileAttach Download the file content as an attachments with the Content-Disposition header
 * @ param range NSRange Range of bytes to download
 * @ param callback PPCircleFileContentBlock File content block
 **/
- (void)testDownloadFile {
    NSString *methodName = @"DownloadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"data" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files/%@", @(self.circle.circleId), @(self.file.fileId)] statusCode:200 headers:@{
        @"Content-Type": @"img/png",
        @"Content-Range": @"bytes 21010-47021/47022",
        @"Accept-Ranges": @"0-47022",
        @"Content-Disposition": @"attachment",
    }];
        
    [PPCircles downloadFile:self.circle.circleId fileId:self.file.fileId apiKey:nil thumbnail:PPFileThumbnailNone m3u8:PPFileM3U8None attach:PPFileAttachNone range:NSMakeRange(0, 0) callback:^(NSData *fileData, NSString *contentType, NSString *contentRange, NSString *acceptRanges, NSString *contentDisposition, NSInteger statusCode, NSError *error) {
    
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

/**
 * Get download URL's
 * A client can request temporary download URL's to get file and thumbnail content directly from S3 instead of copying it through the server.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param fileId Required PPFileId File ID to download
 * @ param content PPFileContent True - Download the file content URL
 * @ param thumbnail PPFileThumbnail True - Download the thumbnail content URL
 * @ param m3u8 PPFileM3U8 True - Download m3u8 content URL
 * @ param expiration PPFileURLExpiration URL's expiration in milliseconds since the current time
 * @ param callback PPCircleFileDownloadURLBlock File content block
 **/
- (void)testGetDownloadUrls {
    NSString *methodName = @"GetDownloadUrls";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files/%@", @(self.circle.circleId), @(self.file.fileId)] statusCode:200 headers:nil];
        
    [PPCircles getDownloadURL:self.circle.circleId fileId:self.file.fileId content:PPFileContentNone thumbnail:PPFileThumbnailNone m3u8:PPFileM3U8None expiration:PPFileURLExpirationNone callback:^(NSURL * _Nullable contentURL, NSURL * _Nullable thumbnailURL, NSURL * _Nullable m3u8URL, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

/**
 * Delete a File.
 * Only the owner of the file or an administrator of the circle may delete a file.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param fileId Required PPFileId File ID to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteFile {
    NSString *methodName = @"DeleteFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/files/%@", @(self.circle.circleId), @(self.file.fileId)] statusCode:200 headers:nil];
    
    [PPCircles deleteFile:self.circle.circleId fileId:self.file.fileId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
     
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Circle Posts

/**
 * Make a post.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param originalPostId PPCirclePostId Original post ID to reply to
 * @ param postId PPCirclePostId Post ID to edit content
 * @ param text NSString Post text
 * @ param fileId PPFileId File ID
 * @ param displayAt PPCirclePostDisplayTime Display at time in seconds (since midnight?)
 * @ param displayDuration PPCirclePostDisplayTime Display duration time in seconds
 * @ param callback PPCirclePostMakeBlock Make post callback block
 **/
- (void)testMakePost {
    NSString *methodName = @"MakePost";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/posts", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles makePost:self.circle.circleId originalPostId:PPCirclePostIdNone postId:PPCirclePostIdNone text:self.post.text fileId:PPFileIdNone displayAt:self.post.displayAt displayDuration:self.post.displayDuration callback:^(PPCirclePostId postId, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Posts.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param postId PPCirclePostId Specific original or reply post ID to filter by
 * @ param authorId PPUserID Post author user ID
 * @ param startDate NSDate Start date of the posts list
 * @ param endDate NSDate End date of the posts list
 * @ param searchText NSString Search text
 * @ param callback PPCirclePostsBlock Posts callback block
 **/
- (void)testGetPosts {
    NSString *methodName = @"GetPosts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/circlePosts" statusCode:200 headers:nil];
    
    [PPCircles getPostsForCircles:@[@(self.circle.circleId)] postId:PPCirclePostIdNone authorId:PPUserIdNone startDate:nil endDate:nil searchText:nil callback:^(NSArray *posts, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete Post.
 * Post can be deleted by the author or circle admin.
 * Deleting a post will delete all attached files. Deleting an original post will delete all replyes and reactions.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param postId PPCirclePostId Specific original or reply post ID to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeletePost {
    NSString *methodName = @"DeletePost";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/posts", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles deletePost:self.circle.circleId postId:self.post.postId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - React on Post

/**
 * React.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param postId PPCirclePostId Specific original or reply post ID to react on
 * @ param type PPCircleReactionType Reaction type
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testReact {
    NSString *methodName = @"React";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/posts/%@/reactions/%@", @(self.circle.circleId), @(self.post.postId), @(PPCommunityReactionTypeLike)] statusCode:200 headers:nil];
    
    [PPCircles react:self.circle.circleId postId:self.post.postId type:PPCircleReactionTypeLike callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Devices.
 * Retrieve connected device instances linked to users inside the circle.
 *
 * @ param circleId Required PPCircleId Circle ID
 * @ param callback PPCircleDevicesBlock Devices callback block
 **/
- (void)testGetDevices {
    NSString *methodName = @"GetDevices";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/circles/%@/devices", @(self.circle.circleId)] statusCode:200 headers:nil];
    
    [PPCircles getDevices:self.circle.circleId callback:^(NSArray *devices, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
