//
//  PPTCFileManagement.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/20/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPDevice.h>
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPFile.h>
#import <Peoplepower/PPFileManagement.h>
#import <Peoplepower/PPUserAccounts.h>

static NSString *moduleName = @"FilesManagement";

@interface PPTCFileManagement : PPBaseTestCase

@property (strong, nonatomic) PPDevice *device;
@property (strong, nonatomic) NSString *sessionKey;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) PPFile *file_image;
@property (strong, nonatomic) PPFile *file_video;
@property (strong, nonatomic) PPFile *file_audio;
@property (strong, nonatomic) NSString *contentUrl;
@property (strong, nonatomic) NSDictionary *uploadHeaders;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) PPFileTag *tag;

@end

@implementation PPTCFileManagement

- (void)setUp {
    [super setUp];
    
    NSDictionary *deviceDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_DEVICES_LOCAL_DEVICE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *fileDict_image = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FILE_MANAGEMENT_IMAGE filename:PLIST_FILE_UNIT_TESTS];
    NSArray *fileNameComponents_image = [[fileDict_image objectForKey:@"fileName"] componentsSeparatedByString:@"."];
    NSDictionary *fileDict_video = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FILE_MANAGEMENT_VIDEO filename:PLIST_FILE_UNIT_TESTS];
    NSArray *fileNameComponents_video = [[fileDict_video objectForKey:@"fileName"] componentsSeparatedByString:@"."];
    NSDictionary *fileDict_audio = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FILE_MANAGEMENT_AUDIO filename:PLIST_FILE_UNIT_TESTS];
    NSArray *fileNameComponents_audio = [[fileDict_audio objectForKey:@"fileName"] componentsSeparatedByString:@"."];
    
    self.device = [PPDevice initWithDictionary:deviceDict];
    self.location = [PPLocation initWithDictionary:locationDict];
    self.sessionKey = @"_API_KEY_";
    self.authToken = @"_TOKEN_";
    self.file_image = [PPFile initWithDictionary:fileDict_image];
    self.file_image.data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:[fileNameComponents_image firstObject] withExtension:[fileNameComponents_image lastObject]]];
    self.file_video = [PPFile initWithDictionary:fileDict_video];
    self.file_video.data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:[fileNameComponents_video firstObject] withExtension:[fileNameComponents_video lastObject]]];
    self.file_audio = [PPFile initWithDictionary:fileDict_audio];
    self.file_audio.data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:[fileNameComponents_audio firstObject] withExtension:[fileNameComponents_audio lastObject]]];
    self.contentUrl = @"https://s3.amazonaws.com/cbacket/fileId?X-Amz-Algorithm=AWS4-HMAC-SHA256...";
    self.uploadHeaders = @{@"x-amz-server-side-encryption": @"AES256"};
    self.startDate = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 * 24 * 5)];
    self.tag = (PPFileTag *)[self.file_image.tags firstObject];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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
 * @ param proxyId Required NSString Device ID of the proxy that thsi file is being uploaded through
 * @ param deviceId NSString Device ID of the dvice that generated this file, if different from the proxyId
 * @ param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @ param expectedSize PPFileSize Expected total size in bytes, if available
 * @ param duration PPFileDuration Duration of the video in seconds, for reporting to the UI
 * @ param rotate PPFileRotate Rotation in degrees. The UI is expected to manually rotat the video back to being upright if this is set.
 * @ param fileId PPFileId Existing file ID to replace the content and properties
 * @ param thumbnail PPFileThumbnail True - The content is a thumbnail image and the file content will be uploaded later
 * @ param incomplete PPFileIncomplete True - This file content will be replaced or extended later. False - This file is complete
 * @ param type PPFileFileType File type. By default it is defined from the content type. However this parameter is useful, if a thumbnail with different content type is uploaded frist.
 * @ param contentType Required NSString Content-Type header.
 * @ param authorizationType Required PPFileManagementAuthorizationType Authorization type used to identify the source device.
 * @ param token Required if authorizationType set to PPFileManagementAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @ param sessionId Required if authorizationType set to PPFileManagementAuthorizationTypeStreamingSessionId NSString Session ID.
 * @ param data Required NSData File data
 * @ param uploadUrl PPFileUploadUrl If it is set to true, the server does not need the file content. The server will create a file record in the database and request S3 to generate a presigned URL to upload the file content, which will be returned to the camera. These presigned URL's can be returned for both the file content and the thumbnail. The URL's are valid until some configurable timeout.
 * @ param progressBlock PPFileManagementProgressBlock File upload progress block
 * @ param callback PPFileManagementFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, twitter account (if any), storage policy, and uploadHeaders
 **/
- (void)testUploadNewFile_image {
    NSString *methodName = @"UploadNewFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/files" statusCode:200 headers:nil];
    
    [PPFileManagement uploadNewFile:self.device.deviceId deviceId:self.device.deviceId fileExtension:@"jpeg" expectedSize:self.file_image.size duration:self.file_image.duration rotate:self.file_image.rotate fileId:self.file_image.fileId thumbnail:self.file_image.thumbnail incomplete:PPFileIncompleteTrue type:self.file_image.type contentType:@"image/jpeg" authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:self.authToken sessionId:nil data:self.file_image.data uploadUrl:PPFileUploadUrlNone progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadNewFileS3_image {
    NSString *methodName = @"UploadNewFileS3";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSURL URLWithString:self.contentUrl].path statusCode:200 headers:nil];
    
    NSString *contentType = @"image/jpeg";
    switch (self.file_image.type) {
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
    
    [PPFileManagement uploadS3File:self.file_image.type contentType:contentType data:self.file_image.data contentUrl:self.contentUrl uploadHeaders:self.uploadHeaders progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadNewFile_video {
    NSString *methodName = @"UploadNewFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/files" statusCode:200 headers:nil];
    
    [PPFileManagement uploadNewFile:self.device.deviceId deviceId:self.device.deviceId fileExtension:@"mp4" expectedSize:self.file_video.size duration:self.file_video.duration rotate:self.file_video.rotate fileId:self.file_video.fileId thumbnail:self.file_video.thumbnail incomplete:PPFileIncompleteTrue type:self.file_video.type contentType:@"video/mp4" authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:self.authToken sessionId:nil data:self.file_video.data uploadUrl:PPFileUploadUrlNone progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadNewFileS3_video {
    NSString *methodName = @"UploadNewFileS3";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSURL URLWithString:self.contentUrl].path statusCode:200 headers:nil];
        
    NSString *contentType = @"image/jpeg";
    switch (self.file_video.type) {
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
    
    [PPFileManagement uploadS3File:self.file_video.type contentType:contentType data:self.file_video.data contentUrl:self.contentUrl uploadHeaders:self.uploadHeaders progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadNewFile_audio {
    NSString *methodName = @"UploadNewFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/files" statusCode:200 headers:nil];
    
    [PPFileManagement uploadNewFile:self.device.deviceId deviceId:self.device.deviceId fileExtension:@"m4a" expectedSize:self.file_audio.size duration:self.file_audio.duration rotate:self.file_audio.rotate fileId:self.file_audio.fileId thumbnail:self.file_audio.thumbnail incomplete:PPFileIncompleteTrue type:self.file_audio.type contentType:@"audio/mpeg" authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:self.authToken sessionId:nil data:self.file_audio.data uploadUrl:PPFileUploadUrlNone progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {
        
        XCTAssertNil(error);
        
        if(!error) {
            [PPFileManagement addFiles:@[fileFragment] userId:[PPUserAccounts currentUser].userId];
        }
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadNewFileS3_audio {
    NSString *methodName = @"UploadNewFileS3";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSURL URLWithString:self.contentUrl].path statusCode:200 headers:nil];
        
    NSString *contentType = @"image/jpeg";
    switch (self.file_audio.type) {
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
    
    [PPFileManagement uploadS3File:self.file_audio.type contentType:contentType data:self.file_audio.data contentUrl:self.contentUrl uploadHeaders:self.uploadHeaders progressBlock:^(NSProgress *progress) {
        
        NSLog(@"%s progress=%@", __PRETTY_FUNCTION__, progress);
        
    } callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Files
 * Return a list of the user's files, and any files that have been shared with this user by other users.
 *
 * @ param type PPFileFileType Type of file to obtain in the list
 * @ param owners PPFileOwners Filter files by owners bitmap
 * @ param ownerId PPUserId User ID to filter files by the specific owner
 * @ param deviceId NSString Camera dvice ID to filter files by the specific camera
 * @ param deviceDesc NSString Camera device description to filter files by the specific camera
 * @ param startDate NSDate Optional start date to start the list of files
 * @ param endDate NSDate Optional end date to end the list of files
 * @ param searchTag NSString Search by tag
 * @ param callback PPFileManagementFilesBlock Files callback block containing list of files, used and total file space, temp key, and temp key expire date
 **/
- (void)testGetFiles {
    NSString *methodName = @"GetFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/files" statusCode:200 headers:nil];
    
    [PPFileManagement getFiles:self.location.locationId type:PPFileFileTypeNone owners:PPFileOwnersNone ownerId:PPUserIdNone deviceId:nil deviceDesc:nil startDate:self.startDate endDate:nil searchTag:nil callback:^(NSArray *files, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSString *tempKey, NSDate *tempKeyExpire, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete all files
 * This action will delete all files that are not marked as favorite.
 *
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteAllFiles {
    NSString *methodName = @"DeleteAllFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/files" statusCode:200 headers:nil];
    
    [PPFileManagement deleteAllFiles:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Last N Files

/**
 * Get Last N Files.
 * Return a list of last N user's files before specific date.
 *
 * @ param count Required PPFileCount Maximum number of files to return
 * @ param startDate NSDate Optional start date to start the list of files
 * @ param endDate NSDate Optional end date to end the list of files, default is current date.
 * @ param type PPFileFileType Type of file to obtain in the list
 * @ param deviceId NSString Camera device ID to filter files by the specific camera
 * @ param deviceDescription NSString Camera device description to filter files by the specific camera
 * @ param callback PPFileManagementLastNFilesBlock Last N Files block containing list of files and temp key/expiry
 **/
- (void)testGetLastNFiles {
    NSString *methodName = @"GetLastNFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/filesByCount/%@", @(10)] statusCode:200 headers:nil];
    
    [PPFileManagement getLastNFiles:10 startDate:nil endDate:nil type:PPFileFileTypeNone deviceId:nil deviceDescription:nil callback:^(NSArray *files, NSString *tempKey, NSDate *tempKeyExpire, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - File Content Management

/**
 * Upload File Fragment or a Thumbnail
 * Allow to add a fragment to the content of the existing file or upload a thumbnail.
 * "Content-Type" and "PPCAuthorization" are same as for uploading a new file.
 *
 * @ param fileId Required PPFileId Existing file ID
 * @ param proxyId Required NSString Device ID of the proxy that this file is being uploaded through
 * @ param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @ param thumbnail PPFileThumbnail True - The content is a thumbnail image
 * @ param incomplete PPFileIncomplete True - The file will be extended later, False - This file is complete
 * @ param index PPFileFragmentIndex Fragmen index starting from 0 to identify unique file fragment. It is used for additional control over uploaded data.
 * @ param contentType Required NSString Content-Type header.
 * @ param authorizationType Required PPFileManagementAuthorizationType Authorization type used to identify the source device.
 * @ param token Required if authorizationType set to PPFileManagementAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @ param sessionId Required if authorizationType set to PPFileManagementAuthorizationTypeStreamingSessionId NSString Session ID.
 * @ param data Required NSData File data
 * @ param callback PPFileManagementFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
- (void)testUploadFileFragment {
    NSString *methodName = @"UploadFileFragment";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement uploadFileFragment:self.file_image.fileId proxyId:self.device.deviceId fileExtension:@"jpeg" thumbnail:PPFileThumbnailTrue incomplete:PPFileIncompleteFalse index:0 contentType:@"image/jpeg" authorizationType:PPFileManagementAuthorizationTypeDeviceAuthenticationToken token:self.authToken sessionId:nil data:self.file_image.data callback:^(NSString *status, PPFile *fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString *twitterAccount, NSString *contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary *uploadHeaders, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get download URL's
 * A client can request temporary download URL's to get file and thumbnail content directly from S3 instead of copying it through the server.
 *
 * @ param fileId Required PPFileId File ID to download
 * @ param locationId Required PPLocationId File location ID
 * @ param content PPFileContent True - Download the file content URL
 * @ param thumbnail PPFileThumbnail True - Download the thumbnail content URL
 * @ param expiration PPFileURLExpiration URL's expiration in milliseconds since the current time
 * @ param callback PPFileManagementDownloadURLBlock File content block
 **/
- (void)testGetDownloadUrls {
    NSString *methodName = @"GetDownloadUrls";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@/url", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement getDownloadURL:self.file_image.fileId locationId:self.location.locationId content:PPFileContentNone thumbnail:PPFileThumbnailNone expiration:PPFileURLExpirationNone callback:^(NSURL * _Nullable contentURL, NSURL * _Nullable thumbnailURL, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
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
 * @ param fileId Required PPFileId File ID to download
 * @ param apiKey NSString Temporary API key
 * @ param thumbnail PPFileThumbnail True - Download the thumbnail for this file, False - Download the actual file, not the thumbnail, default
 * @ param isPublic PPFilePublicAccess True - Do not include api key in authorization header
 * @ param attach PPFileAttach Download the file content as an attachments with the Content-Disposition header
 * @ param range NSRange Range of bytes to download
 * @ param callback PPFileManagementContentBlock File content block
 **/
- (void)testDownloadFile {
    NSString *methodName = @"DownloadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"data" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement downloadFile:self.file_image.fileId apiKey:self.sessionKey thumbnail:PPFileThumbnailNone isPublic:PPFilePublicAccessNone attach:PPFileAttachNone range:NSMakeRange(0, 0) callback:^(NSData *fileContent, NSString *contentType, NSString *contentRange, NSString *acceptRanges, NSString *contentDisposition, NSInteger statusCode, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}

/**
 * Update file attributes.
 * Update the file's attributes to declare, if the file has been viewed or not, if it's a favourite file and shouldn't be auto-deleted, and whether the file is available for public access.
 * The file publisher (camera) can update it as completed.
 * Also this API can be used to recover deleted files.
 *
 * @ param fileId Required PPFileId File ID to update
 * @ param proxyId NSString Device ID of the proxy that this file is being uploaded through
 * @ param incomplete PPFileIncomplete Set it to false to udpate the file as completed
 * @ param recover PPFileRecover Set it to tru to recover a deleted file
 * @ param userId PPUserId User ID to update the file as an administrator
 * @ param viewed PPFileViewed Mark file as viewed
 * @ param favourite PPFileFavourite Mark file as favourite
 * @ param publicAccess PPFilePublicAccess Mark file as being available publicly
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateFileAttribute {
    NSString *methodName = @"UpdateFileAttribute";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement updateFileAttribute:self.file_image.fileId proxyId:nil incomplete:PPFileIncompleteNone recover:PPFileRecoverTrue userId:PPUserIdNone viewed:PPFileViewedNone favourite:PPFileFavouriteTrue publicAccess:PPFilePublicAccessFalse callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
     
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a file
 *
 * @ param fileId Required PPFileId File ID to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteFile {
    NSString *methodName = @"DeleteFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement deleteFile:self.file_image.fileId locationId:self.location.locationId callback:^(NSError *error) {
            
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
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
 * In addition, each API call will return the user's total available space in bytes, and the space that's already been consumed in bytes. As the amount of space in a user's account is actually on the order of gigabytes, please be sure to use very large variable types to store this information, such as a "long long".
 *
 * @ param aggregation Required PPFileSummaryAggregation The duration of time accross which to aggregate summary information
 * @ param details PPFileSummaryDetails If ture, the API will return detailed inormation - slow.  Otherwise only total number of files will be returned.
 * @ param timezone NSString Time zone ID to separate aggreated summary information. For example, "America/Los_Angeles. See the discussion on Time Zones in IOT Suite documentation
 * @ param type PPFileFileType Filter by type of file.
 * @ param owners PPFileOwners Filter files by owners
 * @ param ownerId PPUserId User ID to filter files by the specific owner
 * @ param startDate NSDate Start date for which to begin returning agggregate summary information on the user's files.
 * @ param endDate NSDate End date for which to stop returning agggregate summary information on the user's files.
 * @ param callback PPFileManagementFilesSummaryBlock Files Summary callback block containing list of file summaries, total file space, and used file space
 **/
- (void)testGetAggregatedListOfFiles {
    NSString *methodName = @"GetAggregatedListOfFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/filesSummary/%@", @(PPFileSummaryAggregationDay)] statusCode:200 headers:nil];
    
    [PPFileManagement getAggregatedListOfFiles:PPFileSummaryAggregationDay locationId:self.location.locationId details:PPFileSummaryDetailsNone timezone:nil type:PPFileFileTypeNone startDate:nil endDate:nil callback:^(NSArray *summaries, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSDate *startDate, NSDate *endDate, PPFileCount filesCount, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - File devices

/**
 * Get list of file devices
 * Return all combinations of device ID's and device descriptions from existing user files.
 *
 * @ param callback PPFileManagementFileDevicesBlock File devices callback block containing list of file devices
 **/
- (void)testGetListOfFileDevices {
    NSString *methodName = @"GetListOfFileDevices";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/fileDevices" statusCode:200 headers:nil];
    
    [PPFileManagement getListOfFileDevices:self.location.locationId callback:^(NSArray *devices, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get File Information

/**
 * Get File Information
 * For public files the API key header is optional.
 *
 * @ param fileId PPFileId File ID of the file for which to retrieve information
 * @ param isPublic PPFilePublicAccess True - Do not provide authorization token in header
 * @ param callback PPFileManagementFileInformationBlock File information callback block containing file reference, temp key, and temp key expiration date
 **/
- (void)testGetFileInformation {
    NSString *methodName = @"GetFileInformation";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/filesInfo/%@", @(self.file_image.fileId)] statusCode:200 headers:nil];
    
    [PPFileManagement getFileInformation:self.file_image.fileId isPublic:PPFilePublicAccessNone locationId:self.location.locationId callback:^(PPFile *file, NSString *tempKey, NSDate *tempKeyExpire, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}
#pragma mark - File Tags

/**
 * Apply tag.
 * Tags are a way to categorize sets of files. Tags can be generated automatically from Composer apps, or manually by the user.
 * Users can only see file tags but not other tags. File tags would be used to help them as they search for one of their private files.
 *
 * @ param fileId Required PPFileId File ID
 * @ param tag Required NSString Tag value
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testApplyTag {
    NSString *methodName = @"ApplyTag";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@/tags/%@", @(self.file_image.fileId), self.tag.tag] statusCode:200 headers:nil];
        
    [PPFileManagement applyTag:self.file_image.fileId tag:self.tag.tag locationId:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delet tag.
 *
 * @ param fileId Required PPFileId File ID
 * @ param tag Required NSString Tag value
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteTag {
    NSString *methodName = @"DeleteTag";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@/tags/%@", @(self.file_image.fileId), self.tag.tag] statusCode:200 headers:nil];
        
    [PPFileManagement deleteTag:self.file_image.fileId tag:self.tag.tag locationId:self.location.locationId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Report Abuse

/**
 * Report Abuse
 * The API Key should only be used if a user is logged in and reporting abuse, and helps support / administrators understand and communicate with the person who is reporting the complaint. If the user is not logged into the system and is instead browsing publicly, then you do not have to include an API key in the header.
 *
 * @ param fileId PPFileId File ID to report
 * @ param reportType NSString Type of report. This is typically "abuse", but may be changed to trigger a different type of email template to support /administrators.
 * @ param isPublic PPFilePublicAccess True - Do not provide authorization token in header
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testReportAbuse {
    NSString *methodName = @"ReportAbuse";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/files/%@/report/%@", @(self.file_image.fileId), @"test"] statusCode:200 headers:nil];
        
    [PPFileManagement reportAbuse:self.file_image.fileId reportType:@"test" isPublic:PPFilePublicAccessNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
