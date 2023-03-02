//
//  PPOrganization.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPOrganization.h"
#import "PPOrganizationGroup.h"
#import "PPCloudEngine.h"

@implementation PPOrganization

- (id)initWithOrganization:(PPOrganizationId)organizationId
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
                       zip:(NSString *)zip {
    self = [super init];
    if(self) {
        self.organizationId = organizationId;
        self.parentId = parentId;
        self.name = name;
        self.domainName = domainName;
        self.organizationStatus = organizationStatus;
        self.approvedDate = approvedDate;
        self.group = group;
        self.points = points;
        self.pointsLevel = pointsLevel;
        self.notes = notes;
        self.termsOfService = termsOfService;
        self.features = features;
        self.contactName1 = contactName1;
        self.contactEmail1 = contactEmail1;
        self.contactPhone1 = contactPhone1;
        self.contactName2 = contactName2;
        self.contactEmail2 = contactEmail2;
        self.contactPhone2 = contactPhone2;
        self.officePhone = officePhone;
        self.addrStreet1 = addrStreet1;
        self.addrStreet2 = addrStreet2;
        self.addrCity = addrCity;
        self.state = state;
        self.country = country;
        self.zip = zip;
    }
    return self;
}

+ (PPOrganization *)initWithDictionary:(NSDictionary *)organizationDict {
    NSString *name = [organizationDict objectForKey:@"organizationName"];
    if(!name) {
        name = [organizationDict objectForKey:@"name"];
    }
    NSString *domainName = [organizationDict objectForKey:@"domainName"];
    
    PPOrganizationId organizationId = PPOrganizationIdNone;
    if([organizationDict objectForKey:@"organizationId"]) {
        organizationId = (PPOrganizationId)((NSString *)[organizationDict objectForKey:@"organizationId"]).integerValue;
    }
    else if([organizationDict objectForKey:@"id"]) {
        organizationId = (PPOrganizationId)((NSString *)[organizationDict objectForKey:@"id"]).integerValue;
    }
    PPOrganizationStatus organizationStatus = PPOrganizationStatusNone;
    if([organizationDict objectForKey:@"organizationStatus"]) {
        organizationStatus = (PPOrganizationStatus)((NSString *)[organizationDict objectForKey:@"organizationStatus"]).integerValue;
    }
    PPOrganizationId parentId = PPOrganizationIdNone;
    if([organizationDict objectForKey:@"parentId"]) {
        parentId = (PPOrganizationId)((NSString *)[organizationDict objectForKey:@"parentId"]).integerValue;
    }
    NSString *approvedDateString = [organizationDict objectForKey:@"approvedDate"];
    NSDate *approvedDate = [NSDate date];
    if(approvedDateString != nil) {
        if(![approvedDateString isEqualToString:@""]) {
            approvedDate = [PPNSDate parseDateTime:approvedDateString];
        }
    }
    
    PPOrganizationGroup *group = [PPOrganizationGroup initWithDictionary:organizationDict];
    PPOrganizationPoints points = PPOrganizationPointsNone;
    if([organizationDict objectForKey:@"points"]) {
        points = (PPOrganizationPoints)((NSString *)[organizationDict objectForKey:@"points"]).integerValue;
    }
    PPOrganizationPointsLevel pointsLevel = PPOrganizationPointsLevelNone;
    if([organizationDict objectForKey:@"pointsLevel"]) {
        pointsLevel = (PPOrganizationPointsLevel)((NSString *)[organizationDict objectForKey:@"pointsLevel"]).integerValue;
    }
    
    NSString *notes = [organizationDict objectForKey:@"notes"];
    NSString *termsOfService = [organizationDict objectForKey:@"termsOfService"];
    NSString *features = [organizationDict objectForKey:@"features"];
    
    NSString *contactName1 = [organizationDict objectForKey:@"contactName1"];
    NSString *contactEmail1 = [organizationDict objectForKey:@"contactEmail1"];
    NSString *contactPhone1 = [organizationDict objectForKey:@"contactPhone1"];
    NSString *contactName2 = [organizationDict objectForKey:@"contactName2"];
    NSString *contactEmail2 = [organizationDict objectForKey:@"contactEmail2"];
    NSString *contactPhone2 = [organizationDict objectForKey:@"contactPhone2"];
    NSString *officePhone = [organizationDict objectForKey:@"officePhone"];
    NSString *addrStreet1 = [organizationDict objectForKey:@"addrStreet1"];
    NSString *addrStreet2 = [organizationDict objectForKey:@"addrStreet2"];
    NSString *addrCity = [organizationDict objectForKey:@"addrCity"];
    PPState *state;
    if ([organizationDict objectForKey:@"state"]) {
        state = [PPState initWithDictionary:[organizationDict objectForKey:@"state"]];
    }
    PPCountry *country;
    if ([organizationDict objectForKey:@"country"]) {
        country = [PPCountry initWithDictionary:[organizationDict objectForKey:@"country"]];
    }
    NSString *zip = [organizationDict objectForKey:@"zip"];
    PPOrganization *organization = [[PPOrganization alloc] initWithOrganization:organizationId
                                                                       parentId:parentId
                                                                           name:name
                                                                     domainName:domainName
                                                             organizationStatus:organizationStatus
                                                                   approvedDate:approvedDate
                                                                          group:group
                                                                         points:points
                                                                    pointsLevel:pointsLevel
                                                                          notes:notes
                                                                 termsOfService:termsOfService
                                                                       features:features
                                                                   contactName1:contactName1
                                                                  contactEmail1:contactEmail1
                                                                  contactPhone1:contactPhone1
                                                                   contactName2:contactName2
                                                                  contactEmail2:contactEmail2
                                                                  contactPhone2:contactPhone2
                                                                    officePhone:officePhone
                                                                    addrStreet1:addrStreet1
                                                                    addrStreet2:addrStreet2
                                                                       addrCity:addrCity
                                                                          state:state
                                                                        country:country
                                                                            zip:zip];
    return organization;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPOrganization *organization = [[PPOrganization allocWithZone:zone] init];
    
    organization.organizationId = self.organizationId;
    organization.parentId = self.parentId;
    organization.name = [self.name copyWithZone:zone];
    organization.domainName = [self.domainName copyWithZone:zone];
    organization.organizationStatus = self.organizationStatus;
    organization.approvedDate = [self.approvedDate copyWithZone:zone];
    organization.group = [self.group copyWithZone:zone];
    organization.points = self.points;
    organization.pointsLevel = self.pointsLevel;
    organization.notes = [self.notes copyWithZone:zone];
    organization.termsOfService = [self.termsOfService copyWithZone:zone];
    organization.contactName1 = [self.contactName1 copyWithZone:zone];
    organization.contactEmail1 = [self.contactEmail1 copyWithZone:zone];
    organization.contactPhone1 = [self.contactPhone1 copyWithZone:zone];
    organization.contactName2 = [self.contactName2 copyWithZone:zone];
    organization.contactEmail2 = [self.contactEmail2 copyWithZone:zone];
    organization.contactPhone2 = [self.contactPhone2 copyWithZone:zone];
    organization.officePhone = [self.officePhone copyWithZone:zone];
    organization.addrStreet1 = [self.addrStreet1 copyWithZone:zone];
    organization.addrStreet2 = [self.addrStreet2 copyWithZone:zone];
    organization.addrCity = [self.addrCity copyWithZone:zone];
    organization.state = [self.state copyWithZone:zone];
    organization.country = [self.country copyWithZone:zone];
    organization.zip = [self.zip copyWithZone:zone];
    return organization;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.organizationId = (PPOrganizationId)((NSNumber *)[decoder decodeObjectForKey:@"organizationId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.domainName = [decoder decodeObjectForKey:@"domainName"];
        self.organizationStatus = (PPOrganizationStatus)((NSNumber *)[decoder decodeObjectForKey:@"organizationStatus"]).integerValue;
        self.approvedDate = [decoder decodeObjectForKey:@"approvedDate"];
        self.group = [decoder decodeObjectForKey:@"group"];
        self.points = (PPOrganizationPoints)((NSNumber *)[decoder decodeObjectForKey:@"points"]).integerValue;
        self.pointsLevel = (PPOrganizationPointsLevel)((NSNumber *)[decoder decodeObjectForKey:@"pointsLevel"]).integerValue;
        self.notes = [decoder decodeObjectForKey:@"notes"];
        self.termsOfService = [decoder decodeObjectForKey:@"termsOfService"];
        self.features = [decoder decodeObjectForKey:@"features"];
        self.contactName1 = [decoder decodeObjectForKey:@"contactName1"];
        self.contactEmail1 = [decoder decodeObjectForKey:@"contactEmail1"];
        self.contactPhone1 = [decoder decodeObjectForKey:@"contactPhone1"];
        self.contactName2 = [decoder decodeObjectForKey:@"contactName2"];
        self.contactEmail2 = [decoder decodeObjectForKey:@"contactEmail2"];
        self.contactPhone2 = [decoder decodeObjectForKey:@"contactPhone2"];
        self.officePhone = [decoder decodeObjectForKey:@"officePhone"];
        self.addrStreet1 = [decoder decodeObjectForKey:@"addrStreet1"];
        self.addrStreet2 = [decoder decodeObjectForKey:@"addrStreet2"];
        self.addrCity = [decoder decodeObjectForKey:@"addrCity"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.zip = [decoder decodeObjectForKey:@"zip"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_organizationId) forKey:@"organizationId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_domainName forKey:@"domainName"];
    [encoder encodeObject:@(_organizationStatus) forKey:@"organizationStatus"];
    [encoder encodeObject:_approvedDate forKey:@"approvedDate"];
    [encoder encodeObject:_group forKey:@"group"];
    [encoder encodeObject:@(_points) forKey:@"points"];
    [encoder encodeObject:@(_pointsLevel) forKey:@"pointsLevel"];
    [encoder encodeObject:_notes forKey:@"notes"];
    [encoder encodeObject:_termsOfService forKey:@"termsOfService"];
    [encoder encodeObject:_features forKey:@"features"];
}

@end
