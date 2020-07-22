//
//  PPNotificationMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPRLMDictionary.h"

@class PPNotificationMessageModel;

@interface PPNotificationMessage : PPBaseModel

@property (nonatomic, strong) NSString *notificationTemplate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) PPNotificationMessageModel *model;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model;

+ (PPNotificationMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationMessage *)message;
+ (NSDictionary *)data:(PPNotificationMessage *)message;

@end

@interface PPNotificationMessageModel : PPRLMDictionary
+ (PPNotificationMessageModel *)initWithDictionary:(NSDictionary *)dict;
@end

