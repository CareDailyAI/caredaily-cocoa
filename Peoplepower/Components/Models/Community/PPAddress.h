//
//  PPAddress.h
//  PPiOSCore
//
//  Created by Destry Teeter on 1/21/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPAddress : NSObject

@property (nonatomic, strong) NSString * _Nullable street1;
@property (nonatomic, strong) NSString * _Nullable street2;
@property (nonatomic, strong) NSString * _Nullable city;
@property (nonatomic, strong) PPState * _Nullable state;
@property (nonatomic, strong) PPCountry * _Nullable country;
@property (nonatomic, strong) NSString * _Nullable zip;

- (id)initWithStreet1:(NSString *)street1
              street2:(NSString *)street2
                 city:(NSString *)city
                state:(PPState *)state
              country:(PPCountry *)country
                  zip:(NSString *)zip;

+ (PPAddress *)initWithDictionary:(NSDictionary *)addressDict;

+ (NSDictionary *)dataFromAddress:(PPAddress *)address;

@end

NS_ASSUME_NONNULL_END
