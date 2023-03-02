//
//  PPWeatherMetadata.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPWeatherMetadata : PPBaseModel

@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *units;
@property (nonatomic, strong) NSNumber *expireTimeGMT;
@property (nonatomic, strong) NSNumber *statusCode;

- (id)initWithLanguage:(NSString *)language transactionId:(NSString *)transactionId version:(NSString *)version latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude units:(NSString *)units expireTimeGMT:(NSNumber *)expireTimeGMT statusCode:(NSNumber *)statusCode;

+ (PPWeatherMetadata *)initWithDictionary:(NSDictionary *)metadataDict;

@end
