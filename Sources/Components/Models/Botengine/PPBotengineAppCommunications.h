//
//  PPBotengineAppCommunications.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPBotengineAppCommunications : PPBaseModel

@property (nonatomic) PPBotengineAppCommunicationsCategory category;
@property (nonatomic) BOOL email;
@property (nonatomic) BOOL push;
@property (nonatomic) BOOL sms;
@property (nonatomic) BOOL msg;

- (id)initWithCategory:(PPBotengineAppCommunicationsCategory)category email:(BOOL)email push:(BOOL)push sms:(BOOL)sms msg:(BOOL)msg;

- (NSString *)JSONString;
@end
