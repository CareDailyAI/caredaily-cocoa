//
//  PPDeviceTypeInstallationInstructions.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeInstallationInstructions.h"

@implementation PPDeviceTypeInstallationInstructions

- (id)initWithGoalId:(PPDeviceTypeGoalId)goalId installation:(NSString *)installation {
    self = [super init];
    if(self) {
        self.goalId = goalId;
        self.installation = installation;
    }
    return self;
}

@end
