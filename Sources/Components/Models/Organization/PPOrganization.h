//
//  PPOrganization.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOrganizationGroup.h"

typedef NS_OPTIONS(NSInteger, PPOrganizationId) {
    PPOrganizationIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationStatus) {
    PPOrganizationStatusNone = -2,
    PPOrganizationStatusRejected = -1,
    PPOrganizationStatusApplied = 0,
    PPOrganizationStatusAccepted = 1,
};

typedef NS_OPTIONS(NSInteger, PPOrganizationPoints) {
    PPOrganizationPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationPointsLevel) {
    PPOrganizationPointsLevelNone = -1
};

@interface PPOrganization : RLMObject <NSCopying>

@property (nonatomic) PPOrganizationId organizationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *domainName;
@property (nonatomic) PPOrganizationStatus organizationStatus;
@property (nonatomic, strong) NSDate *approvedDate;
@property (nonatomic, strong) PPOrganizationGroup *group;
@property (nonatomic) PPOrganizationPoints points;
@property (nonatomic) PPOrganizationPointsLevel pointsLevel;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *termsOfService;
@property (nonatomic, strong) NSString *features;

/**
 * Initialize user organization
 * Created when organization information is returned from the GET userInfo API
 */
- (id) initWithOrganization:(PPOrganizationId)organizationId name:(NSString *)name domainName:(NSString *)domainName organizationStatus:(PPOrganizationStatus)organizationStatus approvedDate:(NSDate *)approvedDate group:(PPOrganizationGroup *)group points:(PPOrganizationPoints)points pointsLevel:(PPOrganizationPointsLevel)pointsLevel notes:(NSString *)notes termsOfService:(NSString *)termsOfService features:(NSString *)features;

+ (PPOrganization *)initWithDictionary:(NSDictionary *)organizationDict;


@end

RLM_ARRAY_TYPE(PPOrganization)
