//
//  PPDeviceProperty.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceProperty.h"

@implementation PPDeviceProperty

- (id)initWithName:(NSString *)name index:(NSString *)index content:(NSString *)content {
    self = [super init];
    if(self) {
        self.name = name;
        self.index = index;
        self.content = content;
    }
    return self;
}

+ (PPDeviceProperty *)initWithDictionary:(NSDictionary *)propertyDict {
    NSString *name = [propertyDict objectForKey:@"name"];
    NSString *index;
    if([propertyDict objectForKey:@"index"]) {
        index = [propertyDict objectForKey:@"index"];
    }
    NSString *content = [propertyDict objectForKey:@"value"];
    PPDeviceProperty *property = [[PPDeviceProperty alloc] initWithName:name index:index content:content];
    return property;
}

+ (NSString *)stringify:(PPDeviceProperty *)property {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(property.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\": \"%@\"", property.name];
        appendComma = YES;
    }
    
    if(property.index) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"index\": \"%@\"", property.index];
        appendComma = YES;
    }
    
    if(property.content) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"value\": \"%@\"", property.content];
        appendComma = YES;
    }
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPDeviceProperty *)property {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(property.name) {
        data[@"name"] = property.name;
    }
    
    if(property.index) {
        data[@"index"] = property.index;
    }
    
    if(property.content) {
        data[@"value"] = property.content;
    }
    
    return data;
}

#pragma mark - Helper methods

- (void)sync:(PPDeviceProperty *)property {
    if(property.name) {
        _name = property.name;
    }
    if(property.index) {
        _index = property.index;
    }
    if(property.content) {
        _content = property.content;
    }
}

@end
