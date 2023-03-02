//
//  PPLocationOccupantsRange.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPLocationOccupantsRange.h"

@implementation PPLocationOccupantsRange

- (id)initWithStart:(NSInteger)start end:(NSInteger)end number:(NSInteger)number {
    self = [super init];
    if(self) {
        self.start = start;
        self.end = end;
        self.number = number;
    }
    return self;
}

+ (PPLocationOccupantsRange *)initWithDictionary:(NSDictionary *)occupantsRangeDict {
    NSInteger occupantsRangeStart = ((NSString *)[occupantsRangeDict objectForKey:@"start"]).integerValue;
    NSInteger occupantsRangeEnd = ((NSString *)[occupantsRangeDict objectForKey:@"end"]).integerValue;
    NSInteger occupantsRangeNumber = ((NSString *)[occupantsRangeDict objectForKey:@"number"]).integerValue;
    PPLocationOccupantsRange *occupantsRange = [[PPLocationOccupantsRange alloc] initWithStart:occupantsRangeStart end:occupantsRangeEnd number:occupantsRangeNumber];
    return occupantsRange;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPLocationOccupantsRange *occupantsRange = [[PPLocationOccupantsRange allocWithZone:zone] init];
    
    occupantsRange.start = self.start;
    occupantsRange.end = self.end;
    occupantsRange.number = self.number;
    
    return occupantsRange;
}


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.start = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"start"]).integerValue;
        self.end = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"end"]).integerValue;
        self.number = (NSInteger)((NSNumber *)[decoder decodeObjectForKey:@"number"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_start) forKey:@"start"];
    [encoder encodeObject:@(_end) forKey:@"end"];
    [encoder encodeObject:@(_number) forKey:@"number"];
}


@end
