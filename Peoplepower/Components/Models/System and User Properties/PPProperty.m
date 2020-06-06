//
//  PPProperty.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPProperty.h"

@implementation PPProperty

+ (NSString *)primaryKey {
    return @"name";
}

- (id)initWithName:(NSString *)name value:(NSString *)value {
    self = [super init];
    if(self) {
        self.name = name;
        self.value = value;
    }
    return self;
}

+ (PPProperty *)initWithDictionary:(NSDictionary *)propertyDict {
    NSString *name = [propertyDict objectForKey:@"name"];
    NSString *value = [propertyDict objectForKey:@"value"];
    
    PPProperty *property = [[PPProperty alloc] initWithName:name value:value];
    return property;
}

+ (NSString *)stringify:(PPProperty *)property {
    return [NSString stringWithFormat:@"{\"name\":\"%@\", \"content\":\"%@\"}", property.name, property.value];
}

+ (NSDictionary *)data:(PPProperty *)property {
    NSMutableDictionary *data = @{}.mutableCopy;
    if (property.name != nil && ![property.name isEqualToString:@""]) {
        data[@"name"] = property.name;
    }
    if (property.value != nil && ![property.value isEqualToString:@""]) {
        data[@"content"] = property.value;
    }
    return data;
}

@end
