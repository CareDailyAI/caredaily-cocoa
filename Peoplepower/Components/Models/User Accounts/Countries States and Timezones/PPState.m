//
//  PPState.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPState.h"

@implementation PPState

//+ (NSString *)primaryKey {
//    return @"stateId";
//}

- (id)initWithStateId:(PPStateId)stateId name:(NSString *)name timezoneId:(NSString *)timezoneId abbr:(NSString *)abbr code:(NSString *)code preferred:(PPPreferredState)preferred {
    self = [super init];
    if(self) {
        self.stateId = stateId;
        self.name = name;
        self.timezoneId = timezoneId;
        self.abbr = abbr;
        self.code = code;
        self.preferred = preferred;
    }
    return self;
}

+ (PPState *)initWithDictionary:(NSDictionary *)stateDict {
    
    PPStateId stateId = PPStateIdNone;
    if([stateDict objectForKey:@"id"]) {
        stateId = (PPStateId)((NSString *)[stateDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [stateDict objectForKey:@"name"];
    NSString *timezoneId = [stateDict objectForKey:@"timezoneId"];
    NSString *abbr = [stateDict objectForKey:@"abbr"];
    NSString *code = [stateDict objectForKey:@"code"];
    PPPreferredState preferred = PPPreferredStateNone;
    if([stateDict objectForKey:@"preferred"]) {
        preferred = (PPPreferredState)((NSString *)[stateDict objectForKey:@"preferred"]).integerValue;
    }
    
    PPState *state = [[PPState alloc] initWithStateId:stateId name:name timezoneId:timezoneId abbr:abbr code:code preferred:preferred];
    return state;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPState *state = [[[self class] allocWithZone:zone] init];
    
    state.stateId = self.stateId;
    state.name = [self.name copyWithZone:zone];
    state.timezoneId = [self.timezoneId copyWithZone:zone];
    state.abbr = [self.abbr copyWithZone:zone];
    state.code = [self.code copyWithZone:zone];
    state.preferred = self.preferred;
    
    return state;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.stateId = (PPStateId)((NSNumber *)[decoder decodeObjectForKey:@"stateId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.timezoneId = [decoder decodeObjectForKey:@"timezoneId"];
        self.abbr = [decoder decodeObjectForKey:@"abbr"];
        self.code = [decoder decodeObjectForKey:@"code"];
        self.preferred = (PPPreferredState)((NSNumber *)[decoder decodeObjectForKey:@"preferred"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_stateId) forKey:@"stateId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_timezoneId forKey:@"timezoneId"];
    [encoder encodeObject:_abbr forKey:@"abbr"];
    [encoder encodeObject:_code forKey:@"code"];
    [encoder encodeObject:@(_preferred) forKey:@"preferred"];
}
@end
