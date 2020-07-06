//
//  PPWeatherManagement.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// These API's are avaialabe for certain organizations only.
//

#import "PPBaseModel.h"
#import "PPLocation.h"
#import "PPOrganization.h"
#import "PPWeather.h"

typedef void (^PPWeatherBlock)(PPWeather * _Nullable weather, NSError * _Nullable error);

@interface PPWeatherManagement : PPBaseModel

#pragma mark - Forecast by Geocode

/**
 * Get Forecast by Geocode.
 * Retrieve weather forecust at certain point by latitude and longitude.
 *
 * @param latitude Required float Latitude
 * @param longitude Required float Longitude
 * @param units NSString Units for measurements, default value is "Metric".
 * @param hours PPWeatherManagementForecastHours Forecast depth in hours.
 * @param organizationId Integer For specific organization. Used by administrator only.
 * @param callback PPWeatherBlock Weather callback block
 **/
+ (void)getForecastByGeocode:(float)latitude longitude:(float)longitude units:(NSString * _Nullable )units hours:(PPWeatherManagementForecastHours)hours organizationId:(PPOrganizationId)organizationId callback:(PPWeatherBlock _Nonnull )callback;

#pragma mark - Forecast by Location

/**
 * Get Forecast by Location.
 * Retrieve weather forecast by the location address.
 *
 * @param locationId Required PPLocationId ID of location
 * @param units NSString Units for measurements, default value is "Metric".
 * @param hours PPWeatherManagementForecastHours Forecast depth in hours.
 * @param callback PPWeatherBlock Weather callback block
 **/
+ (void)getForecastByLocation:(PPLocationId)locationId units:(NSString * _Nullable )units hours:(PPWeatherManagementForecastHours)hours callback:(PPWeatherBlock _Nonnull )callback;

#pragma mark - Current weather by Geocode

/**
 * Get current weather by Geocode.
 * Retrieve current weather at certain point by latitude and longitude.
 *
 * @param latitude Required float Latitude
 * @param longitude Required float Longitude
 * @param units NSString Units for measurements, default value is "Metric".
 * @param organizationId Integer For specific organization. Used by administrator only.
 * @param callback PPWeatherBlock Weather callback block
 **/
+ (void)getCurrentWeatherByGeocode:(float)latitude longitude:(float)longitude units:(NSString * _Nullable )units organizationId:(PPOrganizationId)organizationId callback:(PPWeatherBlock _Nonnull )callback;

#pragma mark - Current weather by Location

/**
 * Get current weather by Location.
 * Retrieve current weather at the specific location.
 *
 * @param locationId Required PPLocationId ID of location
 * @param units NSString Units for measurements, default value is "Metric".
 * @param callback PPWeatherBlock Weather callback block
 **/
+ (void)getCurrentWeatherByLocation:(PPLocationId)locationId units:(NSString * _Nullable )units callback:(PPWeatherBlock _Nonnull )callback;

@end
