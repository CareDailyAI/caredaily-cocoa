//
//  PPFileSummary.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPFileSummary : PPBaseModel

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
