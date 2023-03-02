//
//  PPDeviceTypeInstallationInstructions.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeGoal.h"

@interface PPDeviceTypeInstallationInstructions : PPBaseModel

@property (nonatomic) PPDeviceTypeGoalId goalId;
@property (nonatomic, strong) NSString *installation;

- (id)initWithGoalId:(PPDeviceTypeGoalId)goalId installation:(NSString *)installation;

@end
