//
//  PPWeatherMetadata.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPWeatherMetadata.h"

@implementation PPWeatherMetadata

- (id)initWithLanguage:(NSString *)language transactionId:(NSString *)transactionId version:(NSString *)version latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude units:(NSString *)units expireTimeGMT:(NSNumber *)expireTimeGMT statusCode:(NSNumber *)statusCode {
    self = [super init];
    if(self) {
        self.language = language;
        self.transactionId = transactionId;
        self.version = version;
        self.latitude = latitude;
        self.longitude = longitude;
        self.units = units;
        self.expireTimeGMT = expireTimeGMT;
        self.statusCode = statusCode;
    }
    return self;
}

+ (PPWeatherMetadata *)initWithDictionary:(NSDictionary *)metadataDict {
    
    NSString *language = [metadataDict objectForKey:@"language"];
    NSString *transactionId = [metadataDict objectForKey:@"transactionId"];
    NSString *version = [metadataDict objectForKey:@"version"];
    NSNumber *latitude = [metadataDict objectForKey:@"latitude"];
    NSNumber *longitude = [metadataDict objectForKey:@"longitude"];
    NSString *units = [metadataDict objectForKey:@"units"];
    NSNumber *expireTimeGMT = [metadataDict objectForKey:@"expireTimeGMT"];
    NSNumber *statusCode = [metadataDict objectForKey:@"statusCode"];
    
    PPWeatherMetadata *weather = [[PPWeatherMetadata alloc] initWithLanguage:language transactionId:transactionId version:version latitude:latitude longitude:longitude units:units expireTimeGMT:expireTimeGMT statusCode:statusCode];
    return weather;
}

@end
