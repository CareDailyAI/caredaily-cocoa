//
//  PPRuleComponentAction.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPRuleComponent.h"

@interface PPRuleComponentAction : PPRuleComponent

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(RLMArray *)parameters serviceName:(NSString *)serviceName;

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentAction *)ruleComponent;

- (void)sync:(PPRuleComponentAction *)ruleComponent;

@end
