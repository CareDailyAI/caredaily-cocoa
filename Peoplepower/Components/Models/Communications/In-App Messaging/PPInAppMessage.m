//
//  PPInAppMessage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPInAppMessage.h"

@implementation PPInAppMessage

+ (NSString *)primaryKey {
    return @"messageId";
}

- (id)initWithSubject:(NSString *)subject type:(PPInAppMessageType)type sendDate:(NSDate *)sendDate text:(NSString *)text email:(PPInAppMessageEmail)email push:(PPInAppMessagePush)push notReply:(PPInAppMessageNotReply)notReply recipients:(NSArray *)recipients challengeId:(PPInAppMessageChallengeId)challengeId challengeParticipantStatus:(PPInAppMessageChallengeParticipanStatus)challengeParticipantStatus messageId:(PPInAppMessageId)messageId originalMessageId:(PPInAppMessageId)originalMessageId creationDate:(NSDate *)creationDate read:(PPInAppMessageMessagesRead)read from:(PPUser *)from parameters:(PPInAppMessageParameters *)parameters {
    self = [super init];
    if(self) {
        self.subject = subject;
        self.type = type;
        self.sendDate = sendDate;
        self.text = text;
        self.email = email;
        self.push = push;
        self.notReply = notReply;
        self.recipients = (RLMArray<PPInAppMessageRecipient *><PPInAppMessageRecipient> *)recipients;
        self.challengeId = challengeId;
        self.challengeParticipantStatus = challengeParticipantStatus;
        self.messageId = messageId;
        self.originalMessageId = originalMessageId;
        self.creationDate = creationDate;
        self.read = read;
        self.from = from;
        self.parameters = parameters;
    }
    return self;
}

+ (PPInAppMessage *)initWithDictionary:(NSDictionary *)messageDict {
    NSString *subject = [messageDict objectForKey:@"subject"];
    PPInAppMessageType type = PPInAppMessageTypeNone;
    if([messageDict objectForKey:@"type"]) {
        type = (PPInAppMessageType)((NSString *)[messageDict objectForKey:@"type"]).integerValue;
    }
    
    NSString *sendDateString = [messageDict objectForKey:@"sendDate"];
    NSDate *sendDate = [NSDate date];
    if(sendDateString != nil) {
        if(![sendDateString isEqualToString:@""]) {
            sendDate = [PPNSDate parseDateTime:sendDateString];
        }
    }
    
    NSString *text = [messageDict objectForKey:@"text"];
    PPInAppMessageEmail email = PPInAppMessageEmailNone;
    if([messageDict objectForKey:@"email"]) {
        email = (PPInAppMessageEmail)((NSString *)[messageDict objectForKey:@"email"]).integerValue;
    }
    PPInAppMessagePush push = PPInAppMessagePushNone;
    if([messageDict objectForKey:@"push"]) {
        push = (PPInAppMessagePush)((NSString *)[messageDict objectForKey:@"push"]).integerValue;
    }
    PPInAppMessageNotReply notReply = PPInAppMessageNotReplyNone;
    if([messageDict objectForKey:@"notReply"]) {
        notReply = (PPInAppMessageNotReply)((NSString *)[messageDict objectForKey:@"notReply"]).integerValue;
    }
    NSMutableArray *recipients;
    if([messageDict objectForKey:@"recipients"]) {
        recipients = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *recipientDict in [messageDict objectForKey:@"recipients"]) {
            PPInAppMessageRecipient *recipient = [PPInAppMessageRecipient initWithDictionary:recipientDict];
            [recipients addObject:recipient];
        }
    }
    
    PPInAppMessageChallengeId challengeId = PPInAppMessageChallengeIdNone;
    if([messageDict objectForKey:@"challengeId"]) {
        challengeId = (PPInAppMessageChallengeId)((NSString *)[messageDict objectForKey:@"challengeId"]).integerValue;
    }
    PPInAppMessageChallengeParticipanStatus challengeParticipantStatus = PPInAppMessageChallengeParticipanStatusNone;
    if([messageDict objectForKey:@"challengeParticipantStatus"]) {
        challengeParticipantStatus = (PPInAppMessageChallengeParticipanStatus)((NSString *)[messageDict objectForKey:@"challengeParticipantStatus"]).integerValue;
    }
    PPInAppMessageId messageId = PPInAppMessageIdNone;
    if([messageDict objectForKey:@"id"]) {
        messageId = (PPInAppMessageId)((NSString *)[messageDict objectForKey:@"id"]).integerValue;
    }
    PPInAppMessageId originalMessageId = PPInAppMessageIdNone;
    if([messageDict objectForKey:@"originalMessageId"]) {
        originalMessageId = (PPInAppMessageId)((NSString *)[messageDict objectForKey:@"originalMessageId"]).integerValue;
    }
    
    NSString *creationDateString = [messageDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    PPInAppMessageMessagesRead read = PPInAppMessageMessagesReadNone;
    if([messageDict objectForKey:@"read"]) {
        read = (PPInAppMessageMessagesRead)((NSString *)[messageDict objectForKey:@"read"]).integerValue;
    }
    PPUser *from;
    if([messageDict objectForKey:@"from"]) {
        from = [PPUser initWithDictionary:[messageDict objectForKey:@"from"]];
    }
    PPInAppMessageParameters *parameters = [PPInAppMessageParameters initWithDictionary:[messageDict objectForKey:@"parameters"]];
    
    PPInAppMessage *message = [[PPInAppMessage alloc] initWithSubject:subject type:type sendDate:sendDate text:text email:email push:push notReply:notReply recipients:recipients challengeId:challengeId challengeParticipantStatus:challengeParticipantStatus messageId:messageId originalMessageId:originalMessageId creationDate:creationDate read:read from:from parameters:parameters];
    return message;
}

+ (NSString *)stringify:(PPInAppMessage *)message {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(message.subject) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subject\":\"%@\"", message.subject];
        appendComma = YES;
    }
    
    if(message.type != PPInAppMessageTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":\"%li\"", (long)message.type];
        appendComma = YES;
    }
    
    if(message.sendDate) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendFormat:@"\"sendDate\":\"%@\"", [PPNSDate apiFriendStringFromDate:message.sendDate]];
        appendComma = YES;
    }
    
    if(message.text) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"text\":\"%@\"", message.text];
        appendComma = YES;
    }
    
    if(message.email != PPInAppMessageEmailNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"email\":\"%@\"", (message.email) ? @"true" : @"false"];
        appendComma = YES;
    }
    
    if(message.push != PPInAppMessagePushNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"push\":\"%@\"", (message.push) ? @"true" : @"false"];
        appendComma = YES;
    }
    
    if(message.notReply != PPInAppMessageNotReplyNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"notReply\":\"%@\"", (message.notReply) ? @"true" : @"false"];
        appendComma = YES;
    }
    
    if([message.recipients count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"recipient\": ["];
        BOOL appendRecipientComma = NO;
        for(PPInAppMessageRecipient *recipient in message.recipients) {
            if(appendRecipientComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPInAppMessageRecipient stringify:recipient]];
            appendRecipientComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(message.challengeId != PPInAppMessageChallengeIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"challengeId\":\"%li\"", (long)message.challengeId];
        appendComma = YES;
    }
    
    if(message.challengeParticipantStatus != PPInAppMessageChallengeParticipanStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"challengeParticipantStatus\":\"%li\"", (long)message.challengeParticipantStatus];
        appendComma = YES;
    }
    
    if(message.parameters) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"parameters\": {%@}", [PPInAppMessageParameters stringify:message.parameters]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPInAppMessage *)message {
    NSMutableDictionary *data = @{}.mutableCopy;
    if(message.subject) {
        data[@"subject"] = message.subject;
    }
    
    if(message.type != PPInAppMessageTypeNone) {
        data[@"type"] = @(message.type);
    }
    
    if(message.sendDate) {
        data[@"sendDate"] = [PPNSDate apiFriendStringFromDate:message.sendDate];
    }
    
    if(message.text) {
        data[@"text"] =  message.text;
    }
    
    if(message.email != PPInAppMessageEmailNone) {
        data[@"email"] = (message.email) ? @"true" : @"false";
    }
    
    if(message.push != PPInAppMessagePushNone) {
        data[@"push"] = (message.push) ? @"true" : @"false";
    }
    
    if(message.notReply != PPInAppMessageNotReplyNone) {
        data[@"notReply"] = (message.notReply) ? @"true" : @"false";
    }
    
    if([message.recipients count]) {
        NSMutableArray *recipients = @[].mutableCopy;
        for(PPInAppMessageRecipient *recipient in message.recipients) {
            [recipients addObject:[PPInAppMessageRecipient data:recipient]];
        }
    }
    
    if(message.challengeId != PPInAppMessageChallengeIdNone) {
        data[@"challengeId"] = @(message.challengeId);
    }
    
    if(message.challengeParticipantStatus != PPInAppMessageChallengeParticipanStatusNone) {
        data[@"challengeParticipantStatus"] = @(message.challengeParticipantStatus);
    }
    
    if(message.parameters) {
        data[@"parameters"] = [PPInAppMessageParameters data:message.parameters];
    }
    
    return data;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToMessage:(PPInAppMessage *)message {
    BOOL equal = NO;
    if(_messageId == message.messageId) {
        equal = YES;
    }
    
    return equal;
}

- (void)sync:(PPInAppMessage *)message {
    
    if(message.subject) {
        _subject = message.subject;
    }
    if(message.type != PPInAppMessageTypeNone) {
        _type = message.type;
    }
    if(message.sendDate) {
        _sendDate = message.sendDate;
    }
    if(message.text) {
        _text = message.text;
    }
    if(message.email != PPInAppMessageEmailNone) {
        _email = message.email;
    }
    if(message.push != PPInAppMessagePushNone) {
        _push = message.push;
    }
    if(message.notReply != PPInAppMessageNotReplyNone) {
        _notReply = message.notReply;
    }
    if(message.recipients) {
        _recipients = message.recipients;
    }
    if(message.challengeId != PPInAppMessageChallengeIdNone) {
        _challengeId = message.challengeId;
    }
    if(message.challengeParticipantStatus != PPInAppMessageChallengeParticipanStatusNone) {
        _challengeParticipantStatus = message.challengeParticipantStatus;
    }
    if(message.messageId != PPInAppMessageIdNone) {
        _messageId = message.messageId;
    }
    if(message.originalMessageId != PPInAppMessageIdNone) {
        _originalMessageId = message.originalMessageId;
    }
    if(message.creationDate) {
        _creationDate = message.creationDate;
    }
    if(message.read != PPInAppMessageMessagesReadNone) {
        _read = message.read;
    }
    if(message.from) {
        _from = message.from;
    }
    if(message.parameters) {
        _parameters = message.parameters;
    }
}

@end
