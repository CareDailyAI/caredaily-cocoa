//
//  PPWeatherObservationMetric.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPWeatherObservationMetric.h"

@interface PPWeatherObservationMetric : NSObject

@property (nonatomic, strong) NSNumber *wspd;
@property (nonatomic, strong) NSNumber *gust;
@property (nonatomic, strong) NSNumber *vis;
@property (nonatomic, strong) NSNumber *mslp;
@property (nonatomic, strong) NSNumber *altimeter;
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSNumber *dewPt;
@property (nonatomic, strong) NSNumber *rh;
@property (nonatomic, strong) NSNumber *wc;
@property (nonatomic, strong) NSNumber *hi;
@property (nonatomic, strong) NSNumber *tempChange24hour;
@property (nonatomic, strong) NSNumber *tempMax24hour;
@property (nonatomic, strong) NSNumber *tempMin24hour;
@property (nonatomic, strong) NSNumber *pChange;
@property (nonatomic, strong) NSNumber *feelsLike;
@property (nonatomic, strong) NSNumber *snow1hour;
@property (nonatomic, strong) NSNumber *snow6hour;
@property (nonatomic, strong) NSNumber *snow24hour;
@property (nonatomic, strong) NSNumber *snowMTD;
@property (nonatomic, strong) NSNumber *snowSeason;
@property (nonatomic, strong) NSNumber *snowYTD;
@property (nonatomic, strong) NSNumber *snow2day;
@property (nonatomic, strong) NSNumber *snow3day;
@property (nonatomic, strong) NSNumber *snow7day;
@property (nonatomic, strong) NSNumber *ceiling;
@property (nonatomic, strong) NSNumber *precip1hour;
@property (nonatomic, strong) NSNumber *precip6hour;
@property (nonatomic, strong) NSNumber *precip24hour;
@property (nonatomic, strong) NSNumber *precipMTD;
@property (nonatomic, strong) NSNumber *precipYTD;
@property (nonatomic, strong) NSNumber *precip2Day;
@property (nonatomic, strong) NSNumber *precip3Day;
@property (nonatomic, strong) NSNumber *precip7Day;
@property (nonatomic, strong) NSNumber *OBSQualifier100Char;
@property (nonatomic, strong) NSNumber *OBSQualifier50Char;
@property (nonatomic, strong) NSNumber *OBSQualifier32Char;

- (id)initWithWSPD:(NSNumber *)wspd gust:(NSNumber *)gust vis:(NSNumber *)vis mslp:(NSNumber *)mslp altimeter:(NSNumber *)altimeter temp:(NSNumber *)temp dewPt:(NSNumber *)dewPt rh:(NSNumber *)rh wc:(NSNumber *)wc hi:(NSNumber *)hi tempChange24hour:(NSNumber *)tempChange24hour tempMax24hour:(NSNumber *)tempMax24hour tempMin24hour:(NSNumber *)tempMin24hour pChange:(NSNumber *)pChange feelsLike:(NSNumber *)feelsLike snow1hour:(NSNumber *)snow1hour snow6hour:(NSNumber *)snow6hour snow24hour:(NSNumber *)snow24hour snowMTD:(NSNumber *)snowMTD snowSeason:(NSNumber *)snowSeason snowYTD:(NSNumber *)snowYTD snow2day:(NSNumber *)snow2day snow3day:(NSNumber *)snow3day snow7day:(NSNumber *)snow7day ceiling:(NSNumber *)ceiling precip1hour:(NSNumber *)precip1hour precip6hour:(NSNumber *)precip6hour precip24hour:(NSNumber *)precip24hour precipMTD:(NSNumber *)precipMTD precipYTD:(NSNumber *)precipYTD precip2Day:(NSNumber *)precip2Day precip3Day:(NSNumber *)precip3Day precip7Day:(NSNumber *)precip7Day OBSQualifier100Char:(NSNumber *)OBSQualifier100Char OBSQualifier50Char:(NSNumber *)OBSQualifier50Char OBSQualifier32Char:(NSNumber *)OBSQualifier32Char;

+ (PPWeatherObservationMetric *)initWithDictionary:(NSDictionary *)metricDict;

@end
