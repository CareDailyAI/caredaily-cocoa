//
//  PPWeather.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWeather.h"

@implementation PPWeather

- (id)initWithMetaDate:(PPWeatherMetadata *)metaData forecasts:(NSArray *)forecasts observation:(PPWeatherObservation *)observation {
    self = [super init];
    if(self) {
        self.metadata = metaData;
        self.forecasts = forecasts;
        self.observation = observation;
    }
    return self;
}

+ (PPWeather *)initWithDictionary:(NSDictionary *)weatherDict {
    
    PPWeatherMetadata *metaData = [PPWeatherMetadata initWithDictionary:[weatherDict objectForKey:@"metaData"]];
    
    NSMutableArray *forecasts = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary *forecastDict in [weatherDict objectForKey:@"forecasts"]) {
        PPWeatherForecast *forecast = [PPWeatherForecast initWithDictionary:forecastDict];
        [forecasts addObject:forecast];
    }
    
    PPWeatherObservation *observation = [PPWeatherObservation initWithDictionary:[weatherDict objectForKey:@"observation"]];
    
    PPWeather *weather = [[PPWeather alloc] initWithMetaDate:metaData forecasts:forecasts observation:observation];
    return weather;
}

@end
