//
//  PPDeviceCommand.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/25/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceType.h"

typedef NS_OPTIONS(NSInteger, PPDeviceCommandId) {
    PPDeviceCommandIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandResult) {
    PPDeviceCommandResultNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandType) {
    PPDeviceCommandTypeNone = -1,
    PPDeviceCommandTypeSet = 0,
    PPDeviceCommandTypeDelete = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandTimeout) {
    PPDeviceCommandTimeoutNone = -1,
    PPDeviceCommandTimeoutDefault = 60
};

@interface PPDeviceCommand : RLMObject <NSCopying>

@property (nonatomic) PPDeviceCommandId commandId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic) PPDeviceTypeId typeId;
@property (nonatomic, strong) RLMArray<PPDeviceParameter *><PPDeviceParameter> *parameters;
@property (nonatomic) PPDeviceCommandType type;
@property (nonatomic) PPDeviceCommandResult result;
@property (nonatomic) PPDeviceCommandTimeout commandTimeout;
@property (nonatomic, strong) NSString *comment;

- (id)initWithCommandId:(PPDeviceCommandId)commandId deviceId:(NSString *)deviceId creationDate:(NSDate *)creationDate typeId:(PPDeviceTypeId)typeId parameters:(RLMArray *)parameters type:(PPDeviceCommandType)type result:(PPDeviceCommandResult)result commandTimeout:(PPDeviceCommandTimeout)commandTimeout comment:(NSString *)comment;

+ (PPDeviceCommand *)initWithDictionary:(NSDictionary *)commandDict;

@end

RLM_ARRAY_TYPE(PPDeviceCommand);
