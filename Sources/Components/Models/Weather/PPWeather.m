//
//  PPWeather.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPWeather.h"

@implementation PPWeather

- (id)initWithMetaDate:(PPWeatherMetadata *)metaData forecasts:(RLMArray *)forecasts observation:(PPWeatherObservation *)observation {
    self = [super init];
    if(self) {
        self.metadata = metaData;
        self.forecasts = (RLMArray<PPWeatherForecast *><PPWeatherForecast> *)forecasts;
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
    
    PPWeather *weather = [[PPWeather alloc] initWithMetaDate:metaData forecasts:(RLMArray<PPWeatherForecast *><PPWeatherForecast> *)forecasts observation:observation];
    return weather;
}

@end
