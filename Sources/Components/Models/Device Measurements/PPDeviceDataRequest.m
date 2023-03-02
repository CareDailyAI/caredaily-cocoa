//
//  PPDeviceDataRequest.m
//  Peoplepower
//
//  Created by Destry Teeter on 5/7/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceDataRequest.h"

static NSString *kType = @"type";
static NSString *kKey = @"key";
static NSString *kDeviceId = @"deviceId";
static NSString *kStartTime = @"startTime";
static NSString *kEndTime = @"endTime";
static NSString *kParamNames = @"paramNames";
static NSString *kIndex = @"index";
static NSString *kOrdered = @"ordered";
static NSString *kCompression = @"compression";

@implementation PPDeviceDataRequest

- (id)initWithType:(PPDeviceDataRequestType)type key:(NSString * _Nullable )key deviceId:(NSString *)deviceId startDate:(NSDate * _Nullable )startDate endDate:(NSDate *)endDate paramNames:(NSArray * _Nullable )paramNames index:(NSNumber * _Nullable )index ordered:(PPDeviceDataRequestOdered)ordered compression:(PPDeviceDataRequestCompression)compression {
    self = [super init];
    if (self) {
        self.type = type;
        self.key = key;
        self.deviceId = deviceId;
        self.startDate = startDate;
        self.endDate = endDate;
        self.paramNames = paramNames;
        self.index = index;
        self.ordered = ordered;
        self.compression = compression;
    }
    return self;
}

+ (NSDictionary *)dictionaryRepresentation:(PPDeviceDataRequest *)parameter {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [dict setValue:@(parameter.type) forKey:kType];
    if (parameter.key != nil) {
        [dict setValue:parameter.key forKey:kKey];
    }
    [dict setValue:parameter.deviceId forKey:kDeviceId];
    if (parameter.startDate) {
        [dict setValue:@(round(parameter.startDate.timeIntervalSince1970 * 1000)) forKey:kStartTime];
    }
    else {
        [dict setValue:@(0) forKey:kStartTime];
    }
    [dict setValue:@(round(parameter.endDate.timeIntervalSince1970 * 1000)) forKey:kEndTime];
    
    if (parameter.paramNames != nil) {
        [dict setValue:parameter.paramNames forKey:kParamNames];
    }
    if (parameter.index != nil) {
        [dict setValue:parameter.index.stringValue forKey:kIndex];
    }
    if (parameter.ordered != PPDeviceDataRequestOderedNone) {
        [dict setValue:@(parameter.ordered) forKey:kOrdered];
    }
    if (parameter.compression != PPDeviceDataRequestCompressionNone) {
        [dict setValue:@(parameter.compression) forKey:kCompression];
    }
    return dict;
}

@end
