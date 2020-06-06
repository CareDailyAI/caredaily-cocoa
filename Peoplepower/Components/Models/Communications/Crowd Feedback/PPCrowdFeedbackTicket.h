//
//  PPCrowdFeedbackTicket.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCrowdFeedback.h"

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackTicketId) {
    PPCrowdFeedbackTicketIdNone = -1
};

@interface PPCrowdFeedbackTicket : RLMObject

@property (nonatomic) PPCrowdFeedbackId feedbackId;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic) PPCrowdFeedbackTicketId ticketId;

- (id)initWithFeedbackId:(PPCrowdFeedbackId)feedbackId brand:(NSString *)brand ticketId:(PPCrowdFeedbackTicketId)ticketId;

+ (PPCrowdFeedbackTicket *)initWithDictionary:(NSDictionary *)ticketDict;

@end

RLM_ARRAY_TYPE(PPCrowdFeedbackTicket)
