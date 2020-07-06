//
//  PPSMSSubscriber.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPSMSSubcriberCommunicationCategory) {
    PPSMSSubcriberCommunicationCategoryNone = -1,
    PPSMSSubcriberCommunicationCategoryMeOnly = 0,
    PPSMSSubcriberCommunicationCategoryGeneralFriends = 1,
    PPSMSSubcriberCommunicationCategoryFamilyCaregivers = 2
};

typedef NS_OPTIONS(NSInteger, PPSMSSubscriberStatus) {
    PPSMSSubscriberStatusNone = -1,
    PPSMSSubscriberStatusSubscribed = 1,
    PPSMSSubscriberStatusOptOut = 2,
    PPSMSSubscriberStatusInvalid = 3, // SMS cannot be sent to this number
};

@interface PPSMSSubscriber : RLMObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) RLMArray<RLMInt> *categories;
@property (nonatomic) PPSMSSubscriberStatus status;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *initials;

- (id)initWithPhone:(NSString *)phone categories:(RLMArray *)categories status:(PPSMSSubscriberStatus)status firstName:(NSString *)firstName lastName:(NSString *)lastName initials:(NSString *)initials;

+ (PPSMSSubscriber *)initWithDictionary:(NSDictionary *)subscriberDict;

+ (NSString *)stringify:(PPSMSSubscriber *)subscriber;
+ (NSDictionary *)data:(PPSMSSubscriber *)subscriber;

#pragma mark - Helper Methods

- (BOOL)isEqualToSubscriber:(PPSMSSubscriber *)subscriber;

- (void)sync:(PPSMSSubscriber *)subscriber;

@end

RLM_ARRAY_TYPE(PPSMSSubscriber);
