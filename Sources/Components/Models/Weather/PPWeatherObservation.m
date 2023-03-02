//
//  PPWeatherObservation.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWeatherObservation.h"

@implementation PPWeatherObservation

- (id)initWithObservationClass:(NSString *)observationClass expireTimeGMT:(NSNumber *)expireTimeGMT OBSTime:(NSNumber *)OBSTime OBSTimeLocal:(NSDate *)OBSTimeLocal wDir:(NSNumber *)wDir iconCode:(NSNumber *)iconCode iconExtd:(NSNumber *)iconExtd sunrise:(NSDate *)sunrise sunset:(NSDate *)sunset dayInd:(NSString *)dayInd UVIndex:(NSNumber *)UVIndex UVWarning:(NSNumber *)UVWarning WXMan:(NSString *)WXMan OBSQualifierCode:(NSNumber *)OBSQualifierCode PTendCode:(NSNumber *)PTendCode DOW:(NSString *)DOW wdirCardinal:(NSString *)wdirCardinal UVDesc:(NSString *)UVDesc phrase12char:(NSString *)phrase12char phrase22char:(NSString *)phrase22char phrase32char:(NSString *)phrase32char PTendDesc:(NSString *)PTendDesc skyCover:(NSString *)skyCover clds:(NSString *)clds OBSQualifierSeverity:(NSNumber *)OBSQualifierSeverity vocalKey:(NSString *)vocalKey metric:(PPWeatherObservationMetric *)metric {
    self = [super init];
    if(self) {
        self.observationClass = observationClass;
        self.expireTimeGMT = expireTimeGMT;
        self.OBSTime = OBSTime;
        self.OBSTimeLocal = OBSTimeLocal;
        self.wDir = wDir;
        self.iconCode = iconCode;
        self.iconExtd = iconExtd;
        self.sunrise = sunrise;
        self.sunset = sunset;
        self.dayInd = dayInd;
        self.UVIndex = UVIndex;
        self.UVWarning = UVWarning;
        self.WXMan = WXMan;
        self.OBSQualifierCode = OBSQualifierCode;
        self.PTendCode = PTendCode;
        self.DOW = DOW;
        self.wdirCardinal = wdirCardinal;
        self.UVDesc = UVDesc;
        self.phrase12char = phrase12char;
        self.phrase22char = phrase22char;
        self.phrase32char = phrase32char;
        self.PTendDesc = PTendDesc;
        self.skyCover = skyCover;
        self.clds = clds;
        self.OBSQualifierSeverity = OBSQualifierSeverity;
        self.vocalKey = vocalKey;
        self.metric = metric;
    }
    return self;
}

+ (PPWeatherObservation *)initWithDictionary:(NSDictionary *)observationDict {
    
    NSString *observationClass = [observationDict objectForKey:@"observationClass"];
    NSNumber *expireTimeGMT = [observationDict objectForKey:@"expireTimeGMT"];
    NSNumber *OBSTime = [observationDict objectForKey:@"OBSTime"];
    NSDate *OBSTimeLocal = [observationDict objectForKey:@"OBSTimeLocal"];
    NSNumber *wDir = [observationDict objectForKey:@"wDir"];
    NSNumber *iconCode = [observationDict objectForKey:@"iconCode"];
    NSNumber *iconExtd = [observationDict objectForKey:@"iconExtd"];
    NSDate *sunrise = [observationDict objectForKey:@"sunrise"];
    NSDate *sunset = [observationDict objectForKey:@"sunset"];
    NSString *dayInd = [observationDict objectForKey:@"dayInd"];
    NSNumber *UVIndex = [observationDict objectForKey:@"UVIndex"];
    NSNumber *UVWarning = [observationDict objectForKey:@"UVWarning"];
    NSString *WXMan = [observationDict objectForKey:@"WXMan"];
    NSNumber *OBSQualifierCode = [observationDict objectForKey:@"OBSQualifierCode"];
    NSNumber *PTendCode = [observationDict objectForKey:@"PTendCode"];
    NSString *DOW = [observationDict objectForKey:@"DOW"];
    NSString *wdirCardinal = [observationDict objectForKey:@"wdirCardinal"];
    NSString *UVDesc = [observationDict objectForKey:@"UVDesc"];
    NSString *phrase12char = [observationDict objectForKey:@"phrase12char"];
    NSString *phrase22char = [observationDict objectForKey:@"phrase22char"];
    NSString *phrase32char = [observationDict objectForKey:@"phrase32char"];
    NSString *PTendDesc = [observationDict objectForKey:@"PTendDesc"];
    NSString *skyCover = [observationDict objectForKey:@"skyCover"];
    NSString *clds = [observationDict objectForKey:@"clds"];
    NSNumber *OBSQualifierSeverity = [observationDict objectForKey:@"OBSQualifierSeverity"];
    NSString *vocalKey = [observationDict objectForKey:@"vocalKey"];
    PPWeatherObservationMetric *metric = [PPWeatherObservationMetric initWithDictionary:[observationDict objectForKey:@"metric"]];
    
    PPWeatherObservation *observation = [[PPWeatherObservation alloc] initWithObservationClass:observationClass expireTimeGMT:expireTimeGMT OBSTime:OBSTime OBSTimeLocal:OBSTimeLocal wDir:wDir iconCode:iconCode iconExtd:iconExtd sunrise:sunrise sunset:sunset dayInd:dayInd UVIndex:UVIndex UVWarning:UVWarning WXMan:WXMan OBSQualifierCode:OBSQualifierCode PTendCode:PTendCode DOW:DOW wdirCardinal:wdirCardinal UVDesc:UVDesc phrase12char:phrase12char phrase22char:phrase22char phrase32char:phrase32char PTendDesc:PTendDesc skyCover:skyCover clds:clds OBSQualifierSeverity:OBSQualifierSeverity vocalKey:vocalKey metric:metric];
    return observation;
}

@end
