//
//  PPRuleComponentTrigger.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPRuleComponentTrigger.h"

@implementation PPRuleComponentTrigger

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(RLMArray *)parameters serviceName:(NSString *)serviceName {
    self = [super initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    return self;
}


#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentTrigger *)ruleComponent {
    return [super isEqualToRuleComponent:ruleComponent];
}

- (void)sync:(PPRuleComponent *)ruleComponent {
    [super sync:ruleComponent];
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleComponentTrigger *ruleComponent = [[PPRuleComponentTrigger allocWithZone:zone] init];
    ruleComponent.componentId = self.componentId;
    ruleComponent.name = [self.name copyWithZone:zone];
    ruleComponent.displayType = self.displayType;
    ruleComponent.desc = [self.desc copyWithZone:zone];
    ruleComponent.past = [self.past copyWithZone:zone];
    ruleComponent.timezone = self.timezone;
    ruleComponent.functionGroup = [self.functionGroup copyWithZone:zone];
    NSMutableArray *parameters = [[NSMutableArray alloc] initWithCapacity:self.parameters.count];
    for (PPRuleComponentParameter *parameter in self.parameters) {
        [parameters addObject:[parameter copyWithZone:zone]];
    }
    ruleComponent.parameters = parameters;
    ruleComponent.serviceName = [self.serviceName copyWithZone:zone];
    
    return ruleComponent;
}

@end
