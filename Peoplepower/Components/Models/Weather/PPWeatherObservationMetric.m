//
//  PPWeatherObservationMetric.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPWeatherObservationMetric.h"

@implementation PPWeatherObservationMetric

- (id)initWithWSPD:(NSNumber *)wspd gust:(NSNumber *)gust vis:(NSNumber *)vis mslp:(NSNumber *)mslp altimeter:(NSNumber *)altimeter temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt rh:(NSNumber *)rh wc:(NSNumber *)wc hi:(NSNumber *)hi tempChange24hour:(NSNumber *)tempChange24hour tempMax24hour:(NSNumber *)tempMax24hour tempMin24hour:(NSNumber *)tempMin24hour pChange:(NSNumber *)pChange feelsLike:(NSNumber *)feelsLike snow1hour:(NSNumber *)snow1hour snow6hour:(NSNumber *)snow6hour snow24hour:(NSNumber *)snow24hour snowMTD:(NSNumber *)snowMTD snowSeason:(NSNumber *)snowSeason snowYTD:(NSNumber *)snowYTD snow2day:(NSNumber *)snow2day snow3day:(NSNumber *)snow3day snow7day:(NSNumber *)snow7day ceiling:(NSNumber *)ceiling precip1hour:(NSNumber *)precip1hour precip6hour:(NSNumber *)precip6hour precip24hour:(NSNumber *)precip24hour precipMTD:(NSNumber *)precipMTD precipYTD:(NSNumber *)precipYTD precip2Day:(NSNumber *)precip2Day precip3Day:(NSNumber *)precip3Day precip7Day:(NSNumber *)precip7Day OBSQualifier100Char:(NSNumber *)OBSQualifier100Char OBSQualifier50Char:(NSNumber *)OBSQualifier50Char OBSQualifier32Char:(NSNumber *)OBSQualifier32Char {
    self = [super init];
    if(self) {
        self.wspd = wspd;
        self.gust = gust;
        self.vis = vis;
        self.mslp = mslp;
        self.altimeter = altimeter;
        self.temp = temp;
        self.dewPt = dewPt;
        self.rh = rh;
        self.wc = wc;
        self.hi = hi;
        self.tempChange24hour = tempChange24hour;
        self.tempMax24hour = tempMax24hour;
        self.tempMin24hour = tempMin24hour;
        self.pChange = pChange;
        self.feelsLike = feelsLike;
        self.snow1hour = snow1hour;
        self.snow6hour = snow6hour;
        self.snow24hour = snow24hour;
        self.snowMTD = snowMTD;
        self.snowSeason = snowSeason;
        self.snowYTD = snowYTD;
        self.snow2day = snow2day;
        self.snow3day = snow3day;
        self.snow7day = snow7day;
        self.ceiling = ceiling;
        self.precip1hour = precip1hour;
        self.precip6hour = precip6hour;
        self.precip24hour = precip24hour;
        self.precipMTD = precipMTD;
        self.precipYTD = precipYTD;
        self.precip2Day = precip2Day;
        self.precip3Day = precip3Day;
        self.precip7Day = precip7Day;
        self.OBSQualifier100Char = OBSQualifier100Char;
        self.OBSQualifier50Char = OBSQualifier50Char;
        self.OBSQualifier32Char = OBSQualifier32Char;
    }
    return self;
}

+ (PPWeatherObservationMetric *)initWithDictionary:(NSDictionary *)metricDict {
    
    NSNumber *wspd = [metricDict objectForKey:@"wspd"];
    NSNumber *gust = [metricDict objectForKey:@"gust"];
    NSNumber *vis = [metricDict objectForKey:@"vis"];
    NSNumber *mslp = [metricDict objectForKey:@"mslp"];
    NSNumber *altimeter = [metricDict objectForKey:@"altimeter"];
    NSNumber *temp = [metricDict objectForKey:@"temp"];
    NSNumber *dewPt = [metricDict objectForKey:@"dewPt"];
    NSNumber *rh = [metricDict objectForKey:@"rh"];
    NSNumber *wc = [metricDict objectForKey:@"wc"];
    NSNumber *hi = [metricDict objectForKey:@"hi"];
    NSNumber *tempChange24hour = [metricDict objectForKey:@"tempChange24hour"];
    NSNumber *tempMax24hour = [metricDict objectForKey:@"tempMax24hour"];
    NSNumber *tempMin24hour = [metricDict objectForKey:@"tempMin24hour"];
    NSNumber *pChange = [metricDict objectForKey:@"pChange"];
    NSNumber *feelsLike = [metricDict objectForKey:@"feelsLike"];
    NSNumber *snow1hour = [metricDict objectForKey:@"snow1hour"];
    NSNumber *snow6hour = [metricDict objectForKey:@"snow6hour"];
    NSNumber *snow24hour = [metricDict objectForKey:@"snow24hour"];
    NSNumber *snowMTD = [metricDict objectForKey:@"snowMTD"];
    NSNumber *snowSeason = [metricDict objectForKey:@"snowSeason"];
    NSNumber *snowYTD = [metricDict objectForKey:@"snowYTD"];
    NSNumber *snow2day = [metricDict objectForKey:@"snow2day"];
    NSNumber *snow3day = [metricDict objectForKey:@"snow3day"];
    NSNumber *snow7day = [metricDict objectForKey:@"snow7day"];
    NSNumber *ceiling = [metricDict objectForKey:@"ceiling"];
    NSNumber *precip1hour = [metricDict objectForKey:@"precip1hour"];
    NSNumber *precip6hour = [metricDict objectForKey:@"precip6hour"];
    NSNumber *precip24hour = [metricDict objectForKey:@"precip24hour"];
    NSNumber *precipMTD = [metricDict objectForKey:@"precipMTD"];
    NSNumber *precipYTD = [metricDict objectForKey:@"precipYTD"];
    NSNumber *precip2Day = [metricDict objectForKey:@"precip2Day"];
    NSNumber *precip3Day = [metricDict objectForKey:@"precip3Day"];
    NSNumber *precip7Day = [metricDict objectForKey:@"precip7Day"];
    NSNumber *OBSQualifier100Char = [metricDict objectForKey:@"OBSQualifier100Char"];
    NSNumber *OBSQualifier50Char = [metricDict objectForKey:@"OBSQualifier50Char"];
    NSNumber *OBSQualifier32Char = [metricDict objectForKey:@"OBSQualifier32Char"];
    
    PPWeatherObservationMetric *metric = [[PPWeatherObservationMetric alloc] initWithWSPD:wspd gust:gust vis:vis mslp:mslp altimeter:altimeter temp:temp dewPt:dewPt rh:rh wc:wc hi:hi tempChange24hour:tempChange24hour tempMax24hour:tempMax24hour tempMin24hour:tempMin24hour pChange:pChange feelsLike:feelsLike snow1hour:snow1hour snow6hour:snow6hour snow24hour:snow24hour snowMTD:snowMTD snowSeason:snowSeason snowYTD:snowYTD snow2day:snow2day snow3day:snow3day snow7day:snow7day ceiling:ceiling precip1hour:precip1hour precip6hour:precip6hour precip24hour:precip24hour precipMTD:precipMTD precipYTD:precipYTD precip2Day:precip2Day precip3Day:precip3Day precip7Day:precip7Day OBSQualifier100Char:OBSQualifier100Char OBSQualifier50Char:OBSQualifier50Char OBSQualifier32Char:OBSQualifier32Char];
    return metric;
}

@end
