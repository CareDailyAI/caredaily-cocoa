//
//  PPCommunityPostReminder.h
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunityPostReminder : PPBaseModel

@property (nonatomic, strong) NSDate * _Nullable notificationDate;
@property (nonatomic, strong) NSNumber * _Nullable notificationInterval;
@property (nonatomic, strong) NSString * _Nonnull notificationText;

- (id)initWithNotificationDate:(NSDate * _Nullable )notificationDate
          notificationInterval:(NSNumber * _Nullable )notificationInterval
              notificationText:(NSString * _Nonnull )notificationText;

+ (PPCommunityPostReminder *)initWithDictionary:(NSDictionary *)reminderDict;

+ (NSDictionary *)dataFromPostReminder:(PPCommunityPostReminder *)postReminder;

@end

NS_ASSUME_NONNULL_END
