//
//  PPWeather.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPWeatherMetadata.h"
#import "PPWeatherForecast.h"
#import "PPWeatherObservation.h"

@interface PPWeather : PPBaseModel

@property (nonatomic, strong) PPWeatherMetadata *metadata;
@property (nonatomic, strong) NSArray *forecasts;
@property (nonatomic, strong) PPWeatherObservation *observation;

- (id)initWithMetaDate:(PPWeatherMetadata *)metaData forecasts:(NSArray *)forecasts observation:(PPWeatherObservation *)observation;

+ (PPWeather *)initWithDictionary:(NSDictionary *)weatherDict;

@end
