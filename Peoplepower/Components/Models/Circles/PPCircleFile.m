//
//  PPCircleFile.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCircleFile.h"

@implementation PPCircleFile

- (id)initWithId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail name:(NSString *)name type:(PPFileFileType)type creationDate:(NSDate *)creationDate size:(PPFileSize)size duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate user:(PPUser *)user ext:(NSString *)ext width:(PPCircleFileWidth)width height:(PPCircleFileHeight)height data:(NSData *)data {
    self = [super initWithStatus:nil fileId:fileId filesAction:PPFileFilesActionNone thumbnail:thumbnail fragments:PPFileFragmentsNone name:name type:type publicAccess:PPFilePublicAccessNone creationDate:creationDate size:size duration:duration shared:PPFileSharedNone rotate:rotate device:nil user:user viewCount:PPFileViewCountNone viewed:PPFileViewedNone favourite:PPFileFavouriteNone tags:nil data:data];
    if(self) {
        self.ext = ext;
        self.width = width;
        self.height = height;
    }
    return self;
}

+ (PPCircleFile *)initWithDictionary:(NSDictionary *)fileDict {
    PPFile *file = [super initWithDictionary:fileDict];
    
    NSString *ext = [fileDict objectForKey:@"ext"];
    PPCircleFileWidth width = PPCircleFileWidthNone;
    if([fileDict objectForKey:@"width"]) {
        width = (PPCircleFileWidth)((NSString *)[fileDict objectForKey:@"width"]).integerValue;
    }
    PPCircleFileHeight height = PPCircleFileHeightNone;
    if([fileDict objectForKey:@"height"]) {
        height = (PPCircleFileHeight)((NSString *)[fileDict objectForKey:@"height"]).integerValue;
    }
    
    PPCircleFile *circleFile = [[PPCircleFile alloc] initWithId:file.fileId thumbnail:file.thumbnail name:file.name type:file.type creationDate:file.creationDate size:file.size duration:file.duration rotate:file.rotate user:file.user ext:ext width:width height:height data:file.data];
    return circleFile;
}

@end
