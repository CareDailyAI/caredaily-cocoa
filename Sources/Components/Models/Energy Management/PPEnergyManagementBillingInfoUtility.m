//
//  PPEnergyManagementBillingInfoUtility.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPEnergyManagementBillingInfoUtility.h"

@implementation PPEnergyManagementBillingInfoUtility

- (id)initWithId:(PPEnergyManagementBillingInfoUtilityId)utilityId name:(NSString *)name {
    self = [super init];
    if(self) {
        self.utilityId = utilityId;
        self.name = name;
    }
    return self;
}

+ (PPEnergyManagementBillingInfoUtility *)initWithDictionary:(NSDictionary *)utilityDict {
    PPEnergyManagementBillingInfoUtilityId utilityId = PPEnergyManagementBillingInfoUtilityIdNone;
    if([utilityDict objectForKey:@"utilityId"]) {
        utilityId = (PPEnergyManagementBillingInfoUtilityId)((NSString *)[utilityDict objectForKey:@"utilityId"]).integerValue;
    }
    NSString *name = [utilityDict objectForKey:@"name"];
    
    PPEnergyManagementBillingInfoUtility *utility = [[PPEnergyManagementBillingInfoUtility alloc] initWithId:utilityId name:name];
    return utility;
}

+ (NSString *)stringify:(PPEnergyManagementBillingInfoUtility *)utility {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(utility.utilityId != PPEnergyManagementBillingInfoUtilityIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"utilityId\":\"%li\"", (long)utility.utilityId];
        appendComma = YES;
    }
    
    if(utility.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", utility.name];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end

