//
//  PPBotengineAppAccess.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBotengineAppAccess.h"

@implementation PPBotengineAppAccess

- (id)initWithCategory:(PPBotengineAppAccessCategory)category deviceId:(NSString *)deviceId locationId:(NSInteger)locationId trigger:(BOOL)trigger read:(BOOL)read control:(BOOL)control reason:(NSString *)reason excluded:(BOOL)excluded {
    self = [super init];
    if(self) {
        self.category = category;
        self.deviceId = deviceId;
        self.locationId = locationId;
        self.trigger = trigger;
        self.read = read;
        self.control = control;
        self.reason = reason;
        self.excluded = excluded;
    }
    
    return self;
}

- (NSString *)JSONString {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    [JSONString appendFormat:@"\"category\":\"%lu\"", (long)self.category];
    if(self.deviceId && ![self.deviceId isEqualToString:@""]) {
        [JSONString appendFormat:@",\"deviceId\":\"%@\"", self.deviceId];
    }
    if(self.locationId) {
        [JSONString appendFormat:@",\"locationId\":\"%lu\"", (long unsigned)self.locationId];
    }
    [JSONString appendFormat:@",\"excluded\": \"%@\"", (self.excluded) ? @"true" : @"false"];
    [JSONString appendString:@"}"];
    
    return JSONString;
}

@end
