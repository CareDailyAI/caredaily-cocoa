//
//  PPUser.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUser.h"
#import "PPOperationToken.h"

@implementation PPUser

+ (NSString *)primaryKey {
    return @"userId";
}

+ (NSArray<NSString *> *)ignoredProperties {
    return @[
             @"keychain"
             ];
}

- (id)initWithCachedUser {
    NSString *cachedUsername = [UICKeyChainStore keyChainStore][@"user.username"];
    NSString *cachedSessionKey = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", cachedUsername]];
    
    return [self initWithSessionKey:cachedSessionKey username:cachedUsername];
}

- (id)initWithSessionKey:(NSString *)sessionKey username:(NSString *)username {
    self = [[PPUser alloc] initWithUserId:PPUserIdNone email:[[PPUserEmail alloc] initWithEmail:nil verified:PPUserEmailVerifiedNone status:PPUserEmailStatusNone] username:username altUsername:nil firstName:nil lastName:nil communityName:nil language:nil phone:nil phoneType:PPUserPhoneTypeNone smsStatus:PPUserSMSStatusNone anonymous:PPUserAnonymousTypeNone userPermissions:nil tags:nil locations:nil badges:nil organizations:nil avatarFileId:PPUserAvatarFileIdNone creationDate:nil authClients:nil userCommunities:nil locationCommunities:nil];
    if(self) {
        self.sessionKey = sessionKey;
    }
    return self;
}

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName communityName:(NSString *)communityName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(RLMArray *)userPermissions tags:(RLMArray *)tags locations:(RLMArray *)locations badges:(RLMArray *)badges organizations:(RLMArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId creationDate:(NSDate *)creationDate authClients:(RLMArray *)authClients userCommunities:(RLMArray *)userCommunities locationCommunities:(RLMArray *)locationCommunities {
    self = [super init];
    if(self) {
        self.userId = userId;
        self.email = email;
        self.username = username;
        self.altUsername = altUsername;
        self.firstName = firstName;
        self.lastName = lastName;
        self.communityName = communityName;
        self.language = language;
        self.phone = phone;
        self.phoneType = phoneType;
        self.smsStatus = smsStatus;
        self.anonymous = anonymous;
        self.userPermissions = (RLMArray<RLMInt> *)userPermissions;
        self.tags = (RLMArray<PPUserTag *><PPUserTag> *)tags;
        self.authClients = (RLMArray<PPCloudsIntegrationHost *><PPCloudsIntegrationHost> *)authClients;
        self.locations = (RLMArray<PPLocation *><PPLocation> *)locations;
        self.badges = (RLMArray<PPUserBadge *><PPUserBadge> *)badges;
        self.organizations = (RLMArray<PPOrganization *><PPOrganization> *)organizations;
        self.avatarFileId = avatarFileId;
        self.creationDate = creationDate;
        self.userCommunities = (RLMArray<PPUserCommunity *><PPUserCommunity> *)userCommunities;
        self.locationCommunities = (RLMArray<PPLocationCommunity *><PPLocationCommunity> *)locationCommunities;
    }
    return self;
}

+ (PPUser *)initWithDictionary:(NSDictionary *)root {
    NSDictionary *userDict = root;
    if([root objectForKey:@"user"]) {
        userDict = [root objectForKey:@"user"];
    }
    PPUserId userId = PPUserIdNone;
    if([userDict objectForKey:@"id"]) {
        userId = (PPUserId)((NSString *)[userDict objectForKey:@"id"]).integerValue;
    }
    else if([userDict objectForKey:@"userId"]) {
        userId = (PPUserId)((NSString *)[userDict objectForKey:@"userId"]).integerValue;
    }
    
    NSString *username;
    if([userDict objectForKey:@"username"]) {
        username = [userDict objectForKey:@"username"];
    }
    if([userDict objectForKey:@"userName"]) {
        username = [userDict objectForKey:@"userName"];
    }
    NSString *altUsername = [userDict objectForKey:@"altUsername"];
    NSString *firstName = [userDict objectForKey:@"firstName"];
    NSString *lastName = [userDict objectForKey:@"lastName"];
    NSString *communityName = [userDict objectForKey:@"communityName"];
    NSString *language = [userDict objectForKey:@"language"];
    
    PPUserEmail *email = [PPUserEmail initWithDictionary:nil];
    NSObject *emailObj = [userDict objectForKey:@"email"];
    if([emailObj isKindOfClass:[NSDictionary class]]) {
        email = [PPUserEmail initWithDictionary:[userDict objectForKey:@"email"]];
    }
    else if([emailObj isKindOfClass:[NSString class]]) {
        email = [PPUserEmail initWithDictionary:@{@"email": [userDict objectForKey:@"email"]}];
    }
    
    NSString *phone = [[((NSString *)[userDict objectForKey:@"phone"]) componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    PPUserPhoneType phoneType = PPUserPhoneTypeNone;
    if([userDict objectForKey:@"phoneType"]) {
        phoneType = (PPUserPhoneType)((NSString *)[userDict objectForKey:@"phoneType"]).integerValue;
    }
    PPUserSMSStatus smsStatus = PPUserSMSStatusNone;
    if([userDict objectForKey:@"smsStatus"]) {
        smsStatus = (PPUserSMSStatus)((NSString *)[userDict objectForKey:@"smsStatus"]).integerValue;
    }
    PPUserAnonymousType anonymous = PPUserAnonymousTypeNone;
    if([userDict objectForKey:@"anonymous"]) {
        anonymous = (PPUserAnonymousType)((NSString *)[userDict objectForKey:@"anonymous"]).integerValue;
    }
    
    NSArray *permissionArray = [userDict objectForKey:@"permission"];
    
    NSMutableArray *organizations;
    if([root objectForKey:@"organizations"]) {
        organizations = [[NSMutableArray alloc] initWithCapacity:2];
        for(NSDictionary *organizationDict in [root objectForKey:@"organizations"]) {
            PPOrganization *organization = [PPOrganization initWithDictionary:organizationDict];
            [organizations addObject:organization];
        }
    }
    
    NSMutableArray *locations;
    if([root objectForKey:@"locations"]) {
        locations = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *locationDict in [root objectForKey:@"locations"]) {
            PPLocation *userLocation = [PPLocation initWithDictionary:locationDict];
            [locations addObject:userLocation];
        }
    }
    
    NSMutableArray *badges;
    if([root objectForKey:@"badges"]) {
        badges = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *badgeDict in [root objectForKey:@"badges"]) {
            PPUserBadge *userBadge = [PPUserBadge initWithDictionary:badgeDict];
            [badges addObject:userBadge];
        }
    }
    
    NSMutableArray *tags;
    if([root objectForKey:@"tags"]) {
        tags = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *tagDict in [root objectForKey:@"tags"]) {
            PPUserTag *tag = [PPUserTag initWithDictionary:tagDict];
            [tags addObject:tag];
        }
    }
    
    NSMutableArray *authClients;
    if([userDict objectForKey:@"authClients"]) {
        authClients = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *clientDict in [userDict objectForKey:@"authClients"]) {
            PPCloudsIntegrationHost *authClient = [PPCloudsIntegrationHost initWithDictionary:clientDict];
            [authClients addObject:authClient];
        }
    }
    
    PPUserAvatarFileId avatarFileId = PPUserAvatarFileIdNone;
    if([userDict objectForKey:@"avatarFileId"]) {
        avatarFileId = (PPUserAvatarFileId)((NSString *)[userDict objectForKey:@"avatarFileId"]).integerValue;
    }
    
    NSString *creationDateString = [userDict objectForKey:@"creationDate"];
    NSDate *creationDate;
    
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    NSMutableArray *userCommunities;
    if([root objectForKey:@"userCommunities"]) {
        userCommunities = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *communityDict in [root objectForKey:@"userCommunities"]) {
            PPUserCommunity *community = [PPUserCommunity initWithDictionary:communityDict];
            [userCommunities addObject:community];
        }
    }
    
    NSMutableArray *locationCommunities;
    if([root objectForKey:@"locationCommunities"]) {
        locationCommunities = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *communityDict in [root objectForKey:@"locationCommunities"]) {
            PPLocationCommunity *community = [PPLocationCommunity initWithDictionary:communityDict];
            [locationCommunities addObject:community];
        }
    }
    
    PPUser *user = [[PPUser alloc] initWithUserId:userId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName communityName:(NSString *)communityName language:language phone:phone phoneType:phoneType smsStatus:smsStatus anonymous:anonymous userPermissions:(RLMArray *)permissionArray tags:(RLMArray *)tags locations:(RLMArray *)locations badges:(RLMArray *)badges organizations:(RLMArray *)organizations avatarFileId:avatarFileId creationDate:creationDate authClients:(RLMArray *)authClients userCommunities:(RLMArray *)userCommunities locationCommunities:(RLMArray *)locationCommunities];
    return user;
}

#pragma mark - Locations

- (PPLocation *)currentLocation {
    if([self isInvalidated]) {
        return nil;
    }
    PPLocationId locationId = PPLocationIdNone;
    if([UICKeyChainStore keyChainStore][@"user.locationId"]) {
        locationId = (PPLocationId)[UICKeyChainStore keyChainStore][@"user.locationId"].integerValue;
    }
    
    PPLocation *currentLocation;
    
    NSMutableArray *locationIds = @[].mutableCopy;
    for(PPLocation *location in self.locations) {
        [locationIds addObject:@(location.locationId)];
        if(location.locationId == locationId && location.locationAccess != PPLocationAccessNoAccess) {
            currentLocation = location;
            break;
        }
    }
    
    if(!currentLocation) {
        PPLocation *location = [[PPLocation objectsWhere:@"locationId IN %@ && locationAccess != %@", locationIds, @(PPLocationAccessNoAccess)] firstObject];
        if(location.locationId != PPLocationIdNone) {
            currentLocation = location;
            [self setCurrentLocation:currentLocation];
        }
    }
    return currentLocation;
}

- (void)setCurrentLocation:(PPLocation *)location {
    if(location) {
        [UICKeyChainStore keyChainStore][@"user.locationId"] = [NSString stringWithFormat:@"%li", (long)location.locationId];
    }
}

#pragma mark - Helper Methods

- (BOOL)isEqualToUser:(PPUser *)user {
    BOOL equal = NO;
    if (user == nil) {
        return equal;
    }
    if(self.userId != PPUserIdNone && user.userId != PPUserIdNone) {
        if(self.userId == user.userId) {
            equal = YES;
        }
    }
    if(self.username && user.username) {
        if([self.username isEqualToString:user.username]) {
            equal = YES;
        }
    }
    if(self.altUsername && user.altUsername) {
        if([self.altUsername isEqualToString:user.altUsername]) {
            equal = YES;
        }
    }
    if(self.sessionKey && user.sessionKey) {
        if([self.sessionKey isEqualToString:user.sessionKey]) {
            equal = YES;
        }
    }

    return equal;
}

+ (void)sync:(PPUser *)existingUser withUser:(PPUser *)user {
    BOOL shouldWrite = NO;
    if (![[PPRealm defaultRealm] inWriteTransaction]) {
        shouldWrite = YES;
    }
    if (shouldWrite) {
//        [[PPRealm defaultRealm] beginWriteTransaction];
    }
    if(user.sessionKey) {
        existingUser.sessionKey = user.sessionKey;
    }
    if(user.sessionKeyExpiry) {
        existingUser.sessionKeyExpiry = user.sessionKeyExpiry;
    }
    if(user.email.email) {
        existingUser.email = user.email;
    }
    if(user.username) {
        existingUser.username = user.username;
    }
    if(user.altUsername) {
        existingUser.altUsername = user.altUsername;
    }
    if(user.firstName) {
        existingUser.firstName = user.firstName;
    }
    if(user.lastName) {
        existingUser.lastName = user.lastName;
    }
    if(user.language) {
        existingUser.language = user.language;
    }
    if(user.phone) {
        existingUser.phone = user.phone;
    }
    if(user.phoneType != PPUserPhoneTypeNone) {
        existingUser.phoneType = user.phoneType;
    }
    if(user.smsStatus != PPUserSMSStatusNone) {
        existingUser.smsStatus = user.smsStatus;
    }
    if(user.anonymous != PPUserAnonymousTypeNone) {
        existingUser.anonymous = user.anonymous;
    }
    if(user.userPermissions) {
        existingUser.userPermissions = user.userPermissions;
    }
    if(user.tags) {
        existingUser.tags = user.tags;
    }
    if(user.authClients) {
        existingUser.authClients = user.authClients;
    }
    if(user.locations) {
        for (PPLocation *location in user.locations) {
            BOOL found = NO;
            for (PPLocation *existingLocation in existingUser.locations) {
                if (location.locationId == existingLocation.locationId) {
                    [[PPRealm defaultRealm] addOrUpdateObject:location];
                    found = YES;
                    break;
                }
            }
            if (!found) {
                [existingUser.locations addObject:location];
            }
        }
        
        NSMutableArray *locationsToDelete = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (PPLocation *location in existingUser.locations) {
            BOOL found = NO;
            for (PPLocation *existingLocation in user.locations) {
                if (location.locationId == existingLocation.locationId) {
                    found = YES;
                    break;
                }
            }
            if (!found) {
                [locationsToDelete addObject:[PPLocation objectForPrimaryKey:@(location.locationId)]];
            }
        }
        if ([locationsToDelete count] > 0) {
            for (PPLocation *location in locationsToDelete) {
                [existingUser.locations removeObjectAtIndex:[existingUser.locations indexOfObject:location]];
            }
        }
    }
    if(user.badges) {
        existingUser.badges = user.badges;
    }
    if(user.organizations) {
        
        for (PPOrganization *organization in user.organizations) {
            NSInteger index = NSNotFound;
            for (PPOrganization *existingOrganization in existingUser.organizations) {
                if (organization.organizationId == existingOrganization.organizationId) {
                    index = [existingUser.organizations indexOfObject:existingOrganization];
                    break;
                }
            }
            if (index != NSNotFound) {
                [existingUser.organizations replaceObjectAtIndex:index withObject:organization];
            }
            else {
                [existingUser.organizations addObject:organization];
            }
        }
        
        NSMutableArray *organizationsToDelete = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (PPOrganization *organization in existingUser.organizations) {
            BOOL found = NO;
            for (PPOrganization *existingOrganization in user.organizations) {
                if (organization.organizationId == existingOrganization.organizationId) {
                    found = YES;
                    break;
                }
            }
            if (!found) {
                [organizationsToDelete addObject:organization];
            }
        }
        if ([organizationsToDelete count] > 0) {
            for (PPOrganization *organization in organizationsToDelete) {
                [existingUser.organizations removeObjectAtIndex:[existingUser.organizations indexOfObject:organization]];
            }
        }
    }
    if(user.avatarFileId != PPUserAvatarFileIdNone) {
        existingUser.avatarFileId = user.avatarFileId;
    }
    if (shouldWrite) {
//        [[PPRealm defaultRealm] commitWriteTransaction];
    }
    if(user.userCommunities) {
        existingUser.userCommunities = user.userCommunities;
    }
    if(user.locationCommunities) {
        existingUser.locationCommunities = user.locationCommunities;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUser *user = [[[self class] allocWithZone:zone] init];
    
    user.userId = self.userId;
    user.email = [self.email copyWithZone:zone];
    user.username = [self.username copyWithZone:zone];
    user.altUsername = [self.altUsername copyWithZone:zone];
    user.firstName = [self.firstName copyWithZone:zone];
    user.lastName = [self.lastName copyWithZone:zone];
    user.language = [self.language copyWithZone:zone];
    user.phone = [self.phone copyWithZone:zone];
    user.phoneType = self.phoneType;
    user.smsStatus = self.smsStatus;
    user.anonymous = self.anonymous;
    NSMutableArray *userPermissions = [[NSMutableArray alloc] initWithCapacity:self.userPermissions.count];
    for (int i = 0; i < self.userPermissions.count; i++) {
        NSInteger userPermission = (NSInteger)[self.userPermissions objectAtIndex:i];
        [userPermissions addObject:@(userPermission)];
    }
    user.userPermissions = userPermissions;
    NSMutableArray *tags = [[NSMutableArray alloc] initWithCapacity:self.tags.count];
    for (PPUserTag *tag in self.tags) {
        [tags addObject:[tag copyWithZone:zone]];
    }
    user.tags = tags;
    NSMutableArray *authClients = [[NSMutableArray alloc] initWithCapacity:self.authClients.count];
    for (PPCloudsIntegrationHost *authClient in self.authClients) {
        [authClients addObject:[authClient copyWithZone:zone]];
    }
    user.authClients = authClients;
    NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:self.locations.count];
    for (PPLocation *location in self.locations) {
        [locations addObject:[location copyWithZone:zone]];
    }
    user.locations = locations;
    NSMutableArray *badges = [[NSMutableArray alloc] initWithCapacity:self.badges.count];
    for (PPUserBadge *badge in self.badges) {
        [badges addObject:[badge copyWithZone:zone]];
    }
    user.badges = badges;
    NSMutableArray *organizations = [[NSMutableArray alloc] initWithCapacity:self.organizations.count];
    for (PPOrganization *organization in self.organizations) {
        [organizations addObject:[organization copyWithZone:zone]];
    }
    user.organizations = organizations;
    user.avatarFileId = self.avatarFileId;
    user.userCommunities = self.userCommunities;
    user.locationCommunities = self.locationCommunities;
    
    return user;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.userId = (PPUserId)((NSNumber *)[decoder decodeObjectForKey:@"userId"]).integerValue;
        self.email = [decoder decodeObjectForKey:@"email"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.altUsername = [decoder decodeObjectForKey:@"altUsername"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.language = [decoder decodeObjectForKey:@"language"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.phoneType = (PPUserPhoneType)((NSNumber *)[decoder decodeObjectForKey:@"phoneType"]).integerValue;
        self.smsStatus = (PPUserSMSStatus)((NSNumber *)[decoder decodeObjectForKey:@"smsStatus"]).integerValue;
        self.anonymous = (PPUserAnonymousType)((NSNumber *)[decoder decodeObjectForKey:@"anonymous"]).integerValue;
        self.userPermissions = [decoder decodeObjectForKey:@"userPermissions"];
        self.tags = [decoder decodeObjectForKey:@"tags"];
        self.authClients = [decoder decodeObjectForKey:@"authClients"];
        self.locations = [decoder decodeObjectForKey:@"locations"];
        self.badges = [decoder decodeObjectForKey:@"badges"];
        self.organizations = [decoder decodeObjectForKey:@"organizations"];
        self.avatarFileId = (PPUserAvatarFileId)((NSNumber *)[decoder decodeObjectForKey:@"avatarFileId"]).integerValue;
        self.userCommunities = [decoder decodeObjectForKey:@"userCommunities"];
        self.locationCommunities = [decoder decodeObjectForKey:@"locationCommunities"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:@(self.userId) forKey:@"userId"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.altUsername forKey:@"altUsername"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.language forKey:@"language"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:@(self.phoneType) forKey:@"phoneType"];
    [encoder encodeObject:@(self.smsStatus) forKey:@"smsStatus"];
    [encoder encodeObject:@(self.anonymous) forKey:@"anonymous"];
    [encoder encodeObject:self.userPermissions forKey:@"userPermissions"];
    [encoder encodeObject:self.tags forKey:@"tags"];
    [encoder encodeObject:self.authClients forKey:@"authClients"];
    [encoder encodeObject:self.locations forKey:@"locations"];
    [encoder encodeObject:self.badges forKey:@"badges"];
    [encoder encodeObject:self.organizations forKey:@"organizations"];
    [encoder encodeObject:@(self.avatarFileId) forKey:@"avatarFileId"];
    [encoder encodeObject:self.userCommunities forKey:@"userCommunities"];
    [encoder encodeObject:self.locationCommunities forKey:@"locationCommunities"];
}


@end
