//
//  PPStorage.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/16/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPVersion.h"

@interface PPStorage : NSObject

+ (unsigned long long) availableBytes;
+ (BOOL) willItFit:(unsigned long long)availableBytes recordSeconds:(NSInteger)recordSeconds withHd:(BOOL)hdQuality cameraVersion:(PPVersion *)cameraVersion;
+ (NSInteger)howManySecondsWillFit:(unsigned long long)availableBytes withHd:(BOOL)hdQuality cameraVersion:(PPVersion *)cameraVersion;

@end
