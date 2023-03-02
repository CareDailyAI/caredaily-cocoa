//
//  PPWeatherForecast.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPWeatherForecast : PPBaseModel

@property (nonatomic, strong) NSString *forecastClass;
@property (nonatomic, strong) NSNumber *expireTimeGMT;
@property (nonatomic, strong) NSNumber *forecastValid;
@property (nonatomic, strong) NSDate *forecastValidLocal;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSString *dayInd;
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSNumber *dewPt;
@property (nonatomic, strong) NSNumber *hi;
@property (nonatomic, strong) NSNumber *wc;
@property (nonatomic, strong) NSNumber *feelsLike;
@property (nonatomic, strong) NSNumber *iconExtd;
@property (nonatomic, strong) NSString *wxman;
@property (nonatomic, strong) NSNumber *iconCode;
@property (nonatomic, strong) NSString *DOW;
@property (nonatomic, strong) NSString *phrase12Char;
@property (nonatomic, strong) NSString *phrase22Char;
@property (nonatomic, strong) NSString *phrase32Char;
@property (nonatomic, strong) NSString *subphrasePt1;
@property (nonatomic, strong) NSString *subphrasePt2;
@property (nonatomic, strong) NSString *subphrasePt3;
@property (nonatomic, strong) NSNumber *pop;
@property (nonatomic, strong) NSString *precipType;
@property (nonatomic, strong) NSNumber *QPF;
@property (nonatomic, strong) NSNumber *snowQPF;
@property (nonatomic, strong) NSNumber *rh;
@property (nonatomic, strong) NSNumber *wspd;
@property (nonatomic, strong) NSNumber *wDir;
@property (nonatomic, strong) NSString *wDirCardinal;
@property (nonatomic, strong) NSNumber *gust;
@property (nonatomic, strong) NSNumber *clds;
@property (nonatomic, strong) NSNumber *vis;
@property (nonatomic, strong) NSNumber *mslp;
@property (nonatomic, strong) NSNumber *UVIndexRaw;
@property (nonatomic, strong) NSNumber *UVIndex;
@property (nonatomic, strong) NSNumber *UVWarning;
@property (nonatomic, strong) NSString *UVDesc;
@property (nonatomic, strong) NSNumber *golfIndex;
@property (nonatomic, strong) NSString *golfCategory;
@property (nonatomic, strong) NSNumber *severity;

- (id)initWithForecastClass:(NSString *)forecastClass expireTimeGMT:(NSNumber *)expireTimeGMT forecastValid:(NSNumber *)forecastValid forecastValidLocal:(NSDate *)forecastValidLocal num:(NSNumber *)num dayInd:(NSString *)dayInd temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt hi:(NSNumber *)hi wc:(NSNumber *)wc feelsLike:(NSNumber *)feelsLike iconExtd:(NSNumber *)iconExtd wxman:(NSString *)wxman iconCode:(NSNumber *)iconCode DOW:(NSString *)DOW phrase12Char:(NSString *)phrase12Char phrase22Char:(NSString *)phrase22Char phrase32Char:(NSString *)phrase32Char subphrasePt1:(NSString *)subphrasePt1 subphrasePt2:(NSString *)subphrasePt2 subphrasePt3:(NSString *)subphrasePt3 pop:(NSNumber *)pop precipType:(NSString *)precipType QPF:(NSNumber *)QPF snowQPF:(NSNumber *)snowQPF rh:(NSNumber *)rh wspd:(NSNumber *)wspd wDir:(NSNumber *)wDir wDirCardinal:(NSString *)wDirCardinal gust:(NSNumber *)gust clds:(NSNumber *)clds vis:(NSNumber *)vis mslp:(NSNumber *)mslp UVIndexRaw:(NSNumber *)UVIndexRaw UVIndex:(NSNumber *)UVIndex UVWarning:(NSNumber *)UVWarning UVDesc:(NSString *)UVDesc golfIndex:(NSNumber *)golfIndex golfCategory:(NSString *)golfCategory severity:(NSNumber *)severity;

+ (PPWeatherForecast *)initWithDictionary:(NSDictionary *)forecastDict;

@end
