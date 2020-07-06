//
//  PPDeviceFirmwareUpdateDownloadManager.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/17/17.
//  Copyright © 2017 People Power. All rights reserved.
//

#import "PPDeviceFirmwareUpdateDownloadManager.h"
#import "PPDeviceFirmwareUpdateJob.h"
#import <AVFoundation/AVFoundation.h>

@interface PPDeviceFirmwareUpdateDownloadManager()
@property (nonatomic, strong) PPHTTPOperation *downloadOperation;
@property (nonatomic, strong) NSTimer *exportProgressTimer;
@end

@implementation PPDeviceFirmwareUpdateDownloadManager

- (void)download:(PPDeviceFirmwareUpdateJob *)job tempKey:(NSString *)tempKey {
    __block PPDeviceFirmwareUpdateJob *singleJob = job;
    NSURL *url = [NSURL URLWithString:job.url];

    __weak PPDeviceFirmwareUpdateDownloadManager *weakSelf = self;

    PPCloudEngine *cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    PPHTTPOperation *operation = [cloudEngine operationWithRequest:request progressBlock:^(NSProgress *progress) {
        if([weakSelf.delegate respondsToSelector:@selector(downloading:progress:)]) {
            [weakSelf.delegate downloading:singleJob progress:progress];
        }
    } success:^(NSData *responseData, NSObject *response) {
        weakSelf.downloadOperation = nil;
        if([weakSelf.delegate respondsToSelector:@selector(completedDownload:error:)]) {
            [weakSelf.delegate completedDownload:singleJob error:nil];
        }
    } failure:^(NSError *error) {
        weakSelf.downloadOperation = nil;
        if([weakSelf.delegate respondsToSelector:@selector(completedDownload:error:)]) {
            [weakSelf.delegate completedDownload:singleJob error:[PPBaseModel resultCodeToNSError:10042 originatingClass:NSStringFromClass([self class])]];
        }
    }];
    
    _downloadOperation = operation;
}

/**
 * Cancel the operation
 */
- (void)cancelDownload {
    if(_downloadOperation) {
        [_downloadOperation cancel];
    }
}

+ (NSString *)localFilePathForJob:(PPDeviceFirmwareUpdateJob *)job {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *localFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [job.url lastPathComponent]]];
    return localFilePath;
}

+ (BOOL)downloadedJob:(PPDeviceFirmwareUpdateJob *)job {
    NSArray *files = [[NSBundle mainBundle] pathsForResourcesOfType:@".img" inDirectory:@"./"];
    
    NSMutableArray *filesArray = [[NSMutableArray alloc] initWithCapacity:files.count + 1];
    for(NSString *filePath in files) {
        [filesArray addObject:filePath.lastPathComponent];
        if([filePath.lastPathComponent isEqualToString:job.url.lastPathComponent]) {
            return YES;
        }
    }
    return NO;
}

@end
