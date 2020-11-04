//
//  PPState.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCountriesStatesAndTimezones.h"

@interface PPState : NSObject <NSCopying>

/* State ID to reference this state in other API calls */
@property (nonatomic) PPStateId stateId;

/* Name of the state */
@property (nonatomic, strong) NSString * _Nullable name;

/* Default timezone ID of state */
@property (nonatomic, strong) NSString * _Nullable timezoneId;

/* Abbreviation */
@property (nonatomic, strong) NSString * _Nullable abbr;

/* State ANSI code */
@property (nonatomic, strong) NSString * _Nullable code;

/* True for the country or state correlated with the current user IP address */
@property (nonatomic) PPPreferredState preferred;

- (id _Nullable )initWithStateId:(PPStateId)stateId name:(NSString * _Nullable )name timezoneId:(NSString * _Nullable )timezoneId abbr:(NSString * _Nullable )abbr code:(NSString * _Nullable )code preferred:(PPPreferredState)preferred;

+ (PPState * _Nullable )initWithDictionary:(NSDictionary * _Nullable )stateDict;

@end
