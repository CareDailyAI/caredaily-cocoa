//
//  PPOrganizationGroup.h
//  Peoplepower
//
//  Created by Destry Teeter on 10/10/17.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPOrganizationGroup : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *domainName;
@property (nonatomic) PPOrganizationGroupId groupId;
@property (nonatomic) PPOrganizationGroupPoints groupPoints;
@property (nonatomic) PPOrganizationGroupOrganizationId orgId;

- (id) initWithName:(NSString *)name domainName:(NSString *)domainName groupId:(PPOrganizationGroupId)groupId orgId:(PPOrganizationGroupOrganizationId)orgId groupPoints:(PPOrganizationGroupPoints)groupPoints;

+ (PPOrganizationGroup *)initWithDictionary:(NSDictionary *)groupDict;

@end

