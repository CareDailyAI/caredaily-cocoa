//
//  PPFileSummary.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPFileSummaryAggregation) {
    PPFileSummaryAggregationNone = -1,
    PPFileSummaryAggregationHour = 1,
    PPFileSummaryAggregationDay = 2,
    PPFileSummaryAggregationMonth = 3,
    PPFileSummaryAggregationWeek = 4 // 7-day week from Sunday to Saturday
};

typedef NS_OPTIONS(NSInteger, PPFileSummaryDetails) {
    PPFileSummaryDetailsNone = -1,
    PPFileSummaryDetailsFalse = 0,
    PPFileSummaryDetailsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileSummaryTotal) {
    PPFileSummaryTotalNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummarySize) {
    PPFileSummarySizeNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryDuration) {
    PPFileSummaryDurationNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryViewed) {
    PPFileSummaryViewedNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryFavourite) {
    PPFileSummaryFavouriteNone = -1
};

@interface PPFileSummary : RLMObject

/* File creation date rounded to the beginning of an aggregation period */
@property (nonatomic, strong) NSDate *date;

/* Total number of files */
@property (nonatomic) PPFileSummaryTotal total;

/* Total size of the files */
@property (nonatomic) PPFileSummarySize size;

/* Total duration in seconds */
@property (nonatomic) PPFileSummaryDuration duration;

/* Total viewed files */
@property (nonatomic) PPFileSummaryViewed viewed;

/* Total favourite files */
@property (nonatomic) PPFileSummaryFavourite favourite;

- (id)initWithDate:(NSDate *)date total:(PPFileSummaryTotal)total size:(PPFileSummarySize)size duration:(PPFileSummaryDuration)duration viewed:(PPFileSummaryViewed)viewed favourite:(PPFileSummaryFavourite)favourite;

+ (PPFileSummary *)initWithDictionary:(NSDictionary *)summaryDict;

@end

RLM_ARRAY_TYPE(PPFileSummary);
