//
//  PPCircle.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCircle.h"

@implementation PPCircle

- (id)initWithId:(PPCircleId)circleId name:(NSString *)name admin:(PPCircleAdmin)admin status:(PPCircleStatus)status memberStatus:(PPCircleMemberStatus)memberStatus creationDate:(NSDate *)creationDate monthlyDataIn:(PPCircleData)monthlyDataIn monthlyDataMax:(PPCircleData)monthlyDataMax members:(NSArray *)members {
    self = [super init];
    if(self) {
        self.circleId = circleId;
        self.name = name;
        self.admin = admin;
        self.status = status;
        self.memberStatus = memberStatus;
        self.creationDate = creationDate;
        self.monthlyDataIn = monthlyDataIn;
        self.monthlyDataMax = monthlyDataMax;
        self.members = members;
    }
    return self;
}

+ (PPCircle *)initWithDictionary:(NSDictionary *)circleDict {
    
    PPCircleId circleId = PPCircleIdNone;
    if([circleDict objectForKey:@"id"]) {
        circleId = (PPCircleId)((NSString *)[circleDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [circleDict objectForKey:@"name"];
    PPCircleAdmin admin = PPCircleAdminNone;
    if([circleDict objectForKey:@"admin"]) {
        admin = (PPCircleAdmin)((NSString *)[circleDict objectForKey:@"admin"]).integerValue;
    }
    PPCircleStatus status = PPCircleStatusNone;
    if([circleDict objectForKey:@"status"]) {
        status = (PPCircleStatus)((NSString *)[circleDict objectForKey:@"status"]).integerValue;
    }
    PPCircleMemberStatus memberStatus = PPCircleMemberStatusNone;
    if([circleDict objectForKey:@"memberStatus"]) {
        memberStatus = (PPCircleMemberStatus)((NSString *)[circleDict objectForKey:@"memberStatus"]).integerValue;
    }
    
    NSString *creationDateString = [circleDict objectForKey:@"creationDate"];
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    PPCircleData monthlyDataIn = PPCircleDataNone;
    if([circleDict objectForKey:@"monthlyDataIn"]) {
        monthlyDataIn = (PPCircleData)((NSString *)[circleDict objectForKey:@"monthlyDataIn"]).integerValue;
    }
    PPCircleData monthlyDataMax = PPCircleDataNone;
    if([circleDict objectForKey:@"monthlyDataMax"]) {
        monthlyDataMax = (PPCircleData)((NSString *)[circleDict objectForKey:@"monthlyDataMax"]).integerValue;
    }
    
    NSMutableArray *members;
    if([circleDict objectForKey:@"members"]) {
        members = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *memberDict in [circleDict objectForKey:@"members"]) {
            PPCircleMember *member = [PPCircleMember initWithDictionary:memberDict];
            [members addObject:member];
        }
    }
    
    PPCircle *circle = [[PPCircle alloc] initWithId:circleId name:name admin:admin status:status memberStatus:memberStatus creationDate:creationDate monthlyDataIn:monthlyDataIn monthlyDataMax:monthlyDataMax members:members];
    return circle;
}
@end
