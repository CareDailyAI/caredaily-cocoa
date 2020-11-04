//
//  PPCircleFile.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Files in Circles are completely separate from Files in your own personal account. The files belong to the Circle to be shared securely with everyone in the circle, not your account.
// Files may have short descriptions. Also they are distinguished by types.
//

#import "PPFile.h"
#import "PPUser.h"

@interface PPCircleFile : PPFile

@property (nonatomic, strong) NSString *ext;
@property (nonatomic) PPCircleFileWidth width;
@property (nonatomic) PPCircleFileHeight height;

- (id)initWithId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail name:(NSString *)name type:(PPFileFileType)type  creationDate:(NSDate *)creationDate size:(PPFileSize)size duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate user:(PPUser *)user ext:(NSString *)ext width:(PPCircleFileWidth)width height:(PPCircleFileHeight)height data:(NSData *)data;

+ (PPCircleFile *)initWithDictionary:(NSDictionary *)fileDict;

@end
