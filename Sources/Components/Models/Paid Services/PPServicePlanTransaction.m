//
//  PPServicePlanTransaction.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPServicePlanTransaction.h"

@implementation PPServicePlanTransaction

- (id)initWithId:(NSString *)transactionId gatewayId:(NSString *)gatewayId status:(PPServicePlanStatus)status issueDate:(NSDate *)issueDate startDate:(NSDate *)startDate endDate:(NSDate *)endDate amount:(float)amount {
    self = [super init];
    if(self) {
        self.transactionId = transactionId;
        self.gatewayId = gatewayId;
        self.status = status;
        self.issueDate = issueDate;
        self.startDate = startDate;
        self.endDate = endDate;
        self.amount = amount;
    }
    return self;
}

+ (PPServicePlanTransaction *)initWithDictionary:(NSDictionary *)transactionDict {
    
    NSString *transactionId = [transactionDict objectForKey:@"transactionId"];
    NSString *gatewayId = [transactionDict objectForKey:@"gatewayId"];
    PPServicePlanStatus status = PPServicePlanStatusNone;
    if([transactionDict objectForKey:@"status"]) {
        status = (PPServicePlanStatus)((NSString *)[transactionDict objectForKey:@"status"]).integerValue;
    }
    
    NSString *issueDateString = [transactionDict objectForKey:@"issueDate"];
    NSDate *issueDate = [NSDate date];
    if(issueDateString != nil) {
        if(![issueDateString isEqualToString:@""]) {
            issueDate = [PPNSDate parseDateTime:issueDateString];
        }
    }
    
    NSString *startDateString = [transactionDict objectForKey:@"startDate"];
    NSDate *startDate = [NSDate date];
    if(startDateString != nil) {
        if(![startDateString isEqualToString:@""]) {
            startDate = [PPNSDate parseDateTime:startDateString];
        }
    }
    
    NSString *endDateString = [transactionDict objectForKey:@"endDate"];
    NSDate *endDate = [NSDate date];
    if(endDateString != nil) {
        if(![endDateString isEqualToString:@""]) {
            endDate = [PPNSDate parseDateTime:endDateString];
        }
    }
    
    float amount = (float)((NSString *)[transactionDict objectForKey:@"amount"]).floatValue;
    
    PPServicePlanTransaction *planTransaction = [[PPServicePlanTransaction alloc] initWithId:transactionId gatewayId:gatewayId status:status issueDate:issueDate startDate:startDate endDate:endDate amount:amount];
    return planTransaction;
}
@end
