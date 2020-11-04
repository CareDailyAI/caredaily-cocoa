//
//  PPApplicationFile.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPLocation.h"
#import "PPDevice.h"

@interface PPApplicationFile : PPBaseModel

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
