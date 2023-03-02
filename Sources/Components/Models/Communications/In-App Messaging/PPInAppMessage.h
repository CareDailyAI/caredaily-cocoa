//
//  PPInAppMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPInAppMessageParameters.h"
#import "PPInAppMessageRecipient.h"

@interface PPInAppMessage : PPBaseModel

/* Subject line of the message */
@property (nonatomic, strong) NSString *subject;

/* The developer can use this field to store any value needed to assist the app. Its contents are unused and undefined by the IoT Software Suite. */
@property (nonatomic) PPInAppMessageType type;

/* Specific date to send this message. Optional. */
@property (nonatomic, strong) NSDate *sendDate;

/* Message body. Data can also be delivered in base-64 encoding, but it must be interpreted by the application. */
@property (nonatomic, strong) NSString *text;

/* Message delivered or not delivered over email */
@property (nonatomic) PPInAppMessageEmail email;

/* Message delivered or not delivered over push */
@property (nonatomic) PPInAppMessagePush push;

/* Message allows or not does not allow replies */
@property (nonatomic) PPInAppMessageNotReply notReply;

/* Recipients of this message */
@property (nonatomic, strong) RLMArray<PPInAppMessageRecipient *><PPInAppMessageRecipient> *recipients;

/* Send a message to participants of this challenge */
@property (nonatomic) PPInAppMessageChallengeId challengeId;

/* A bitmask for the challenge participant statuses */
@property (nonatomic) PPInAppMessageChallengeParticipanStatus challengeParticipantStatus;

/* Specific message ID */
@property (nonatomic) PPInAppMessageId messageId;

/* Original message ID where the current message can reply */
@property (nonatomic) PPInAppMessageId originalMessageId;

/* Creation timestamp */
@property (nonatomic, strong) NSDate *creationDate;

/* Message has been read or not */
@property (nonatomic) PPInAppMessageMessagesRead read;

/* User object describing who the message was from, including userId, email, firstName, lastName */
@property (nonatomic, strong) PPUser *from;

/* A key/value pairs map containing string parameters */
@property (nonatomic, strong) PPInAppMessageParameters *parameters;

- (id)initWithSubject:(NSString *)subject type:(PPInAppMessageType)type sendDate:(NSDate *)sendDate text:(NSString *)text email:(PPInAppMessageEmail)email push:(PPInAppMessagePush)push notReply:(PPInAppMessageNotReply)notReply recipients:(NSArray *)recipients challengeId:(PPInAppMessageChallengeId)challengeId challengeParticipantStatus:(PPInAppMessageChallengeParticipanStatus)challengeParticipantStatus messageId:(PPInAppMessageId)messageId originalMessageId:(PPInAppMessageId)originalMessageId creationDate:(NSDate *)creationDate read:(PPInAppMessageMessagesRead)read from:(PPUser *)from parameters:(PPInAppMessageParameters *)parameters;

+ (PPInAppMessage *)initWithDictionary:(NSDictionary *)messageDict;

+ (NSString *)stringify:(PPInAppMessage *)message;
+ (NSDictionary *)data:(PPInAppMessage *)message;

#pragma mark - Helper Methods

- (BOOL)isEqualToMessage:(PPInAppMessage *)message;

- (void)sync:(PPInAppMessage *)message;

@end
