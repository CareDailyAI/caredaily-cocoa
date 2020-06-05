//
//  PPCrowdFeedbackTicket.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCrowdFeedbackTicket.h"

@implementation PPCrowdFeedbackTicket

- (id)initWithFeedbackId:(PPCrowdFeedbackId)feedbackId brand:(NSString *)brand ticketId:(PPCrowdFeedbackTicketId)ticketId {
    self = [super init];
    if(self) {
        self.feedbackId = feedbackId;
        self.brand = brand;
        self.ticketId = ticketId;
    }
    return self;
}

+ (PPCrowdFeedbackTicket *)initWithDictionary:(NSDictionary *)ticketDict {
    PPCrowdFeedbackId feedbackId = PPCrowdFeedbackIdNone;
    if([ticketDict objectForKey:@"id"]) {
        feedbackId = (PPCrowdFeedbackId)((NSString *)[ticketDict objectForKey:@"id"]).integerValue;
    }
    NSString *brand = [ticketDict objectForKey:@"brand"];
    PPCrowdFeedbackTicketId ticketId = PPCrowdFeedbackTicketIdNone;
    if([ticketDict objectForKey:@"ticketId"]) {
        ticketId = (PPCrowdFeedbackTicketId)((NSString *)[ticketDict objectForKey:@"ticketId"]).integerValue;
    }
    
    PPCrowdFeedbackTicket *ticket = [[PPCrowdFeedbackTicket alloc] initWithFeedbackId:feedbackId brand:brand ticketId:ticketId];
    return ticket;
}

@end
