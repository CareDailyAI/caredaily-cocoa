//
//  PPCircle.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCircleMember.h"

typedef NS_OPTIONS(NSInteger, PPCircleId) {
    PPCircleIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCircleAdmin) {
    PPCircleAdminNone = -1,
    PPCircleAdminFalse = 0,
    PPCircleAdminTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPCircleStatus) {
    PPCircleStatusNone = -1,
    PPCircleStatusFreeCircle = 1,
    PPCircleStatusPremiumCircle = 2
};

typedef NS_OPTIONS(long long, PPCircleData) {
    PPCircleDataNone = 0,
};

@interface PPCircle : PPBaseModel

@property (nonatomic) PPCircleId circleId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPCircleAdmin admin;
@property (nonatomic) PPCircleStatus status;
@property (nonatomic) PPCircleMemberStatus memberStatus;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic) PPCircleData monthlyDataIn;
@property (nonatomic) PPCircleData monthlyDataMax;
@property (nonatomic, strong) RLMArray<PPCircleMember *><PPCircleMember> *members;
@property (readonly) RLMLinkingObjects *posts;

- (id)initWithId:(PPCircleId)circleId name:(NSString *)name admin:(PPCircleAdmin)admin status:(PPCircleStatus)status memberStatus:(PPCircleMemberStatus)memberStatus creationDate:(NSDate *)creationDate monthlyDataIn:(PPCircleData)monthlyDataIn monthlyDataMax:(PPCircleData)monthlyDataMax members:(RLMArray *)members;

+ (PPCircle *)initWithDictionary:(NSDictionary *)circleDict;

@end

