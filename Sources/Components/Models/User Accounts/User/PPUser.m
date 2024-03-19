//
//  PPUser.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPUser.h"
#import "PPOperationToken.h"

@implementation PPUser

- (id)initWithCachedUser {
    NSString *cachedUsername = [UICKeyChainStore keyChainStore][@"user.username"];
    NSString *cachedAltUsername = [UICKeyChainStore keyChainStore][@"user.altUsername"];
    NSString *cachedSessionKey = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", cachedUsername]];
    
    return [self initWithSessionKey:cachedSessionKey username:cachedUsername altUsername:cachedAltUsername];
}

- (id)initWithSessionKey:(NSString *)sessionKey username:(NSString *)username {
    return [self initWithSessionKey:sessionKey username:username altUsername:nil];
}

- (id)initWithSessionKey:(NSString *)sessionKey username:(NSString *)username altUsername:(NSString *)altUsername {
    self = [[PPUser alloc] initWithUserId:PPUserIdNone email:[[PPUserEmail alloc] initWithEmail:nil verified:PPUserEmailVerifiedNone status:PPUserEmailStatusNone] username:username altUsername:altUsername firstName:nil lastName:nil communityName:nil language:nil phone:nil phoneType:PPUserPhoneTypeNone smsStatus:PPUserSMSStatusNone anonymous:PPUserAnonymousTypeNone userPermissions:nil tags:nil locations:nil badges:nil organizations:nil avatarFileId:PPUserAvatarFileIdNone creationDate:nil authClients:nil userCommunities:nil locationCommunities:nil];
    if(self) {
        self.sessionKey = sessionKey;
    }
    return self;
}

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName communityName:(NSString *)communityName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(NSArray *)userPermissions tags:(NSArray *)tags locations:(NSArray *)locations badges:(NSArray *)badges organizations:(NSArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId creationDate:(NSDate *)creationDate authClients:(NSArray *)authClients userCommunities:(NSArray *)userCommunities locationCommunities:(NSArray *)locationCommunities accessibility:(PPUserAccessibility)accessibility {
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
        self.userPermissions = userPermissions;
        self.tags = tags;
        self.authClients = authClients;
        self.locations = locations;
        self.badges = badges;
        self.organizations = organizations;
        self.avatarFileId = avatarFileId;
        self.creationDate = creationDate;
        self.userCommunities = userCommunities;
        self.locationCommunities = locationCommunities;
        self.accessibility = accessibility;
    }
    return self;
}
- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName communityName:(NSString *)communityName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(NSArray *)userPermissions tags:(NSArray *)tags locations:(NSArray *)locations badges:(NSArray *)badges organizations:(NSArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId creationDate:(NSDate *)creationDate authClients:(NSArray *)authClients userCommunities:(NSArray *)userCommunities locationCommunities:(NSArray *)locationCommunities __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use initWithUserId:email:username:altUsername:firstName:lastName:communityName:language:phone:phoneType:smsStatus:anonymous:userPermissions:tags:locations:badges:organizations:avatarFileId:creationDate:authClients:userCommunities:locationCommunities:accessibility:{", __FUNCTION__);
    return [self initWithUserId:userId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName communityName:communityName language:language phone:phone phoneType:phoneType smsStatus:smsStatus anonymous:anonymous userPermissions:userPermissions tags:tags locations:locations badges:badges organizations:organizations avatarFileId:avatarFileId creationDate:creationDate authClients:authClients userCommunities:userCommunities locationCommunities:locationCommunities accessibility:PPUserAccessibilityNone];
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
    
    PPUserAccessibility accessibility = PPUserAccessibilityNone;
    if([userDict objectForKey:@"accessibility"]) {
        accessibility = (PPUserAccessibility)((NSString *)[userDict objectForKey:@"accessibility"]).integerValue;
    }
    
    PPUser *user = [[PPUser alloc] initWithUserId:userId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName communityName:communityName language:language phone:phone phoneType:phoneType smsStatus:smsStatus anonymous:anonymous userPermissions:permissionArray tags:tags locations:locations badges:badges organizations:organizations avatarFileId:avatarFileId creationDate:creationDate authClients:authClients userCommunities:userCommunities locationCommunities:locationCommunities accessibility:accessibility];
    return user;
}

#pragma mark - Locations

- (PPLocation *)currentLocation {
    PPLocationId locationId = PPLocationIdNone;
    if([UICKeyChainStore keyChainStore][@"user.locationId"]) {
        locationId = (PPLocationId)[UICKeyChainStore keyChainStore][@"user.locationId"].integerValue;
    }
    
    PPLocation *currentLocation;
    
    for(PPLocation *location in self.locations) {
        if(location.locationId == locationId && location.locationAccess != PPLocationAccessNoAccess) {
            currentLocation = location;
            break;
        }
    }
    
    if(!currentLocation) {
        for (PPLocation *location in self.locations) {
            if(location.locationId != PPLocationIdNone && location.locationAccess != PPLocationAccessNoAccess) {
                currentLocation = location;
                [self setCurrentLocation:currentLocation];
                break;
            }
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

- (void)sync:(PPUser *)user {
    if(user.userId != PPUserIdNone) {
        self.userId = user.userId;
    }
    if(user.sessionKey) {
        self.sessionKey = user.sessionKey;
    }
    if(user.sessionKeyExpiry) {
        self.sessionKeyExpiry = user.sessionKeyExpiry;
    }
    if(user.email.email) {
        self.email = user.email;
    }
    if(user.username) {
        self.username = user.username;
    }
    if(user.altUsername) {
        self.altUsername = user.altUsername;
    }
    if(user.firstName) {
        self.firstName = user.firstName;
    }
    if(user.lastName) {
        self.lastName = user.lastName;
    }
    if(user.language) {
        self.language = user.language;
    }
    if(user.phone) {
        self.phone = user.phone;
    }
    if(user.phoneType != PPUserPhoneTypeNone) {
        self.phoneType = user.phoneType;
    }
    if(user.smsStatus != PPUserSMSStatusNone) {
        self.smsStatus = user.smsStatus;
    }
    if(user.anonymous != PPUserAnonymousTypeNone) {
        self.anonymous = user.anonymous;
    }
    if(user.userPermissions) {
        self.userPermissions = user.userPermissions;
    }
    if(user.tags) {
        self.tags = user.tags;
    }
    if(user.authClients) {
        self.authClients = user.authClients;
    }
    if(user.locations) {
        self.locations = user.locations;
    }
    if(user.badges) {
        self.badges = user.badges;
    }
    if(user.organizations) {
        self.organizations = user.organizations;
    }
    if(user.avatarFileId != PPUserAvatarFileIdNone) {
        self.avatarFileId = user.avatarFileId;
    }
    if(user.userCommunities) {
        self.userCommunities = user.userCommunities;
    }
    if(user.locationCommunities) {
        self.locationCommunities = user.locationCommunities;
    }
    if(user.accessibility != PPUserAccessibilityNone) {
        self.accessibility = user.accessibility;
    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPUser *user = [[PPUser allocWithZone:zone] init];
    
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
    user.userPermissions = self.userPermissions;
    user.tags = self.tags;
    user.authClients = self.authClients;
    user.locations = self.locations;
    user.badges = self.badges;
    user.organizations = self.organizations;
    user.avatarFileId = self.avatarFileId;
    user.userCommunities = self.userCommunities;
    user.locationCommunities = self.locationCommunities;
    user.accessibility = self.accessibility;
    
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
        self.accessibility = (PPUserAccessibility)((NSNumber *)[decoder decodeObjectForKey:@"accessibility"]).integerValue;
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
    [encoder encodeObject:@(self.accessibility) forKey:@"accessibility"];
}


@end
