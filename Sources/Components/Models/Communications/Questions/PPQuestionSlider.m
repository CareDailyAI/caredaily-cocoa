//
//  PPQuestionSlider.m
//  Peoplepower
//
//  Created by Destry Teeter on 2/17/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPQuestionSlider.h"

@implementation PPQuestionSlider

- (id)initWithMax:(NSNumber *)max
              min:(NSNumber *)min
              inc:(NSNumber *)inc
          minDesc:(NSString *)minDesc
          maxDesc:(NSString *)maxDesc
        unitsDesc:(NSString *)unitsDesc {
    self = [super init];
    if (self) {
        self.max = max;
        self.min = min;
        self.inc = inc;
        self.minDesc = minDesc;
        self.maxDesc = maxDesc;
        self.unitsDesc = unitsDesc;
    }
    return self;
}

+ (PPQuestionSlider *)initWithDictionary:(NSDictionary *)sliderDict {
    NSNumber *min;
    if([sliderDict objectForKey:@"min"]) {
        min = [[NSNumber alloc] initWithFloat:((NSString *)[sliderDict objectForKey:@"min"]).floatValue];
    }
    NSNumber *max;
    if([sliderDict objectForKey:@"max"]) {
        max = [[NSNumber alloc] initWithFloat:((NSString *)[sliderDict objectForKey:@"max"]).floatValue];
    }
    NSNumber *inc;
    if([sliderDict objectForKey:@"inc"]) {
        inc = [[NSNumber alloc] initWithFloat:((NSString *)[sliderDict objectForKey:@"inc"]).floatValue];
    }
    NSString *minDesc = [sliderDict objectForKey:@"minDesc"];
    NSString *maxDesc = [sliderDict objectForKey:@"maxDesc"];
    NSString *unitsDesc = [sliderDict objectForKey:@"unitsDesc"];
    
    PPQuestionSlider *slider = [[PPQuestionSlider alloc] initWithMax:max
                                                                 min:min
                                                                 inc:inc
                                                             minDesc:minDesc
                                                             maxDesc:maxDesc
                                                           unitsDesc:unitsDesc];
    return slider;
}

@end
