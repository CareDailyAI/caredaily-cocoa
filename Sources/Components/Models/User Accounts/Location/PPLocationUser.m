//
//  PPLocationUser.m
//  Peoplepower
//
//  Created by Destry Teeter on 12/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPLocationUser.h"

@implementation PPLocationUser

- (id)initWithUserId:(PPUserId)userId
          locationId:(PPLocationId)locationId
               email:(PPUserEmail *)email
            username:(NSString *)username
         altUsername:(NSString *)altUsername
           firstName:(NSString *)firstName
            lastName:(NSString *)lastName
               phone:(NSString *)phone
           phoneType:(PPUserPhoneType)phoneType
           smsStatus:(PPUserSMSStatus)smsStatus
      locationAccess:(PPLocationAccess)locationAccess
            category:(PPLocationCategory)category
           schedules:(RLMArray *)schedules
        avatarFileId:(PPUserAvatarFileId)avatarFileId
           temporary:(PPLocationTemporary)temporary
       accessEndDate:(NSDate *)accessEndDate
                role:(PPLocationUserRole)role
 medicalRecordNumber:(NSString *)medicalRecordNumber
           pronounId:(PPUserPronounId)pronounId
       accessibility:(PPUserAccessibility)accessibility
           birthDate:(NSString *)birthDate
              gender:(PPUserGender)gender
           residency:(PPLocationResidency)residency {
    self = [super initWithUserId:userId
                           email:email
                        username:username
                     altUsername:altUsername
                       firstName:firstName
                        lastName:lastName
                   communityName:nil
                        language:nil
                           phone:phone
                       phoneType:phoneType
                       smsStatus:smsStatus
                       anonymous:PPUserAnonymousTypeNone
                 userPermissions:nil
                            tags:nil
                       locations:nil
                          badges:nil
                   organizations:nil
                    avatarFileId:avatarFileId
                    creationDate:nil
                     authClients:nil
                 userCommunities:nil
             locationCommunities:nil
             medicalRecordNumber:medicalRecordNumber
                       pronounId:pronounId
                   accessibility:accessibility
                       birthDate:birthDate
                          gender:gender];
    if(self) {
        self.locationId = locationId;
        self.locationAccess = locationAccess;
        self.category = category;
        self.role = role;
        self.residency = residency;
        self.schedules = (RLMArray<PPLocationUserSchedule *><PPLocationUserSchedule> *)schedules;
        self.temporary = temporary;
        self.accessEndDate = accessEndDate;
    }
    return self;
}
- (id)initWithUserId:(PPUserId)userId locationId:(PPLocationId)locationId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus locationAccess:(PPLocationAccess)locationAccess category:(PPLocationCategory)category schedules:(RLMArray *)schedules avatarFileId:(PPUserAvatarFileId)avatarFileId temporary:(PPLocationTemporary)temporary accessEndDate:(NSDate *)accessEndDate role:(PPLocationUserRole)role accessibility:(PPUserAccessibility)accessibility birthDate:(NSString *)birthDate gender:(PPUserGender)gender  __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use -initWithUserId:locationId:email:username:altUsername:firstName:lastName:phone:phoneType:smsStatus:locationAccess:category:schedules:avatarFileId:temporary:accessEndDate:role:medicalRecordNumber:pronounId:accessibility:birthDate:gender:residency:", __FUNCTION__);
    return [self initWithUserId:userId locationId:locationId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName phone:phone phoneType:phoneType smsStatus:smsStatus locationAccess:locationAccess category:category schedules:schedules avatarFileId:avatarFileId temporary:temporary accessEndDate:accessEndDate role:role medicalRecordNumber:nil pronounId:PPUserPronounIdNone accessibility:accessibility birthDate:nil gender:PPUserGenderNone residency:PPLocationResidencyNone];
}
- (id)initWithUserId:(PPUserId)userId locationId:(PPLocationId)locationId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus locationAccess:(PPLocationAccess)locationAccess category:(PPLocationCategory)category schedules:(RLMArray *)schedules avatarFileId:(PPUserAvatarFileId)avatarFileId temporary:(PPLocationTemporary)temporary accessEndDate:(NSDate *)accessEndDate role:(PPLocationUserRole)role accessibility:(PPUserAccessibility)accessibility  __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use -initWithUserId:locationId:email:username:altUsername:firstName:lastName:phone:phoneType:smsStatus:locationAccess:category:schedules:avatarFileId:temporary:accessEndDate:role:medicalRecordNumber:pronounId:accessibility:birthDate:gender:", __FUNCTION__);
    return [self initWithUserId:userId locationId:locationId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName phone:phone phoneType:phoneType smsStatus:smsStatus locationAccess:locationAccess category:category schedules:schedules avatarFileId:avatarFileId temporary:temporary accessEndDate:accessEndDate role:PPLocationUserRoleNone medicalRecordNumber:nil pronounId:PPUserPronounIdNone accessibility:PPUserAccessibilityNone birthDate:nil gender:PPUserGenderNone];
}
- (id)initWithUserId:(PPUserId)userId locationId:(PPLocationId)locationId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus locationAccess:(PPLocationAccess)locationAccess category:(PPLocationCategory)category schedules:(RLMArray *)schedules avatarFileId:(PPUserAvatarFileId)avatarFileId temporary:(PPLocationTemporary)temporary accessEndDate:(NSDate *)accessEndDate  __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use -initWithUserId:locationId:email:username:altUsername:firstName:lastName:phone:phoneType:smsStatus:locationAccess:category:schedules:avatarFileId:temporary:accessEndDate:role:medicalRecordNumber:pronounId:accessibility:birthDate:gender:", __FUNCTION__);
    return [self initWithUserId:userId locationId:locationId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName phone:phone phoneType:phoneType smsStatus:smsStatus locationAccess:locationAccess category:category schedules:schedules avatarFileId:avatarFileId temporary:temporary accessEndDate:accessEndDate role:PPLocationUserRoleNone medicalRecordNumber:nil pronounId:PPUserPronounIdNone accessibility:PPUserAccessibilityNone birthDate:nil gender:PPUserGenderNone];
}

+ (PPLocationUser *)initWithDictionary:(NSDictionary *)userDict {
    PPUser *user = [PPUser initWithDictionary:userDict];
    
    PPLocationAccess locationAccess = PPLocationAccessNone;
    if([userDict objectForKey:@"locationAccess"]) {
        locationAccess = (PPLocationAccess)((NSString *)[userDict objectForKey:@"locationAccess"]).integerValue;
    }
    PPLocationCategory userCategory = PPLocationCategoryNone;
    if([userDict objectForKey:@"category"]) {
        userCategory = (PPLocationCategory)((NSString *)[userDict objectForKey:@"category"]).integerValue;
    }
    PPLocationUserRole role = PPLocationUserRoleNone;
    if([userDict objectForKey:@"role"]) {
        role = (PPLocationUserRole)((NSString *)[userDict objectForKey:@"role"]).integerValue;
    }
    PPLocationResidency residency = PPLocationResidencyNone;
    if([userDict objectForKey:@"residency"]) {
        residency = (PPLocationResidency)((NSString *)[userDict objectForKey:@"residency"]).integerValue;
    }
    
    NSMutableArray *schedules;
    if([userDict objectForKey:@"schedules"]) {
        schedules = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *schedulesDict in [userDict objectForKey:@"schedules"]) {
            PPLocationUserSchedule *schedule = [PPLocationUserSchedule initWithDictionary:schedulesDict];
            [schedules addObject:schedule];
        }
    }
    
    PPLocationTemporary temporary = PPLocationTemporaryNone;
    if([userDict objectForKey:@"temporary"]) {
        temporary = (PPLocationTemporary)((NSString *)[userDict objectForKey:@"temporary"]).integerValue;
    }
    
    NSString *accessEndDateString = [userDict objectForKey:@"accessEndDate"];
    NSDate *accessEndDate = [NSDate dateWithTimeIntervalSince1970:0];
    if(accessEndDateString != nil) {
        if(![accessEndDateString isEqualToString:@""]) {
            accessEndDate = [PPNSDate parseDateTime:accessEndDateString];
        }
    }
    
    PPLocationUser *locationUser = [[PPLocationUser alloc] initWithUserId:user.userId
                                                               locationId:PPLocationIdNone
                                                                    email:user.email
                                                                 username:user.username
                                                              altUsername:user.altUsername
                                                                firstName:user.firstName
                                                                 lastName:user.lastName
                                                                    phone:user.phone
                                                                phoneType:user.phoneType
                                                                smsStatus:user.smsStatus
                                                           locationAccess:locationAccess
                                                                 category:userCategory
                                                                schedules:(RLMArray *)schedules
                                                             avatarFileId:user.avatarFileId
                                                                temporary:temporary
                                                            accessEndDate:accessEndDate
                                                                     role:role
                                                      medicalRecordNumber:user.medicalRecordNumber
                                                                pronounId:user.pronounId
                                                            accessibility:user.accessibility
                                                                birthDate:user.birthDate
                                                                   gender:user.gender
                                                                residency:residency];
    return locationUser;
}

@end
