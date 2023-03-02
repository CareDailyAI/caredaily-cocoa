//
//  PPDevice.h
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceType.h"
#import "PPDeviceTypeGoal.h"
#import "PPDeviceParameter.h"
#import "PPDeviceParameters.h"
#import "PPDeviceMeasurements.h"
#import "PPDeviceProperty.h"
#import "PPLocation.h"

@interface PPDevice : PPBaseModel

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
