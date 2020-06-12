//
//  PPBotengineAppDeviceType.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppDeviceType.h"
#import "PPDeviceType.h"

@implementation PPBotengineAppDeviceType

- (id)initWithDeviceType:(PPDeviceType *)deviceType minOccurence:(NSInteger)minOccurence trigger:(BOOL)trigger read:(BOOL)read control:(BOOL)control reason:(NSString *)reason {
    self = [super init];
    if(self) {
        self.deviceType = deviceType;
        self.minOccurence = minOccurence;
        self.trigger = trigger;
        self.read = read;
        self.control = control;
        self.reason = reason;
    }
    return self;
}

@end
