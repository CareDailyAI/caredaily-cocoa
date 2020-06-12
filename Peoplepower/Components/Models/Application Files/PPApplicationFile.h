//
//  PPApplicationFile.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPLocation.h"
#import "PPDevice.h"

typedef NS_OPTIONS(NSInteger, PPApplicationFileId) {
    PPApplicationFileIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFileFileType) {
    PPApplicationFileFileTypeNone = -1,
    PPApplicationFileFileTypeUserImage = 1,
    PPApplicationFileFileTypeLocationImage = 2,
    PPApplicationFileFileTypeDeviceImage = 3,
    PPApplicationFileFileTypeBitmapMask = 4,
    PPApplicationFileFileTypeAny = 5
};

typedef NS_OPTIONS(long long, PPApplicationFileSize) {
    PPApplicationFileSizeNone = -1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFilePublicAccess) {
    PPApplicationFilePublicAccessNone = -1,
    PPApplicationFilePublicAccessFalse = 0,
    PPApplicationFilePublicAccessTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFileAttach) {
    PPApplicationFileAttachNone = -1,
    PPApplicationFileAttachFalse = 0,
    PPApplicationFileAttachTrue = 1
};

@interface PPApplicationFile : NSObject

@property (nonatomic) PPApplicationFileId fileId;
@property (nonatomic) PPApplicationFileFileType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPApplicationFileSize size;
@property (nonatomic) PPUserId userId;
@property (nonatomic) PPLocationId locationId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic) PPApplicationFilePublicAccess publicAccess;
@property (nonatomic, strong) NSData *data;

- (id)initWithFile:(PPApplicationFileId)fileId type:(PPApplicationFileFileType)type name:(NSString *)name size:(PPApplicationFileSize)size userId:(PPUserId)userId locationId:(PPLocationId)locationId deviceId:(NSString *)deviceId publicAccess:(PPApplicationFilePublicAccess)publicAccess data:(NSData *)data;

+ (PPApplicationFile *)initWithDictionary:(NSDictionary *)fileDict;

#pragma mark - Helper methods

- (BOOL)isEqualToFile:(PPApplicationFile *)file;

- (void)sync:(PPApplicationFile *)file;

@end
