//
//  PPNotificationEmailMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPNotificationMessage.h"
#import "PPNotificationEmailMessageAttachment.h"

@interface PPNotificationEmailMessage : PPNotificationMessage

@property (nonatomic, strong) NSString *subject;
@property (nonatomic) PPNotificationEmailMessageHTML html;
@property (nonatomic, strong) NSArray *attachments;

- (id)initWithTemplate:(NSString *)notificationTemplate content:(NSString *)content model:(NSDictionary *)model subject:(NSString *)subject html:(PPNotificationEmailMessageHTML)html attachments:(NSArray *)attachments;

+ (PPNotificationEmailMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPNotificationEmailMessage *)emailMessage;
+ (NSDictionary *)data:(PPNotificationEmailMessage *)emailMessage;

@end
