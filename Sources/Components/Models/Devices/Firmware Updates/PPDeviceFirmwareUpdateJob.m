//
//  PPDeviceFirmwareUpdateJob.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/17/17.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceFirmwareUpdateJob.h"
#import "PPCloudEngine.h"

@implementation PPDeviceFirmwareUpdateJob

+ (NSString *)primaryKey {
    return @"jobId";
}

- (id)initWithJobId:(PPDeviceFirmwareUpdateJobId)jobId index:(NSString *)index firmware:(NSString *)firmware currentFirmware:(NSString *)currentFirmware status:(PPDeviceFirmwareUpdateStatus)status url:(NSString *)url checkSum:(NSString *)checkSum notificationDate:(NSDate *)notificationDate startDate:(NSDate *)startDate device:(PPDevice *)device {
    self = [super init];
    if(self) {
        self.jobId = jobId;
        self.index = index;
        self.firmware = firmware;
        self.currentFirmware = currentFirmware;
        self.status = status;
        self.url = url;
        self.checkSum = checkSum;
        self.notificationDate = notificationDate;
        self.startDate = startDate;
        self.device = device;
    }
    return self;
}

+ (PPDeviceFirmwareUpdateJob *)initWithDictionary:(NSDictionary *)jobDict {
    PPDeviceFirmwareUpdateJobId jobId = PPDeviceFirmwareUpdateJobIdNone;
    if([jobDict objectForKey:@"id"]) {
        jobId = (PPDeviceFirmwareUpdateJobId)((NSString *)[jobDict objectForKey:@"id"]).integerValue;
    }
    NSString *index = [jobDict objectForKey:@"index"];
    NSString *firmware = [jobDict objectForKey:@"firmware"];
    NSString *currentFirmware = [jobDict objectForKey:@"currentFirmware"];
    PPDeviceFirmwareUpdateStatus status = PPDeviceFirmwareUpdateStatusNone;
    if([jobDict objectForKey:@"index"]) {
        status = (PPDeviceFirmwareUpdateStatus)((NSString *)[jobDict objectForKey:@"index"]).integerValue;
    }
    NSString *url = [jobDict objectForKey:@"url"];
    NSString *checkSum = [jobDict objectForKey:@"checkSum"];
    
    NSString *notificationDateString = [jobDict objectForKey:@"notificationDate"];
    NSDate *notificationDate = [NSDate date];
    if(notificationDateString != nil) {
        if(![notificationDateString isEqualToString:@""]) {
            notificationDate = [PPNSDate parseDateTime:notificationDateString];
        }
    }
    
    NSString *startDateString = [jobDict objectForKey:@"startDate"];
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    PPDevice *device = [PPDevice initWithDictionary:[jobDict objectForKey:@"device"]];
    PPDeviceFirmwareUpdateJob *job = [[PPDeviceFirmwareUpdateJob alloc] initWithJobId:jobId index:index firmware:firmware currentFirmware:currentFirmware status:status url:url checkSum:checkSum notificationDate:notificationDate startDate:startDate device:device];
    return job;
}

- (NSString *)statusString {
    NSString *statusString = @"";
    switch (_status) {
        case PPDeviceFirmwareUpdateStatusAvailable:
            statusString = NSLocalizedStringFromTableInBundle(@"Available", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Firmware Update - Available");
            break;
        case PPDeviceFirmwareUpdateStatusApproved:
            statusString = NSLocalizedStringFromTableInBundle(@"Approved", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Firmware Update - Approved");
            break;
        case PPDeviceFirmwareUpdateStatusDecline:
            statusString = NSLocalizedStringFromTableInBundle(@"Declined", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Firmware Update - Declined");
            break;
        case PPDeviceFirmwareUpdateStatusStarted:
            statusString = NSLocalizedStringFromTableInBundle(@"Started", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Firmware Update - Started");
            break;
            
        default:
            statusString = @"";
            break;
    }
    return statusString;
}

- (BOOL)isHostOTAUCompatible {
    BOOL supported = YES;
//    if([_device parameterWithName:FIRMWARE]) {
//        float os = ((NSString *)[_device parameterWithName:FIRMWARE]).floatValue;
//        if(_device.typeId == PPDeviceTypeIdiOSMobileCamera) {
//            if(os < 10.0) {
//                supported = NO;
//            }
//        }
//    }
    return supported;
}

@end
