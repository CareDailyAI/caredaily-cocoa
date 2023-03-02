//
//  PPTimezone.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPTimezone : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString * _Nonnull timezoneId;
@property (nonatomic) PPTimezoneOffset offset;
@property (nonatomic) PPDaylightSavingsTime dst;
@property (nonatomic, strong) NSString * _Nullable name;

- (id _Nullable )initWithTimezoneId:(NSString * _Nonnull )timezoneId offset:(PPTimezoneOffset)offset dst:(PPDaylightSavingsTime)dst name:(NSString * _Nullable )name;

+ (PPTimezone * _Nullable )initWithDictionary:(NSDictionary * _Nullable )timezoneDict;

#pragma mark - Helper Methods

- (BOOL)isEqualToTimezone:(PPTimezone * _Nullable )timezone;

- (void)sync:(PPTimezone * _Nullable )timezone;

@end
