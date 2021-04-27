//
//  PPSupportTicket.m
//  Peoplepower iOS
//
//  Created by Destry Teeter on 4/26/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPSupportTicket.h"

@implementation PPSupportTicket

- (id)initWithType:(PPSupportTicketType)type
          priority:(PPSupportTicketPriority)priority
           subject:(NSString *)subject
           comment:(NSString *)comment {
    self = [super init];
    if (self) {
        self.type = type;
        self.priority = priority;
        self.subject = subject;
        self.comment = comment;
    }
    return self;
}

+ (PPSupportTicket *)initWithDictionary:(NSDictionary *)supportDict {
    PPSupportTicketType type = PPSupportTicketTypeProblem;
    if ([supportDict objectForKey:@"type"]) {
        type = ((NSNumber *)[supportDict objectForKey:@"type"]).integerValue;
    }
    PPSupportTicketPriority priority = PPSupportTicketPriorityLow;
    if ([supportDict objectForKey:@"priority"]) {
        priority = ((NSNumber *)[supportDict objectForKey:@"priority"]).integerValue;
    }
    NSString *subject = [supportDict objectForKey:@"subject"];
    NSString *comment = [supportDict objectForKey:@"comment"];
    
    return [[PPSupportTicket alloc] initWithType:type
                                        priority:priority
                                         subject:subject
                                         comment:comment];
}

@end
