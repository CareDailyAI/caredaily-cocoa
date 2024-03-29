//
//  PPLocationOccupantsRange.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPLocationOccupantsRange : PPBaseModel <NSCopying>

@property (nonatomic) NSInteger start;
@property (nonatomic) NSInteger end;
@property (nonatomic) NSInteger number;

- (id)initWithStart:(NSInteger)start end:(NSInteger)end number:(NSInteger)number;

+ (PPLocationOccupantsRange *)initWithDictionary:(NSDictionary *)occupantsRangeDict;

@end
