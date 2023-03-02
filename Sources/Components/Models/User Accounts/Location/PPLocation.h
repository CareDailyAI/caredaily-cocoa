//
//  PPLocation.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPState.h"
#import "PPCountry.h"
#import "PPTimezone.h"
#import "PPLocationSize.h"
#import "PPLocationOccupantsRange.h"
#import "PPLocationSceneEvent.h"
#import "PPUserService.h"
#import "PPCloudsIntegrationClient.h"
#import "PPCloudsIntegrationHost.h"

@interface PPLocation : PPBaseModel <NSCopying>

/* A location represents a physical place occupied by this person and where his or her devices can be installed. When creating or updating location information in a user's account, all fields are optional. */

#pragma mark - Location Information

/* Location Id */
@property (nonatomic) PPLocationId locationId;

/* Name of the location (i.e. "My House" or "Upstairs Bedroom") */
@property (nonatomic, strong) NSString *name;

/* Type of location */
@property (nonatomic) PPLocationType type;

/* Is owner of this location */
@property (nonatomic) PPLocationOwner owner;

/* Location Access */
@property (nonatomic) PPLocationAccess locationAccess;

/* User Category */
@property (nonatomic) PPLocationCategory userCategory;

/* The last user in location status like HOME, AWAY, SLEEP, VACATION, etc. It is used in analytic rules. */
@property (nonatomic, strong) PPLocationSceneEvent *event;

/* User's timezone ID. For example, "US/Pacific" or "GMT+0800". See the PPDateTimeFormats for more details. */
@property (nonatomic, strong) PPTimezone *timezone;

/* Utility account number, when this user account is linked to acquire data from a utility. */
@property (nonatomic, strong) NSString *utilityAccountNo;

/* Address - Street 1 */
@property (nonatomic, strong) NSString *addrStreet1;

/* Address - Street 2 */
@property (nonatomic, strong) NSString *addrStreet2;

/* Address - City */
@property (nonatomic, strong) NSString *addrCity;

/* State identifier. Use the Countries, states, and time zones API to obtain numeric identifiers for each state supported on the IoT Software Suite. If you need to add more states to support a specific region, please contact support@peoplepowerco.com. */
@property (nonatomic, strong) PPState *state;

/* Country identifier. Use the Countries, states, and time zones API to obtain numeric identifiers for each state supported on the IoT Software Suite. If you need to add more countries to support a specific region, please contact support@peoplepowerco.com. */
@property (nonatomic, strong) PPCountry *country;

/* Zip / Postal Code */
@property (nonatomic, strong) NSString *zip;

/* The latitude in degrees. Positive values indicate latitudes north of the equator. Negative values indicate latitudes south of the equator. */
@property (nonatomic, strong) NSString *latitude;

/* The longitude in degrees. Measurements are relative to the zero meridian, with positive values extending east of the meridian and negative values extending west of the meridian. */
@property (nonatomic, strong) NSString *longitude;

/* This represents the approximate size of the location. PPLocationSize object containing 'unit' and 'value'. Please see the request example for more details. Size units:
 *  ft2 - Square Foot
 *  m2 - Square Meter */
@property (nonatomic, strong) PPLocationSize *size;

/* Number of stories in the home / building */
@property (nonatomic) PPLocationStoriesNumber storiesNumber;

/* Number of rooms. */
@property (nonatomic) PPLocationRoomsNumber roomsNumber;

/* Number of bathrooms. */
@property (nonatomic) PPLocationBathroomsNumber bathroomsNumber;

/* Total number of people living / working at this location. */
@property (nonatomic) PPLocationOccupantsNumber occupantsNumber;

/* Range of occupant ages. Array of PPLocationOccupantsRange objects describing age ranges in years, and the number of occupants in those age ranges. e.g. {"start": 0, "end": 6, "number": 1} */
@property (nonatomic, strong) NSArray *occupantsRanges;

/* Keeps a note about when the location is used by people.
 *  1 - Day
 *  2 - Night
 *  3 - Both */
@property (nonatomic) PPLocationUsagePeriod usagePeriod;

/* This is a bitmap that describes the type of heating that is used at this location.
 *  1 - Electric
 *  2 - Natural Gas
 *  4 - Propane
 *  8 - Oil
 *  16 - Biomass
 *  128 - Other */
@property (nonatomic) PPLocationHeatingType heatingType;

/* This is a bitmap that describes the type of cooling that is used at this location.
 *  1 - Central A/C
 *  2 - Window A/C
 *  4 - Open windows / fans
 *  128 - Other */
@property (nonatomic) PPLocationCoolingType coolingType;

/* This is a bitmap that describes the type of water heating that is used at this location.
 *  1 - Electric
 *  2 - Natural Gas
 *  4 - Propane
 *  8 - Oil
 *  16 - Biomass
 *  32 - Solar
 *  128 - Other */
@property (nonatomic) PPLocationWaterHeaterType waterHeaterType;

/* Describes the type of thermostat that is used at this location.
 *  1 - Non-programmable
 *  2 - Programmable
 *  3 - Internet Connected */
@property (nonatomic) PPLocationThermostatType thermostatType;

/* File Upload policy. By default, the IoT Software Suite will automatically delete old files (i.e. videos and images) once a user's account is full, such as videos and images. */
@property (nonatomic) PPLocationFileUploadPolicy fileUploadPolicy;

/* Location auths */
@property (nonatomic, strong) NSArray *auths;

/* Location auth clients */
@property (nonatomic, strong) NSArray *clients;

/* Location services */
@property (nonatomic, strong) NSArray *services;

/* Temporary access */
@property (nonatomic) PPLocationTemporary temporary;

/* Temporary access end date */
@property (nonatomic, strong) NSDate *accessEndDate;

/* Phone number, where a user can send and receive SMS */
@property (nonatomic, strong) NSString *smsPhone;

/* Location creation date */
@property (nonatomic, strong) NSDate *creationDate;

/* App Name */
@property (nonatomic, strong) NSString *appName;

/* Organization ID */
@property (nonatomic) PPOrganizationId organizationId;

/* Organization */
@property (nonatomic, strong) PPOrganization *organization;

/* Marks location as a test location. */
@property (nonatomic) PPLocationTest test;

/* Location Code Type */
@property (nonatomic) PPLocationCodeType codeType;

/* Locations's preferred language. For example:
 en - English
 cn - Chinese
 fr - French
 ru - Russian
 etc */
@property (nonatomic, strong) NSString *language;

- (id)initWithLocationId:(PPLocationId)locationId
                    name:(NSString *)name
          locationAccess:(PPLocationAccess)locationAccess
            userCategory:(PPLocationCategory)userCategory
                   event:(PPLocationSceneEvent *)event
                    type:(PPLocationType)type
                   owner:(PPLocationOwner)owner
        utilityAccountNo:(NSString *)utilityAccountNo
                timezone:(PPTimezone *)timezone
             addrStreet1:(NSString *)addrStreet1
             addrStreet2:(NSString *)addrStreet2
                addrCity:(NSString *)addrCity
                   state:(PPState *)state
                 country:(PPCountry *)country
                     zip:(NSString *)zip
                latitude:(NSString *)latitude
               longitude:(NSString *)longitude
                    size:(PPLocationSize *)size
           storiesNumber:(PPLocationStoriesNumber)storiesNumber
             roomsNumber:(PPLocationRoomsNumber)roomsNumber
         bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber
         occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber
         occupantsRanges:(NSArray *)occupantsRanges
             usagePeriod:(PPLocationUsagePeriod)usagePeriod
             heatingType:(PPLocationHeatingType)heatingType
             coolingType:(PPLocationCoolingType)coolingType
         waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType
          thermostatType:(PPLocationThermostatType)thermostatType
        fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy
                   auths:(NSArray *)auths
                 clients:(NSArray *)clients
                services:(NSArray *)services
               temporary:(PPLocationTemporary)temporary
           accessEndDate:(NSDate *)accessEndDate
                smsPhone:(NSString *)smsPhone
            creationDate:(NSDate *)creationDate
                 appName:(NSString *)appName
          organizationId:(PPOrganizationId)organizationId
            organization:(PPOrganization *)organization
                    test:(PPLocationTest)test
                codeType:(PPLocationCodeType)codeType
                language:(NSString *)language
;

+ (PPLocation *)initWithDictionary:(NSDictionary *)locationDict;

/**
 * Provides a human readable description of this location
 *
 * @return NSString Description of this location
 **/
- (NSString *)humanReadableLocationDescription;

/**
 * Return a JSON friendly string of a given location
 *
 * @param location PPLocation Location to be stringified
 *
 * @return NSString JSON string
 **/
+ (NSString *)JSONString:(PPLocation *)location;

/**
 * Return a JSON friendly string of a given location
 *
 * @param location PPLocation Location to be stringified
 * @param appName NSString App name to add this location to a specific organization
 *
 * @return NSString JSON string
 **/
+ (NSString *)JSONString:(PPLocation *)location appName:(NSString *)appName;

/**
 * Return a JSON object of a given location
 *
 * @param location PPLocation Location to be stringified
 * @param appName NSString App name to add this location to a specific organization
 *
 * @return NSDictionary JSON object
 **/
+ (NSDictionary *)JSONData:(PPLocation *)location appName:(NSString *)appName;

@end
