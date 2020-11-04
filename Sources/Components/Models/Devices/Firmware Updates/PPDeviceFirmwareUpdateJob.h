//
//  PPDeviceFirmwareUpdateJob.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/17/17.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDevice.h"

@interface PPDeviceFirmwareUpdateJob : PPBaseModel

@property (nonatomic) PPDeviceFirmwareUpdateJobId jobId;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *firmware;
@property (nonatomic, strong) NSString *currentFirmware;
@property (nonatomic) PPDeviceFirmwareUpdateStatus status;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *checkSum;
@property (nonatomic, strong) NSDate *notificationDate;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) PPDevice *device;

- (id)initWithJobId:(PPDeviceFirmwareUpdateJobId)jobId index:(NSString *)index firmware:(NSString *)firmware currentFirmware:(NSString *)currentFirmware status:(PPDeviceFirmwareUpdateStatus)status url:(NSString *)url checkSum:(NSString *)checkSum notificationDate:(NSDate *)notificationDate startDate:(NSDate *)startDate device:(PPDevice *)device;

+ (PPDeviceFirmwareUpdateJob *)initWithDictionary:(NSDictionary *)jobDict;

- (NSString *)statusString;
- (BOOL)isHostOTAUCompatible;

@end
