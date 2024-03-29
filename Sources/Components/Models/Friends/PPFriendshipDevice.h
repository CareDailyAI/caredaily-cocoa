//
//  PPFriendshipDevice.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDevice.h"

@interface PPFriendshipDevice : PPDevice

/* Location event names: when are devices shared? (HOME, AWAY, etc.) */
@property (nonatomic, strong) NSArray *events;

/* Current device location event name */
@property (nonatomic, strong) NSString *currentEvent;

/* Indicates if notifications from this device is muted */
@property (nonatomic) PPFriendshipDeviceMute mute;

/* Date this device was shared */
@property (nonatomic, strong) NSDate *shareDate;

@property (nonatomic, strong) NSString *friendshipDeviceId;
@property (nonatomic) NSInteger friendshipId;

- (id)initWithDeviceId:(NSString *)deviceId name:(NSString *)name typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category events:(NSArray *)events currentEvent:(NSString *)currentEvent shared:(PPDeviceShared)shared shareDate:(NSDate *)shareDate mute:(PPFriendshipDeviceMute)mute connected:(PPDeviceConnected)connected typeAttributes:(NSMutableArray *)typeAttributes parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId userId:(PPUserId)userId;
- (id)initWithDeviceId:(NSString *)deviceId name:(NSString *)name typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category events:(NSArray *)events currentEvent:(NSString *)currentEvent shared:(PPDeviceShared)shared shareDate:(NSDate *)shareDate mute:(PPFriendshipDeviceMute)mute connected:(PPDeviceConnected)connected typeAttributes:(NSMutableArray *)typeAttributes parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId __attribute__((deprecated));

+ (PPFriendshipDevice *)initWithDevice:(PPDevice *)device events:(NSArray *)events currentEvent:(NSString *)currentEvent mute:(PPFriendshipDeviceMute)mute shareDate:(NSDate *)shareDate;

+ (PPFriendshipDevice *)initWithDictionary:(NSDictionary *)friendshipDeviceDict;

+ (NSString *)stringify:(PPFriendshipDevice *)device;

@end
