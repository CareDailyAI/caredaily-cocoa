//
//  PPRuleComponentAction.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponentAction.h"

@implementation PPRuleComponentAction

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(NSArray *)parameters serviceName:(NSString *)serviceName {
    self = [super initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    return self;
}

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentAction *)ruleComponent {
    return [super isEqualToRuleComponent:ruleComponent];
}

- (void)sync:(PPRuleComponentAction *)ruleComponent {
    [super sync:ruleComponent];
}

@end
