//
//  PPBotengineAppInstance.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBotengineApp.h"

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
- (void)postDataStreamWithBitmask:(PPBotengineAppInstanceDataStreamBitmask)dataStreamType locationId:(PPLocationId)locationId address:(NSString *)address feed:(NSDictionary *)feed callback:(PPErrorBlock)callback;
- (void)postDataStreamWithBitmask:(PPBotengineAppInstanceDataStreamBitmask)dataStreamType address:(NSString *)address feed:(NSDictionary *)feed callback:(PPErrorBlock)callback __attribute__((deprecated));

@end
