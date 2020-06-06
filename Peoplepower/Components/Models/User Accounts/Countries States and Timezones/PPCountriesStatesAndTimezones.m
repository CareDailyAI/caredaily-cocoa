//
//  PPCountriesStatesAndTimezones.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPCountriesStatesAndTimezones.h"
#import "PPCountry.h"
#import "PPState.h"

@implementation PPCountriesStatesAndTimezones

-(id) initWithCountries:(RLMArray *)countries {
	self = [super init];
	if(self) {
        self.countries = countries;
	}
	return self;
}

- (NSArray *)statesForCountry:(PPCountryId)countryId {
    NSMutableArray *states = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCountry *country in _countries) {
        if(country.countryId == countryId || countryId == PPCountryIdNone) {
            [states addObjectsFromArray:[PPRLMArray arrayFromArray:country.states]];
        }
    }
    
    return states;
}

- (PPCountry *)countryForState:(PPStateId)stateId {
    for(PPCountry *country in _countries) {
        for(PPState *state in country.states) {
            if(state.stateId == stateId) {
                return country;
            }
        }
    }
    
    return nil;
}

@end
