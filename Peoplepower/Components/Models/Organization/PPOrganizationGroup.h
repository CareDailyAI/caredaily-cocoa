//
//  PPOrganizationGroup.h
//  Peoplepower
//
//  Created by Destry Teeter on 10/10/17.
//  Copyright © 2017 People Power. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupId) {
    PPOrganizationGroupIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupOrganizationId) {
    PPOrganizationGroupOrganizationIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupPoints) {
    PPOrganizationGroupPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupType) {
    PPOrganizationGroupTypeNone = -1,
    PPOrganizationGroupTypeResidential = 0,
    PPOrganizationGroupTypeBusiness = 1,
};

@interface PPOrganizationGroup : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *domainName;
@property (nonatomic) PPOrganizationGroupId groupId;
@property (nonatomic) PPOrganizationGroupPoints groupPoints;
@property (nonatomic) PPOrganizationGroupOrganizationId orgId;

- (id) initWithName:(NSString *)name domainName:(NSString *)domainName groupId:(PPOrganizationGroupId)groupId orgId:(PPOrganizationGroupOrganizationId)orgId groupPoints:(PPOrganizationGroupPoints)groupPoints;

+ (PPOrganizationGroup *)initWithDictionary:(NSDictionary *)groupDict;

@end
