//
//  PPQuestionSlider.h
//  Peoplepower
//
//  Created by Destry Teeter on 2/17/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import <Peoplepower/Peoplepower.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPQuestionSlider : PPBaseModel

/* Slider question minimum value */
@property (nonatomic) NSNumber<RLMFloat> *min;

/* Slider question maximum value */
@property (nonatomic) NSNumber<RLMFloat> *max;

/* Slider question incremental slider value */
@property (nonatomic) NSNumber<RLMFloat> *inc;

/* Description of slider question minimum value */
@property (nonatomic, strong) NSString *minDesc;

/* Description of slider question maximum value */
@property (nonatomic, strong) NSString *maxDesc;

/* Description of slider question UOM */
@property (nonatomic, strong) NSString *unitsDesc;

- (id)initWithMax:(NSNumber *)max
              min:(NSNumber *)min
              inc:(NSNumber *)inc
          minDesc:(NSString *)minDesc
          maxDesc:(NSString *)maxDesc
        unitsDesc:(NSString *)unitsDesc;

+ (PPQuestionSlider *)initWithDictionary:(NSDictionary *)sliderDict;

@end

NS_ASSUME_NONNULL_END
