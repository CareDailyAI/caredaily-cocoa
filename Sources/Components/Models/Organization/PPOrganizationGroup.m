//
//  PPOrganizationGroup.m
//  Peoplepower
//
//  Created by Destry Teeter on 10/10/17.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPOrganizationGroup.h"

@implementation PPOrganizationGroup

- (id)initWithName:(NSString *)name domainName:(NSString *)domainName groupId:(PPOrganizationGroupId)groupId orgId:(PPOrganizationGroupOrganizationId)orgId groupPoints:(PPOrganizationGroupPoints)groupPoints {
    self = [super init];
    if(self) {
        self.name = name;
        self.domainName = domainName;
        self.groupId = groupId;
        self.orgId = orgId;
        self.groupPoints = groupPoints;
    }
    return self;
}

+ (PPOrganizationGroup *)initWithDictionary:(NSDictionary *)groupDict {
    PPOrganizationGroupId groupId = PPOrganizationGroupIdNone;
    if([groupDict objectForKey:@"id"]) {
        groupId = (PPOrganizationGroupId)((NSString *)[groupDict objectForKey:@"id"]).integerValue;
    }
    else if([groupDict objectForKey:@"groupId"]) {
        groupId = (PPOrganizationGroupId)((NSString *)[groupDict objectForKey:@"groupId"]).integerValue;
    }
    PPOrganizationGroupOrganizationId orgId = PPOrganizationGroupOrganizationIdNone;
    if([groupDict objectForKey:@"organizationId"]) {
        orgId = (PPOrganizationGroupOrganizationId)((NSString *)[groupDict objectForKey:@"organizationId"]).integerValue;
    }
    NSString *name = [groupDict objectForKey:@"groupName"];
    if(!name) {
        name = [groupDict objectForKey:@"name"];
    }
    NSString *domainName = [groupDict objectForKey:@"domainName"];
    PPOrganizationGroupPoints groupPoints = PPOrganizationGroupPointsNone;
    if([groupDict objectForKey:@"groupPoints"]) {
        groupPoints = (PPOrganizationGroupPoints)((NSString *)[groupDict objectForKey:@"groupPoints"]).integerValue;
    }
    
    PPOrganizationGroup *orgGroup = [[PPOrganizationGroup alloc] initWithName:name domainName:domainName groupId:groupId orgId:orgId groupPoints:groupPoints];
    return orgGroup;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPOrganizationGroup *group = [[PPOrganizationGroup allocWithZone:zone] init];
    group.name = [self.name copyWithZone:zone];
    group.domainName = [self.domainName copyWithZone:zone];
    group.groupId = self.groupId;
    group.orgId = self.orgId;
    group.groupPoints = self.groupPoints;
    
    return group;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.domainName = [decoder decodeObjectForKey:@"domainName"];
        self.groupId = (PPOrganizationGroupId)((NSNumber *)[decoder decodeObjectForKey:@"groupId"]).integerValue;
        self.orgId = (PPOrganizationGroupOrganizationId)((NSNumber *)[decoder decodeObjectForKey:@"orgId"]).integerValue;
        self.groupPoints = (PPOrganizationGroupPoints)((NSNumber *)[decoder decodeObjectForKey:@"groupPoints"]).integerValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_domainName forKey:@"domainName"];
    [encoder encodeObject:@(_groupId) forKey:@"groupId"];
    [encoder encodeObject:@(_orgId) forKey:@"orgId"];
    [encoder encodeObject:@(_groupPoints) forKey:@"groupPoints"];
}

@end

