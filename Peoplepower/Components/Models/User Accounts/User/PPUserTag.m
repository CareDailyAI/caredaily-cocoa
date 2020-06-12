//
//  PPUserTag.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserTag.h"
#import "PPCloudEngine.h"

@implementation PPUserTag

- (id)initWithTag:(NSString *)tag {
    self = [super init];
    if(self) {
        self.tag = tag;
    }
    return self;
}

+ (PPUserTag *)initWithDictionary:(NSDictionary *)tagDict {
    NSString *tag = [tagDict objectForKey:@"tag"];
    PPUserTag *userTag = [[PPUserTag alloc] initWithTag:tag];
    return userTag;
}

#pragma mark - Helper methods

- (void)sync:(PPUserTag *)userTag {
    if(userTag.tag) {
        _tag = userTag.tag;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUserTag *tag = [[PPUserTag allocWithZone:zone] init];
    
    tag.tag = [self.tag copyWithZone:zone];
    
    return tag;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.tag = [decoder decodeObjectForKey:@"tag"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_tag forKey:@"tag"];
}


@end

