//
//  PPRuleComponent.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPRuleComponent.h"
#import "PPRuleComponentTrigger.h"
#import "PPRuleComponentState.h"
#import "PPRuleComponentAction.h"

@implementation PPRuleComponent

- (id)initWithId:(PPRuleComponentId)componentId name:(NSString *)name displayType:(PPRuleComponentDisplayType)displayType desc:(NSString *)desc past:(NSString *)past timezone:(PPRuleComponentTimezone)timezone functionGroup:(NSString *)functionGroup parameters:(NSMutableArray *)parameters serviceName:(NSString *)serviceName {
    self = [super init];
    if(self) {
        self.componentId = componentId;
        self.name = name;
        self.displayType = displayType;
        self.desc = desc;
        self.past = past;
        self.timezone = timezone;
        self.functionGroup = functionGroup;
        self.parameters = parameters;
        self.serviceName = serviceName;
    }
    return self;
}

+ (NSObject *)initWithDictionary:(NSDictionary *)componentDict subclass:(NSString *)subclass {
    
    PPRuleComponentId componentId = PPRuleComponentIdNone;
    if([componentDict objectForKey:@"id"]) {
        componentId = (PPRuleComponentId)((NSString *)[componentDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [componentDict objectForKey:@"name"];
    PPRuleComponentDisplayType displayType = PPRuleComponentDisplayTypeNone;
    if([componentDict objectForKey:@"display"]) {
        displayType = (PPRuleComponentDisplayType)((NSString *)[componentDict objectForKey:@"display"]).integerValue;
    }
    NSString *desc = [componentDict objectForKey:@"desc"];
    NSString *past = [componentDict objectForKey:@"past"];
    PPRuleComponentTimezone timezone = PPRuleComponentTimezoneNone;
    if([componentDict objectForKey:@"timezone"]) {
        timezone = (PPRuleComponentTimezone)((NSString *)[componentDict objectForKey:@"timezone"]).integerValue;
    }
    NSString *functionGroup = [componentDict objectForKey:@"functionGroup"];
    NSMutableArray *parameters;
    if([componentDict objectForKey:@"parameters"]) {
        parameters = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *parameterDict in [componentDict objectForKey:@"parameters"]) {
            PPRuleComponentParameter *parameter = [PPRuleComponentParameter initWithDictionary:parameterDict];
            [parameters addObject:parameter];
        }
    }
    NSString *serviceName = [componentDict objectForKey:@"serviceName"];
    
    NSObject *component;
    if([subclass isEqualToString:NSStringFromClass([PPRuleComponentTrigger class])]) {
        component = [[PPRuleComponentTrigger alloc] initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    }
    else if([subclass isEqualToString:NSStringFromClass([PPRuleComponentState class])]) {
        component = [[PPRuleComponentState alloc] initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    }
    else if([subclass isEqualToString:NSStringFromClass([PPRuleComponentAction class])]) {
        component = [[PPRuleComponentAction alloc] initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    }
    else {
        component = [[PPRuleComponent alloc] initWithId:componentId name:name displayType:displayType desc:desc past:past timezone:timezone functionGroup:functionGroup parameters:parameters serviceName:serviceName];
    }
    
    return component;
}

+ (NSString *)stringify:(PPRuleComponent *)component {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if (component.componentId != PPRuleComponentIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":%li",(long)component.componentId];
        appendComma = YES;
    }
    
    if (component.parameters) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"parameter\": ["];
        
        BOOL appendParamComma = NO;
        for (PPRuleComponentParameter *parameter in component.parameters) {
            if(parameter.optional == PPRuleComponentParameterOptionalTrue) {
                continue;
            }
            if(appendParamComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"%@", [PPRuleComponentParameter stringify:parameter]];
            appendParamComma = YES;
        }
        [JSONString appendString:@"]"];
        
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPRuleComponent *)component {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if (component.componentId != PPRuleComponentIdNone) {
        data[@"id"] = @(component.componentId);
    }
    
    if (component.parameters) {
        NSMutableArray *parameters = @[].mutableCopy;
        
        for (PPRuleComponentParameter *parameter in component.parameters) {
            if(parameter.optional == PPRuleComponentParameterOptionalTrue) {
                continue;
            }
            [parameters addObject:[PPRuleComponentParameter data:parameter]];
        }

        data[@"parameter"] = parameters;
    }
    
    return data;
}

#pragma marker - Helper Methods

- (BOOL)isEqualToRuleComponent:(PPRuleComponent *)ruleComponent {
    BOOL equal = NO;
    
    if(ruleComponent.componentId != PPRuleComponentIdNone) {
        if(_componentId == ruleComponent.componentId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPRuleComponent *)ruleComponent {

    if(ruleComponent.componentId != PPRuleComponentIdNone) {
        _componentId = ruleComponent.componentId;
    }
    if(ruleComponent.name) {
        _name = ruleComponent.name;
    }
    if(ruleComponent.displayType != PPRuleComponentDisplayTypeNone) {
        _displayType = ruleComponent.displayType;
    }
    if(ruleComponent.desc) {
        _desc = ruleComponent.desc;
    }
    if(ruleComponent.past) {
        _past = ruleComponent.past;
    }
    if(ruleComponent.timezone != PPRuleComponentTimezoneNone) {
        _timezone = ruleComponent.timezone;
    }
    if(ruleComponent.functionGroup) {
        _functionGroup = ruleComponent.functionGroup;
    }
    if(ruleComponent.parameters) {
        for(PPRuleComponentParameter *newParameter in ruleComponent.parameters) {
            for(PPRuleComponentParameter *parameter in _parameters) {
                [parameter sync:newParameter];
            }
        }
    }
    if(ruleComponent.serviceName) {
        _serviceName = ruleComponent.serviceName;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPRuleComponent *ruleComponent = [[PPRuleComponent allocWithZone:zone] init];
    ruleComponent.componentId = self.componentId;
    ruleComponent.name = [self.name copyWithZone:zone];
    ruleComponent.displayType = self.displayType;
    ruleComponent.desc = [self.desc copyWithZone:zone];
    ruleComponent.past = [self.past copyWithZone:zone];
    ruleComponent.timezone = self.timezone;
    ruleComponent.functionGroup = [self.functionGroup copyWithZone:zone];
    ruleComponent.parameters = [self.parameters copyWithZone:zone];
    ruleComponent.serviceName = [self.serviceName copyWithZone:zone];
    
    return ruleComponent;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.componentId = (PPRuleComponentId)((NSNumber *)[decoder decodeObjectForKey:@"componentId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.displayType = (PPRuleComponentDisplayType)((NSNumber *)[decoder decodeObjectForKey:@"displayType"]).integerValue;
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.past = [decoder decodeObjectForKey:@"past"];
        self.timezone = (PPRuleComponentTimezone)((NSNumber *)[decoder decodeObjectForKey:@"timezone"]).integerValue;
        self.functionGroup = [decoder decodeObjectForKey:@"functionGroup"];
        self.parameters = [decoder decodeObjectForKey:@"parameters"];
        self.serviceName = [decoder decodeObjectForKey:@"serviceName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_componentId) forKey:@"componentId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_displayType) forKey:@"displayType"];
    [encoder encodeObject:_desc forKey:@"desc"];
    [encoder encodeObject:_past forKey:@"past"];
    [encoder encodeObject:@(_timezone) forKey:@"timezone"];
    [encoder encodeObject:_functionGroup forKey:@"functionGroup"];
    [encoder encodeObject:_parameters forKey:@"parameters"];
    [encoder encodeObject:_serviceName forKey:@"serviceName"];
 }

@end
