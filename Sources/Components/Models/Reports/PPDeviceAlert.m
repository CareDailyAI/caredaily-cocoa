//
//  PPDeviceAlert.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/17/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceAlert.h"

@implementation PPDeviceAlert

- (id)initWithType:(NSString *)alertType count:(PPDeviceAlertCount)count {
    self = [super init];
    if(self) {
        self.alertType = alertType;
        self.count = count;
    }
    return self;
}

+ (PPDeviceAlert *)initWithDictionary:(NSDictionary *)alertDict {
    NSString *alertType = [alertDict objectForKey:@"alertType"];
    PPDeviceAlertCount count = PPDeviceAlertCountNone;
    if([alertDict objectForKey:@"alertType"]) {
        count = (PPDeviceAlertCount)((NSString *)[alertDict objectForKey:@"alertType"]).integerValue;
    }
    
    PPDeviceAlert *alert = [[PPDeviceAlert alloc] initWithType:alertType count:count];
    return alert;
}

@end
