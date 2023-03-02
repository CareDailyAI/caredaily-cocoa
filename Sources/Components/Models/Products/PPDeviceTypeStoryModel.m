//
//  PPDeviceTypeStoryModel.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/21/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeStoryModel.h"

@implementation PPDeviceTypeStoryModel

- (id)initWithId:(NSString *)modelId brand:(NSString *)brand {
    self = [super init];
    if(self) {
        self.modelId = modelId;
        self.brand = brand;
    }
    return self;
}

+ (PPDeviceTypeStoryModel *)initWithDictionary:(NSDictionary *)modelDict {
    NSString *modelId = [modelDict objectForKey:@"id"];
    NSString *brand = [modelDict objectForKey:@"brand"];
    
    PPDeviceTypeStoryModel *model = [[PPDeviceTypeStoryModel alloc] initWithId:modelId brand:brand];
    return model;
}

+ (NSString *)stringify:(PPDeviceTypeStoryModel *)model {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(model.modelId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", model.modelId];
        appendComma = YES;
    }
    
    if(model.brand) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"brand\":\"%@\"", model.brand];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}
@end
