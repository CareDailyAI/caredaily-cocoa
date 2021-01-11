//
//  PPNotificationEmailMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"
#import "PPNotificationEmailMessageAttachment.h"

@interface PPNotificationEmailMessage : PPNotificationMessage

@property (nonatomic, strong) NSString *subject;
@property (nonatomic) PPNotificationEmailMessageHTML html;
@property (nonatomic, strong) RLMArray<PPNotificationEmailMessageAttachment *><PPNotificationEmailMessageAttachment> *attachments;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(PPNotificationMessageModel *)model subject:(NSString *)subject html:(PPNotificationEmailMessageHTML)html attachments:(RLMArray *)attachments;

+ (PPNotificationEmailMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationEmailMessage *)emailMessage;
+ (NSDictionary *)data:(PPNotificationEmailMessage *)emailMessage;

@end