//
//  PPTCCommunity.m
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPCommunity.h>

static NSString *moduleName = @"Community";

@interface PPTCCommunity : PPBaseTestCase

@property (strong, nonatomic) PPCommunityPost *post;
@property (strong, nonatomic) PPCommunityComment *comment;
@property (strong, nonatomic) PPCommunityFile *file_video;
@property (strong, nonatomic) PPCommunityFile *file_image;
@property (strong, nonatomic) PPCommunityFile *file_audio;

@end

@implementation PPTCCommunity

- (void)setUp {
    [super setUp];
    NSDictionary *postDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_COMMUNITY_POST filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *commentDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_COMMUNITY_COMMENT filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *fileDict_video = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_COMMUNITY_FILE_VIDEO filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *fileDict_image = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_COMMUNITY_FILE_IMAGE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *fileDict_audio = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_COMMUNITY_FILE_AUDIO filename:PLIST_FILE_UNIT_TESTS];
    
    self.post = [PPCommunityPost initWithDictionary:postDict];
    self.comment = [PPCommunityComment initWithDictionary:commentDict];
    self.file_video = [PPCommunityFile initWithDictionary:fileDict_video];
    self.file_image = [PPCommunityFile initWithDictionary:fileDict_image];
    self.file_audio = [PPCommunityFile initWithDictionary:fileDict_audio];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatePost {
    NSString *methodName = @"CreatePost";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPosts" statusCode:200 headers:nil];
    
    [PPCommunity createPost:self.post callback:^(PPCommunityPostId postId, NSError * _Nonnull error) {

        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUpdatePost {
    NSString *methodName = @"UpdatePost";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPosts" statusCode:200 headers:nil];
    
    [PPCommunity updatePost:self.post.postId post:self.post callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testGetPosts {
    NSString *methodName = @"GetPosts";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPosts" statusCode:200 headers:nil];
    
    [PPCommunity getPosts:PPCommunityPostIdNone postTypes:nil locationId:PPLocationIdNone communityId:PPCommunityIdNone communityLocationId:PPLocationIdNone startDate:nil endDate:nil status:PPCommunityPostStatusNone callback:^(NSArray * _Nonnull posts, NSError * _Nonnull error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testDeletePost {
    NSString *methodName = @"DeletePost";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPosts" statusCode:200 headers:nil];
    
    [PPCommunity deletePost:self.post.postId callback:^(NSError *error) {
        
        XCTAssertNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testComment {
    NSString *methodName = @"Comment";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPostComments" statusCode:200 headers:nil];
     
    [PPCommunity comment:self.post.postId commentId:PPCommunityCommentIdNone replyCommentId:PPCommunityCommentIdNone comment:self.comment.commentText callback:^(PPCommunityCommentId commentId, NSError * _Nullable error) {

         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testDeleteComment {
    NSString *methodName = @"DeleteComment";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPostComments" statusCode:200 headers:nil];
     
    [PPCommunity deleteComment:self.post.postId commentId:self.comment.commentId callback:^(NSError * _Nullable error) {

         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testReaction {
    NSString *methodName = @"Reaction";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/communityPostReaction" statusCode:200 headers:nil];
     
    [PPCommunity reaction:self.post.postId commentId:PPCommunityCommentIdNone reaction:PPCommunityReactionTypeLike callback:^(NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadFile_video {
    NSString *methodName = @"UploadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:[NSString stringWithFormat:@"%@-video", methodName]];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity uploadFile:_post.postId type:_file_video.type contentType:_file_video.contentType ext:_file_video.ext duration:_file_video.duration rotate:_file_video.rotate size:_file_video.size thumbnail:_file_video.thumbnail m3u8:_file_video.m3u8 expiration:-1 callback:^(NSInteger fileId, NSString * _Nullable contentUrl, NSString * _Nullable thumbnailUrl, NSString * _Nullable m3u8Url, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadFile_image {
    NSString *methodName = @"UploadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:[NSString stringWithFormat:@"%@-image", methodName]];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity uploadFile:_post.postId type:_file_image.type contentType:_file_image.contentType ext:_file_image.ext duration:_file_image.duration rotate:_file_image.rotate size:_file_image.size thumbnail:_file_image.thumbnail m3u8:_file_image.m3u8 expiration:-1 callback:^(NSInteger fileId, NSString * _Nullable contentUrl, NSString * _Nullable thumbnailUrl, NSString * _Nullable m3u8Url, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUploadFile_audio {
    NSString *methodName = @"UploadFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:[NSString stringWithFormat:@"%@-audio", methodName]];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity uploadFile:_post.postId type:_file_audio.type contentType:_file_audio.contentType ext:_file_audio.ext duration:_file_audio.duration rotate:_file_audio.rotate size:_file_audio.size thumbnail:_file_audio.thumbnail m3u8:_file_audio.m3u8 expiration:-1 callback:^(NSInteger fileId, NSString * _Nullable contentUrl, NSString * _Nullable thumbnailUrl, NSString * _Nullable m3u8Url, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testUpdateFile {
    NSString *methodName = @"UpdateFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity updateFile:_post.postId fileId:_file_video.fileId complete:PPCommunityFileCompleteTrue callback:^(NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testGetFileURLs {
    NSString *methodName = @"GetFileURLs";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity getFileURLs:_post.postId fileId:_file_video.fileId content:1 thumbnail:1 m3u8:1 expiration:-1 callback:^(NSArray<PPCommunityFile *> * _Nullable files, NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

- (void)testDeleteFile {
    NSString *methodName = @"DeleteFile";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/communityPosts/%@/files", @(_post.postId)] statusCode:200 headers:nil];
     
    [PPCommunity deleteFile:_post.postId fileId:_file_video.fileId callback:^(NSError * _Nullable error) {
        
         XCTAssertNil(error);
         [expectation fulfill];
         
     }];
     
     [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
