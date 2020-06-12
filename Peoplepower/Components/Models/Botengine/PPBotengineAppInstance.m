//
//  PPBotengineAppInstance.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppInstance.h"
#import "PPBotengine.h"

@implementation PPBotengineAppInstance

+ (PPBotengineAppInstance *)appInstanceFromAppInstanceDict:(NSDictionary *)appInstanceDict {
    PPBotengineApp *composerApp = [PPBotengineApp appFromAppDict:appInstanceDict];
    
    NSInteger instanceId = ((NSString *)[appInstanceDict objectForKey:@"appInstanceId"]).integerValue;
    PPBotengineAppInstanceStatus instanceStatus = ((NSString *)[appInstanceDict objectForKey:@"status"]).intValue;

    NSString *purchaseDateString = [appInstanceDict objectForKey:@"purchaseDate"];
    NSDate *purchaseDate = [NSDate date];
    if(purchaseDateString != nil) {
        if([purchaseDateString isKindOfClass:[NSString class]]) {
            if(![purchaseDateString isEqualToString:@""]) {
                purchaseDate = [PPNSDate parseDateTime:purchaseDateString];
            }
        }
        else {
            purchaseDate = [NSDate dateWithTimeIntervalSince1970:(purchaseDateString.floatValue/1000.0)];
        }
    }
    
    NSString *nickname = [appInstanceDict objectForKey:@"nickname"];
    NSString *timezone = [appInstanceDict objectForKey:@"timezone"];
    return [[PPBotengineAppInstance alloc] initWithInstanceId:instanceId instanceStatus:instanceStatus purchaseDate:purchaseDate nickname:nickname timezone:timezone app:composerApp];
}

- (id)initWithInstanceId:(NSInteger)instanceId instanceStatus:(PPBotengineAppInstanceStatus)instanceStatus purchaseDate:(NSDate *)purchaseDate nickname:(NSString *)nickname timezone:(NSString *)timezone app:(PPBotengineApp *)app {
    self = [super initWithBundle:app.bundle category:app.category marketing:app.marketing rating:app.rating compatible:app.compatible instanceSummary:app.instanceSummary versions:app.versions trigger:app.trigger schedule:app.schedule events:app.events deviceTypes:app.deviceTypes access:app.access communications:app.communications];
    if(self) {
        self.instanceId = instanceId;
        self.instanceStatus = instanceStatus;
        self.purchaseDate = purchaseDate;
        self.nickname = nickname;
        self.timezone = timezone;
    }
    
    return self;
}

- (void)setNickname:(NSString *)nickname callback:(PPErrorBlock)callback {
    if([self.nickname isEqualToString:nickname]) {
        callback(nil);
        return;
    }
    
    [PPBotengine configureAppInstance:self.instanceId status:PPBotengineAppInstanceStatusUndefined nickname:nickname timezone:nil access:nil communications:nil callback:^(NSError *error) {
        if(error) {
            callback(error);
            return;
        }
        
        self.nickname = nickname;
        callback(nil);
    }];
}

- (void)setInstanceStatus:(PPBotengineAppInstanceStatus)instanceStatus callback:(PPErrorBlock)callback {
    if(self.instanceStatus == instanceStatus) {
        callback(nil);
        return;
    }
    
    [PPBotengine configureAppInstance:self.instanceId status:instanceStatus nickname:nil timezone:nil access:nil communications:nil callback:^(NSError *error) {
        if(error) {
            callback(error);
            return;
        }
        
        self.instanceStatus = instanceStatus;
        callback(nil);
    }];
}

- (void)setTimezone:(NSString *)timezone callback:(PPErrorBlock)callback {
    if([self.timezone isEqualToString:timezone]) {
        callback(nil);
        return;
    }
    
    [PPBotengine configureAppInstance:self.instanceId status:PPBotengineAppInstanceStatusUndefined nickname:nil timezone:timezone access:nil communications:nil callback:^(NSError *error) {
        if(error) {
            callback(error);
            return;
        }
        
        self.timezone = timezone;
        callback(nil);
    }];
}

- (void)setAccess:(NSArray *)access callback:(PPErrorBlock)callback {
    [PPBotengine configureAppInstance:self.instanceId status:PPBotengineAppInstanceStatusUndefined nickname:nil timezone:nil access:access communications:nil callback:^(NSError *error) {
        if(error) {
            callback(error);
            return;
        }
        
        for(PPBotengineAppAccess *newAccess in access) {
            for(PPBotengineAppAccess *oldAccess in self.access) {
                if([oldAccess.deviceId isEqualToString:newAccess.deviceId]) {
                    oldAccess.excluded = newAccess.excluded;
                    break;
                }
            }
        }
        
        callback(nil);
    }];
}

- (void)setCommunications:(NSArray *)communications callback:(PPErrorBlock)callback {
    NSMutableArray *communicationsArray = [[NSMutableArray alloc] init];
    
    BOOL matched = YES;
    if([self.communications count] > 0) {
        matched = NO;
        for(PPBotengineAppCommunications *x in self.communications) {
            
            BOOL found = NO;
            for(PPBotengineAppCommunications *y in communications) {
                if(!found && x.category == y.category) {
                    found = YES;
                }
                
                if(found) {
                    matched = YES;
                    [communicationsArray addObject:[[PPBotengineAppCommunications alloc] initWithCategory:y.category email:y.email push:y.push sms:y.sms msg:y.msg]];
                    break;
                }
            }
            if(!found) {
                [communicationsArray addObject:x];
            }
        }
    }
    
    if(!matched) {
        callback([PPBaseModel resultCodeToNSError:8 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Failed to update app instance communications with array: %@", communications]]);
        return;
    }
    
    if([communicationsArray count] == 0) {
        communicationsArray = [NSMutableArray arrayWithArray:communications];
    }

    [PPBotengine configureAppInstance:self.instanceId status:PPBotengineAppInstanceStatusUndefined nickname:nil timezone:nil access:nil communications:communicationsArray callback:^(NSError *error) {
        if(error) {
            callback(error);
            return;
        }
        
        self.communications = communicationsArray;
        callback(nil);
    }];
}

- (void)postDataStreamWithBitmask:(PPBotengineAppInstanceDataStreamBitmask)dataStreamType address:(NSString *)address feed:(NSDictionary *)feed callback:(PPErrorBlock)callback {
    [PPBotengine postDataStream:dataStreamType address:address locationId:[[PPUserAccounts currentUser] currentLocation].locationId organizationId:PPOrganizationIdNone feed:feed appInstanceId:_instanceId callback:callback];
}

@end
