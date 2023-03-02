//
//  PPStorage.m
//  Peoplepower
//
//  Created by Destry Teeter on 8/16/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPStorage.h"

@implementation PPStorage

/**
 * Get the total free space on the file system
 */
+ (unsigned long long)availableBytes {
    unsigned long long totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        totalFreeSpace = [[dictionary objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
    }
    
    return totalFreeSpace;
}



/**
 * Find out if a video will fit on the camera's available storage
 * @param availableBytes the total available bytes on the camera
 * @param recordSeconds the total number of seconds to record
 * @param hdQuality YES if HD is enabled (assumes 1080p to be safe)
 * @param cameraVersion Version number of the camera, because we might change the storage requirements in future camera revisions
 * @return YES if the desired video is expected to fit
 */
+ (BOOL) willItFit:(unsigned long long)availableBytes recordSeconds:(NSInteger)recordSeconds withHd:(BOOL)hdQuality cameraVersion:(PPVersion *)cameraVersion {
    // This was written for 2.0.0 cameras, which don't support HLS.
    // The 2.0.0 storage mechanism is this: record 1 second of video, then record the rest of the video, then stitch the two together to form a final video
    // So we need double the amount of storage available.
    // Medium quality = approximately 140,000 bytes per second (measured) => round up to 150000 bytes per second
    // HD quality = assume 1080p = 1,258,390 bytes per second (measured) => round up to 1300000 bytes per second
    
    if(hdQuality) {
        unsigned long long estimatedSize = 1300000ll * recordSeconds;
        estimatedSize *= 2;
        return estimatedSize < availableBytes;
    }
    else {
        unsigned long long estimatedSize = 150000ll * recordSeconds;
        estimatedSize *= 2;
        return estimatedSize < availableBytes;
    }
}

/**
 * Find out approximately how many seconds of video will fit within the given available bytes
 * @param availableBytes total bytes available to write to
 * @param withHd YES if HD is enabled (assumes 1080p to be safe)
 * @param cameraVersion Version number of the camrea, because we might change the storage requirements in future camera revisions
 * @return estimated number of seconds that should safely fit in the available bytes
 */
+ (NSInteger)howManySecondsWillFit:(unsigned long long)availableBytes withHd:(BOOL)withHd cameraVersion:(PPVersion *)cameraVersion {
    // This was written for 2.0.0 cameras, which don't support HLS.
    // The 2.0.0 storage mechanism is this: record 1 second of video, then record the rest of the video, then stitch the two together to form a final video
    // So we need double the amount of storage available.
    // Medium quality = approximately 140,000 bytes per second (measured) => round up to 150000 bytes per second
    // HD quality = assume 1080p = 1,258,390 bytes per second (measured) => round up to 1300000 bytes per second
    
    if(withHd) {
        return (NSInteger) ((availableBytes / 2) / 1300000ll);
    }
    else {
        return (NSInteger) ((availableBytes / 2) / 150000ll);
    }
}


@end
