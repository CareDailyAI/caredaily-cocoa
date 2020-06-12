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
@property (nonatomic, strong) NSString *name;

/* Default timezone ID of state */
@property (nonatomic, strong) NSString *timezoneId;

/* Abbreviation */
@property (nonatomic, strong) NSString *abbr;

/* State ANSI code */
@property (nonatomic, strong) NSString *code;

/* True for the country or state correlated with the current user IP address */
@property (nonatomic) PPPreferredState preferred;

- (id)initWithStateId:(PPStateId)stateId name:(NSString *)name timezoneId:(NSString *)timezoneId abbr:(NSString *)abbr code:(NSString *)code preferred:(PPPreferredState)preferred;

+ (PPState *)initWithDictionary:(NSDictionary *)stateDict;

@end
