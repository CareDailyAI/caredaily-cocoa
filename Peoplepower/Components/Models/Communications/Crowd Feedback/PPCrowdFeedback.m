//
//  PPCrowdFeedback.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCrowdFeedback.h"

@implementation PPCrowdFeedback

+ (NSString *)primaryKey {
    return @"feedbackId";
}

- (id)initWithFeedbackId:(PPCrowdFeedbackId)feedbackId appName:(NSString *)appName appVersion:(NSString *)appVersion type:(PPCrowdFeedbackType)type subject:(NSString *)subject email:(NSString *)email deviceId:(NSString *)deviceId deviceModel:(NSString *)deviceModel deviceOs:(NSString *)deviceOs productId:(PPCrowdFeedbackProductId)productId productCategory:(PPCrowdFeedbackProductCategory)productCategory viewer:(NSString *)viewer desc:(NSString *)desc votingCount:(PPCrowdFeedbackVotingCount)votingCount rank:(PPCrowdFeedbackRank)rank enabled:(PPCrowdFeedbackEnabled)enabled {
    self = [super init];
    if(self) {
        
        self.feedbackId = feedbackId;
        self.appName = appName;
        self.appVersion = appVersion;
        self.type = type;
        self.subject = subject;
        self.email = email;
        self.deviceId = deviceId;
        self.deviceModel = deviceModel;
        self.deviceOs = deviceOs;
        self.productId = productId;
        self.productCategory = productCategory;
        self.viewer = viewer;
        self.desc = desc;
        self.votingCount = votingCount;
        self.rank = rank;
        self.enabled = enabled;
    }
    return self;
}

+ (PPCrowdFeedback *)initWithDictionary:(NSDictionary *)feedbackDict {
    PPCrowdFeedbackId feedbackId = PPCrowdFeedbackIdNone;
    if([feedbackDict objectForKey:@"id"]) {
        feedbackId = (PPCrowdFeedbackId)((NSString *)[feedbackDict objectForKey:@"id"]).integerValue;
    }
    NSString *appName = [feedbackDict objectForKey:@"appName"];
    NSString *appVersion = [feedbackDict objectForKey:@"appVersion"];
    PPCrowdFeedbackType type = PPCrowdFeedbackTypeNone;
    if([feedbackDict objectForKey:@"type"]) {
        type = (PPCrowdFeedbackType)((NSString *)[feedbackDict objectForKey:@"type"]).integerValue;
    }
    NSString *subject = [feedbackDict objectForKey:@"subject"];
    NSString *email = [feedbackDict objectForKey:@"email"];
    NSString *deviceId = [feedbackDict objectForKey:@"deviceId"];
    NSString *deviceModel = [feedbackDict objectForKey:@"deviceModel"];
    NSString *deviceOs = [feedbackDict objectForKey:@"deviceOs"];
    PPCrowdFeedbackProductId productId = PPCrowdFeedbackProductIdNone;
    if([feedbackDict objectForKey:@"productId"]) {
        productId = (PPCrowdFeedbackProductId)((NSString *)[feedbackDict objectForKey:@"productId"]).integerValue;
    }
    PPCrowdFeedbackProductCategory productCategory = PPCrowdFeedbackProductCategoryNone;
    if([feedbackDict objectForKey:@"productCategory"]) {
        productCategory = (PPCrowdFeedbackProductCategory)((NSString *)[feedbackDict objectForKey:@"productCategory"]).integerValue;
    }
    NSString *viewer = [feedbackDict objectForKey:@"viewer"];
    NSString *desc = [feedbackDict objectForKey:@"description"];
    PPCrowdFeedbackVotingCount votingCount = PPCrowdFeedbackVotingCountNone;
    if([feedbackDict objectForKey:@"votingCount"]) {
        votingCount = (PPCrowdFeedbackVotingCount)((NSString *)[feedbackDict objectForKey:@"votingCount"]).integerValue;
    }
    PPCrowdFeedbackRank rank = PPCrowdFeedbackRankNone;
    if([feedbackDict objectForKey:@"rank"]) {
        rank = (PPCrowdFeedbackRank)((NSString *)[feedbackDict objectForKey:@"rank"]).integerValue;
    }
    PPCrowdFeedbackEnabled enabled = PPCrowdFeedbackEnabledNone;
    if([feedbackDict objectForKey:@"enabled"]) {
        enabled = (PPCrowdFeedbackEnabled)((NSString *)[feedbackDict objectForKey:@"enabled"]).integerValue;
    }

    PPCrowdFeedback *feedback = [[PPCrowdFeedback alloc] initWithFeedbackId:feedbackId appName:appName appVersion:appVersion type:type subject:subject email:email deviceId:deviceId deviceModel:deviceModel deviceOs:deviceOs productId:productId productCategory:productCategory viewer:viewer desc:desc votingCount:votingCount rank:rank enabled:enabled];
    return feedback;
}


+ (NSString *)stringify:(PPCrowdFeedback *)feedback {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@""];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(feedback.feedbackId != PPCrowdFeedbackIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%li\"", (long)feedback.feedbackId];
        appendComma = YES;
    }
    
    if(feedback.appName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"appName\":\"%@\"", feedback.appName];
        appendComma = YES;
    }
    
    if(feedback.appVersion) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"appVersion\":\"%@\"", feedback.appVersion];
        appendComma = YES;
    }
    
    if(feedback.type != PPCrowdFeedbackTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":\"%li\"", (long)feedback.type];
        appendComma = YES;
    }
    
    if(feedback.subject) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subject\":\"%@\"", feedback.subject];
        appendComma = YES;
    }
    
    if(feedback.email) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"email\":\"%@\"", feedback.email];
        appendComma = YES;
    }
    
    if(feedback.deviceId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"deviceId\":\"%@\"", feedback.deviceId];
        appendComma = YES;
    }
    
    if(feedback.deviceModel) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"deviceModel\":\"%@\"", feedback.deviceModel];
        appendComma = YES;
    }
    
    if(feedback.deviceOs) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"deviceOs\":\"%@\"", feedback.deviceOs];
        appendComma = YES;
    }
    
    if(feedback.productId != PPCrowdFeedbackProductIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"productId\":\"%li\"", (long)feedback.productId];
        appendComma = YES;
    }
    
    if(feedback.productCategory != PPCrowdFeedbackProductCategoryNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"productCategory\":\"%li\"", (long)feedback.productCategory];
        appendComma = YES;
    }
    
    if(feedback.viewer) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"viewer\":\"%@\"", feedback.viewer];
        appendComma = YES;
    }
    
    if(feedback.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"description\":\"%@\"", feedback.desc];
        appendComma = YES;
    }
    
    if(feedback.enabled != PPCrowdFeedbackEnabledNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"enabled\":\"%li\"", (long)feedback.enabled];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPCrowdFeedback *)feedback {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(feedback.feedbackId != PPCrowdFeedbackIdNone) {
        data[@"id"] = @(feedback.feedbackId);
    }
    if(feedback.appName) {
        data[@"appName"] = feedback.appName;
    }
    if(feedback.appVersion) {
        data[@"appVersion"] = feedback.appVersion;
    }
    if(feedback.type != PPCrowdFeedbackTypeNone) {
        data[@"type"] = @(feedback.type);
    }
    if(feedback.subject) {
        data[@"subject"] = feedback.subject;
    }
    if(feedback.email) {
        data[@"email"] = feedback.email;
    }
    if(feedback.deviceId) {
        data[@"deviceId"] = feedback.deviceId;
    }
    if(feedback.deviceModel) {
        data[@"deviceModel"] = feedback.deviceModel;
    }
    if(feedback.deviceOs) {
        data[@"deviceOs"] = feedback.deviceOs;
    }
    if(feedback.productId != PPCrowdFeedbackProductIdNone) {
        data[@"productId"] = @(feedback.productId);
    }
    if(feedback.productCategory != PPCrowdFeedbackProductCategoryNone) {
        data[@"productCategory"] = @(feedback.productCategory);
    }
    if(feedback.viewer) {
        data[@"viewer"] = feedback.viewer;
    }
    if(feedback.desc) {
        data[@"description"] = feedback.desc;
    }
    if(feedback.enabled != PPCrowdFeedbackEnabledNone) {
        data[@"enabled"] = @(feedback.enabled);
    }
    return data;
}

#pragma mark - Helper methods

- (BOOL)isEqualToFeedback:(PPCrowdFeedback *)feedback {
    BOOL equal = NO;
    if(feedback.feedbackId != PPCrowdFeedbackIdNone) {
        equal = YES;
    }
    return equal;
}

- (void)sync:(PPCrowdFeedback *)feedback {
    if(feedback.feedbackId != PPCrowdFeedbackIdNone) {
        _feedbackId = feedback.feedbackId;
    }
    if(feedback.appName) {
        _appName = feedback.appName;
    }
    if(feedback.appVersion) {
        _appVersion = feedback.appVersion;
    }
    if(feedback.type != PPCrowdFeedbackTypeNone) {
        _type = feedback.type;
    }
    if(feedback.subject) {
        _subject = feedback.subject;
    }
    if(feedback.email) {
        _email = feedback.email;
    }
    if(feedback.deviceId) {
        _deviceId = feedback.deviceId;
    }
    if(feedback.deviceModel) {
        _deviceModel = feedback.deviceModel;
    }
    if(feedback.deviceOs) {
        _deviceOs = feedback.deviceOs;
    }
    if(feedback.productId != PPCrowdFeedbackProductIdNone) {
        _productId = feedback.productId;
    }
    if(feedback.productCategory != PPCrowdFeedbackProductCategoryNone) {
        _productCategory = feedback.productCategory;
    }
    if(feedback.viewer) {
        _viewer = feedback.viewer;
    }
    if(feedback.desc) {
        _desc = feedback.desc;
    }
    if(feedback.votingCount != PPCrowdFeedbackVotingCountNone) {
        _votingCount = feedback.votingCount;
    }
    if(feedback.rank != PPCrowdFeedbackRankNone) {
        _rank = feedback.rank;
    }
    if(feedback.enabled != PPCrowdFeedbackEnabledNone) {
        _enabled = feedback.enabled;
    }
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        _feedbackId = (PPCrowdFeedbackId)((NSNumber *)[decoder decodeObjectForKey:@"id"]).integerValue;
        _appName = [decoder decodeObjectForKey:@"appName"];
        _appVersion = [decoder decodeObjectForKey:@"appVersion"];
        _type = (PPCrowdFeedbackType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
        _subject = [decoder decodeObjectForKey:@"subject"];
        _email = [decoder decodeObjectForKey:@"email"];
        _deviceId = [decoder decodeObjectForKey:@"deviceId"];
        _deviceModel = [decoder decodeObjectForKey:@"deviceModel"];
        _deviceOs = [decoder decodeObjectForKey:@"deviceOs"];
        _productId = (PPCrowdFeedbackProductId)((NSNumber *)[decoder decodeObjectForKey:@"productId"]).integerValue;
        _productCategory = (PPCrowdFeedbackProductCategory)((NSNumber *)[decoder decodeObjectForKey:@"productCategory"]).integerValue;
        _viewer = [decoder decodeObjectForKey:@"viewer"];
        _desc = [decoder decodeObjectForKey:@"description"];
        _votingCount = (PPCrowdFeedbackVotingCount)((NSNumber *)[decoder decodeObjectForKey:@"votingCount"]).integerValue;
        _rank = (PPCrowdFeedbackRank)((NSNumber *)[decoder decodeObjectForKey:@"rank"]).integerValue;
        _enabled = (PPCrowdFeedbackEnabled)((NSNumber *)[decoder decodeObjectForKey:@"enabled"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_feedbackId) forKey:@"feedbackId"];
    [encoder encodeObject:_appName forKey:@"appName"];
    [encoder encodeObject:_appVersion forKey:@"appVersion"];
    [encoder encodeObject:@(_type) forKey:@"type"];
    [encoder encodeObject:_subject forKey:@"subject"];
    [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:_deviceId forKey:@"deviceId"];
    [encoder encodeObject:_deviceModel forKey:@"deviceModel"];
    [encoder encodeObject:_deviceOs forKey:@"deviceOs"];
    [encoder encodeObject:@(_productId) forKey:@"productId"];
    [encoder encodeObject:@(_productCategory) forKey:@"productCategory"];
    [encoder encodeObject:_viewer forKey:@"viewer"];
    [encoder encodeObject:_desc forKey:@"desc"];
    [encoder encodeObject:@(_votingCount) forKey:@"votingCount"];
    [encoder encodeObject:@(_rank) forKey:@"rank"];
    [encoder encodeObject:@(_enabled) forKey:@"enabled"];
}

@end
