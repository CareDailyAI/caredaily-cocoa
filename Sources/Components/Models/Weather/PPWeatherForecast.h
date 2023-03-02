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
@property (nonatomic, strong) NSNumber<RLMInt> *expireTimeGMT;
@property (nonatomic, strong) NSNumber<RLMBool> *forecastValid;
@property (nonatomic, strong) NSDate *forecastValidLocal;
@property (nonatomic, strong) NSNumber<RLMInt> *num;
@property (nonatomic, strong) NSString *dayInd;
@property (nonatomic, strong) NSNumber<RLMInt> *temp;
@property (nonatomic, strong) NSNumber<RLMInt> *dewPt;
@property (nonatomic, strong) NSNumber<RLMInt> *hi;
@property (nonatomic, strong) NSNumber<RLMInt> *wc;
@property (nonatomic, strong) NSNumber<RLMInt> *feelsLike;
@property (nonatomic, strong) NSNumber<RLMInt> *iconExtd;
@property (nonatomic, strong) NSString *wxman;
@property (nonatomic, strong) NSNumber<RLMInt> *iconCode;
@property (nonatomic, strong) NSString *DOW;
@property (nonatomic, strong) NSString *phrase12Char;
@property (nonatomic, strong) NSString *phrase22Char;
@property (nonatomic, strong) NSString *phrase32Char;
@property (nonatomic, strong) NSString *subphrasePt1;
@property (nonatomic, strong) NSString *subphrasePt2;
@property (nonatomic, strong) NSString *subphrasePt3;
@property (nonatomic, strong) NSNumber<RLMInt> *pop;
@property (nonatomic, strong) NSString *precipType;
@property (nonatomic, strong) NSNumber<RLMInt> *QPF;
@property (nonatomic, strong) NSNumber<RLMInt> *snowQPF;
@property (nonatomic, strong) NSNumber<RLMInt> *rh;
@property (nonatomic, strong) NSNumber<RLMInt> *wspd;
@property (nonatomic, strong) NSNumber<RLMInt> *wDir;
@property (nonatomic, strong) NSString *wDirCardinal;
@property (nonatomic, strong) NSNumber<RLMInt> *gust;
@property (nonatomic, strong) NSNumber<RLMInt> *clds;
@property (nonatomic, strong) NSNumber<RLMInt> *vis;
@property (nonatomic, strong) NSNumber<RLMInt> *mslp;
@property (nonatomic, strong) NSNumber<RLMInt> *UVIndexRaw;
@property (nonatomic, strong) NSNumber<RLMInt> *UVIndex;
@property (nonatomic, strong) NSNumber<RLMInt> *UVWarning;
@property (nonatomic, strong) NSString *UVDesc;
@property (nonatomic, strong) NSNumber<RLMInt> *golfIndex;
@property (nonatomic, strong) NSString *golfCategory;
@property (nonatomic, strong) NSNumber<RLMInt> *severity;

- (id)initWithForecastClass:(NSString *)forecastClass expireTimeGMT:(NSNumber *)expireTimeGMT forecastValid:(NSNumber *)forecastValid forecastValidLocal:(NSDate *)forecastValidLocal num:(NSNumber *)num dayInd:(NSString *)dayInd temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt hi:(NSNumber *)hi wc:(NSNumber *)wc feelsLike:(NSNumber *)feelsLike iconExtd:(NSNumber *)iconExtd wxman:(NSString *)wxman iconCode:(NSNumber *)iconCode DOW:(NSString *)DOW phrase12Char:(NSString *)phrase12Char phrase22Char:(NSString *)phrase22Char phrase32Char:(NSString *)phrase32Char subphrasePt1:(NSString *)subphrasePt1 subphrasePt2:(NSString *)subphrasePt2 subphrasePt3:(NSString *)subphrasePt3 pop:(NSNumber *)pop precipType:(NSString *)precipType QPF:(NSNumber *)QPF snowQPF:(NSNumber *)snowQPF rh:(NSNumber *)rh wspd:(NSNumber *)wspd wDir:(NSNumber *)wDir wDirCardinal:(NSString *)wDirCardinal gust:(NSNumber *)gust clds:(NSNumber *)clds vis:(NSNumber *)vis mslp:(NSNumber *)mslp UVIndexRaw:(NSNumber *)UVIndexRaw UVIndex:(NSNumber *)UVIndex UVWarning:(NSNumber *)UVWarning UVDesc:(NSString *)UVDesc golfIndex:(NSNumber *)golfIndex golfCategory:(NSString *)golfCategory severity:(NSNumber *)severity;

+ (PPWeatherForecast *)initWithDictionary:(NSDictionary *)forecastDict;

@end
