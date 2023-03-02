//
//  PPInAppMessageRecipient.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPInAppMessageRecipient.h"

@implementation PPInAppMessageRecipient

- (id)initWithOrganization:(PPOrganization *)organization user:(PPUser *)user userTag:(NSString *)userTag deviceTag:(NSString *)deviceTag {
    self = [super init];
    if(self) {
        self.organization = organization;
        self.user = user;
        self.userTag = userTag;
        self.deviceTag = deviceTag;
    }
    return self;
}

+ (PPInAppMessageRecipient *)initWithDictionary:(NSDictionary *)recipientDict {
    PPOrganization *organization = [PPOrganization initWithDictionary:recipientDict];
    PPUser *user = [PPUser initWithDictionary:recipientDict];
    NSString *userTag = [recipientDict objectForKey:@"userTag"];
    NSString *deviceTag = [recipientDict objectForKey:@"deviceTag"];
    
    PPInAppMessageRecipient *recipient = [[PPInAppMessageRecipient alloc] initWithOrganization:organization user:user userTag:userTag deviceTag:deviceTag];
    return recipient;
}


+ (NSString *)stringify:(PPInAppMessageRecipient *)recipient {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(recipient.organization) {
        if(recipient.organization.organizationId != PPOrganizationIdNone) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"organizationId\":\"%li\"", (long)recipient.organization.organizationId];
            appendComma = YES;
        }
        if(recipient.organization.group) {
            if(recipient.organization.group.groupId != PPOrganizationGroupIdNone) {
                if(appendComma) {
                    [JSONString appendString:@","];
                }
                [JSONString appendFormat:@"\"groupId\":\"%li\"", (long)recipient.organization.group.groupId];
                appendComma = YES;
            }
        }
    }
    if(recipient.user) {
        if(recipient.user.userId != PPUserIdNone) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"userId\":\"%li\"", (long)recipient.user.userId];
            appendComma = YES;
        }
    }
    if(recipient.userTag) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"userTag\":\"%@\"", recipient.userTag];
        appendComma = YES;
    }
    if(recipient.deviceTag) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"deviceTag\":\"%@\"", recipient.deviceTag];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)data:(PPInAppMessageRecipient *)recipient {
    NSMutableDictionary *data = @{}.mutableCopy;
    if(recipient.organization) {
        if(recipient.organization.organizationId != PPOrganizationIdNone) {
            data[@"organizationId"] = @(recipient.organization.organizationId);
        }
        if(recipient.organization.group) {
            if(recipient.organization.group.groupId != PPOrganizationGroupIdNone) {
                data[@"groupId"] = @(recipient.organization.group.groupId);
            }
        }
    }
    if(recipient.user) {
        if(recipient.user.userId != PPUserIdNone) {
            data[@"userId"] = @(recipient.user.userId);
        }
    }
    if(recipient.userTag) {
        data[@"userTag"] = recipient.userTag;
    }
    if(recipient.deviceTag) {
        data[@"deviceTag"] = recipient.deviceTag;
    }
    return data;
}

@end
