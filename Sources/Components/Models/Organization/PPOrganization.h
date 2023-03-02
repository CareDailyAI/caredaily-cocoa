//
//  PPOrganization.h
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOrganizationGroup.h"
#import "PPState.h"
#import "PPCountry.h"

@interface PPOrganization : PPBaseModel <NSCopying>

@property (nonatomic) PPOrganizationId organizationId;
@property (nonatomic) PPOrganizationId parentId;
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
@property (nonatomic, strong) NSString *contactName1;
@property (nonatomic, strong) NSString *contactEmail1;
@property (nonatomic, strong) NSString *contactPhone1;
@property (nonatomic, strong) NSString *contactName2;
@property (nonatomic, strong) NSString *contactEmail2;
@property (nonatomic, strong) NSString *contactPhone2;
@property (nonatomic, strong) NSString *officePhone;

@property (nonatomic, strong) NSString *addrStreet1;
@property (nonatomic, strong) NSString *addrStreet2;
@property (nonatomic, strong) NSString *addrCity;
@property (nonatomic, strong) PPState *state;
@property (nonatomic, strong) PPCountry *country;
@property (nonatomic, strong) NSString *zip;

/**
 * Initialize user organization
 * Created when organization information is returned from the GET userInfo API
 */
- (id) initWithOrganization:(PPOrganizationId)organizationId
                   parentId:(PPOrganizationId)parentId
                       name:(NSString *)name
                 domainName:(NSString *)domainName
         organizationStatus:(PPOrganizationStatus)organizationStatus
               approvedDate:(NSDate *)approvedDate
                      group:(PPOrganizationGroup *)group
                     points:(PPOrganizationPoints)points
                pointsLevel:(PPOrganizationPointsLevel)pointsLevel
                      notes:(NSString *)notes
             termsOfService:(NSString *)termsOfService
                   features:(NSString *)features
               contactName1:(NSString *)contactName1
              contactEmail1:(NSString *)contactEmail1
              contactPhone1:(NSString *)contactPhone1
               contactName2:(NSString *)contactName2
              contactEmail2:(NSString *)contactEmail2
              contactPhone2:(NSString *)contactPhone2
                officePhone:(NSString *)officePhone
                addrStreet1:(NSString *)addrStreet1
                addrStreet2:(NSString *)addrStreet2
                   addrCity:(NSString *)addrCity
                      state:(PPState *)state
                    country:(PPCountry *)country
                        zip:(NSString *)zip;

+ (PPOrganization *)initWithDictionary:(NSDictionary *)organizationDict;


@end
