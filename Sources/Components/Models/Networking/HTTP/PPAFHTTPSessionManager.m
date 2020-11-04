//
//  PPAFHTTPSessionManager.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPAFHTTPSessionManager.h"
#import "PPCurlDebug.h"
@import AFNetworking;

@implementation PPAFHTTPSessionManager

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
							completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
	
	PPLogAPI(@"%@", [PPCurlDebug requestToDescription:request]);
	
    return [super dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:completionHandler];
	
}
#pragma clang diagnostic pop

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request uploadProgress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock downloadProgress:(void (^)(NSProgress * _Nonnull))downloadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler {
    
    PPLogAPI(@"%@", [PPCurlDebug requestToDescription:request]);
    
    return [super dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler {
    
    PPLogAPI(@"%@", [PPCurlDebug requestToDescription:request]);
    
    return [super uploadTaskWithStreamedRequest:request progress:uploadProgressBlock completionHandler:completionHandler];
}

@end
