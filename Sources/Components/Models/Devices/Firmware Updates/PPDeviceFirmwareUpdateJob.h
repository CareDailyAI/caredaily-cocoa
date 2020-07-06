//
//  PPDeviceFirmwareUpdateJob.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/17/17.
//  Copyright © 2017 People Power. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDevice.h"

typedef NS_OPTIONS(NSInteger, PPDeviceFirmwareUpdateStatus) {
    PPDeviceFirmwareUpdateStatusNone = -1,
    PPDeviceFirmwareUpdateStatusDone = 0,
    PPDeviceFirmwareUpdateStatusAvailable = 1,
    PPDeviceFirmwareUpdateStatusApproved = 2,
    PPDeviceFirmwareUpdateStatusDecline = 3,
    PPDeviceFirmwareUpdateStatusStarted = 4,
};

extern NSString *FIRMWARE_UPDATE_INDEX_BLE;
extern NSString *FIRMWARE_UPDATE_INDEX_MOTOR;

typedef NS_OPTIONS(NSInteger, PPDeviceFirmwareUpdateJobId) {
    PPDeviceFirmwareUpdateJobIdNone = -1
};

@interface PPDeviceFirmwareUpdateJob : RLMObject

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

RLM_ARRAY_TYPE(PPDeviceFirmwareUpdateJob);
