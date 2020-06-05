//
//  PPUserCode.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserCode.h"

@implementation PPUserCode

- (id)initWithName:(NSString *)name type:(PPUserCodeType)type {
    self = [super init];
    if(self) {
        self.name = name;
        self.type = type;
    }
    return self;
}

+ (PPUserCode *)initWithDictionary:(NSDictionary *)codeDict {
    NSString *name = [codeDict objectForKey:@"name"];
    PPUserCodeType type = PPUserCodeTypeManual;
    if ([codeDict objectForKey:@"type"]) {
        type = (PPUserCodeType)((NSNumber *)[codeDict objectForKey:@"type"]).integerValue;
    }
    
    PPUserCode *userCode = [[PPUserCode alloc] initWithName:name type:type];
    return userCode;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.type = (PPUserCodeType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_type) forKey:@"type"];
    [encoder encodeObject:_code forKey:@"code"];
}


@end

