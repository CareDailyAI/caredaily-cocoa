//
//  PPLocationSize.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPLocationSize : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *unit;
@property (nonatomic) PPLocationSizeContent content;

- (id)initWithUnit:(NSString *)unit content:(PPLocationSizeContent)content;

+ (PPLocationSize *)initWithDictionary:(NSDictionary *)sizeDict;

@end
