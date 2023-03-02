//
//  PPFileSummary.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPFileSummary.h"

@implementation PPFileSummary

- (id)initWithDate:(NSDate *)date total:(PPFileSummaryTotal)total size:(PPFileSummarySize)size duration:(PPFileSummaryDuration)duration viewed:(PPFileSummaryViewed)viewed favourite:(PPFileSummaryFavourite)favourite {
    self = [super init];
    if(self) {
        self.date = date;
        self.total = total;
        self.size = size;
        self.duration = duration;
        self.viewed = viewed;
        self.favourite = favourite;
    }
    return self;
}

+ (PPFileSummary *)initWithDictionary:(NSDictionary *)summaryDict {
    NSString *dateString = [summaryDict objectForKey:@"date"];
    NSDate *date = [NSDate date];
    
    if(dateString != nil) {
        if(![dateString isEqualToString:@""]) {
            date = [PPNSDate parseDateTime:dateString];
        }
    }
    PPFileSummaryTotal total = PPFileSummaryTotalNone;
    if([summaryDict objectForKey:@"total"]) {
        total = (PPFileSummaryTotal)((NSString *)[summaryDict objectForKey:@"total"]).integerValue;
    }
    PPFileSummarySize size = PPFileSummarySizeNone;
    if([summaryDict objectForKey:@"size"]) {
        size = (PPFileSummarySize)((NSString *)[summaryDict objectForKey:@"size"]).integerValue;
    }
    PPFileSummaryDuration duration = PPFileSummaryDurationNone;
    if([summaryDict objectForKey:@"duration"]) {
        duration = (PPFileSummaryDuration)((NSString *)[summaryDict objectForKey:@"duration"]).integerValue;
    }
    PPFileSummaryViewed viewed = PPFileSummaryViewedNone;
    if([summaryDict objectForKey:@"viewed"]) {
        viewed = (PPFileSummaryViewed)((NSString *)[summaryDict objectForKey:@"viewed"]).integerValue;
    }
    PPFileSummaryFavourite favourite = PPFileSummaryFavouriteNone;
    if([summaryDict objectForKey:@"favourite"]) {
        favourite = (PPFileSummaryFavourite)((NSString *)[summaryDict objectForKey:@"favourite"]).integerValue;
    }
    
    PPFileSummary *summary = [[PPFileSummary alloc] initWithDate:date total:total size:size duration:duration viewed:viewed favourite:favourite];
    return summary;
}
@end
