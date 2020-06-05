//
//  PPDeviceDataRequest.h
//  PPiOSCore
//
//  Created by Destry Teeter on 5/7/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestType) {
    PPDeviceDataRequestTypeParameters = 1, // Device Parameters
    PPDeviceDataRequestTypeActivities = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestOdered) {
    PPDeviceDataRequestOderedNone = -2,
    PPDeviceDataRequestOderedDesc = -1,
    PPDeviceDataRequestOderedAsc  = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestCompression) {
    PPDeviceDataRequestCompressionNone          = -1,
    PPDeviceDataRequestCompressionLZ4           = 0, // Default
    PPDeviceDataRequestCompressionZIP           = 1,
    PPDeviceDataRequestCompressionNoCompression = 2
};

@interface PPDeviceDataRequest : PPBaseModel

@property (nonatomic) PPDeviceDataRequestType type;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSArray *paramNames;
@property (nonatomic, strong) NSNumber *index;
@property (nonatomic) PPDeviceDataRequestOdered ordered;
@property (nonatomic) PPDeviceDataRequestCompression compression;

- (id)initWithType:(PPDeviceDataRequestType)type key:(NSString * _Nullable )key deviceId:(NSString *)deviceId startDate:(NSDate * _Nullable )startDate endDate:(NSDate *)endDate paramNames:(NSArray * _Nullable )paramNames index:(NSNumber * _Nullable )index ordered:(PPDeviceDataRequestOdered)ordered compression:(PPDeviceDataRequestCompression)compression;

+ (NSDictionary *)dictionaryRepresentation:(PPDeviceDataRequest *)parameter;

@end

NS_ASSUME_NONNULL_END
