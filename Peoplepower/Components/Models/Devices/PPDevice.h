//
//  PPDevice.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceType.h"
#import "PPDeviceTypeGoal.h"
#import "PPDeviceParameter.h"
#import "PPDeviceParameters.h"
#import "PPDeviceMeasurements.h"
#import "PPDeviceProperty.h"
#import "PPLocation.h"
#import "PPUser.h"

extern NSString *DEVICE_NAME;
extern NSString *DEVICE_CONNECTED;
extern NSString *DEVICE_RESTRICTED;
extern NSString *DEVICE_SHARED;
extern NSString *DEVICE_NEW_DEVICE;
extern NSString *DEVICE_GOAL_ID;
extern NSString *DEVICE_LAST_DATA_RECEIVED_DATE;
extern NSString *DEVICE_LAST_MEASURE_DATE;
extern NSString *DEVICE_LAST_CONNECTED_DATE;
extern NSString *DEVICE_ICON;
extern NSString *DEVICE_LOCATION_ID;

typedef NS_OPTIONS(NSInteger, PPHistoricalMeasurementsAggregation) {
    PPHistoricalMeasurementsAggregationDefault = 0,
    PPHistoricalMeasurementsAggregationMinimum = 1,
    PPHistoricalMeasurementsAggregationMaximum = 2,
    PPHistoricalMeasurementsAggregationMedian = 3,
    PPHistoricalMeasurementsAggregationTimeDistributedAverage = 4,
    PPHistoricalMeasurementsAggregationAverage = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceConnected) {
    PPDeviceConnectedNone = -1,
    PPDeviceConnectedFalse = 0,
    PPDeviceConnectedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceNewDevice) {
    PPDeviceNewDeviceNone = -1,
    PPDeviceNewDeviceFalse = 0,
    PPDeviceNewDeviceTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceRestricted) {
    PPDeviceRestrictedNone = -1,
    PPDeviceRestrictedFalse = 0,
    PPDeviceRestrictedTrue = 1
};

@interface PPDevice : NSObject

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *proxyId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPDeviceConnected connected;
@property (nonatomic) PPDeviceRestricted restricted;
@property (nonatomic) PPDeviceShared shared;
@property (nonatomic) PPDeviceNewDevice newDevice;
@property (nonatomic) PPDeviceTypeGoalId goalId;
@property (nonatomic) PPDeviceTypeId typeId;
@property (nonatomic) PPDeviceTypeCategory category;
@property (nonatomic, strong) NSMutableArray *typeAttributes;
@property (nonatomic) PPLocationId locationId;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *lastDataReceivedDate;
@property (nonatomic, strong) NSDate *lastMeasureDate;
@property (nonatomic, strong) NSDate *lastConnectedDate;
@property (nonatomic, strong) NSMutableArray *parameters;
@property (nonatomic, strong) NSMutableArray *properties;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSMutableArray *spaces;
@property (nonatomic, strong) NSString *modelId;

@property (nonatomic) PPLocation *location;

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId;

+ (PPDevice *)initWithDictionary:(NSDictionary *)deviceDict;

- (PPDeviceParameter *)parameterWithName:(NSString *)paramName index:(NSString *)paramIndex;

- (void)setParameter:(NSString *)paramName value:(NSString *)paramValue index:(NSString *)paramIndex lastUpdateDate:(NSDate *)paramLastUpdateDate;

#pragma mark - Helper methods

- (BOOL)isEqualToDevice:(PPDevice *)device;

- (void)sync:(PPDevice *)device;

@end
