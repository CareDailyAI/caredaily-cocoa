//
//  PPFriendshipDevice.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"

typedef NS_OPTIONS(NSInteger, PPFriendshipDeviceMute) {
    PPFriendshipDeviceMuteNone = -1,
    PPFriendshipDeviceMuteFalse = 0,
    PPFriendshipDeviceMuteTrue = 1
};

@interface PPFriendshipDevice : PPDevice

/* Location event names: when are devices shared? (HOME, AWAY, etc.) */
@property (nonatomic, strong) RLMArray<RLMString> *events;

/* Current device location event name */
@property (nonatomic, strong) NSString* currentEvent;

/* Indicates if notifications from this device is muted */
@property (nonatomic) PPFriendshipDeviceMute mute;

/* Date this device was shared */
@property (nonatomic, strong) NSDate *shareDate;

@property (nonatomic, strong) NSString *friendshipDeviceId;
@property (nonatomic) NSInteger friendshipId;

- (id)initWithDeviceId:(NSString *)deviceId name:(NSString *)name typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category events:(RLMArray *)events currentEvent:(NSString *)currentEvent shared:(PPDeviceShared)shared shareDate:(NSDate *)shareDate mute:(PPFriendshipDeviceMute)mute connected:(PPDeviceConnected)connected typeAttributes:(RLMArray *)typeAttributes parameters:(RLMArray *)parameters properties:(RLMArray *)properties icon:(NSString *)icon spaces:(RLMArray *)spaces modelId:(NSString *)modelId;

+ (PPFriendshipDevice *)initWithDevice:(PPDevice *)device events:(RLMArray *)events currentEvent:(NSString *)currentEvent mute:(PPFriendshipDeviceMute)mute shareDate:(NSDate *)shareDate;

+ (PPFriendshipDevice *)initWithDictionary:(NSDictionary *)friendshipDeviceDict;

+ (NSString *)stringify:(PPFriendshipDevice *)device;

@end

