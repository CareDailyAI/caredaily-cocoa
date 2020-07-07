//
//  PPBotengineAppDeviceType.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPDeviceType;

@interface PPBotengineAppDeviceType : PPBaseModel

@property (nonatomic, strong) PPDeviceType *deviceType;
@property (nonatomic) NSInteger minOccurence;
@property (nonatomic) BOOL trigger;
@property (nonatomic) BOOL read;
@property (nonatomic) BOOL control;
@property (nonatomic, strong) NSString *reason;

- (id)initWithDeviceType:(PPDeviceType *)deviceType minOccurence:(NSInteger)minOccurence trigger:(BOOL)trigger read:(BOOL)read control:(BOOL)control reason:(NSString *)reason;

@end

