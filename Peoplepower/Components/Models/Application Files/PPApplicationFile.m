//
//  PPApplicationFile.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPApplicationFile.h"
#import "PPNSData.h"

@implementation PPApplicationFile

- (id)initWithFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type name:(NSString *)name size:(PPApplicationFileSize)size userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId publicAccess:(PPApplicationFilePublicAccess)publicAccess data:(NSData *)data {
    self = [super init];
    if(self) {
        self.fileId = fileId;
        self.type = type;
        self.name = name;
        self.size = size;
        self.deviceId = deviceId;
        self.userId = userId;
        self.locationId = locationId;
        self.publicAccess = publicAccess;
        self.data = data;
    }
    return self;
}

+ (PPApplicationFile *)initWithDictionary:(NSDictionary *)fileDict {
    
    PPApplicationFileId fileId = PPApplicationFileIdNone;
    if([fileDict objectForKey:@"id"]) {
        fileId = (PPApplicationFileId)((NSString *)[fileDict objectForKey:@"id"]).integerValue;
    }
    PPApplicationFileFileType type = PPApplicationFileFileTypeNone;
    if([fileDict objectForKey:@"type"]) {
        type = (PPApplicationFileFileType)((NSString *)[fileDict objectForKey:@"type"]).integerValue;
    }
    NSString *name = [fileDict objectForKey:@"name"];
    PPApplicationFileSize size = PPApplicationFileSizeNone;
    if([fileDict objectForKey:@"size"]) {
        size = (PPApplicationFileSize)((NSString *)[fileDict objectForKey:@"size"]).integerValue;
    }
    NSString *deviceId = [fileDict objectForKey:@"deviceId"];
    PPLocationId locationId = PPLocationIdNone;
    if([fileDict objectForKey:@"locationId"]) {
        locationId = (PPLocationId)((NSString *)[fileDict objectForKey:@"locationId"]).integerValue;
    }
    PPUserId userId = PPUserIdNone;
    if([fileDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[fileDict objectForKey:@"userId"]).integerValue;
    }
    PPApplicationFilePublicAccess publicAccess = PPApplicationFilePublicAccessNone;
    if([fileDict objectForKey:@"publicAccess"]) {
        publicAccess = (PPApplicationFilePublicAccess)((NSString *)[fileDict objectForKey:@"publicAccess"]).integerValue;
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
    
    PPApplicationFile *file = [[PPApplicationFile alloc] initWithFile:fileId type:type name:name size:size userId:userId locationId:locationId deviceId:deviceId publicAccess:publicAccess data:data];
    return file;
}

#pragma mark - Helper methods

#pragma mark - Helper methods

- (BOOL)isEqualToFile:(PPApplicationFile *)file {
    BOOL equal = NO;
    
    if(file.fileId != PPApplicationFileIdNone && _fileId != PPApplicationFileIdNone) {
        if(file.fileId == _fileId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPApplicationFile *)file {
    
    if(file.fileId != PPApplicationFileIdNone) {
        _fileId = file.fileId;
    }
    if(file.type != PPApplicationFileFileTypeNone) {
        _type = file.type;
    }
    if(file.name) {
        _name = file.name;
    }
    if(file.size != PPApplicationFileSizeNone) {
        _size = file.size;
    }
    if(file.userId != PPUserIdNone) {
        _userId = file.userId;
    }
    if(file.locationId != PPLocationIdNone) {
        _locationId = file.locationId;
    }
    if(file.publicAccess != PPApplicationFilePublicAccessNone) {
        _publicAccess = file.publicAccess;
    }
    if(file.data) {
        _data = file.data;
    }
}

@end
