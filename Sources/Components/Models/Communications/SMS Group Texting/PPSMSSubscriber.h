//
//  PPSMSSubscriber.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPSMSSubscriber : PPBaseModel

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic) PPSMSSubscriberStatus status;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *initials;

- (id)initWithPhone:(NSString *)phone categories:(NSArray *)categories status:(PPSMSSubscriberStatus)status firstName:(NSString *)firstName lastName:(NSString *)lastName initials:(NSString *)initials;

+ (PPSMSSubscriber *)initWithDictionary:(NSDictionary *)subscriberDict;

+ (NSString *)stringify:(PPSMSSubscriber *)subscriber;
+ (NSDictionary *)data:(PPSMSSubscriber *)subscriber;

#pragma mark - Helper Methods

- (BOOL)isEqualToSubscriber:(PPSMSSubscriber *)subscriber;

- (void)sync:(PPSMSSubscriber *)subscriber;

@end
