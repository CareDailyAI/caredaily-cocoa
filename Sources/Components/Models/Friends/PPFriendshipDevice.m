//
//  PPFriendshipDevice.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPFriendshipDevice.h"

@implementation PPFriendshipDevice

+ (NSString *)primaryKey {
    return @"friendshipDeviceId";
}

+ (NSArray<NSString *> *)ignoredProperties {
    return @[
             @"friendshipId"
             ];
}

- (NSString *)friendshipDeviceId {
    return [NSString stringWithFormat:@"%li-%@", (long)_friendshipId, self.deviceId];
}

- (id)initWithDeviceId:(NSString *)deviceId name:(NSString *)name typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category events:(RLMArray *)events currentEvent:(NSString *)currentEvent shared:(PPDeviceShared)shared shareDate:(NSDate *)shareDate mute:(PPFriendshipDeviceMute)mute connected:(PPDeviceConnected)connected typeAttributes:(RLMArray *)typeAttributes parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId userId:(PPUserId)userId {
    self = [super initWithDeviceId:deviceId proxyId:nil name:name connected:PPDeviceConnectedNone restricted:PPDeviceRestrictedNone shared:shared newDevice:PPDeviceNewDeviceNone goalId:PPDeviceTypeGoalIdNone typeId:typeId category:category typeAttributes:typeAttributes locationId:PPLocationIdNone startDate:nil lastDataReceivedDate:nil lastMeasureDate:nil lastConnectedDate:nil parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:userId];
    if(self) {
        self.events = (RLMArray<RLMString> *)events;
        self.currentEvent = currentEvent;
        self.mute = mute;
        self.shareDate = shareDate;
    }
    return self;
}
- (id)initWithDeviceId:(NSString *)deviceId name:(NSString *)name typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category events:(RLMArray *)events currentEvent:(NSString *)currentEvent shared:(PPDeviceShared)shared shareDate:(NSDate *)shareDate mute:(PPFriendshipDeviceMute)mute connected:(PPDeviceConnected)connected typeAttributes:(RLMArray *)typeAttributes parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use -initWithDeviceId:name:typeId:category:events:currentEvent:shared:shareDate:mute:connected:typeAttributes:parameters:properties:icon:spaces:modelId:userId: {", __FUNCTION__);
    return [self initWithDeviceId:deviceId name:name typeId:typeId category:category events:events currentEvent:currentEvent shared:shared shareDate:shareDate mute:mute connected:connected typeAttributes:typeAttributes parameters:parameters properties:properties icon:icon spaces:spaces modelId:modelId userId:PPUserIdNone];
}

+ (PPFriendshipDevice *)initWithDevice:(PPDevice *)device events:(RLMArray *)events currentEvent:(NSString *)currentEvent mute:(PPFriendshipDeviceMute)mute shareDate:(NSDate *)shareDate {
    PPFriendshipDevice *friendshipDevice = [[PPFriendshipDevice alloc] initWithDeviceId:device.deviceId name:device.name typeId:device.typeId category:device.category events:events currentEvent:currentEvent shared:device.shared shareDate:shareDate mute:mute connected:device.connected typeAttributes:device.typeAttributes parameters:device.parameters properties:device.properties icon:device.icon spaces:device.spaces modelId:device.modelId userId:PPUserIdNone];
    return friendshipDevice;
}

+ (PPFriendshipDevice *)initWithDictionary:(NSDictionary *)friendshipDeviceDict {
    NSString *deviceId = [friendshipDeviceDict objectForKey:@"id"];
    NSString *name = [friendshipDeviceDict objectForKey:@"desc"];
    NSString *icon = [friendshipDeviceDict objectForKey:@"icon"];
    
    PPDeviceConnected connected = PPDeviceConnectedNone;
    if([friendshipDeviceDict objectForKey:@"connected"]) {
        connected = (PPDeviceConnected)((NSString *)[friendshipDeviceDict objectForKey:@"connected"]).boolValue;
    }
    NSArray *events = [((NSString *)[friendshipDeviceDict objectForKey:@"events"]) componentsSeparatedByString:@","];
    NSString *currentEvent = [friendshipDeviceDict objectForKey:@"currentEvent"];
    PPFriendshipDeviceMute mute = PPFriendshipDeviceMuteNone;
    if([friendshipDeviceDict objectForKey:@"mute"]) {
        mute = (PPFriendshipDeviceMute)((NSString *)[friendshipDeviceDict objectForKey:@"mute"]).boolValue;
    }
    PPDeviceShared shared = PPDeviceSharedNone;
    if([friendshipDeviceDict objectForKey:@"shared"]) {
        shared = (PPDeviceShared)((NSString *)[friendshipDeviceDict objectForKey:@"shared"]).boolValue;
    }
    
    NSString *shareDateString = [friendshipDeviceDict objectForKey:@"shareDate"];
    NSDate *shareDate = [NSDate date];
    
    if(shareDateString != nil) {
        if(![shareDateString isEqualToString:@""]) {
            shareDate = [PPNSDate parseDateTime:shareDateString];
        }
    }
    
    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
    if([friendshipDeviceDict objectForKey:@"type"]) {
        typeId = (PPDeviceTypeId)((NSString *)[friendshipDeviceDict objectForKey:@"type"]).integerValue;
    }
    
    
    PPDeviceTypeCategory category = (PPDeviceTypeCategory)((NSString *)[friendshipDeviceDict objectForKey:@"typeCategory"]).integerValue;
    
    NSMutableArray *typeAttributes;
    if([friendshipDeviceDict objectForKey:@"typeAttributes"]) {
        typeAttributes = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *typeAttributeDict in [friendshipDeviceDict objectForKey:@"typeAttributes"]) {
            PPDeviceTypeAttribute *attribute = [PPDeviceTypeAttribute initWithDictionary:typeAttributeDict];
            [typeAttributes addObject:attribute];
        }
    }
    
    NSMutableArray *parameters;
    if([friendshipDeviceDict objectForKey:@"parameters"]) {
        parameters = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *parameterDict in [friendshipDeviceDict objectForKey:@"parameters"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:parameterDict];
            [parameters addObject:parameter];
        }
    }
    
    NSMutableArray *spaces;
    if([friendshipDeviceDict objectForKey:@"spaces"]) {
        spaces = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *spaceDict in [friendshipDeviceDict objectForKey:@"spaces"]) {
            PPLocationSpace *space = [PPLocationSpace initWithDictionary:spaceDict];
            [spaces addObject:space];
        }
    }
    
    NSString *modelId = [friendshipDeviceDict objectForKey:@"modelId"];
    
    PPUserId userId = PPUserIdNone;
    if([friendshipDeviceDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[friendshipDeviceDict objectForKey:@"userId"]).integerValue;
    }
    
    PPFriendshipDevice *device = [[PPFriendshipDevice alloc] initWithDeviceId:deviceId name:name typeId:typeId category:category events:(RLMArray *)events currentEvent:currentEvent shared:shared shareDate:shareDate mute:mute connected:connected typeAttributes:(RLMArray *)typeAttributes parameters:(RLMArray *)parameters properties:nil icon:icon spaces:(RLMArray *)spaces modelId:modelId userId:userId];
    return device;
}

+ (NSString *)stringify:(PPFriendshipDevice *)device {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithCapacity:0];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(device.deviceId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", device.deviceId];
        appendComma = YES;
    }
    
    if(device.mute != PPFriendshipDeviceMuteNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"mute\":%li", (long)device.mute];
        appendComma = YES;
    }
    
    if([device.events count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"events\":\"%@\"", [PPRLMArray stringArray:device.events componentsJoinedByString:@","]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end

