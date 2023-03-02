//
//  PPNotificationEmailMessageAttachment.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPNotificationEmailMessageAttachment : PPBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *contentId;

- (id)initWithName:(NSString *)name content:(NSString *)content contentType:(NSString *)contentType contentId:(NSString *)contentId;

+ (NSString *)stringify:(PPNotificationEmailMessageAttachment *)attachment;
+ (NSMutableDictionary *)data:(PPNotificationEmailMessageAttachment *)attachment;

@end
