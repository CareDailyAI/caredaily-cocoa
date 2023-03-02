//
//  PPUserCode.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPUserCode.h"

@implementation PPUserCode

- (id)initWithName:(NSString *)name
              type:(PPUserCodeType)type
          verified:(PPUserCodeVerified)verified {
    self = [super init];
    if(self) {
        self.name = name;
        self.type = type;
        self.verified = verified;
    }
    return self;
}

+ (PPUserCode *)initWithDictionary:(NSDictionary *)codeDict {
    NSString *name = [codeDict objectForKey:@"name"];
    PPUserCodeType type = PPUserCodeTypeManual;
    if ([codeDict objectForKey:@"type"]) {
        type = (PPUserCodeType)((NSNumber *)[codeDict objectForKey:@"type"]).integerValue;
    }
    PPUserCodeVerified verified = PPUserCodeVerifiedNone;
    if ([codeDict objectForKey:@"verified"]) {
        verified = (PPUserCodeVerified)((NSNumber *)[codeDict objectForKey:@"verified"]).integerValue;
    }
    
    PPUserCode *userCode = [[PPUserCode alloc] initWithName:name type:type verified:verified];
    return userCode;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.type = (PPUserCodeType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
        self.verified = (PPUserCodeVerified)((NSNumber *)[decoder decodeObjectForKey:@"verified"]).integerValue;
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_type) forKey:@"type"];
    [encoder encodeObject:@(_verified) forKey:@"verified"];
    [encoder encodeObject:_code forKey:@"code"];
}


@end

