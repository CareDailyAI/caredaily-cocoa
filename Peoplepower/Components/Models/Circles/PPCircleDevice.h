//
//  PPCircleDevice.h
//  PPiOSCore-Framework
//
//  Created by Destry Teeter on 7/24/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCircleMember.h"

@interface PPCircleDevice : PPDevice

@property (nonatomic) PPCircleId circleId;
@property (nonatomic) PPCircleMember *user;

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId;

+ (PPCircleDevice *)initWithDictionary:(NSDictionary *)deviceDict;

@end

RLM_ARRAY_TYPE(PPCircleDevice)
