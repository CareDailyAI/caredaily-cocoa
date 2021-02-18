//
//  PPQuestionSlider.m
//  Peoplepower
//
//  Created by Destry Teeter on 2/17/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPQuestionSlider.h"

@implementation PPQuestionSlider

- (id)initWithMax:(PPQuestionSliderMax)max
              min:(PPQuestionSliderMin)min
              inc:(PPQuestionSliderInc)inc
          minDesc:(NSString *)minDesc
          maxDesc:(NSString *)maxDesc
        unitsDesc:(NSString *)unitsDesc {
    self = [super init];
    if (self) {
        self.max = max;
        self.min = min;
        self.minDesc = minDesc;
        self.maxDesc = maxDesc;
        self.unitsDesc = unitsDesc;
    }
    return self;
}

+ (PPQuestionSlider *)initWithDictionary:(NSDictionary *)sliderDict {
    PPQuestionSliderMin min = PPQuestionSliderMinNone;
    if([sliderDict objectForKey:@"min"]) {
        min = (PPQuestionSliderMin)((NSString *)[sliderDict objectForKey:@"min"]).integerValue;
    }
    PPQuestionSliderMax max = PPQuestionSliderMaxNone;
    if([sliderDict objectForKey:@"max"]) {
        max = (PPQuestionSliderMax)((NSString *)[sliderDict objectForKey:@"max"]).integerValue;
    }
    PPQuestionSliderInc inc = PPQuestionSliderIncNone;
    if([sliderDict objectForKey:@"inc"]) {
        inc = (PPQuestionSliderInc)((NSString *)[sliderDict objectForKey:@"inc"]).integerValue;
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
