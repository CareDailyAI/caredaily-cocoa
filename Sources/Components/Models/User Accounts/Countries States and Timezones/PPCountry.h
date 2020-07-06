//
//  PPCountry.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCountriesStatesAndTimezones.h"
#import "PPState.h"
#import "PPTimezone.h"

@interface PPCountry : NSObject <NSCopying>

@property (nonatomic) PPCountryId countryId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *currencySymbol;
@property (nonatomic, strong) NSString *zipFormat;
@property (nonatomic, strong) NSString *zipName;
@property (nonatomic, strong) NSString *stateName;
@property (nonatomic) PPPreferredCountry preferred;
@property (nonatomic, strong) NSArray *timezones;
@property (nonatomic, strong) NSArray *states;

- (id)initWithCountryId:(PPCountryId)countryId name:(NSString *)name countryCode:(NSString *)countryCode currencyCode:(NSString *)currencyCode currencySymbol:(NSString *)currencySymbol zipFormat:(NSString *)zipFormat zipName:(NSString *)zipName stateName:(NSString *)stateName preferred:(PPPreferredCountry)preferred timezones:(NSArray *)timezones states:(NSArray *)states;

+ (PPCountry *)initWithDictionary:(NSDictionary *)countryDict;

@end
