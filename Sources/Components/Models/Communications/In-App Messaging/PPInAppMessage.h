//
//  PPInAppMessage.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPInAppMessageParameters.h"
#import "PPInAppMessageRecipient.h"

typedef NS_OPTIONS(NSInteger, PPInAppMessageType) {
    PPInAppMessageTypeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageEmail) {
    PPInAppMessageEmailNone = -1,
    PPInAppMessageEmailFalse = 0, // Don't deliver this message over email, default
    PPInAppMessageEmailTrue = 1 // Deliver this message over email
};

typedef NS_OPTIONS(NSInteger, PPInAppMessagePush) {
    PPInAppMessagePushNone = -1,
    PPInAppMessagePushFalse = 0, // Don't deliver this message over push notification, default
    PPInAppMessagePushTrue = 1 // Deliver this message over push notification
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageNotReply) {
    PPInAppMessageNotReplyNone = -1,
    PPInAppMessageNotReplyFalse = 0, // Allow replies, default
    PPInAppMessageNotReplyTrue = 1 // Do not allow replies to this thread
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageChallengeId) {
    PPInAppMessageChallengeIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageChallengeParticipanStatus) {
    PPInAppMessageChallengeParticipanStatusNone = 0,
    PPInAppMessageChallengeParticipanStatusNotResponded = 1 << 0,
    PPInAppMessageChallengeParticipanStatusOptedIn = 1 << 1,
    PPInAppMessageChallengeParticipanStatusOptedOut = 1 << 2
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageId) {
    PPInAppMessageIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageMessagesRead) {
    PPInAppMessageMessagesReadNone = -1,
    PPInAppMessageMessagesReadFalse = 0,
    PPInAppMessageMessagesReadTrue = 1
};

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
