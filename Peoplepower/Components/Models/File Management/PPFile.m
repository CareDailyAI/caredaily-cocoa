//
//  PPFile.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPFile.h"
#import "PPNSData.h"

@implementation PPFile

+ (NSString *)primaryKey {
    return @"fileId";
}

- (id)initWithStatus:(NSString *)status fileId:(PPFileId)fileId filesAction:(PPFileFilesAction)filesAction thumbnail:(PPFileThumbnail)thumbnail fragments:(PPFileFragments)fragments name:(NSString *)name type:(PPFileFileType)type publicAccess:(PPFilePublicAccess)publicAccess creationDate:(NSDate *)creationDate size:(PPFileSize)size duration:(PPFileDuration)duration shared:(PPFileShared)shared rotate:(PPFileRotate)rotate device:(PPDevice *)device user:(PPUser *)user viewCount:(PPFileViewCount)viewCount viewed:(PPFileViewed)viewed favourite:(PPFileFavourite)favourite tags:(RLMArray *)tags data:(NSData *)data {
    self = [super init];
    if(self) {
        self.status = status;
        self.fileId = fileId;
        self.filesAction = filesAction;
        self.thumbnail = thumbnail;
        self.fragments = fragments;
        self.name = name;
        self.type = type;
        self.publicAccess = publicAccess;
        self.creationDate = creationDate;
        self.size = size;
        self.duration = duration;
        self.shared = shared;
        self.rotate = rotate;
        self.device = device;
        self.user = user;
        self.viewCount = viewCount;
        self.viewed = viewed;
        self.favourite = favourite;
        self.tags = (RLMArray<PPFileTag *><PPFileTag> *)tags;
        self.data = data;
    }
    return self;
}

+ (PPFile *)initWithDictionary:(NSDictionary *)fileDict {
 
    NSString *status = [fileDict objectForKey:@"status"];
    PPFileId fileId = PPFileIdNone;
    if([fileDict objectForKey:@"id"]) {
        fileId = (PPFileId)((NSString *)[fileDict objectForKey:@"id"]).integerValue;
    }
    if([fileDict objectForKey:@"fileId"]) {
        fileId = (PPFileId)((NSString *)[fileDict objectForKey:@"fileId"]).integerValue;
    }
    if([fileDict objectForKey:@"fileRef"]) {
        fileId = (PPFileId)((NSString *)[fileDict objectForKey:@"fileRef"]).integerValue;
    }
    PPFileFilesAction filesAction = PPFileFilesActionNone;
    if([fileDict objectForKey:@"filesAction"]) {
        filesAction = (PPFileFilesAction)((NSString *)[fileDict objectForKey:@"filesAction"]).integerValue;
    }
    PPFileThumbnail thumbnail = PPFileThumbnailNone;
    if([fileDict objectForKey:@"thumbnail"]) {
        thumbnail = (PPFileThumbnail)((NSString *)[fileDict objectForKey:@"thumbnail"]).integerValue;
    }
    PPFileFragments fragments = PPFileFragmentsNone;
    if([fileDict objectForKey:@"fragments"]) {
        fragments = (PPFileFragments)((NSString *)[fileDict objectForKey:@"fragments"]).integerValue;
    }
    NSString *name = [fileDict objectForKey:@"name"];
    PPFileFileType type = PPFileFileTypeNone;
    if([fileDict objectForKey:@"type"]) {
        type = (PPFileFileType)((NSString *)[fileDict objectForKey:@"type"]).integerValue;
    }
    PPFilePublicAccess publicAccess = PPFilePublicAccessNone;
    if([fileDict objectForKey:@"publicAccess"]) {
        publicAccess = (PPFilePublicAccess)((NSString *)[fileDict objectForKey:@"publicAccess"]).integerValue;
    }
    
    NSString *creationDateString = [fileDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    PPFileSize size = PPFileSizeNone;
    if([fileDict objectForKey:@"size"]) {
        size = (PPFileSize)((NSString *)[fileDict objectForKey:@"size"]).integerValue;
    }
    PPFileDuration duration = PPFileDurationNone;
    if([fileDict objectForKey:@"duration"]) {
        duration = (PPFileDuration)((NSString *)[fileDict objectForKey:@"duration"]).integerValue;
    }
    PPFileShared shared = PPFileSharedNone;
    if([fileDict objectForKey:@"shared"]) {
        shared = (PPFileShared)((NSString *)[fileDict objectForKey:@"shared"]).integerValue;
    }
    PPFileRotate rotate = PPFileRotateNone;
    if([fileDict objectForKey:@"rotate"]) {
        rotate = (PPFileRotate)((NSString *)[fileDict objectForKey:@"rotate"]).integerValue;
    }
    NSData *data;
    if([fileDict objectForKey:@"data"]) {
        if([[fileDict objectForKey:@"data"] isKindOfClass:[NSData class]]) {
            data = [fileDict objectForKey:@"data"];
        }
        else {
            data = [PPNSData dataFromBase64String:[fileDict objectForKey:@"data"]];
        }
    }
    PPDevice *device = [PPDevice initWithDictionary:[fileDict objectForKey:@"device"]];
    PPUser *user;
    if([fileDict objectForKey:@"user"]) {
        user = [PPUser initWithDictionary:[fileDict objectForKey:@"user"]];
    }
    PPFileViewCount viewCount = PPFileViewCountNone;
    if([fileDict objectForKey:@"viewCount"]) {
        viewCount = (PPFileViewCount)((NSString *)[fileDict objectForKey:@"viewCount"]).integerValue;
    }
    PPFileViewed viewed = PPFileViewedNone;
    if([fileDict objectForKey:@"viewed"]) {
        viewed = (PPFileViewed)((NSString *)[fileDict objectForKey:@"viewed"]).integerValue;
    }
    PPFileFavourite favourite = PPFileFavouriteNone;
    if([fileDict objectForKey:@"favourite"]) {
        favourite = (PPFileFavourite)((NSString *)[fileDict objectForKey:@"favourite"]).integerValue;
    }
    NSMutableArray *tags;
    if([fileDict objectForKey:@"tags"]) {
        tags = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *tagDict in [fileDict objectForKey:@"tags"]) {
            PPFileTag *tag = [PPFileTag initWithDictionary:tagDict];
            [tags addObject:tag];
        }
    }
    
    PPFile *file = [[PPFile alloc] initWithStatus:status fileId:fileId filesAction:filesAction thumbnail:thumbnail fragments:fragments name:name type:type publicAccess:publicAccess creationDate:creationDate size:size duration:duration shared:shared rotate:rotate device:device user:user viewCount:viewCount viewed:viewed favourite:favourite tags:(RLMArray *)tags data:data];
    return file;
}

+ (NSString *)stringify:(PPFile *)file {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    if(file.viewed != PPFileViewedNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"viewed\":%li", (long)file.viewed];
        appendComma = YES;
    }
    
    if(file.favourite != PPFileFavouriteNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"favourite\":%li", (long)file.favourite];
        appendComma = YES;
    }
    
    if(file.publicAccess != PPFilePublicAccessNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"publicAccess\":%li", (long)file.publicAccess];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;

}

#pragma mark - Helper methods

- (BOOL)isEqualToFile:(PPFile *)file {
    BOOL equal = NO;
    
    if(file.fileId != PPFileIdNone && _fileId != PPFileIdNone) {
        if(file.fileId == _fileId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPFile *)file {
    
    if(file.status) {
        _status = file.status;
    }
    if(file.fileId != PPFileIdNone) {
        _fileId = file.fileId;
    }
    if(file.filesAction != PPFileFilesActionNone) {
        _filesAction = file.filesAction;
    }
    if(file.thumbnail != PPFileThumbnailNone) {
        _thumbnail = file.thumbnail;
    }
    if(file.fragments != PPFileFragmentsNone) {
        _fragments = file.fragments;
    }
    if(file.name) {
        _name = file.name;
    }
    if(file.type != PPFileFileTypeNone) {
        _type = file.type;
    }
    if(file.publicAccess != PPFilePublicAccessNone) {
        _publicAccess = file.publicAccess;
    }
    if(file.creationDate) {
        _creationDate = file.creationDate;
    }
    if(file.size != PPFileSizeNone) {
        _size = file.size;
    }
    if(file.duration != PPFileDurationNone) {
        _duration = file.duration;
    }
    if(file.shared != PPFileSharedNone) {
        _shared = file.shared;
    }
    if(file.rotate != PPFileRotateNone) {
        _rotate = file.rotate;
    }
    if(file.device) {
        _device = file.device;
    }
    if(file.user) {
        _user = file.user;
    }
    if(file.viewCount != PPFileViewCountNone) {
        _viewCount = file.viewCount;
    }
    if(file.viewed != PPFileViewedNone) {
        _viewed = file.viewed;
    }
    if(file.favourite != PPFileFavouriteNone) {
        _favourite = file.favourite;
    }
    if(file.tags) {
        _tags = file.tags;
    }
    if(file.data) {
        _data = file.data;
    }
}
@end
