//
//  PPCallCenterAlert.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCallCenterAlert.h"

@implementation PPCallCenterAlert

- (id)initWithAlertDate:(NSDate *)alertDate alertDateMS:(NSInteger)alertDateMS alertStatus:(PPCallCenterAlertStatus)alertStatus signalType:(NSString *)signalType signalMessage:(NSString *)signalMessage alertSourceType:(PPCallCenterAlertSourceType)alertSourceType device:(PPDevice *)device {
    self = [super init];
    if(self) {
        self.alertDate = alertDate;
        self.alertDateMS = alertDateMS;
        self.alertStatus = alertStatus;
        self.signalType = signalType;
        self.signalMessage = signalMessage;
        self.alertSourceType = alertSourceType;
        self.device = device;
    }
    return self;
}

+ (PPCallCenterAlert *)initWithDictionary:(NSDictionary *)alertDict {
    NSString *alertDateString = [alertDict objectForKey:@"alertDate"];
    NSDate *alertDate = [NSDate date];
    if(alertDateString != nil) {
        if(![alertDateString isEqualToString:@""]) {
            alertDate = [PPNSDate parseDateTime:alertDateString];
        }
    }
    
    NSInteger alertDateMS = ((NSString *)[alertDict objectForKey:@"alertDateMS"]).integerValue;
    
    PPCallCenterAlertStatus alertStatus = PPCallCenterAlertStatusNone;
    if([alertDict objectForKey:@"alertStatus"]) {
        alertStatus = (PPCallCenterAlertStatus)((NSString *)[alertDict objectForKey:@"alertStatus"]).integerValue;
    }
    NSString *signalType = [alertDict objectForKey:@"signalType"];
    NSString *signalMessage = [alertDict objectForKey:@"signalMessage"];
    PPCallCenterAlertSourceType alertSourceType = PPCallCenterAlertSourceTypeNone;
    if([alertDict objectForKey:@"alertSourceType"]) {
        alertSourceType = (PPCallCenterAlertSourceType)((NSString *)[alertDict objectForKey:@"alertSourceType"]).integerValue;
    }
    PPDevice *device;
    if([alertDict objectForKey:@"device"]) {
        device = [PPDevice initWithDictionary:[alertDict objectForKey:@"device"]];
    }
    
    PPCallCenterAlert *alert = [[PPCallCenterAlert alloc] initWithAlertDate:alertDate alertDateMS:alertDateMS alertStatus:alertStatus signalType:signalType signalMessage:signalMessage alertSourceType:alertSourceType device:device];
    return alert;
}

@end
