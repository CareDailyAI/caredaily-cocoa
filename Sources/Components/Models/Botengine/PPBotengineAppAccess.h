//
//  PPBotengineAppAccess.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPBotengineAppAccessCategory) {
    PPBotengineAppAccessCategoryLocations = 1,
    PPBotengineAppAccessCategoryDeviceFiles = 2,
    PPBotengineAppAccessCategoryCallCenter = 3,
    PPBotengineAppAccessCategoryDevices = 4
};

@interface PPBotengineAppAccess : PPBaseModel

@property (nonatomic) PPBotengineAppAccessCategory category;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic) NSInteger locationId;
@property (nonatomic) BOOL trigger;
@property (nonatomic) BOOL read;
@property (nonatomic) BOOL control;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic) BOOL excluded;

- (id)initWithCategory:(PPBotengineAppAccessCategory)category deviceId:(NSString *)deviceId locationId:(NSInteger)locationId trigger:(BOOL)trigger read:(BOOL)read control:(BOOL)control reason:(NSString *)reason excluded:(BOOL)excluded;

- (NSString *)JSONString;

@end

