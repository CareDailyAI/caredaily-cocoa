//
//  PPDeviceDataRequest.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/7/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPDeviceDataRequest : PPBaseModel

@property (nonatomic) PPDeviceDataRequestType type;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSArray *paramNames;
@property (nonatomic, strong) NSNumber<RLMInt> *index;
@property (nonatomic) PPDeviceDataRequestOdered ordered;
@property (nonatomic) PPDeviceDataRequestCompression compression;

- (id)initWithType:(PPDeviceDataRequestType)type key:(NSString * _Nullable )key deviceId:(NSString *)deviceId startDate:(NSDate * _Nullable )startDate endDate:(NSDate *)endDate paramNames:(NSArray * _Nullable )paramNames index:(NSNumber * _Nullable )index ordered:(PPDeviceDataRequestOdered)ordered compression:(PPDeviceDataRequestCompression)compression;

+ (NSDictionary *)dictionaryRepresentation:(PPDeviceDataRequest *)parameter;

@end

NS_ASSUME_NONNULL_END
