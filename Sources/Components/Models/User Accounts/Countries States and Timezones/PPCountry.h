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

@interface PPCountry : PPBaseModel <NSCopying>

@property (nonatomic) PPCountryId countryId;
@property (nonatomic, strong) NSString * _Nullable name;
@property (nonatomic, strong) NSString * _Nullable countryCode;
@property (nonatomic, strong) NSString * _Nullable currencyCode;
@property (nonatomic, strong) NSString * _Nullable currencySymbol;
@property (nonatomic, strong) NSString * _Nullable zipFormat;
@property (nonatomic, strong) NSString * _Nullable zipName;
@property (nonatomic, strong) NSString * _Nullable stateName;
@property (nonatomic) PPPreferredCountry preferred;
@property (nonatomic, strong) NSArray * _Nullable timezones;
@property (nonatomic, strong) NSArray * _Nullable states;

- (id _Nullable )initWithCountryId:(PPCountryId)countryId name:(NSString *_Nullable)name countryCode:(NSString *_Nullable)countryCode currencyCode:(NSString *_Nullable)currencyCode currencySymbol:(NSString *_Nullable)currencySymbol zipFormat:(NSString *_Nullable)zipFormat zipName:(NSString *_Nullable)zipName stateName:(NSString *_Nullable)stateName preferred:(PPPreferredCountry)preferred timezones:(NSArray *_Nullable)timezones states:(NSArray *_Nullable)states;

+ (PPCountry *_Nullable)initWithDictionary:(NSDictionary *_Nullable)countryDict;

@end
