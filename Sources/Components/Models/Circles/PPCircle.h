//
//  PPCircle.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCircleMember.h"

@interface PPCircle : PPBaseModel

@property (nonatomic) PPCircleId circleId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPCircleAdmin admin;
@property (nonatomic) PPCircleStatus status;
@property (nonatomic) PPCircleMemberStatus memberStatus;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic) PPCircleData monthlyDataIn;
@property (nonatomic) PPCircleData monthlyDataMax;
@property (nonatomic, strong) NSArray *members;

- (id)initWithId:(PPCircleId)circleId name:(NSString *)name admin:(PPCircleAdmin)admin status:(PPCircleStatus)status memberStatus:(PPCircleMemberStatus)memberStatus creationDate:(NSDate *)creationDate monthlyDataIn:(PPCircleData)monthlyDataIn monthlyDataMax:(PPCircleData)monthlyDataMax members:(NSArray *)members;

+ (PPCircle *)initWithDictionary:(NSDictionary *)circleDict;

@end
