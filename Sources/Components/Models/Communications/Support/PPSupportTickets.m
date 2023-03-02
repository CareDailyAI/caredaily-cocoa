//
//  PPSupportTickets.m
//  Peoplepower iOS
//
//  Created by Destry Teeter on 4/26/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPSupportTickets.h"

@implementation PPSupportTickets

#pragma mark - Support Ticket

/**
 * Support Ticket
 * Create a support ticket.
 *
 * @param supportTicket PPSupportTicket Required Support ticket
 * @param userId PPUserId Request support for this user by an administrator
 * @param callback PPErrorBlock Error callback block
 */
+ (void)postSupportTicket:(PPSupportTicket * _Nonnull )supportTicket userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"ticket"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    data[@"type"] = @(supportTicket.type);
    data[@"priority"] = @(supportTicket.priority);
    data[@"subject"] = supportTicket.subject;
    data[@"comment"] = supportTicket.comment;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.supportTicket.postSupportTicket()", DISPATCH_QUEUE_SERIAL);
    
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
