//
//  PPDeviceCommand.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/25/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceCommand.h"
#import "PPDeviceParameter.h"

@implementation PPDeviceCommand

+ (NSString *)primaryKey {
    return @"commandId";
}

- (id)initWithCommandId:(PPDeviceCommandId)commandId deviceId:(NSString *)deviceId creationDate:(NSDate *)creationDate typeId:(PPDeviceTypeId)typeId parameters:(NSArray *)parameters type:(PPDeviceCommandType)type result:(PPDeviceCommandResult)result commandTimeout:(PPDeviceCommandTimeout)commandTimeout comment:(NSString *)comment {
    self = [super init];
    if(self) {
        self.commandId = commandId;
        self.deviceId = deviceId;
        self.creationDate = creationDate;
        self.typeId = typeId;
        self.parameters = (RLMArray<PPDeviceParameter *><PPDeviceParameter> *)parameters;
        self.type = type;
        self.result = result;
        self.commandTimeout = commandTimeout;
        self.comment = comment;
    }
    return self;
}

+ (PPDeviceCommand *)initWithDictionary:(NSDictionary *)commandDict {
    PPDeviceCommandId commandId = PPDeviceCommandIdNone;
    if([commandDict objectForKey:@"commandId"]) {
        commandId = (PPDeviceCommandId)((NSString *)[commandDict objectForKey:@"commandId"]).integerValue;
    }
    NSDate *creationDate = [NSDate date];
    
    NSTimeInterval creationDateTimeInteval = -1;
    
    if([commandDict objectForKey:@"creationTime"]) {
        creationDateTimeInteval = (NSTimeInterval)((NSString *)[commandDict objectForKey:@"creationTime"]).integerValue;
    }
    if(creationDateTimeInteval != -1) {
        creationDate = [NSDate dateWithTimeIntervalSince1970:creationDateTimeInteval];
    }
    
    NSString *deviceId = [commandDict objectForKey:@"deviceId"];
    
    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
    if([commandDict objectForKey:@"deviceType"]) {
        typeId = (PPDeviceTypeId)((NSString *)[commandDict objectForKey:@"deviceType"]).integerValue;
    }
    
    NSMutableArray *parameters;
    if([commandDict objectForKey:@"parameters"]) {
        parameters = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *paramDict in [commandDict objectForKey:@"parameters"]) {
            PPDeviceParameter *parameter = [PPDeviceParameter initWithDictionary:paramDict];
            [parameters addObject:parameter];
        }
    }
    
    PPDeviceCommandType type = PPDeviceCommandTypeNone;
    if([commandDict objectForKey:@"type"]) {
        type = (PPDeviceCommandType)((NSString *)[commandDict objectForKey:@"type"]).integerValue;
    }
    
    PPDeviceCommandResult result = PPDeviceCommandResultNone;
    if([commandDict objectForKey:@"result"]) {
        result = (PPDeviceCommandResult)((NSString *)[commandDict objectForKey:@"result"]).integerValue;
    }
    
    PPDeviceCommandTimeout commandTimeout = PPDeviceCommandTimeoutNone;
    if([commandDict objectForKey:@"commandTimeout"]) {
        commandTimeout = (PPDeviceCommandTimeout)((NSString *)[commandDict objectForKey:@"commandTimeout"]).integerValue;
    }
    
    NSString *comment = [commandDict objectForKey:@"comment"];
    
    
    PPDeviceCommand *command = [[PPDeviceCommand alloc] initWithCommandId:commandId deviceId:deviceId creationDate:creationDate typeId:typeId parameters:(RLMArray<PPDeviceParameter *><PPDeviceParameter> *)parameters type:type result:result commandTimeout:commandTimeout comment:comment];
    return command;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPDeviceCommand *command = [[[self class] allocWithZone:zone] init];
    
    command.commandId = self.commandId;
    command.deviceId = [self.deviceId copyWithZone:zone];
    command.creationDate = [self.creationDate copyWithZone:zone];
    command.typeId = self.typeId;
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:self.parameters.count];
    for (PPDeviceParameter *parameter in self.parameters) {
        [parameters addObject:[parameter copyWithZone:zone]];
    }
    command.parameters = parameters;
    command.type = self.type;
    command.result = self.result;
    command.commandTimeout = self.commandTimeout;
    command.comment = [self.comment copyWithZone:zone];
    
    return command;
}


@end
