//
//  PPTimezone.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPTimezone.h"

@implementation PPTimezone

- (id)initWithTimezoneId:(NSString *)timezoneId offset:(PPTimezoneOffset)offset dst:(PPDaylightSavingsTime)dst name:(NSString *)name {
    self = [super init];
    if(self) {
        self.timezoneId = timezoneId;
        self.offset = offset;
        self.dst = dst;
        self.name = name;
    }
    return self;
}

+ (PPTimezone *)initWithDictionary:(NSDictionary *)timezoneDict {
    
    NSString *timezoneId = [timezoneDict objectForKey:@"id"];
    PPTimezoneOffset offset = PPTimezoneOffsetNone;
    if([timezoneDict objectForKey:@"offset"]) {
        offset = (PPTimezoneOffset)((NSString *)[timezoneDict objectForKey:@"offset"]).integerValue;
    }
    PPDaylightSavingsTime dst = PPDaylightSavingsTimeNone;
    if([timezoneDict objectForKey:@"dst"]) {
        dst = (PPDaylightSavingsTime)((NSString *)[timezoneDict objectForKey:@"dst"]).integerValue;
    }
    NSString *name = [timezoneDict objectForKey:@"name"];
    
    PPTimezone *timezone = [[PPTimezone alloc] initWithTimezoneId:timezoneId offset:offset dst:dst name:name];
    return timezone;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToTimezone:(PPTimezone *)timezone {
    BOOL equal = NO;
    if(_timezoneId && timezone.timezoneId) {
        if([_timezoneId isEqualToString:timezone.timezoneId]) {
            equal = YES;
        }
    }
    return equal;
}

- (void)sync:(PPTimezone *)timezone {
    if(timezone.timezoneId) {
        _timezoneId = timezone.timezoneId;
    }
    if(timezone.offset != PPTimezoneOffsetNone) {
        _offset = timezone.offset;
    }
    if(timezone.dst != PPDaylightSavingsTimeNone) {
        _dst = timezone.dst;
    }
    if(timezone.name) {
        _name = timezone.name;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPTimezone *timezone = [[[self class] allocWithZone:zone] init];
    
    timezone.timezoneId = [self.timezoneId copyWithZone:zone];
    timezone.offset = self.offset;
    timezone.dst = self.dst;
    timezone.name = [self.name copyWithZone:zone];
    
    return timezone;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.timezoneId = [decoder decodeObjectForKey:@"timezoneId"];
        self.offset = (PPTimezoneOffset)((NSNumber *)[decoder decodeObjectForKey:@"offset"]).integerValue;
        self.dst = (PPDaylightSavingsTime)((NSNumber *)[decoder decodeObjectForKey:@"dst"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_timezoneId forKey:@"timezoneId"];
    [encoder encodeObject:@(_offset) forKey:@"offset"];
    [encoder encodeObject:@(_dst) forKey:@"dst"];
    [encoder encodeObject:_name forKey:@"name"];
}
@end
