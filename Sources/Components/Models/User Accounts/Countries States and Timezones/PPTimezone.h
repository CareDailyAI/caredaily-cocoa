//
//  PPTimezone.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCountriesStatesAndTimezones.h"

@interface PPTimezone : NSObject <NSCopying>

@property (nonatomic, strong) NSString *timezoneId;
@property (nonatomic) PPTimezoneOffset offset;
@property (nonatomic) PPDaylightSavingsTime dst;
@property (nonatomic, strong) NSString *name;

- (id)initWithTimezoneId:(NSString *)timezoneId offset:(PPTimezoneOffset)offset dst:(PPDaylightSavingsTime)dst name:(NSString *)name;

+ (PPTimezone *)initWithDictionary:(NSDictionary *)timezoneDict;

#pragma mark - Helper Methods

- (BOOL)isEqualToTimezone:(PPTimezone *)timezone;

- (void)sync:(PPTimezone *)timezone;

@end
