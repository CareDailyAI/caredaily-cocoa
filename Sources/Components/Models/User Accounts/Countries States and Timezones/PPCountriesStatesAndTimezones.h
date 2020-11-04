//
//  PPCountriesStatesAndTimezones.h
//  Peoplepower
//
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPCountry;
@class PPState;
@class PPTimezone;

@interface PPCountriesStatesAndTimezones : PPBaseModel

- (id)initWithCountries:(RLMArray *)countries;

- (NSArray *)statesForCountry:(PPCountryId)countryId;
- (PPCountry *)countryForState:(PPStateId)stateId;

@property (nonatomic, strong) RLMArray<PPCountry *><PPCountry> *countries;

@end
