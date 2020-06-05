//
//  PPOrganization.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPOrganization.h"
#import "PPOrganizationGroup.h"
#import "PPCloudEngine.h"

@implementation PPOrganization

- (id) initWithOrganization:(PPOrganizationId)organizationId name:(NSString *)name domainName:(NSString *)domainName organizationStatus:(PPOrganizationStatus)organizationStatus approvedDate:(NSDate *)approvedDate group:(PPOrganizationGroup *)group points:(PPOrganizationPoints)points pointsLevel:(PPOrganizationPointsLevel)pointsLevel notes:(NSString *)notes termsOfService:(NSString *)termsOfService features:(NSString *)features {
    self = [super init];
    if(self) {
        self.organizationId = organizationId;
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
    
    PPOrganization *organization = [[PPOrganization alloc] initWithOrganization:organizationId name:name domainName:domainName organizationStatus:organizationStatus approvedDate:approvedDate group:group points:points pointsLevel:pointsLevel notes:notes termsOfService:termsOfService features:features];
    return organization;
}

#pragma mark - Encoding

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
