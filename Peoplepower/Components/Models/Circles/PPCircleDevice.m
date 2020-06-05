//
//  PPCircleDevice.m
//  PPiOSCore-Framework
//
//  Created by Destry Teeter on 7/24/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCircleDevice.h"

@implementation PPCircleDevice

- (id)initWithCircleId:(PPCircleId)circleId user:(PPCircleMember *)user location:(PPLocation *)location deviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId {
    self = [super initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:typeAttributes locationId:location.locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId];
    if(self) {
        self.circleId = circleId;
        self.user = user;
        self.location = location;
    }
    return self;
}

+ (PPCircleDevice *)initWithDictionary:(NSDictionary *)deviceDict {
    PPDevice *device = [super initWithDictionary:deviceDict];
    
    PPCircleMember *user;
    if([deviceDict objectForKey:@"user"]) {
        user = [PPCircleMember initWithDictionary:[deviceDict objectForKey:@"user"]];
    }
    
    PPLocation *location;
    if([deviceDict objectForKey:@"location"]) {
        location = [PPLocation initWithDictionary:[deviceDict objectForKey:@"location"]];
    }
    return [[PPCircleDevice alloc] initWithCircleId:PPCircleIdNone user:user location:location deviceId:device.deviceId proxyId:device.proxyId name:device.name connected:device.connected restricted:device.restricted shared:device.shared newDevice:device.newDevice goalId:device.goalId typeId:device.typeId category:device.category typeAttributes:device.typeAttributes startDate:device.startDate lastDataReceivedDate:device.lastDataReceivedDate lastMeasureDate:device.lastMeasureDate lastConnectedDate:device.lastConnectedDate parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId];
}

@end
