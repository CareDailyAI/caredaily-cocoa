//
//  PPLocation.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocation.h"

@interface PPLocation()

@end

@implementation PPLocation

- (id)initWithLocationId:(PPLocationId)locationId
                    name:(NSString *)name
          locationAccess:(PPLocationAccess)locationAccess
            userCategory:(PPLocationCategory)userCategory
                   event:(PPLocationSceneEvent *)event
                    type:(PPLocationType)type
                   owner:(PPLocationOwner)owner
        utilityAccountNo:(NSString *)utilityAccountNo
                timezone:(PPTimezone *)timezone
             addrStreet1:(NSString *)addrStreet1
             addrStreet2:(NSString *)addrStreet2
                addrCity:(NSString *)addrCity
                   state:(PPState *)state
                 country:(PPCountry *)country
                     zip:(NSString *)zip
                latitude:(NSString *)latitude
               longitude:(NSString *)longitude
                    size:(PPLocationSize *)size
           storiesNumber:(PPLocationStoriesNumber)storiesNumber
             roomsNumber:(PPLocationRoomsNumber)roomsNumber
         bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber
         occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber
         occupantsRanges:(NSArray *)occupantsRanges
             usagePeriod:(PPLocationUsagePeriod)usagePeriod
             heatingType:(PPLocationHeatingType)heatingType
             coolingType:(PPLocationCoolingType)coolingType
         waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType
          thermostatType:(PPLocationThermostatType)thermostatType
        fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy
                   auths:(NSArray *)auths
                 clients:(NSArray *)clients
                services:(NSArray *)services
               temporary:(PPLocationTemporary)temporary
           accessEndDate:(NSDate *)accessEndDate
                smsPhone:(NSString *)smsPhone
            creationDate:(NSDate *)creationDate
                 appName:(NSString *)appName
          organizationId:(PPOrganizationId)organizationId
            organization:(PPOrganization *)organization
                    test:(PPLocationTest)test
                codeType:(PPLocationCodeType)codeType
                language:(NSString *)language
{
    self = [super init];
    if(self) {
        self.locationId = locationId;
        self.name = name;
        self.locationAccess = locationAccess;
        self.userCategory = userCategory;
        self.type = type;
        self.event = event;
        self.utilityAccountNo = utilityAccountNo;
        self.timezone = timezone;
        self.addrStreet1 = addrStreet1;
        self.addrStreet2 = addrStreet2;
        self.addrCity = addrCity;
        self.state = state;
        self.country = country;
        self.zip = zip;
        self.latitude = latitude;
        self.longitude = longitude;
        self.size = size;
        self.storiesNumber = storiesNumber;
        self.roomsNumber = roomsNumber;
        self.bathroomsNumber = bathroomsNumber;
        self.occupantsNumber = occupantsNumber;
        self.occupantsRanges = occupantsRanges;
        self.usagePeriod = usagePeriod;
        self.heatingType = heatingType;
        self.coolingType = coolingType;
        self.waterHeaterType = waterHeaterType;
        self.thermostatType = thermostatType;
        self.fileUploadPolicy = fileUploadPolicy;
        self.auths = auths;
        self.clients = clients;
        self.services = services;
        self.temporary = temporary;
        self.accessEndDate = accessEndDate;
        self.smsPhone = smsPhone;
        self.creationDate = creationDate;
        self.appName = appName;
        self.organizationId = organizationId;
        self.organization = organization;
        self.test = test;
        self.codeType = codeType;
        self.language = language;
    }
    return self;
}

+ (PPLocation *)initWithDictionary:(NSDictionary *)locationDict {
    PPLocationId locationId = PPLocationIdNone;
    if([locationDict objectForKey:@"id"]) {
        locationId = ((NSString *)[locationDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [locationDict objectForKey:@"name"];
    PPLocationAccess locationAccess = PPLocationAccessNone;
    if([locationDict objectForKey:@"locationAccess"]) {
        locationAccess = (PPLocationAccess)((NSString *)[locationDict objectForKey:@"locationAccess"]).integerValue;
    }
    PPLocationCategory userCategory = PPLocationCategoryNone;
    if([locationDict objectForKey:@"userCategory"]) {
        userCategory = (PPLocationCategory)((NSString *)[locationDict objectForKey:@"userCategory"]).integerValue;
    }
    PPLocationType type = PPLocationTypeNone;
    if([locationDict objectForKey:@"type"]) {
        type = (PPLocationType)((NSString *)[locationDict objectForKey:@"type"]).integerValue;
    }
    PPLocationOwner owner = PPLocationOwnerNone;
    if([locationDict objectForKey:@"owner"]) {
        owner = (PPLocationOwner)((NSString *)[locationDict objectForKey:@"owner"]).integerValue;
    }
    NSString *utilityAccountNo = [locationDict objectForKey:@"utilityAccountNo"];
    
    PPState *state = [PPState initWithDictionary:[locationDict objectForKey:@"state"]];
    PPTimezone *timezone = [PPTimezone initWithDictionary:[locationDict objectForKey:@"timezone"]];
    PPCountry *country = [PPCountry initWithDictionary:[locationDict objectForKey:@"country"]];

    NSString *zipCode = [locationDict objectForKey:@"zip"];
    NSString *addrCity = [locationDict objectForKey:@"addrCity"];
    NSString *addrStreet1 = [locationDict objectForKey:@"addrStreet1"];
    NSString *addrStreet2 = [locationDict objectForKey:@"addrStreet2"];
    NSString *latitude = [locationDict objectForKey:@"latitude"];
    NSString *longitude = [locationDict objectForKey:@"longitude"];
    
    PPLocationSceneEvent *event = [[PPLocationSceneEvent alloc] initWithEvent:[locationDict objectForKey:@"event"] date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:YES comment:nil];
    event.locationId = locationId;
    
    PPLocationSize *size = [PPLocationSize initWithDictionary:[locationDict objectForKey:@"size"]];
    
    PPLocationStoriesNumber storiesNumber = PPLocationStoriesNumberNone;
    if([locationDict objectForKey:@"storiesNumber"]) {
        storiesNumber = (PPLocationStoriesNumber)((NSString *)[locationDict objectForKey:@"storiesNumber"]).integerValue;
    }
    PPLocationRoomsNumber roomsNumber = PPLocationRoomsNumberNone;
    if([locationDict objectForKey:@"roomsNumber"]) {
        roomsNumber = (PPLocationRoomsNumber)((NSString *)[locationDict objectForKey:@"roomsNumber"]).integerValue;
    }
    PPLocationBathroomsNumber bathroomsNumber = PPLocationBathroomsNumberNone;
    if([locationDict objectForKey:@"bathroomsNumber"]) {
        bathroomsNumber = (PPLocationBathroomsNumber)((NSString *)[locationDict objectForKey:@"bathroomsNumber"]).integerValue;
    }
    PPLocationOccupantsNumber occupantsNumber = PPLocationOccupantsNumberNone;
    if([locationDict objectForKey:@"occupantsNumber"]) {
        occupantsNumber = (PPLocationOccupantsNumber)((NSString *)[locationDict objectForKey:@"occupantsNumber"]).integerValue;
    }
    
    NSMutableArray *occupantsRanges;
    if([locationDict objectForKey:@"occupantsRange"]) {
        occupantsRanges = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *occupantsRangeDict in [locationDict objectForKey:@"occupantsRange"]) {
            PPLocationOccupantsRange *occupantsRange = [PPLocationOccupantsRange initWithDictionary:occupantsRangeDict];
            [occupantsRanges addObject:occupantsRange];
        }
    }
    
    PPLocationUsagePeriod usagePeriod = PPLocationUsagePeriodNone;
    if([locationDict objectForKey:@"usagePeriod"]) {
        usagePeriod = (PPLocationUsagePeriod)((NSString *)[locationDict objectForKey:@"usagePeriod"]).integerValue;
    }
    
    PPLocationHeatingType heatingTye = PPLocationHeatingTypeNone;
    if([locationDict objectForKey:@"heatingType"]) {
        heatingTye = (PPLocationHeatingType)((NSString *)[locationDict objectForKey:@"heatingType"]).integerValue;
    }
    
    PPLocationCoolingType coolingType = PPLocationCoolingTypeNone;
    if([locationDict objectForKey:@"coolingType"]) {
        coolingType = (PPLocationCoolingType)((NSString *)[locationDict objectForKey:@"coolingType"]).integerValue;
    }
    
    PPLocationWaterHeaterType waterHeaterType = PPLocationWaterHeaterTypeNone;
    if([locationDict objectForKey:@"waterHeaterType"]) {
        waterHeaterType = (PPLocationWaterHeaterType)((NSString *)[locationDict objectForKey:@"waterHeaterType"]).integerValue;
    }
    
    PPLocationThermostatType thermostatType = PPLocationThermostatTypeNone;
    if([locationDict objectForKey:@"thermostatType"]) {
        thermostatType = (PPLocationThermostatType)((NSString *)[locationDict objectForKey:@"thermostatType"]).integerValue;
    }
    
    PPLocationFileUploadPolicy fileUploadPolicy = PPLocationFileUploadPolicyNone;
    if([locationDict objectForKey:@"fileUploadPolicy"]) {
        fileUploadPolicy = (PPLocationFileUploadPolicy)((NSString *)[locationDict objectForKey:@"fileUploadPolicy"]).integerValue;
    }
    
    
    NSMutableArray *auths;
    if([locationDict objectForKey:@"auths"]) {
        auths = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *authDict in [locationDict objectForKey:@"auths"]) {
            PPCloudsIntegrationClient *auth = [PPCloudsIntegrationClient initWithDictionary:authDict];
            [auths addObject:auth];
        }
    }
    
    NSMutableArray *clients;
    if([locationDict objectForKey:@"authClients"]) {
        clients = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *clientDict in [locationDict objectForKey:@"authClients"]) {
            PPCloudsIntegrationHost *authClient = [PPCloudsIntegrationHost initWithDictionary:clientDict];
            [clients addObject:authClient];
        }
    }
    
    NSMutableArray *services;
    if([locationDict objectForKey:@"services"]) {
        services = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *serviceDict in [locationDict objectForKey:@"services"]) {
            PPUserService *userService = [PPUserService initWithDictionary:serviceDict];
            [services addObject:userService];
        }
    }
    
    PPLocationTemporary temporary = PPLocationTemporaryNone;
    if([locationDict objectForKey:@"temporary"]) {
        temporary = (PPLocationTemporary)((NSString *)[locationDict objectForKey:@"temporary"]).integerValue;
    }
    
    NSString *accessEndDateString = [locationDict objectForKey:@"accessEndDate"];
    NSDate *accessEndDate = [NSDate dateWithTimeIntervalSince1970:0];
    if(accessEndDateString != nil) {
        if(![accessEndDateString isEqualToString:@""]) {
            accessEndDate = [PPNSDate parseDateTime:accessEndDateString];
        }
    }
    
    NSString *smsPhone = [locationDict objectForKey:@"smsPhone"];
    
    NSString *creationDateString = [locationDict objectForKey:@"creationDate"];
    NSDate *creationDate;
    
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    NSString *appName = [locationDict objectForKey:@"appName"];
    PPOrganizationId organizationId = PPOrganizationIdNone;
    if([locationDict objectForKey:@"organizationId"]) {
        organizationId = (PPOrganizationId)((NSString *)[locationDict objectForKey:@"organizationId"]).integerValue;
    }
    PPOrganization *organization;
    if ([locationDict objectForKey:@"organization"]) {
        organization = [PPOrganization initWithDictionary:[locationDict objectForKey:@"organization"]];
    }
    
    PPLocationTest test = PPLocationTestNone;
    if([locationDict objectForKey:@"test"]) {
        test = (PPLocationTest)((NSString *)[locationDict objectForKey:@"test"]).integerValue;
    }
    
    PPLocationCodeType codeType = PPLocationCodeTypeNone;
    if([locationDict objectForKey:@"codeType"]) {
        codeType = (PPLocationCodeType)((NSString *)[locationDict objectForKey:@"codeType"]).integerValue;
    }
    
    NSString *language = [locationDict objectForKey:@"language"];
    
    PPLocation *location = [[PPLocation alloc] initWithLocationId:locationId
                                                             name:name
                                                   locationAccess:locationAccess
                                                     userCategory:userCategory
                                                            event:event
                                                             type:type
                                                            owner:owner
                                                 utilityAccountNo:utilityAccountNo
                                                         timezone:timezone
                                                      addrStreet1:addrStreet1
                                                      addrStreet2:addrStreet2
                                                         addrCity:addrCity
                                                            state:state
                                                          country:country
                                                              zip:zipCode
                                                         latitude:latitude
                                                        longitude:longitude
                                                             size:size
                                                    storiesNumber:storiesNumber
                                                      roomsNumber:roomsNumber
                                                  bathroomsNumber:bathroomsNumber
                                                  occupantsNumber:occupantsNumber
                                                  occupantsRanges:occupantsRanges
                                                      usagePeriod:usagePeriod
                                                      heatingType:heatingTye
                                                      coolingType:coolingType
                                                  waterHeaterType:waterHeaterType
                                                   thermostatType:thermostatType
                                                 fileUploadPolicy:fileUploadPolicy
                                                            auths:auths
                                                          clients:clients
                                                         services:services
                                                        temporary:temporary
                                                    accessEndDate:accessEndDate
                                                         smsPhone:smsPhone
                                                     creationDate:creationDate
                                                          appName:appName
                                                   organizationId:organizationId
                                                     organization:organization
                                                             test:test
                                                         codeType:codeType
                                                         language:language
                            ];
    return location;
}

/**
 * Provides a human readable description of this location
 *
 * @return NSString Description of this location
 **/
- (NSString *)humanReadableLocationDescription {
    NSMutableString *description = [[NSMutableString alloc] init];
    if(self.addrStreet1 && ![self.addrStreet1 isEqualToString:@""]) {
        [description appendFormat:@"%@", self.addrStreet1];
    }
    if(self.addrStreet2 && ![self.addrStreet2 isEqualToString:@""]) {
        [description appendFormat:@"%@%@", (description.length > 0) ? @", " : @"" , self.addrStreet2];
    }
    if(self.addrCity && ![self.addrCity isEqualToString:@""]) {
        [description appendFormat:@"%@%@", (description.length > 0) ? @", " : @"", self.addrCity];
    }
    if(self.state && self.state.name != nil && ![self.state.name isEqualToString:@""]) {
        [description appendFormat:@"%@%@", (description.length > 0) ? @", " : @"", self.state.name];
    }
    if(self.zip && ![self.zip isEqualToString:@""]) {
        [description appendFormat:@"%@%@", (description.length > 0) ? @", " : @"", self.zip];
    }
    if(self.country && self.country.name != nil && ![self.country.name isEqualToString:@""]) {
        [description appendFormat:@"%@%@", (description.length > 0) ? @", " : @"", self.country.name];
    }
    
    return description;
}

/**
 * Return a JSON friendly string of a given location
 *
 * @param location PPLocation Location to be stringified
 *
 * @return NSString JSON string
 **/
+ (NSString *)JSONString:(PPLocation *)location {
    return [PPLocation JSONString:location appName:nil];
}

/**
 * Return a JSON friendly string of a given location
 *
 * @param location PPLocation Location to be stringified
 * @param appName NSString App name to add this location to a specific organization
 *
 * @return NSString JSON string
 **/
+ (NSString *)JSONString:(PPLocation *)location appName:(NSString *)appName {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    
    [JSONString appendString:@"{"];
    BOOL appendComma = NO;
    if(location.name) {
        [JSONString appendFormat:@"\"name\":\"%@\"", location.name];
        appendComma = YES;
    }
    if(appName) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"appName\":\"%@\"", appName];
        appendComma = YES;
    }
    if(location.locationAccess != PPLocationAccessNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"locationAccess\":\"%li\"", (long)location.locationAccess];
        appendComma = YES;
    }
    if(location.userCategory != PPLocationCategoryNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"userCategory\":\"%li\"", (long)location.userCategory];
        appendComma = YES;
    }
    if(location.type != PPLocationTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":\"%li\"", (long)location.type];
        appendComma = YES;
    }
    if(location.utilityAccountNo) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"utilityAccountNo\":\"%@\"", location.utilityAccountNo];
        appendComma = YES;
    }
    if(location.timezone != nil && location.timezone.timezoneId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"timezone\": {"];
        
        [JSONString appendFormat:@"\"id\":\"%@\"", location.timezone.timezoneId];
        [JSONString appendString:@"}"];
        appendComma = YES;
    }
    if(location.addrStreet1) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"addrStreet1\":\"%@\"", location.addrStreet1];
        appendComma = YES;
    }
    if(location.addrStreet2) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"addrStreet2\":\"%@\"", location.addrStreet2];
        appendComma = YES;
    }
    if(location.addrCity) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"addrCity\":\"%@\"", location.addrCity];
        appendComma = YES;
    }
    if(location.state != nil && location.state.stateId != PPStateIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"state\": {"];
        
        [JSONString appendFormat:@"\"id\":\"%li\"", (long)location.state.stateId];
        [JSONString appendString:@"}"];
        appendComma = YES;
    }
    if(location.country != nil && location.country.countryId != PPCountryIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"country\": {"];
        
        [JSONString appendFormat:@"\"id\":\"%li\"", (long)location.country.countryId];
        [JSONString appendString:@"}"];
        appendComma = YES;
    }
    if(location.zip) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"zip\":\"%@\"", location.zip];
        appendComma = YES;
    }
    if(location.latitude) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"latitude\":\"%@\"", location.latitude];
        appendComma = YES;
    }
    if(location.longitude) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"longitude\":\"%@\"", location.longitude];
        appendComma = YES;
    }
    if(location.size != nil && location.size.unit && location.size.content != PPLocationSizeContentNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendString:@"\"size\": {"];
        
        [JSONString appendFormat:@"\"unit\":\"%@\"", location.size.unit];
        [JSONString appendString:@","];
        [JSONString appendFormat:@"\"content\":\"%li\"", (long)location.size.content];
        [JSONString appendString:@"}"];
        appendComma = YES;
    }
    if(location.storiesNumber != PPLocationStoriesNumberNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"storiesNumber\":\"%li\"", (long)location.storiesNumber];
        appendComma = YES;
    }
    if(location.roomsNumber != PPLocationRoomsNumberNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"roomsNumber\":\"%li\"", (long)location.roomsNumber];
        appendComma = YES;
    }
    if(location.bathroomsNumber != PPLocationBathroomsNumberNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"bathroomsNumber\":\"%li\"", (long)location.bathroomsNumber];
        appendComma = YES;
    }
    if(location.occupantsNumber != PPLocationOccupantsNumberNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"occupantsNumber\":\"%li\"", (long)location.occupantsNumber];
        appendComma = YES;
    }
    if([location.occupantsRanges count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        
        [JSONString appendString:@"\"occupantsRange\": ["];
        
        BOOL appendOccupantsRangeComma = NO;
        for(PPLocationOccupantsRange *occupantsRange in location.occupantsRanges) {
            if(appendOccupantsRangeComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:@"{"];
            [JSONString appendFormat:@"\"start\":\"%li\",", (long)occupantsRange.start];
            [JSONString appendFormat:@"\"end\":\"%li\",", (long)occupantsRange.end];
            [JSONString appendFormat:@"\"number\":\"%li\"", (long)occupantsRange.number];
            [JSONString appendString:@"}"];
            appendOccupantsRangeComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    if(location.usagePeriod != PPLocationUsagePeriodNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"usagePeriod\":\"%li\"", (long)location.usagePeriod];
        appendComma = YES;
    }
    if(location.heatingType != PPLocationHeatingTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"heatingType\":\"%lu\"", (unsigned long)location.heatingType];
        appendComma = YES;
    }
    if(location.coolingType != PPLocationCoolingTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"coolingType\":\"%lu\"", (unsigned long)location.coolingType];
        appendComma = YES;
    }
    if(location.waterHeaterType != PPLocationWaterHeaterTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"waterHeaterType\":\"%lu\"", (unsigned long)location.waterHeaterType];
        appendComma = YES;
    }
    if(location.thermostatType != PPLocationThermostatTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"thermostatType\":\"%lu\"", (unsigned long)location.thermostatType];
        appendComma = YES;
    }
    if(location.fileUploadPolicy != PPLocationFileUploadPolicyNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"fileUploadPolicy\":\"%li\"", (long)location.fileUploadPolicy];
        appendComma = YES;
    }
    if(location.test != PPLocationTestNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"test\":%@", @(location.test)];
        appendComma = YES;
    }
    if(location.language != nil) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"language\":%@", location.language];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    
    return JSONString;
}

+ (NSDictionary *)JSONData:(PPLocation *)location appName:(NSString *)appName {
    NSMutableDictionary *data = @{}.mutableCopy;
    if(location.name) {
        data[@"name"] = location.name;
    }
    if(appName) {
        data[@"appName"] = appName;
    }
    if(location.locationAccess != PPLocationAccessNone) {
        data[@"locationAccess"] = @(location.locationAccess);
    }
    if(location.userCategory != PPLocationCategoryNone) {
        data[@"userCategory"] = @(location.userCategory);
    }
    if(location.type != PPLocationTypeNone) {
        data[@"type"] = @(location.type);
    }
    if(location.utilityAccountNo) {
        data[@"utilityAccountNo"] = location.utilityAccountNo;
    }
    if(location.timezone != nil && location.timezone.timezoneId) {
        data[@"timezone"] = @{@"id": location.timezone.timezoneId};
    }
    if(location.addrStreet1) {
        data[@"addrStreet1"] = location.addrStreet1;
    }
    if(location.addrStreet2) {
        data[@"addrStreet2"] = location.addrStreet2;
    }
    if(location.addrCity) {
        data[@"addrCity"] = location.addrCity;
    }
    if(location.state != nil && location.state.stateId != PPStateIdNone) {
        data[@"state"] = @{@"id": @(location.state.stateId)};
    }
    if(location.country != nil && location.country.countryId != PPCountryIdNone) {
        data[@"country"] = @{@"id": @(location.country.countryId)};
    }
    if(location.zip) {
        data[@"zip"] = location.zip;
    }
    if(location.latitude) {
        data[@"latitude"] = location.latitude;
    }
    if(location.longitude) {
        data[@"longitude"] = location.longitude;
    }
    if(location.size != nil && location.size.unit && location.size.content != PPLocationSizeContentNone) {
        data[@"size"] = @{
          @"unit": location.size.unit,
          @"content": @(location.size.content)
        };
    }
    if(location.storiesNumber != PPLocationStoriesNumberNone) {
        data[@"storiesNumber"] = @(location.storiesNumber);
    }
    if(location.roomsNumber != PPLocationRoomsNumberNone) {
        data[@"roomsNumber"] = @(location.roomsNumber);
    }
    if(location.bathroomsNumber != PPLocationBathroomsNumberNone) {
        data[@"bathroomsNumber"] = @(location.bathroomsNumber);
    }
    if(location.occupantsNumber != PPLocationOccupantsNumberNone) {
        data[@"occupantsNumber"] = @(location.occupantsNumber);
    }
    if([location.occupantsRanges count]) {
        
        NSMutableArray *occupantsRange = @[].mutableCopy;
        
        for(PPLocationOccupantsRange *range in location.occupantsRanges) {
            [occupantsRange addObject:@{
               @"start": @(range.start),
               @"end": @(range.end),
               @"number": @(range.number),
            }];
        }
        data[@"occupantsRange"] = occupantsRange;
    }
    if(location.usagePeriod != PPLocationUsagePeriodNone) {
        data[@"usagePeriod"] = @(location.usagePeriod);
    }
    if(location.heatingType != PPLocationHeatingTypeNone) {
        data[@"heatingType"] = @(location.heatingType);
    }
    if(location.coolingType != PPLocationCoolingTypeNone) {
        data[@"coolingType"] = @(location.coolingType);
    }
    if(location.waterHeaterType != PPLocationWaterHeaterTypeNone) {
        data[@"waterHeaterType"] = @(location.waterHeaterType);
    }
    if(location.thermostatType != PPLocationThermostatTypeNone) {
        data[@"thermostatType"] = @(location.thermostatType);
    }
    if(location.fileUploadPolicy != PPLocationFileUploadPolicyNone) {
        data[@"fileUploadPolicy"] = @(location.fileUploadPolicy);
    }
    if(location.language != nil) {
        data[@"language"] = location.language;
    }
    
    return data;
}

#pragma mark - Private methods

- (void)setLocationId:(PPLocationId)locationId {
    _locationId = locationId;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPLocation *location = [[PPLocation allocWithZone:zone] init];
    
    location.locationId = self.locationId;
    location.name = [self.name copyWithZone:zone];
    location.locationAccess = self.locationAccess;
    location.userCategory = self.userCategory;
    location.type = self.type;
    location.owner = self.owner;
    location.utilityAccountNo = [self.utilityAccountNo copyWithZone:zone];
    location.timezone = [self.timezone copyWithZone:zone];
    location.event = [self.event copyWithZone:zone];
    location.addrStreet1 = [self.addrStreet1 copyWithZone:zone];
    location.addrStreet2 = [self.addrStreet2 copyWithZone:zone];
    location.addrCity = [self.addrCity copyWithZone:zone];
    location.state = [self.state copyWithZone:zone];
    location.country = [self.country copyWithZone:zone];
    location.zip = [self.zip copyWithZone:zone];
    location.latitude = [self.latitude copyWithZone:zone];
    location.longitude = [self.longitude copyWithZone:zone];
    location.size = [self.size copyWithZone:zone];
    location.storiesNumber = self.storiesNumber;
    location.roomsNumber = self.roomsNumber;
    location.bathroomsNumber = self.bathroomsNumber;
    location.occupantsNumber = self.occupantsNumber;
    location.occupantsRanges = [self.occupantsRanges copyWithZone:zone];
    location.usagePeriod = self.usagePeriod;
    location.heatingType = self.heatingType;
    location.coolingType = self.coolingType;
    location.waterHeaterType = self.waterHeaterType;
    location.thermostatType = self.thermostatType;
    location.fileUploadPolicy = self.fileUploadPolicy;
    location.auths = self.auths;
    location.clients = self.clients;
    location.services = self.services;
    location.temporary = self.temporary;
    location.accessEndDate = [self.accessEndDate copyWithZone:zone];
    location.creationDate = [self.creationDate copyWithZone:zone];
    location.smsPhone = [self.smsPhone copyWithZone:zone];
    location.appName = [self.appName copyWithZone:zone];
    location.organizationId = self.organizationId;
    location.organization = [self.organization copyWithZone:zone];
    location.test = self.test;
    location.codeType = self.codeType;
    location.language = self.language;
    return location;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.locationId = (PPLocationId)((NSNumber *)[decoder decodeObjectForKey:@"locationId"]).integerValue;
        self.name = [decoder decodeObjectForKey:@"name"];
        self.locationAccess = (PPLocationAccess)((NSNumber *)[decoder decodeObjectForKey:@"locationAccess"]).integerValue;
        self.userCategory = (PPLocationCategory)((NSNumber *)[decoder decodeObjectForKey:@"userCategory"]).integerValue;
        self.type = (PPLocationType)((NSNumber *)[decoder decodeObjectForKey:@"type"]).integerValue;
        self.owner = (PPLocationOwner)((NSNumber *)[decoder decodeObjectForKey:@"owner"]).integerValue;
        self.utilityAccountNo = [decoder decodeObjectForKey:@"utilityAccountNo"];
        self.timezone = [decoder decodeObjectForKey:@"timezone"];
        self.event = [decoder decodeObjectForKey:@"event"];
        self.addrStreet1 = [decoder decodeObjectForKey:@"addrStreet1"];
        self.addrStreet2 = [decoder decodeObjectForKey:@"addrStreet2"];
        self.addrCity = [decoder decodeObjectForKey:@"addrCity"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.zip = [decoder decodeObjectForKey:@"zip"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
        self.size = [decoder decodeObjectForKey:@"size"];
        self.storiesNumber = (PPLocationStoriesNumber)((NSNumber *)[decoder decodeObjectForKey:@"storiesNumber"]).integerValue;
        self.roomsNumber = (PPLocationRoomsNumber)((NSNumber *)[decoder decodeObjectForKey:@"roomsNumber"]).integerValue;
        self.bathroomsNumber = (PPLocationBathroomsNumber)((NSNumber *)[decoder decodeObjectForKey:@"bathroomsNumber"]).integerValue;
        self.occupantsNumber = (PPLocationOccupantsNumber)((NSNumber *)[decoder decodeObjectForKey:@"occupantsNumber"]).integerValue;
        self.occupantsRanges = [decoder decodeObjectForKey:@"occupantsRanges"];
        self.usagePeriod = (PPLocationUsagePeriod)((NSNumber *)[decoder decodeObjectForKey:@"usagePeriod"]).integerValue;
        self.heatingType = (PPLocationHeatingType)((NSNumber *)[decoder decodeObjectForKey:@"heatingType"]).integerValue;
        self.coolingType = (PPLocationCoolingType)((NSNumber *)[decoder decodeObjectForKey:@"coolingType"]).integerValue;
        self.waterHeaterType = (PPLocationWaterHeaterType)((NSNumber *)[decoder decodeObjectForKey:@"waterHeaterType"]).integerValue;
        self.thermostatType = (PPLocationThermostatType)((NSNumber *)[decoder decodeObjectForKey:@"thermostatType"]).integerValue;
        self.fileUploadPolicy = (PPLocationFileUploadPolicy)((NSNumber *)[decoder decodeObjectForKey:@"fileUploadPolicy"]).integerValue;
        self.auths = [decoder decodeObjectForKey:@"auths"];
        self.clients = [decoder decodeObjectForKey:@"clients"];
        self.services = [decoder decodeObjectForKey:@"services"];
        self.temporary = (PPLocationTemporary)((NSNumber *)[decoder decodeObjectForKey:@"temporary"]).integerValue;
        self.accessEndDate = [decoder decodeObjectForKey:@"accessEndDate"];
        self.creationDate = [decoder decodeObjectForKey:@"creationDate"];
        self.smsPhone = [decoder decodeObjectForKey:@"smsPhone"];
        self.appName = [decoder decodeObjectForKey:@"appName"];
        self.organizationId = (PPOrganizationId)((NSNumber *)[decoder decodeObjectForKey:@"organizationId"]).integerValue;
        self.organization = [decoder decodeObjectForKey:@"organization"];
        self.test = (PPLocationTest)((NSNumber *)[decoder decodeObjectForKey:@"test"]).integerValue;
        self.codeType = (PPLocationCodeType)((NSNumber *)[decoder decodeObjectForKey:@"codeType"]).integerValue;
        self.language = [decoder decodeObjectForKey:@"language"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(_locationId) forKey:@"locationId"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:@(_locationAccess) forKey:@"locationAccess"];
    [encoder encodeObject:@(_userCategory) forKey:@"userCategory"];
    [encoder encodeObject:@(_type) forKey:@"type"];
    [encoder encodeObject:@(_owner) forKey:@"owner"];
    [encoder encodeObject:_utilityAccountNo forKey:@"utilityAccountNo"];
    [encoder encodeObject:_timezone forKey:@"timezone"];
    [encoder encodeObject:_event forKey:@"event"];
    [encoder encodeObject:_addrStreet1 forKey:@"addrStreet1"];
    [encoder encodeObject:_addrStreet2 forKey:@"addrStreet2"];
    [encoder encodeObject:_addrCity forKey:@"addrCity"];
    [encoder encodeObject:_state forKey:@"state"];
    [encoder encodeObject:_country forKey:@"country"];
    [encoder encodeObject:_zip forKey:@"zip"];
    [encoder encodeObject:_latitude forKey:@"latitude"];
    [encoder encodeObject:_longitude forKey:@"longitude"];
    [encoder encodeObject:_size forKey:@"size"];
    [encoder encodeObject:@(_storiesNumber) forKey:@"storiesNumber"];
    [encoder encodeObject:@(_roomsNumber) forKey:@"roomsNumber"];
    [encoder encodeObject:@(_bathroomsNumber) forKey:@"bathroomsNumber"];
    [encoder encodeObject:@(_occupantsNumber) forKey:@"occupantsNumber"];
    [encoder encodeObject:_occupantsRanges forKey:@"occupantsRanges"];
    [encoder encodeObject:@(_usagePeriod) forKey:@"usagePeriod"];
    [encoder encodeObject:@(_heatingType) forKey:@"heatingType"];
    [encoder encodeObject:@(_coolingType) forKey:@"coolingType"];
    [encoder encodeObject:@(_waterHeaterType) forKey:@"waterHeaterType"];
    [encoder encodeObject:@(_thermostatType) forKey:@"thermostatType"];
    [encoder encodeObject:@(_fileUploadPolicy) forKey:@"fileUploadPolicy"];
    [encoder encodeObject:_auths forKey:@"auths"];
    [encoder encodeObject:_clients forKey:@"clients"];
    [encoder encodeObject:_services forKey:@"services"];
    [encoder encodeObject:@(_temporary) forKey:@"temporary"];
    [encoder encodeObject:_accessEndDate forKey:@"accessEndDate"];
    [encoder encodeObject:_creationDate forKey:@"creationDate"];
    [encoder encodeObject:_smsPhone forKey:@"smsPhone"];
    [encoder encodeObject:_appName forKey:@"appName"];
    [encoder encodeObject:@(_organizationId) forKey:@"organizationId"];
    [encoder encodeObject:_organization forKey:@"organization"];
    [encoder encodeObject:@(_test) forKey:@"test"];
    [encoder encodeObject:@(_codeType) forKey:@"codeType"];
    [encoder encodeObject:_language forKey:@"language"];
}


@end


