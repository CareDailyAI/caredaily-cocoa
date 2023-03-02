//
//  PPCountriesStatesAndTimezones.h
//  Peoplepower
//
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPCountry;
@class PPState;
@class PPTimezone;

@interface PPCountriesStatesAndTimezones : PPBaseModel

- (id)initWithCountries:(NSArray *)countries;

- (NSArray *)statesForCountry:(PPCountryId)countryId;
- (PPCountry *)countryForState:(PPStateId)stateId;

@property (nonatomic, strong) NSArray *countries;

@end
