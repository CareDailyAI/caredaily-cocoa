//
//  PPTCApplicationFiles.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/20/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPApplicationFileManagement.h>

static NSString *moduleName = @"ApplicationFiles";

@interface PPTCApplicationFiles : PPBaseTestCase

@property (strong, nonatomic) PPApplicationFile *file;
@end

@implementation PPTCApplicationFiles

- (void)setUp {
    [super setUp];
    NSDictionary *fileDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_FILE_MANAGEMENT_IMAGE filename:PLIST_FILE_UNIT_TESTS];
    NSArray *fileNameComponents = [[fileDict objectForKey:@"fileName"] componentsSeparatedByString:@"."];
    
    self.file = [PPApplicationFile initWithDictionary:fileDict];
    self.file.data = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:[fileNameComponents firstObject] withExtension:[fileNameComponents lastObject]]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Files Management

/**
 * Upload File Content.
 * The "Content-Type" header must be like "image/...", "video/...", "audio/..." or "application/octet-stream"
 * For example: image/jpeg, video/mp4, audio/mp3.
 *
 * @ param fileId PPApplicationFileId Existing file ID to replace the content and properties
 * @ param type Requried PPApplicationFileFileType File type
 * @ param userId PPUserId User ID associated with this file. It can be used by organization administrators to upload files on other user acccount.s
 * @ param locationId PPLocationId Location ID associated with this file
 * @ param deviceId NSString Device ID associated with this file
 * @ param name NSString File name
 * @ param publicAccess PPApplicationFilePublicAccess Publicly available file
 * @ param contentType Required NSString Content-Type header.
 * @ param data Required NSData File data
 * @ param callback PPApplicationFileManagementUploadFileBlock Upload file callback block containing file id
 **/
- (void)testUploadFile {
    NSString *methodName = @"UploadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/appfiles" statusCode:200 headers:nil];
    
    [PPApplicationFileManagement uploadFile:self.file.fileId type:PPApplicationFileFileTypeUserImage userId:PPUserIdNone locationId:PPLocationIdNone deviceId:nil name:nil publicAccess:PPApplicationFilePublicAccessNone contentType:@"image/jpeg" data:self.file.data progressBlock:^(NSProgress *progress) {
        
    } callback:^(PPApplicationFileId fileId, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get Files.
 * Return a list of the user's files filtered by query parameters.
 *
 * @ param fileId PPApplicationFileId File ID Filter
 * @ param type PPApplicationFileFileType File type
 * @ param userId PPUserId User ID associated with this file. It can be used by organization administrators to upload files on other user acccount.s
 * @ param locationId PPLocationId Location ID associated with this file
 * @ param deviceId NSString Device ID associated with this file
 * @ param name NSString File name
 * @ param isPublic PPApplicationFilePublicAccess True - Do not include api key in authorization header
 * @ param callback PPApplicationFileManagementFilesBlock Files callback containing list of files, along with temp key and temp key expiry
 **/
- (void)testGetFiles {
    NSString *methodName = @"GetFiles";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/espapi/cloud/json/appfiles" statusCode:200 headers:nil];
    
    [PPApplicationFileManagement getFiles:PPApplicationFileIdNone type:PPApplicationFileFileTypeNone userId:PPUserIdNone locationId:PPLocationIdNone deviceId:nil name:nil isPublic:PPApplicationFilePublicAccessNone callback:^(NSArray *files, NSString *tempKey, NSDate *tempKeyExpire, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
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
 * @ param fileId Required PPApplicationFileId File ID to download
 * @ param apiKey NSString Temporary API key
 * @ param userId PPUserId User ID to download file as administrator.
 * @ param locationId PPLocationId Location ID to download file as administrator.
 * @ param isPublic PPApplicationFilePublicAccess True - Do not include api key in authorization header
 * @ param attach PPApplicationFileAttach Download the file content as an attachments with the Content-Disposition header
 * @ param range NSRange Range of bytes to download
 * @ param callback PPApplicationFileManagementContentBlock File content block
 **/
- (void)testDownloadFile {
    NSString *methodName = @"DownloadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"data" path:[NSString stringWithFormat:@"/espapi/cloud/json/appfiles/%@", @(self.file.fileId)] statusCode:200 headers:@{
        @"Content-Type": @"img/png",
        @"Content-Range": @"bytes 21010-47021/47022",
        @"Accept-Ranges": @"0-47022",
        @"Content-Disposition": @"attachment",
    }];
    
        
    [PPApplicationFileManagement downloadFile:self.file.fileId apiKey:nil userId:PPUserIdNone locationId:PPLocationIdNone isPublic:PPApplicationFilePublicAccessNone attach:PPApplicationFileAttachNone range:NSMakeRange(0, 0) callback:^(NSData *fileContent, NSString *contentType, NSString *contentRange, NSString *acceptRanges, NSString *contentDisposition, NSInteger statusCode, NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:30.0];
}
/**
 * Delete a File.
 *
 * @ param fileId Required PPApplicationFileId File ID to delete
 * @ param userId PPUserId User ID to delete file as administrator.
 * @ param locationId PPLocationId Location ID to delete file as administrator.
 * @ param callback PPErrorBlock callback
 **/
- (void)testDeleteFile {
    NSString *methodName = @"DeleteFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/espapi/cloud/json/appfiles/%@", @(self.file.fileId)] statusCode:200 headers:nil];
    
    [PPApplicationFileManagement deleteFile:self.file.fileId apiKey:nil userId:PPUserIdNone locationId:PPLocationIdNone callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}


@end
