//
//  PPInAppMessaging.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// It is possible for a user to send a message while remaining anonymous to other people within the Community Social Network. See user updates to specify anonymity.
// The user has to be an administrator or approved in the organization to send and receive messages.
//

#import "PPBaseModel.h"
#import "PPInAppMessage.h"
#import "PPUser.h"

typedef void (^PPInAppMessagingBlock)(PPInAppMessageId messageId, NSError * _Nullable error);
typedef void (^PPInAppMessagesBlock)(NSArray * _Nullable messages, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPInApMessagingStatus) {
    PPInApMessagingStatusNone = -1,
    PPInApMessagingStatusSentMessages = 0,
    PPInApMessagingStatusInboundUnreadMessages = 1,
    PPInApMessagingStatusInboundReadMessages = 2,
    PPInApMessagingStatusAllInboundMessages = 3
};

@interface PPInAppMessaging : PPBaseModel

/**
 * Shared messages across the entire application
 */
+ (NSArray *)sharedMessagesForUser:(PPUserId)userId;

/**
 * Add messages.
 * Add messages to local reference.
 *
 * @param messages NSArray Array of messages to add.
 * @param userId Required PPUserId User Id to associate these messages with
 **/
+ (void)addMessages:(NSArray *)messages userId:(PPUserId)userId;

/**
 * Remove messages.
 * Remove messages from local reference.
 *
 * @param messages NSArray Array of messages to remove.
 * @param userId Required PPUserId User Id to associate these messages with
 **/
+ (void)removeMessages:(NSArray *)messages userId:(PPUserId)userId;

#pragma mark - Send a Message

/**
 * Send a Message.
 *
 * @param message Required PPInAppMessage Message to be sent
 * @param callback PPInAppMessagingBlock In-App Message callback block containing message Id
 **/
+ (void)sendMessage:(PPInAppMessage * _Nonnull )message callback:(PPInAppMessagingBlock _Nonnull )callback;

/**
 * Receive Messages
 *
 * @param status PPInAppMessagingStatus Messages status
 * @param messageId PPInAppMessageId Filter messages and replies by the original message ID
 * @param userId PPUserId User ID to get messages for, for use by administrators only
 * @param type PPInAppMessageType This field is available for the application developer to use as needed. It is unused and undefined by the IoT Software Suite.
 * @param challengeId PPInAppMessageChallengeId Get messages linked to this challenge.
 * @param searchBy NSString Search by subject, text, from or recipient fields
 * @param callback PPInAppMessagesBlock In-App Messages callback block containing array of messages
 **/
+ (void)recieveMessages:(PPInAppMessageChallengeParticipanStatus)status messageId:(PPInAppMessageId)messageId userId:(PPUserId)userId type:(PPInAppMessageType)type challengeId:(PPInAppMessageChallengeId)challengeId searchBy:(NSString * _Nullable )searchBy callback:(PPInAppMessagesBlock _Nonnull )callback;

#pragma mark - Manage a message

/**
 * Update message attributes.
 *
 * @param messageId Required PPInAppMessageId Message Id to update
 * @param read PPInAppMessageMessagesRead Read status to update to
 * @param subject NSString Subject of the message
 * @param text NSString Text of the message
 * @param parameters NSDictrionary Parameters of the message
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateMessageAttributions:(PPInAppMessageId)messageId read:(PPInAppMessageMessagesRead)read subject:(NSString * _Nullable )subject text:(NSString * _Nullable )text parameters:(PPInAppMessageParameters * _Nullable )parameters callback:(PPErrorBlock _Nonnull )callback;

/**
 * Delete a message
 *
 * @param messageId Required PPInAppMessageId Message Id to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteMessage:(PPInAppMessageId)messageId callback:(PPErrorBlock _Nonnull )callback;

/**
 * Reply to a message
 * When replying to a message, the body may specify whether to also delivery the reply over email and push notification, to notify the recipient.
 *
 * @param messageId Required PPInAppMessageId Message Id to reply to
 * @param text Required NSString Text of the reply message
 * @param email PPInAppMessageEmail Send a notification over email
 * @param push PPInAppMessagePush Send a notification over push
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)replyToMessage:(PPInAppMessageId)messageId text:(NSString * _Nonnull )text email:(PPInAppMessageEmail)email push:(PPInAppMessagePush)push callback:(PPErrorBlock _Nonnull )callback;
 
@end
