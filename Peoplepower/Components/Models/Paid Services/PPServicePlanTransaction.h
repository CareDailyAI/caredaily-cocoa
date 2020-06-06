//
//  PPServicePlanTransaction.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPServicePlan.h"

@interface PPServicePlanTransaction : RLMObject

@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, strong) NSString *gatewayId;
@property (nonatomic) PPServicePlanStatus status;
@property (nonatomic, strong) NSDate *issueDate;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic) float amount;

- (id)initWithId:(NSString *)transactionId gatewayId:(NSString *)gatewayId status:(PPServicePlanStatus)status issueDate:(NSDate *)issueDate startDate:(NSDate *)startDate endDate:(NSDate *)endDate amount:(float)amount;

+ (PPServicePlanTransaction *)initWithDictionary:(NSDictionary *)transactionDict;

@end

RLM_ARRAY_TYPE(PPServicePlanTransaction);
