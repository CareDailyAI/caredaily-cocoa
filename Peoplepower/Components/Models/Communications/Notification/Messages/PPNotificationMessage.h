//
//  PPNotificationMessage.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPNotificationMessage : NSObject

@property (nonatomic, strong) NSString *notificationTemplate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *model;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model;

+ (PPNotificationMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationMessage *)message;
+ (NSDictionary *)data:(PPNotificationMessage *)message;

@end

