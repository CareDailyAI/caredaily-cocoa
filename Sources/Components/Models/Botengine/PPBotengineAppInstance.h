//
//  PPBotengineAppInstance.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineApp.h"

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceId) {
    PPBotengineAppInstanceIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceStatus) {
    PPBotengineAppInstanceStatusUndefined = -1,
    PPBotengineAppInstanceStatusIncomplete = 0,
    PPBotengineAppInstanceStatusActive     = 1,
    PPBotengineAppInstanceStatusInactive   = 2
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceDataStreamBitmask) {
    PPBotengineAppInstanceDataStreamBitmaskUndefined      = 0,
    PPBotengineAppInstanceDataStreamBitmaskInvdividual    = 1 << 0,
    PPBotengineAppInstanceDataStreamBitmaskOrganizational = 1 << 1,
    PPBotengineAppInstanceDataStreamBitmaskCircle         = 1 << 2
};

@interface PPBotengineAppInstance : PPBotengineApp

@property (nonatomic) NSInteger instanceId;
@property (nonatomic) PPBotengineAppInstanceStatus instanceStatus;
@property (nonatomic, strong) NSDate *purchaseDate;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *timezone;

+ (PPBotengineAppInstance *)appInstanceFromAppInstanceDict:(NSDictionary *)appInstanceDict;

- (id)initWithInstanceId:(NSInteger)instanceId instanceStatus:(PPBotengineAppInstanceStatus)instanceStatus purchaseDate:(NSDate *)purchaseDate nickname:(NSString *)nickname timezone:(NSString *)timezone app:(PPBotengineApp *)app;

- (void)setNickname:(NSString *)nickname callback:(PPErrorBlock)callback;
- (void)setInstanceStatus:(PPBotengineAppInstanceStatus)instanceStatus callback:(PPErrorBlock)callback;
- (void)setTimezone:(NSString *)timezone callback:(PPErrorBlock)callback;
- (void)setAccess:(NSArray *)access callback:(PPErrorBlock)callback;
- (void)setCommunications:(NSArray *)communications callback:(PPErrorBlock)callback;
- (void)postDataStreamWithBitmask:(PPBotengineAppInstanceDataStreamBitmask)dataStreamType address:(NSString *)address feed:(NSDictionary *)feed callback:(PPErrorBlock)callback;

@end
