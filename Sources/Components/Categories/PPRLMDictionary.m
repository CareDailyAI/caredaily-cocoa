//
//  PPRLMDictionary.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRLMDictionary.h"

@implementation PPRLMDictionary

- (id)initWithKeys:(RLMArray *)keys value:(RLMArray *)values {
    self = [super init];
    if(self) {
        self.keys = (RLMArray<RLMString> *)keys;
        self.values = (RLMArray<RLMString> *)values;
    }
    return self;
}

- (NSString *)stringValueForKey:(NSString *)key {
    NSInteger idx = [self.keys indexOfObject:key];
    if([self.values count] > idx) {
        return [self.values objectAtIndex:[self.keys indexOfObject:key]];
    }
    return nil;
}

- (NSString *)arrayValueForKey:(NSString *)key {
    NSInteger idx = [self.keys indexOfObject:key];
    if([self.values count] > idx) {
        NSString *string = [self.values objectAtIndex:[self.keys indexOfObject:key]];
        NSError *error;
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        if (data != nil) {
            NSArray *array = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                return array;
            }
        }
    }
    return nil;
}

- (NSString *)dictValueForKey:(NSString *)key {
    NSInteger idx = [self.keys indexOfObject:key];
    if([self.values count] > idx) {
        NSString *string = [self.values objectAtIndex:[self.keys indexOfObject:key]];
        NSError *error;
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        if (data != nil) {
            NSArray *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                return dict;
            }
        }
    }
    return nil;
}

+ (PPRLMDictionary *)initWithDictionary:(NSDictionary *)dict {
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:[dict.allKeys count]];
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[dict.allKeys count]];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[NSNumber class]]) {
            [keys addObject:key];
            [values addObject:((NSNumber *)obj).stringValue];
        }
        else if([obj isKindOfClass:[NSString class]]) {
            [keys addObject:key];
            [values addObject:[[NSString stringWithString:obj] stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""]];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]
                 || [obj isKindOfClass:[NSArray class]]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
            if (!error) {
                [keys addObject:key];
                [values addObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            }
        }
    }];
    
    PPRLMDictionary *RLMDictionary = [[PPRLMDictionary alloc] initWithKeys:(RLMArray *)keys value:(RLMArray *)values];
    return RLMDictionary;
}


+ (NSString *)stringify:(PPRLMDictionary *)model {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@""];
    
    BOOL appendComma = NO;
    for(NSInteger i = 0; i < model.keys.count; i++) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"%@\":\"%@\"", [model.keys objectAtIndex:i], [model.values objectAtIndex:i]];
        appendComma = YES;
    }
    
    return JSONString;
}

+ (NSDictionary *)data:(PPRLMDictionary *)model {
    NSMutableDictionary *data = @{}.mutableCopy;
    for (NSInteger i = 0; i < model.keys.count; i++) {
        data[[model.keys objectAtIndex:i]] = [model.values objectAtIndex:i];
    }
    return data;
}

@end
