//
//  PPWeatherObservationMetric.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPWeatherObservationMetric.h"

@interface PPWeatherObservationMetric : RLMObject

@property (nonatomic, strong) NSNumber<RLMInt> *wspd;
@property (nonatomic, strong) NSNumber<RLMInt> *gust;
@property (nonatomic, strong) NSNumber<RLMFloat> *vis;
@property (nonatomic, strong) NSNumber<RLMFloat> *mslp;
@property (nonatomic, strong) NSNumber<RLMFloat> *altimeter;
@property (nonatomic, strong) NSNumber<RLMInt> *temp;
@property (nonatomic, strong) NSNumber<RLMInt> *dewPt;
@property (nonatomic, strong) NSNumber<RLMInt> *rh;
@property (nonatomic, strong) NSNumber<RLMInt> *wc;
@property (nonatomic, strong) NSNumber<RLMInt> *hi;
@property (nonatomic, strong) NSNumber<RLMInt> *tempChange24hour;
@property (nonatomic, strong) NSNumber<RLMInt> *tempMax24hour;
@property (nonatomic, strong) NSNumber<RLMInt> *tempMin24hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *pChange;
@property (nonatomic, strong) NSNumber<RLMInt> *feelsLike;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow1hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow6hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow24hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *snowMTD;
@property (nonatomic, strong) NSNumber<RLMFloat> *snowSeason;
@property (nonatomic, strong) NSNumber<RLMFloat> *snowYTD;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow2day;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow3day;
@property (nonatomic, strong) NSNumber<RLMFloat> *snow7day;
@property (nonatomic, strong) NSNumber<RLMInt> *ceiling;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip1hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip6hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip24hour;
@property (nonatomic, strong) NSNumber<RLMFloat> *precipMTD;
@property (nonatomic, strong) NSNumber<RLMFloat> *precipYTD;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip2Day;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip3Day;
@property (nonatomic, strong) NSNumber<RLMFloat> *precip7Day;
@property (nonatomic, strong) NSNumber<RLMInt> *OBSQualifier100Char;
@property (nonatomic, strong) NSNumber<RLMInt> *OBSQualifier50Char;
@property (nonatomic, strong) NSNumber<RLMInt> *OBSQualifier32Char;

- (id)initWithWSPD:(NSNumber *)wspd gust:(NSNumber *)gust vis:(NSNumber *)vis mslp:(NSNumber *)mslp altimeter:(NSNumber *)altimeter temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt rh:(NSNumber *)rh wc:(NSNumber *)wc hi:(NSNumber *)hi tempChange24hour:(NSNumber *)tempChange24hour tempMax24hour:(NSNumber *)tempMax24hour tempMin24hour:(NSNumber *)tempMin24hour pChange:(NSNumber *)pChange feelsLike:(NSNumber *)feelsLike snow1hour:(NSNumber *)snow1hour snow6hour:(NSNumber *)snow6hour snow24hour:(NSNumber *)snow24hour snowMTD:(NSNumber *)snowMTD snowSeason:(NSNumber *)snowSeason snowYTD:(NSNumber *)snowYTD snow2day:(NSNumber *)snow2day snow3day:(NSNumber *)snow3day snow7day:(NSNumber *)snow7day ceiling:(NSNumber *)ceiling precip1hour:(NSNumber *)precip1hour precip6hour:(NSNumber *)precip6hour precip24hour:(NSNumber *)precip24hour precipMTD:(NSNumber *)precipMTD precipYTD:(NSNumber *)precipYTD precip2Day:(NSNumber *)precip2Day precip3Day:(NSNumber *)precip3Day precip7Day:(NSNumber *)precip7Day OBSQualifier100Char:(NSNumber *)OBSQualifier100Char OBSQualifier50Char:(NSNumber *)OBSQualifier50Char OBSQualifier32Char:(NSNumber *)OBSQualifier32Char;

+ (PPWeatherObservationMetric *)initWithDictionary:(NSDictionary *)metricDict;

@end

RLM_ARRAY_TYPE(PPWeatherObservationMetric);
