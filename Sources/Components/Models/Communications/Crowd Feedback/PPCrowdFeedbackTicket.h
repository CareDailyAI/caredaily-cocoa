//
//  PPCrowdFeedbackTicket.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCrowdFeedback.h"

@interface PPCrowdFeedbackTicket : PPBaseModel

@property (nonatomic) PPCrowdFeedbackId feedbackId;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic) PPCrowdFeedbackTicketId ticketId;

- (id)initWithFeedbackId:(PPCrowdFeedbackId)feedbackId brand:(NSString *)brand ticketId:(PPCrowdFeedbackTicketId)ticketId;

+ (PPCrowdFeedbackTicket *)initWithDictionary:(NSDictionary *)ticketDict;

@end
