//
//  PPWeatherForecast.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWeatherForecast.h"

@implementation PPWeatherForecast

- (id)initWithForecastClass:(NSString *)forecastClass expireTimeGMT:(NSNumber *)expireTimeGMT forecastValid:(NSNumber *)forecastValid forecastValidLocal:(NSDate *)forecastValidLocal num:(NSNumber *)num dayInd:(NSString *)dayInd temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt hi:(NSNumber *)hi wc:(NSNumber *)wc feelsLike:(NSNumber *)feelsLike iconExtd:(NSNumber *)iconExtd wxman:(NSString *)wxman iconCode:(NSNumber *)iconCode DOW:(NSString *)DOW phrase12Char:(NSString *)phrase12Char phrase22Char:(NSString *)phrase22Char phrase32Char:(NSString *)phrase32Char subphrasePt1:(NSString *)subphrasePt1 subphrasePt2:(NSString *)subphrasePt2 subphrasePt3:(NSString *)subphrasePt3 pop:(NSNumber *)pop precipType:(NSString *)precipType QPF:(NSNumber *)QPF snowQPF:(NSNumber *)snowQPF rh:(NSNumber *)rh wspd:(NSNumber *)wspd wDir:(NSNumber *)wDir wDirCardinal:(NSString *)wDirCardinal gust:(NSNumber *)gust clds:(NSNumber *)clds vis:(NSNumber *)vis mslp:(NSNumber *)mslp UVIndexRaw:(NSNumber *)UVIndexRaw UVIndex:(NSNumber *)UVIndex UVWarning:(NSNumber *)UVWarning UVDesc:(NSString *)UVDesc golfIndex:(NSNumber *)golfIndex golfCategory:(NSString *)golfCategory severity:(NSNumber *)severity {
    self = [super init];
    if(self) {
        self.forecastClass = forecastClass;
        self.expireTimeGMT = expireTimeGMT;
        self.forecastValid = forecastValid;
        self.forecastValidLocal = forecastValidLocal;
        self.num = num;
        self.dayInd = dayInd;
        self.temp = temp;
        self.dewPt = dewPt;
        self.hi = hi;
        self.wc = wc;
        self.feelsLike = feelsLike;
        self.iconExtd = iconExtd;
        self.wxman = wxman;
        self.iconCode = iconCode;
        self.DOW = DOW;
        self.phrase12Char = phrase12Char;
        self.phrase22Char = phrase22Char;
        self.phrase32Char = phrase32Char;
        self.subphrasePt1 = subphrasePt1;
        self.subphrasePt2 = subphrasePt2;
        self.subphrasePt3 = subphrasePt3;
        self.pop = pop;
        self.precipType = precipType;
        self.QPF = QPF;
        self.snowQPF = snowQPF;
        self.rh = rh;
        self.wspd = wspd;
        self.wDir = wDir;
        self.wDirCardinal = wDirCardinal;
        self.gust = gust;
        self.clds = clds;
        self.vis = vis;
        self.mslp = mslp;
        self.UVIndexRaw = UVIndexRaw;
        self.UVIndex = UVIndex;
        self.UVWarning = UVWarning;
        self.UVDesc = UVDesc;
        self.golfIndex = golfIndex;
        self.golfCategory = golfCategory;
        self.severity = severity;
    }
    return self;
}

+ (PPWeatherForecast *)initWithDictionary:(NSDictionary *)forecastDict {
    
    NSString *forecastClass = [forecastDict objectForKey:@"forecastClass"];
    NSNumber *expireTimeGMT = [forecastDict objectForKey:@"expireTimeGMT"];
    NSNumber *forecastValid = [forecastDict objectForKey:@"forecastValid"];
    NSDate *forecastValidLocal = [forecastDict objectForKey:@"forecastValidLocal"];
    NSNumber *num = [forecastDict objectForKey:@"num"];
    NSString *dayInd = [forecastDict objectForKey:@"dayInd"];
    NSNumber *temp = [forecastDict objectForKey:@"temp"];
    NSNumber *dewPt = [forecastDict objectForKey:@"dewPt"];
    NSNumber *hi = [forecastDict objectForKey:@"hi"];
    NSNumber *wc = [forecastDict objectForKey:@"wc"];
    NSNumber *feelsLike = [forecastDict objectForKey:@"feelsLike"];
    NSNumber *iconExtd = [forecastDict objectForKey:@"iconExtd"];
    NSString *wxman = [forecastDict objectForKey:@"wxman"];
    NSNumber *iconCode = [forecastDict objectForKey:@"iconCode"];
    NSString *DOW = [forecastDict objectForKey:@"DOW"];
    NSString *phrase12Char = [forecastDict objectForKey:@"phrase12Char"];
    NSString *phrase22Char = [forecastDict objectForKey:@"phrase22Char"];
    NSString *phrase32Char = [forecastDict objectForKey:@"phrase32Char"];
    NSString *subphrasePt1 = [forecastDict objectForKey:@"subphrasePt1"];
    NSString *subphrasePt2 = [forecastDict objectForKey:@"subphrasePt2"];
    NSString *subphrasePt3 = [forecastDict objectForKey:@"subphrasePt3"];
    NSNumber *pop = [forecastDict objectForKey:@"pop"];
    NSString *precipType = [forecastDict objectForKey:@"precipType"];
    NSNumber *QPF = [forecastDict objectForKey:@"QPF"];
    NSNumber *snowQPF = [forecastDict objectForKey:@"snowQPF"];
    NSNumber *rh = [forecastDict objectForKey:@"rh"];
    NSNumber *wspd = [forecastDict objectForKey:@"wspd"];
    NSNumber *wDir = [forecastDict objectForKey:@"wDir"];
    NSString *wDirCardinal = [forecastDict objectForKey:@"wDirCardinal"];
    NSNumber *gust = [forecastDict objectForKey:@"gust"];
    NSNumber *clds = [forecastDict objectForKey:@"clds"];
    NSNumber *vis = [forecastDict objectForKey:@"vis"];
    NSNumber *mslp = [forecastDict objectForKey:@"mslp"];
    NSNumber *UVIndexRaw = [forecastDict objectForKey:@"UVIndexRaw"];
    NSNumber *UVIndex = [forecastDict objectForKey:@"UVIndex"];
    NSNumber *UVWarning = [forecastDict objectForKey:@"UVWarning"];
    NSString *UVDesc = [forecastDict objectForKey:@"UVDesc"];
    NSNumber *golfIndex = [forecastDict objectForKey:@"golfIndex"];
    NSString *golfCategory = [forecastDict objectForKey:@"golfCategory"];
    NSNumber *severity = [forecastDict objectForKey:@"severity"];
    
    PPWeatherForecast *forecast = [[PPWeatherForecast alloc] initWithForecastClass:forecastClass expireTimeGMT:expireTimeGMT forecastValid:forecastValid forecastValidLocal:forecastValidLocal num:num dayInd:dayInd temp:temp dewPt:dewPt hi:hi wc:wc feelsLike:feelsLike iconExtd:iconExtd wxman:wxman iconCode:iconCode DOW:DOW phrase12Char:phrase12Char phrase22Char:phrase22Char phrase32Char:phrase32Char subphrasePt1:subphrasePt1 subphrasePt2:subphrasePt2 subphrasePt3:subphrasePt3 pop:pop precipType:precipType QPF:QPF snowQPF:snowQPF rh:rh wspd:wspd wDir:wDir wDirCardinal:wDirCardinal gust:gust clds:clds vis:vis mslp:mslp UVIndexRaw:UVIndexRaw UVIndex:UVIndex UVWarning:UVWarning UVDesc:UVDesc golfIndex:golfIndex golfCategory:golfCategory severity:severity];
    return forecast;
}

@end
