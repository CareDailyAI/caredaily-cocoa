//
//  PPCountry.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCountry.h"

@implementation PPCountry

//+ (NSString *)primaryKey {
//    return @"countryId";
//}

- (id)initWithCountryId:(PPCountryId)countryId name:(NSString *)name countryCode:(NSString *)countryCode currencyCode:(NSString *)currencyCode currencySymbol:(NSString *)currencySymbol zipFormat:(NSString *)zipFormat zipName:(NSString *)zipName stateName:(NSString *)stateName preferred:(PPPreferredCountry)preferred timezones:(RLMArray *)timezones states:(RLMArray *)states {
    self = [super init];
    if(self) {
        self.countryId = countryId;
        self.name = name;
        self.countryCode = countryCode;
        self.currencyCode = currencyCode;
        self.currencySymbol = currencySymbol;
        self.zipFormat = zipFormat;
        self.zipName = zipName;
        self.stateName = stateName;
        self.preferred = preferred;
        self.timezones = (RLMArray<PPTimezone *><PPTimezone> *)timezones;
        self.states = (RLMArray<PPState *><PPState> *)states;
    }
    return self;
}

+ (PPCountry *)initWithDictionary:(NSDictionary *)countryDict {
    
    PPCountryId countryId = PPCountryIdNone;
    if([countryDict objectForKey:@"id"]) {
        countryId = (PPCountryId)((NSString *)[countryDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [countryDict objectForKey:@"name"];
    NSString *countryCode = [countryDict objectForKey:@"countryCode"];
    NSString *currencyCode = [countryDict objectForKey:@"currencyCode"];
    NSString *currencySymbol = [countryDict objectForKey:@"currencySymbol"];
    NSString *zipFormat = [countryDict objectForKey:@"zipFormat"];
    NSString *zipName = [countryDict objectForKey:@"zipName"];
    NSString *stateName = [countryDict objectForKey:@"stateName"];
    PPPreferredCountry preferred = PPPreferredCountryNone;
    if([countryDict objectForKey:@"preferred"]) {
        preferred = (PPPreferredCountry)((NSString *)[countryDict objectForKey:@"preferred"]).integerValue;
    }
    
    NSMutableArray *states;
    if([countryDict objectForKey:@"states"]) {
        states = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *stateDict in [countryDict objectForKey:@"states"]) {
            PPState *state = [PPState initWithDictionary:stateDict];
            [states addObject:state];
        }
    }
    
    NSMutableArray *timezones;
    if([countryDict objectForKey:@"timezones"]) {
        timezones = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *timezoneDict in [countryDict objectForKey:@"timezones"]) {
            PPTimezone *timezone = [PPTimezone initWithDictionary:timezoneDict];
            [timezones addObject:timezone];
        }
    }
    
    PPCountry *country = [[PPCountry alloc] initWithCountryId:countryId name:name countryCode:countryCode currencyCode:currencyCode currencySymbol:currencySymbol zipFormat:zipFormat zipName:zipName stateName:stateName preferred:preferred timezones:(RLMArray<PPTimezone *><PPTimezone> *)timezones states:(RLMArray<PPState *><PPState> *)states];
    return country;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPCountry *country = [[PPCountry allocWithZone:zone] init];
    
    country.countryId = self.countryId;
    country.name = [self.name copyWithZone:zone];
    country.countryCode = [self.countryCode copyWithZone:zone];
    country.currencyCode = [self.currencyCode copyWithZone:zone];
    country.currencySymbol = [self.currencySymbol copyWithZone:zone];
    country.zipFormat = [self.zipFormat copyWithZone:zone];
    country.zipName = [self.zipName copyWithZone:zone];
    country.stateName = [self.stateName copyWithZone:zone];
    country.preferred = self.preferred;
    NSMutableArray *timezones = [[NSMutableArray alloc] initWithCapacity:self.timezones.count];
    for (PPTimezone *timezone in self.timezones) {
        [timezones addObject:[timezone copyWithZone:zone]];
    }
    country.timezones = timezones;
    NSMutableArray *states = [[NSMutableArray alloc] initWithCapacity:self.states.count];
    for (PPState *state in self.states) {
        [states addObject:[state copyWithZone:zone]];
    }
    country.states = states;
    
    return country;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.countryId = (PPCountryId)((NSNumber *)[decoder decodeObjectForKey:@"countryId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.countryCode = [decoder decodeObjectForKey:@"countryCode"];
        self.currencyCode = [decoder decodeObjectForKey:@"currencyCode"];
        self.currencySymbol = [decoder decodeObjectForKey:@"currencySymbol"];
        self.zipFormat = [decoder decodeObjectForKey:@"zipFormat"];
        self.zipName = [decoder decodeObjectForKey:@"zipName"];
        self.stateName = [decoder decodeObjectForKey:@"stateName"];
        self.preferred = (PPPreferredCountry)((NSNumber *)[decoder decodeObjectForKey:@"preferred"]).integerValue;
        self.timezones = [decoder decodeObjectForKey:@"timezones"];
        self.states = [decoder decodeObjectForKey:@"states"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_countryId) forKey:@"countryId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_countryCode forKey:@"countryCode"];
    [encoder encodeObject:_currencyCode forKey:@"currencyCode"];
    [encoder encodeObject:_currencySymbol forKey:@"currencySymbol"];
    [encoder encodeObject:_zipFormat forKey:@"zipFormat"];
    [encoder encodeObject:_zipName forKey:@"zipName"];
    [encoder encodeObject:_stateName forKey:@"stateName"];
    [encoder encodeObject:@(_preferred) forKey:@"preferred"];
    [encoder encodeObject:_timezones forKey:@"timezones"];
    [encoder encodeObject:_states forKey:@"states"];
}
@end
