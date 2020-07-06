//
//  PPDeviceFirmwareUpdateDownloadManager.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/17/17.
//  Copyright © 2017 People Power. All rights reserved.
//

#import "PPBaseModel.h"
@class PPDeviceFirmwareUpdateJob;

@protocol PPDeviceFirmwareUpdateDownloadManagerDelegate <NSObject>
@optional
- (void)completedDownload:(PPDeviceFirmwareUpdateJob *)job error:(NSError *)error;
- (void)downloading:(PPDeviceFirmwareUpdateJob *)job progress:(NSProgress *)progress;
@end


@interface PPDeviceFirmwareUpdateDownloadManager : NSObject

@property (nonatomic, weak, readwrite) NSObject<PPDeviceFirmwareUpdateDownloadManagerDelegate> *delegate;

- (void)download:(PPDeviceFirmwareUpdateJob *)job tempKey:(NSString *)tempKey;
- (void)cancelDownload;
+ (NSString *)localFilePathForJob:(PPDeviceFirmwareUpdateJob *)job;
+ (BOOL)downloadedJob:(PPDeviceFirmwareUpdateJob *)job;


@end
