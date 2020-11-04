//
//  PPWeatherObservation.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPWeatherObservationMetric.h"

@interface PPWeatherObservation : PPBaseModel

@property (nonatomic, strong) NSString *observationClass;
@property (nonatomic, strong) NSNumber *expireTimeGMT;
@property (nonatomic, strong) NSNumber *OBSTime;
@property (nonatomic, strong) NSDate *OBSTimeLocal;
@property (nonatomic, strong) NSNumber *wDir;
@property (nonatomic, strong) NSNumber *iconCode;
@property (nonatomic, strong) NSNumber *iconExtd;
@property (nonatomic, strong) NSDate *sunrise;
@property (nonatomic, strong) NSDate *sunset;
@property (nonatomic, strong) NSString *dayInd;
@property (nonatomic, strong) NSNumber *UVIndex;
@property (nonatomic, strong) NSNumber *UVWarning;
@property (nonatomic, strong) NSString *WXMan;
@property (nonatomic, strong) NSNumber *OBSQualifierCode;
@property (nonatomic, strong) NSNumber *PTendCode;
@property (nonatomic, strong) NSString *DOW;
@property (nonatomic, strong) NSString *wdirCardinal;
@property (nonatomic, strong) NSString *UVDesc;
@property (nonatomic, strong) NSString *phrase12char;
@property (nonatomic, strong) NSString *phrase22char;
@property (nonatomic, strong) NSString *phrase32char;
@property (nonatomic, strong) NSString *PTendDesc;
@property (nonatomic, strong) NSString *skyCover;
@property (nonatomic, strong) NSString *clds;
@property (nonatomic, strong) NSNumber *OBSQualifierSeverity;
@property (nonatomic, strong) NSString *vocalKey;
@property (nonatomic, strong) PPWeatherObservationMetric *metric;

- (id)initWithObservationClass:(NSString *)observationClass expireTimeGMT:(NSNumber *)expireTimeGMT OBSTime:(NSNumber *)OBSTime OBSTimeLocal:(NSDate *)OBSTimeLocal wDir:(NSNumber *)wDir iconCode:(NSNumber *)iconCode iconExtd:(NSNumber *)iconExtd sunrise:(NSDate *)sunrise sunset:(NSDate *)sunset dayInd:(NSString *)dayInd UVIndex:(NSNumber *)UVIndex UVWarning:(NSNumber *)UVWarning WXMan:(NSString *)WXMan OBSQualifierCode:(NSNumber *)OBSQualifierCode PTendCode:(NSNumber *)PTendCode DOW:(NSString *)DOW wdirCardinal:(NSString *)wdirCardinal UVDesc:(NSString *)UVDesc phrase12char:(NSString *)phrase12char phrase22char:(NSString *)phrase22char phrase32char:(NSString *)phrase32char PTendDesc:(NSString *)PTendDesc skyCover:(NSString *)skyCover clds:(NSString *)clds OBSQualifierSeverity:(NSNumber *)OBSQualifierSeverity vocalKey:(NSString *)vocalKey metric:(PPWeatherObservationMetric *)metric;

+ (PPWeatherObservation *)initWithDictionary:(NSDictionary *)observationDict;

@end
