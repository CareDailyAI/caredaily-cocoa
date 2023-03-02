//
//  PPQuestionSlider.h
//  Peoplepower
//
//  Created by Destry Teeter on 2/17/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import <Peoplepower/Peoplepower.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPQuestionSlider : PPBaseModel

/* Slider question minimum value */
@property (nonatomic) NSNumber<RLMFloat> * _Nullable min;

/* Slider question maximum value */
@property (nonatomic) NSNumber<RLMFloat> * _Nullable max;

/* Slider question incremental slider value */
@property (nonatomic) NSNumber<RLMFloat> * _Nullable inc;

/* Description of slider question minimum value */
@property (nonatomic, strong) NSString * _Nullable minDesc;

/* Description of slider question maximum value */
@property (nonatomic, strong) NSString * _Nullable maxDesc;

/* Description of slider question UOM */
@property (nonatomic, strong) NSString * _Nullable unitsDesc;

- (id)initWithMax:(NSNumber * _Nullable )max
              min:(NSNumber * _Nullable )min
              inc:(NSNumber * _Nullable )inc
          minDesc:(NSString * _Nullable )minDesc
          maxDesc:(NSString * _Nullable )maxDesc
        unitsDesc:(NSString * _Nullable )unitsDesc;

+ (PPQuestionSlider *)initWithDictionary:(NSDictionary *)sliderDict;

@end

NS_ASSUME_NONNULL_END
