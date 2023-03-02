//
//  PPWeatherManagement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWeatherManagement.h"
#import "PPCloudEngine.h"

@implementation PPWeatherManagement

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
+ (void)getForecastByGeocode:(float)latitude longitude:(float)longitude units:(NSString *)units hours:(PPWeatherManagementForecastHours)hours organizationId:(PPOrganizationId)organizationId callback:(PPWeatherBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"weather/forecast/geocode/%f/%f?", latitude, longitude];
    
    if(units) {
        [requestString appendFormat:@"units=%@&", units];
    }
    if(hours != PPWeatherManagementForecastHoursNone) {
        [requestString appendFormat:@"hours=%li&", (long)hours];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.weathermanagement.getForecastByGeocode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPWeather *weather;
            if(!error) {
                weather = [PPWeather initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(weather, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)getForecastByLocation:(PPLocationId)locationId units:(NSString *)units hours:(PPWeatherManagementForecastHours)hours callback:(PPWeatherBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"weather/forecast/location/%li?", (long)locationId];
    
    if(units) {
        [requestString appendFormat:@"units=%@&", units];
    }
    if(hours != PPWeatherManagementForecastHoursNone) {
        [requestString appendFormat:@"hours=%li&", (long)hours];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.weathermanagement.getForecastByLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPWeather *weather;
            if(!error) {
                weather = [PPWeather initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(weather, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)getCurrentWeatherByGeocode:(float)latitude longitude:(float)longitude units:(NSString *)units organizationId:(PPOrganizationId)organizationId callback:(PPWeatherBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"weather/current/geocode/%f/%f?", latitude, longitude];
    
    if(units) {
        [requestString appendFormat:@"units=%@&", units];
    }
    if(organizationId != PPOrganizationIdNone) {
        [requestString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.weathermanagement.getCurrentWeatherByGeocode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPWeather *weather;
            
            if(!error) {
                weather = [PPWeather initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(weather, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Current weather by Location

/**
 * Get current weather by Location.
 * Retrieve current weather at the specific location.
 *
 * @param locationId Required PPLocationId ID of location
 * @param units NSString Units for measurements, default value is "Metric".
 * @param callback PPWeatherBlock Weather callback block
 **/
+ (void)getCurrentWeatherByLocation:(PPLocationId)locationId units:(NSString *)units callback:(PPWeatherBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"weather/current/location/%li?", (long)locationId];
    
    if(units) {
        [requestString appendFormat:@"units=%@&", units];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.weathermanagement.getCurrentWeatherByLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPWeather *weather;
            
            if(!error) {
                weather = [PPWeather initWithDictionary:root];
            }
                
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(weather, error);
            });
        });
    } failure:^(NSError *error) {
            
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end

