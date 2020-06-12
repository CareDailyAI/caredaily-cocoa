//
//  PPLocationSize.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationSize.h"

@implementation PPLocationSize

- (id)initWithUnit:(NSString *)unit content:(PPLocationSizeContent)content {
    self = [super init];
    if(self) {
        self.unit = unit;
        self.content = content;
    }
    return self;
}

+ (PPLocationSize *)initWithDictionary:(NSDictionary *)sizeDict {
    NSString *unit = [sizeDict objectForKey:@"unit"];
    PPLocationSizeContent content = PPLocationSizeContentNone;
    if([sizeDict objectForKey:@"content"]) {
        content = (PPLocationSizeContent)((NSString *)[sizeDict objectForKey:@"content"]).integerValue;
    }
    
    PPLocationSize *size = [[PPLocationSize alloc] initWithUnit:unit content:content];
    return size;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPLocationSize *size = [[[self class] allocWithZone:zone] init];
    
    size.unit = [self.unit copyWithZone:zone];
    size.content = self.content;
    
    return size;
}
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.unit = [decoder decodeObjectForKey:@"unit"];
        self.content = (PPLocationSizeContent)((NSNumber *)[decoder decodeObjectForKey:@"content"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_unit forKey:@"unit"];
    [encoder encodeObject:@(_content) forKey:@"content"];
}


@end
