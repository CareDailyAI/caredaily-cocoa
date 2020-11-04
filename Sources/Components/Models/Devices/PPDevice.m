//
//  PPDevice.m
//  Peoplepower
//
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"

NSString *DEVICE_NAME = @"name";
NSString *DEVICE_CONNECTED = @"connected";
NSString *DEVICE_RESTRICTED = @"restricted";
NSString *DEVICE_SHARED = @"shared";
NSString *DEVICE_NEW_DEVICE = @"newDevice";
NSString *DEVICE_GOAL_ID = @"goalId";
NSString *DEVICE_LAST_DATA_RECEIVED_DATE = @"lastDataReceivedDate";
NSString *DEVICE_LAST_MEASURE_DATE = @"lastMeasureDate";
NSString *DEVICE_LAST_CONNECTED_DATE = @"lastConnectedDate";
NSString *DEVICE_ICON = @"icon";
NSString *DEVICE_LOCATION_ID = @"locationId";

@implementation PPDevice

+ (NSString *)primaryKey {
    return @"deviceId";
}

- (PPLocation *)location {
    return [PPLocation objectForPrimaryKey:@(_locationId)];
}
/*
@synthesize deviceId;
@synthesize proxyId;
@synthesize typeId;
@synthesize locationId;
@synthesize category;
@synthesize typeAttributes;
@synthesize parameters;
@synthesize properties;
@synthesize name;
@synthesize connected;
@synthesize restricted;
@synthesize shared;
@synthesize newDevice;
@synthesize goalId;
@synthesize lastDataReceivedDate;
@synthesize lastMeasureDate;
@synthesize lastConnectedDate;
@synthesize icon;
*/
- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(RLMArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId {
    self = [super init];
    if(self) {
        self.deviceId = deviceId;
        self.proxyId = proxyId;
        self.typeId = typeId;
        self.category = category;
        self.typeAttributes = (RLMArray<PPDeviceTypeAttribute *><PPDeviceTypeAttribute> *)typeAttributes;
        self.parameters = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)parameters;
        self.properties = (RLMArray<PPDeviceProperty *><PPDeviceProperty> *)properties;
        
        self.name = name;
        self.connected = connected;
        self.restricted = restricted;
        self.shared = shared;
        self.newDevice = newDevice;
        self.goalId = goalId;
        self.startDate = startDate;
        self.lastDataReceivedDate = lastDataReceivedDate;
        self.lastMeasureDate = lastMeasureDate;
        self.lastConnectedDate = lastConnectedDate;
        self.icon = icon;
        self.locationId = locationId;
        self.spaces = (RLMArray<PPLocationSpace *><PPLocationSpace> *)spaces;
        self.modelId = modelId;
    }
    return self;
}

+ (PPDevice *)initWithDictionary:(NSDictionary *)deviceDict {
    NSString *deviceId = [deviceDict objectForKey:@"id"];
    
    NSString *proxyId = [deviceDict objectForKey:@"proxyId"];;
    NSString *name = [deviceDict objectForKey:@"desc"];
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunguarded-availability"
// Fix an issue where space characters are being represented as a special character
    name = [name stringByReplacingOccurrencesOfString:[@"%C2%A0" stringByRemovingPercentEncoding] withString:@" "];
#pragma GCC diagnostic pop
    PPDeviceConnected connected = PPDeviceConnectedNone;
    if([deviceDict objectForKey:@"connected"]) {
        connected = (PPDeviceConnected)((NSString *)[deviceDict objectForKey:@"connected"]).boolValue;
    }
    PPDeviceNewDevice newDevice = PPDeviceNewDeviceNone;
    if([deviceDict objectForKey:@"newDevice"]) {
        newDevice = (PPDeviceNewDevice)((NSString *)[deviceDict objectForKey:@"newDevice"]).boolValue;
    }
    PPDeviceRestricted restricted = PPDeviceRestrictedNone;
    if([deviceDict objectForKey:@"restricted"]) {
        restricted = (PPDeviceRestricted)((NSString *)[deviceDict objectForKey:@"restricted"]).boolValue;
    }
    PPDeviceShared shared = PPDeviceSharedNone;
    if([deviceDict objectForKey:@"shared"]) {
        shared = (PPDeviceShared)((NSString *)[deviceDict objectForKey:@"shared"]).boolValue;
    }
    PPDeviceTypeGoalId goalId = PPDeviceTypeGoalIdNone;
    if([deviceDict objectForKey:@"goalId"]) {
        goalId = (PPDeviceTypeGoalId)((NSString *)[deviceDict objectForKey:@"goalId"]).integerValue;
    }
    PPLocationId locationId = PPLocationIdNone;
    if([deviceDict objectForKey:@"locationId"]) {
        locationId = (PPLocationId)((NSString *)[deviceDict objectForKey:@"locationId"]).integerValue;
    }
    NSString *icon = [deviceDict objectForKey:@"icon"];
    
    NSString *startDateString = [deviceDict objectForKey:@"startDate"];
    NSDate *startDate;
    
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSString *lastDataReceivedDateString = [deviceDict objectForKey:@"lastDataReceivedDate"];
    NSDate *lastDataReceivedDate;
    
    if(lastDataReceivedDateString != nil) {
        if(![lastDataReceivedDateString isEqualToString:@""]) {
            lastDataReceivedDate = [PPNSDate parseDateTime:lastDataReceivedDateString];
        }
    }
    
    NSString *lastMeasureDateString = [deviceDict objectForKey:@"lastMeasureDate"];
    NSDate *lastMeasureDate;
    
    if(lastMeasureDateString != nil) {
        if(![lastMeasureDateString isEqualToString:@""]) {
            lastMeasureDate = [PPNSDate parseDateTime:lastMeasureDateString];
        }
    }
    
    NSString *lastConnectedDateString = [deviceDict objectForKey:@"lastConnectedDate"];
    NSDate *lastConnectedDate;
    
    if(lastConnectedDateString != nil) {
        if(![lastConnectedDateString isEqualToString:@""]) {
            lastConnectedDate = [PPNSDate parseDateTime:lastConnectedDateString];
        }
    }
    
    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
    if([deviceDict objectForKey:@"type"]) {
        typeId = (PPDeviceTypeId)((NSString *)[deviceDict objectForKey:@"type"]).integerValue;
    }
    
    
    PPDeviceTypeCategory category = PPDeviceTypeCategoryNone;
    if([deviceDict objectForKey:@"typeCategory"]) {
        category = (PPDeviceTypeCategory)((NSString *)[deviceDict objectForKey:@"typeCategory"]).integerValue;
    }
    
    NSMutableArray *typeAttributes;
    if([deviceDict objectForKey:@"typeAttributes"]) {
        typeAttributes = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *typeAttributeDict in [deviceDict objectForKey:@"typeAttributes"]) {
            PPDeviceTypeAttribute *attribute = [PPDeviceTypeAttribute initWithDictionary:typeAttributeDict];
            [typeAttributes addObject:attribute];
        }
    }
    
    NSMutableArray *parameters;
    if([deviceDict objectForKey:@"parameters"]) {
        parameters = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *parameterDict in [deviceDict objectForKey:@"parameters"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:parameterDict];
            [parameters addObject:parameter];
        }
    }
    
    NSMutableArray *properties;
    if([deviceDict objectForKey:@"properties"]) {
        properties = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *propertyDict in [deviceDict objectForKey:@"properties"]) {
            PPDeviceProperty *property = [PPDeviceProperty initWithDictionary:propertyDict];
            [properties addObject:property];
        }
    }
    
    NSMutableArray *spaces;
    if([deviceDict objectForKey:@"spaces"]) {
        spaces = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *spaceDict in [deviceDict objectForKey:@"spaces"]) {
            PPLocationSpace *space = [PPLocationSpace initWithDictionary:spaceDict];
            [spaces addObject:space];
        }
    }
    
    NSString *modelId = [deviceDict objectForKey:@"modelId"];
    
    PPDevice *device = [[PPDevice alloc] initWithDeviceId:deviceId proxyId:proxyId name:name connected:connected restricted:restricted shared:shared newDevice:newDevice goalId:goalId typeId:typeId category:category typeAttributes:(RLMArray *)typeAttributes locationId:locationId startDate:startDate lastDataReceivedDate:lastDataReceivedDate lastMeasureDate:lastMeasureDate lastConnectedDate:lastConnectedDate parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:icon spaces:(RLMArray *)spaces modelId:modelId];
    return device;
}

#pragma mark - Parameters

- (PPDeviceParameter *)parameterWithName:(NSString *)paramName index:(NSString *)paramIndex {
    for(PPDeviceParameter *param in self.parameters) {
        if([param.name isEqualToString:paramName]) {
            if(paramIndex) {
                if([param.index isEqualToString:paramIndex]) {
                    return param;
                }
            }
            else {
                return param;
            }
        }
    }
    return nil;
}

- (void)setParameter:(NSString *)paramName value:(NSString *)paramValue index:(NSString *)paramIndex lastUpdateDate:(NSDate *)paramLastUpdateDate {
    if(!self.parameters) {
        self.parameters = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)[[NSMutableArray alloc] initWithCapacity:0];
    }
#warning After removing logging this broke.  Need to check that paramaters are still being propagated to realm
    [self.realm transactionWithBlock:^{
        PPDeviceParameter *param = [self parameterWithName:paramName index:paramIndex];
        PPDeviceParameter *newParam = [[PPDeviceParameter alloc] initWithName:paramName index:paramIndex value:paramValue lastUpdateDate:paramLastUpdateDate];
        if(param) {
            [self.parameters replaceObjectAtIndex:[self.parameters indexOfObject:param] withObject:newParam];
        }
        else {
            [self.parameters addObject:newParam];
        }
    }];
}

//#pragma mark - Private
//
//- (void)setName:(NSString *)name_ {
//    [self willChangeValueForKey:DEVICE_NAME];
//    name = name_;
//    [self didChangeValueForKey:DEVICE_NAME];
//}
//
//- (void)setConnected:(PPDeviceConnected)connected_ {
//    [self willChangeValueForKey:DEVICE_CONNECTED];
//    connected = connected_;
//    [self didChangeValueForKey:DEVICE_CONNECTED];
//}
//
//- (void)setRestricted:(PPDeviceRestricted)restricted_ {
//    [self willChangeValueForKey:DEVICE_RESTRICTED];
//    restricted = restricted_;
//    [self didChangeValueForKey:DEVICE_RESTRICTED];
//}
//
//- (void)setShared:(PPDeviceShared)shared_ {
//    [self willChangeValueForKey:DEVICE_SHARED];
//    shared = shared_;
//    [self didChangeValueForKey:DEVICE_SHARED];
//}
//
//- (void)setNewDevice:(PPDeviceNewDevice)newDevice_ {
//    [self willChangeValueForKey:DEVICE_NEW_DEVICE];
//    newDevice = newDevice_;
//    [self didChangeValueForKey:DEVICE_NEW_DEVICE];
//}
//
//- (void)setGoalId:(PPDeviceTypeGoalId)goalId_ {
//    [self willChangeValueForKey:DEVICE_GOAL_ID];
//    goalId = goalId_;
//    [self didChangeValueForKey:DEVICE_GOAL_ID];
//}
//
//- (void)setLastDataReceivedDate:(NSDate *)lastDataReceivedDate_ {
//    [self willChangeValueForKey:DEVICE_LAST_DATA_RECEIVED_DATE];
//    lastDataReceivedDate = lastDataReceivedDate_;
//    [self didChangeValueForKey:DEVICE_LAST_DATA_RECEIVED_DATE];
//}
//
//- (void)setLastMeasureDate:(NSDate *)lastMeasureDate_ {
//    [self willChangeValueForKey:DEVICE_LAST_MEASURE_DATE];
//    lastMeasureDate = lastMeasureDate_;
//    [self didChangeValueForKey:DEVICE_LAST_MEASURE_DATE];
//}
//
//- (void)setLastConnectedDate:(NSDate *)lastConnectedDate_ {
//    [self willChangeValueForKey:DEVICE_LAST_CONNECTED_DATE];
//    lastConnectedDate = lastConnectedDate_;
//    [self didChangeValueForKey:DEVICE_LAST_CONNECTED_DATE];
//}
//
//- (void)setIcon:(NSString *)icon_ {
//    [self willChangeValueForKey:DEVICE_ICON];
//    icon = icon_;
//    [self didChangeValueForKey:DEVICE_ICON];
//}
//
//- (void)setLocationId:(PPLocationId)locationId_ {
//    [self willChangeValueForKey:DEVICE_LOCATION_ID];
//    locationId = locationId_;
//    [self didChangeValueForKey:DEVICE_LOCATION_ID];
//}

#pragma mark - Helper methods

- (BOOL)isEqualToDevice:(PPDevice *)device {
    BOOL equal = NO;
    
    if(self.deviceId && device.deviceId) {
        if([self.deviceId isEqualToString:device.deviceId]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDevice *)device {
    if(device.proxyId) {
        self.proxyId = device.proxyId;
    }
    if(device.typeAttributes) {
        for(PPDeviceTypeAttribute *newAttribute in device.typeAttributes) {
            BOOL found = NO;
            for(PPDeviceTypeAttribute *attribute in self.typeAttributes) {
                if([attribute.name isEqualToString:newAttribute.name]) {
                    found = YES;
                    [attribute sync:newAttribute];
                }
            }
            if(!found) {
                [self.typeAttributes addObject:newAttribute];
            }
        }
    }
    if(device.parameters) {
        for(PPDeviceParameter *newParameter in device.parameters) {
            BOOL found = NO;
            for(PPDeviceParameter *parameter in self.parameters) {
                if([parameter.name isEqualToString:newParameter.name]) {
                    found = YES;
                    [parameter sync:newParameter];
                }
            }
            if(!found) {
                [self.parameters addObject:newParameter];
            }
        }
    }
    if(device.properties) {
        for(PPDeviceProperty *newProperty in device.properties) {
            BOOL found = NO;
            for(PPDeviceProperty *property in self.properties) {
                if([property.name isEqualToString:newProperty.name]) {
                    found = YES;
                    [property sync:newProperty];
                }
            }
            if(!found) {
                [self.properties addObject:newProperty];
            }
        }
    }
    if(device.name) {
        self.name = device.name;
    }
    if(device.connected != PPDeviceConnectedNone) {
        self.connected = device.connected;
    }
    if(device.restricted != PPDeviceRestrictedNone) {
        self.restricted = device.restricted;
    }
    if(device.shared != PPDeviceSharedNone) {
        self.shared = device.shared;
    }
    if(device.newDevice != PPDeviceNewDeviceNone) {
        self.newDevice = device.newDevice;
    }
    if(device.goalId != PPDeviceTypeGoalIdNone) {
        self.goalId = device.goalId;
    }
    if(device.lastDataReceivedDate) {
        self.lastDataReceivedDate = device.lastDataReceivedDate;
    }
    if(device.lastMeasureDate) {
        self.lastMeasureDate = device.lastMeasureDate;
    }
    if(device.lastConnectedDate) {
        self.lastConnectedDate = device.lastConnectedDate;
    }
    if(device.icon) {
        self.icon = device.icon;
    }
    if(device.locationId != PPLocationIdNone) {
        self.locationId = device.locationId;
    }
    if(device.modelId) {
        self.modelId = device.modelId;
    }
}

@end
