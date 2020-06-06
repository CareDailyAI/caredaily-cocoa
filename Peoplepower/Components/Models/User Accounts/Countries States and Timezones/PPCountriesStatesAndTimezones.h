//
//  PPCountriesStatesAndTimezones.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"

@class PPCountry;
@class PPState;
@class PPTimezone;

typedef NS_OPTIONS(NSInteger, PPCountryId) {
    PPCountryIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPStateId) {
    PPStateIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPPreferredCountry) {
    PPPreferredCountryNone = -1,
    PPPreferredCountryFalse = 0,
    PPPreferredCountryTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPPreferredState) {
    PPPreferredStateNone = -1,
    PPPreferredStateFalse = 0,
    PPPreferredStateTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDaylightSavingsTime) {
    PPDaylightSavingsTimeNone = -1,
    PPDaylightSavingsTimeFalse = 0,
    PPDaylightSavingsTimeTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPTimezoneOffset) {
    PPTimezoneOffsetNone = -1
};

@interface PPCountriesStatesAndTimezones : PPBaseModel

- (id)initWithCountries:(RLMArray *)countries;

- (NSArray *)statesForCountry:(PPCountryId)countryId;
- (PPCountry *)countryForState:(PPStateId)stateId;

@property (nonatomic, strong) RLMArray<PPCountry *> *countries;

@end
