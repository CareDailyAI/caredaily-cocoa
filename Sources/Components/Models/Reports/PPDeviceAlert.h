//
//  PPDeviceAlert.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/17/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceAlert : PPBaseModel

@property (nonatomic, strong) NSString *alertType;
@property (nonatomic) PPDeviceAlertCount count;

- (id)initWithType:(NSString *)alertType count:(PPDeviceAlertCount)count;

+ (PPDeviceAlert *)initWithDictionary:(NSDictionary *)alertDict;

@end
