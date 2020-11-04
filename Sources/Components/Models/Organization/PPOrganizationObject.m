//
//  PPOrganizationObject.m
//  Peoplepower
//
//  Created by Destry Teeter on 10/19/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPOrganizationObject.h"

@implementation PPOrganizationObject

- (id)initWithName:(NSString *)name contentType:(NSString *)contentType value:(NSString *)value privateContent:(PPOrganizationObjectPrivateContent)privateContent parent:(PPOrganizationObjectParent)parent {
    self = [super init];
    if (self) {
        self.name = name;
        self.contentType = contentType;
        self.value = value;
        self.privateContent = privateContent;
        self.parent = parent;
    }
    return self;
}

+ (PPOrganizationObject *)initWithDictionary:(NSDictionary *)objectDict {
    NSString *name = [objectDict objectForKey:@"name"];
    NSString *contentType = [objectDict objectForKey:@"contentType"];
    NSString *value = [objectDict objectForKey:@"value"];
    PPOrganizationObjectPrivateContent privateContent = PPOrganizationObjectPrivateContentNone;
    if ([objectDict objectForKey:@"privateContent"]) {
        privateContent = ((NSNumber *)[objectDict objectForKey:@"privateContent"]).integerValue;
    }
    PPOrganizationObjectParent parent = PPOrganizationObjectParentNone;
    if ([objectDict objectForKey:@"parent"]) {
        parent = ((NSNumber *)[objectDict objectForKey:@"parent"]).integerValue;
    }
    
    return [[PPOrganizationObject alloc] initWithName:name
                                          contentType:contentType
                                                value:value
                                       privateContent:privateContent
                                               parent:parent];
}

@end
