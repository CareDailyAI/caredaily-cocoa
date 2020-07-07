//
//  PPNotificationSMSMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"

typedef NS_OPTIONS(NSInteger, PPNotificationSMSMessageCategory) {
    PPNotificationSMSMessageCategoryDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSMSMessageIndividual) {
    PPNotificationSMSMessageIndividualNone = -1,
    PPNotificationSMSMessageIndividualFalse = 0,
    PPNotificationSMSMessageIndividualTrue = 1
};

@interface PPNotificationSMSMessage : PPNotificationMessage

@property (nonatomic, strong) RLMArray<RLMString> *categories;
@property (nonatomic, strong) RLMArray<RLMString> *phones;
@property (nonatomic) PPNotificationSMSMessageIndividual individual;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model categories:(RLMArray *)categories phones:(RLMArray *)phones individual:(PPNotificationSMSMessageIndividual)individual;

+ (PPNotificationSMSMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationSMSMessage *)message;
+ (NSDictionary *)data:(PPNotificationSMSMessage *)message;

@end
