//
//  PPRuleComponentTrigger.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPRuleComponent.h"

@interface PPRuleComponentTrigger : PPRuleComponent

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(NSArray *)parameters serviceName:(NSString *)serviceName;

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponentTrigger *)ruleComponent;

- (void)sync:(PPRuleComponentTrigger *)ruleComponent;

@end
