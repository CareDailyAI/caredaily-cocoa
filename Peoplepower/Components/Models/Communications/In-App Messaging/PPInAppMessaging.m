//
//  PPInAppMessaging.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPInAppMessaging.h"
#import "PPCloudEngine.h"

@implementation PPInAppMessaging

#pragma mark - Session Management

#pragma mark - Notification Messages

__strong static NSMutableDictionary*_sharedMessages = nil;

/**
 * Shared messages across the entire application
 */
+ (NSArray *)sharedMessagesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedMessages) {
        [PPInAppMessaging initializeSharedMessages];
    }
    NSMutableArray *sharedMessages = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *messagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedMessages.allKeys) {
        for(PPInAppMessage *message in [_sharedMessages objectForKey:userIdKey]) {
            NSMutableDictionary *messageIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [messageIdentifiers setValue:@(message.messageId) forKey:@"messageId"];
            [messagesArray addObject:messageIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedMessages addObject:message];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedMessages=%@", __PRETTY_FUNCTION__, messagesArray);
#endif
#endif
    return sharedMessages;
}

+ (void)initializeSharedMessages {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedMessages = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedMessagesData = [defaults objectForKey:@"user.notificationMessages"];
//    if(storedMessagesData) {
//        _sharedMessages = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedMessagesData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add messages.
 * Add messages from local reference.
 *
 * @param messages NSArray Array of messages to remove.
 * @param userId Required PPUserId User Id to associate these messages with
 **/
+ (void)addMessages:(NSArray *)messages userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s messages=%@", __PRETTY_FUNCTION__, messages);
#endif
#endif
    if(!_sharedMessages) {
        [PPInAppMessaging initializeSharedMessages];
    }
    
    NSMutableArray *messagesArray = [_sharedMessages objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!messagesArray) {
        messagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPInAppMessage *message in messages) {
        
        BOOL found = NO;
        for(PPInAppMessage *sharedMessage in messagesArray) {
            if([sharedMessage isEqualToMessage:message]) {
                [sharedMessage sync:message];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[messages indexOfObject:message]];
        }
    }
    
    [messagesArray addObjectsFromArray:[messages objectsAtIndexes:indexSet]];
    [_sharedMessages setObject:messagesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedMessageData = [NSKeyedArchiver archivedDataWithRootObject:_sharedMessages];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedMessageData forKey:@"user.notificationMessages"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s messagesArray=%@", __PRETTY_FUNCTION__, messagesArray);
#endif
#endif
}

/**
 * Remove messages.
 * Remove messages from local reference.
 *
 * @param messages NSArray Array of messages to remove.
 * @param userId Required PPUserId User Id to associate these messages with
 **/
+ (void)removeMessages:(NSArray *)messages userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s messages=%@", __PRETTY_FUNCTION__, messages);
#endif
#endif
    
    if(!_sharedMessages) {
        [PPInAppMessaging initializeSharedMessages];
    }
    
    NSMutableArray *messagesArray = [_sharedMessages objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!messagesArray) {
        messagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPInAppMessage *message in messages) {
        for(PPInAppMessage *sharedMessage in messagesArray) {
            if([sharedMessage isEqualToMessage:message]) {
                [indexSet addIndex:[messagesArray indexOfObject:sharedMessage]];
                break;
            }
        }
    }
    
    [messagesArray removeObjectsAtIndexes:indexSet];
    [_sharedMessages setObject:messagesArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedMessageData = [NSKeyedArchiver archivedDataWithRootObject:_sharedMessages];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedMessageData forKey:@"user.inAppMessages"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s messagesArray=%@", __PRETTY_FUNCTION__, messagesArray);
#endif
#endif
}

#pragma mark - Send a Message

/**
 * Send a Message.
 *
 * @param message Required PPInAppMessage Message to be sent
 * @param callback PPInAppMessagingBlock In-App Message callback block containing message Id
 **/
+ (void)sendMessage:(PPInAppMessage *)message callback:(PPInAppMessagingBlock)callback {
    NSAssert1(message != nil, @"%s missing message", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithString:@"messages"];
    
    NSMutableDictionary *data = @{}.mutableCopy;
    data[@"message"] = [PPInAppMessage data:message];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(PPInAppMessageIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.sendMessage()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPInAppMessageId messageId = PPInAppMessageIdNone;
            
            if(!error) {
                if([root objectForKey:@"messageId"]) {
                    messageId = (PPInAppMessageId)((NSString *)[root objectForKey:@"messageId"]).integerValue;
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(messageId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPInAppMessageIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)recieveMessages:(PPInAppMessageChallengeParticipanStatus)status messageId:(PPInAppMessageId)messageId userId:(PPUserId)userId type:(PPInAppMessageType)type challengeId:(PPInAppMessageChallengeId)challengeId searchBy:(NSString *)searchBy callback:(PPInAppMessagesBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"messages"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(status != PPInAppMessageChallengeParticipanStatusNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"status" value:@(status).stringValue]];
    }
    if(messageId != PPInAppMessageIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"messageId" value:@(messageId).stringValue]];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(type != PPInAppMessageTypeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(type).stringValue]];
    }
    if(challengeId != PPInAppMessageChallengeIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"challengeId" value:@(challengeId).stringValue]];
    }
    if(searchBy)  {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"searchBy" value:searchBy]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.recieveMessages()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *messages;
            
            if(!error) {
                messages = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *messageDict in [root objectForKey:@"messages"]) {
                    PPInAppMessage *message = [PPInAppMessage initWithDictionary:messageDict];
                    [messages addObject:message];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(messages, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)updateMessageAttributions:(PPInAppMessageId)messageId read:(PPInAppMessageMessagesRead)read subject:(NSString *)subject text:(NSString *)text parameters:(PPInAppMessageParameters *)parameters callback:(PPErrorBlock)callback {
    NSAssert1(messageId != PPInAppMessageIdNone, @"%s missing messageId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"messages/%@", @(messageId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(read != PPInAppMessageMessagesReadNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"read" value:(read) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    if(subject || text || parameters) {
        PPInAppMessage *message = [[PPInAppMessage alloc] initWithSubject:subject type:PPInAppMessageTypeNone sendDate:nil text:text email:PPInAppMessageEmailNone push:PPInAppMessagePushNone notReply:PPInAppMessageNotReplyNone recipients:nil challengeId:PPInAppMessageChallengeIdNone challengeParticipantStatus:PPInAppMessageChallengeParticipanStatusNone messageId:PPInAppMessageIdNone originalMessageId:PPInAppMessageIdNone creationDate:nil read:PPInAppMessageMessagesReadNone from:nil parameters:parameters];
        data[@"message"] = [PPInAppMessage data:message];
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.updateMessageAttributions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete a message
 *
 * @param messageId Required PPInAppMessageId Message Id to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteMessage:(PPInAppMessageId)messageId callback:(PPErrorBlock)callback {
    NSAssert1(messageId != PPInAppMessageIdNone, @"%s missing messageId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"messages/%@", @(messageId)]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.deleteMessage()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

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
+ (void)replyToMessage:(PPInAppMessageId)messageId text:(NSString *)text email:(PPInAppMessageEmail)email push:(PPInAppMessagePush)push callback:(PPErrorBlock)callback {
    NSAssert1(messageId != PPInAppMessageIdNone, @"%s missing messageId", __FUNCTION__);
    NSAssert1(text != nil, @"%s missing text", __FUNCTION__);

    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"messages/%@", @(messageId)]];
    
    NSMutableDictionary *data = @{}.mutableCopy;
    PPInAppMessage *message = [[PPInAppMessage alloc] initWithSubject:nil type:PPInAppMessageTypeNone sendDate:nil text:text email:email push:push notReply:PPInAppMessageNotReplyNone recipients:nil challengeId:PPInAppMessageChallengeIdNone challengeParticipantStatus:PPInAppMessageChallengeParticipanStatusNone messageId:PPInAppMessageIdNone originalMessageId:PPInAppMessageIdNone creationDate:nil read:PPInAppMessageMessagesReadNone from:nil parameters:nil];
    data[@"message"] = [PPInAppMessage data:message];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.replyToMessage()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end

