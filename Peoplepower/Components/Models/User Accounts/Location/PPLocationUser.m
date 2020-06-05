//
//  PPLocationUser.m
//  PPiOSCore
//
//  Created by Destry Teeter on 12/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationUser.h"

@implementation PPLocationUser

- (id)initWithUserId:(PPUserId)userId locationId:(PPLocationId)locationId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus locationAccess:(PPLocationAccess)locationAccess category:(PPLocationCategory)category schedules:(NSArray *)schedules avatarFileId:(PPUserAvatarFileId)avatarFileId temporary:(PPLocationTemporary)temporary accessEndDate:(NSDate *)accessEndDate {
    self = [super initWithUserId:userId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName communityName:nil language:nil phone:phone phoneType:phoneType smsStatus:smsStatus anonymous:PPUserAnonymousTypeNone userPermissions:nil tags:nil locations:nil badges:nil organizations:nil avatarFileId:avatarFileId creationDate:nil authClients:nil userCommunities:nil locationCommunities:nil];
    if(self) {
        self.locationId = locationId;
        self.locationAccess = locationAccess;
        self.category = category;
        self.schedules = schedules;
        self.temporary = temporary;
        self.accessEndDate = accessEndDate;
    }
    return self;
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
    
    PPLocationUser *locationUser = [[PPLocationUser alloc] initWithUserId:user.userId locationId:PPLocationIdNone email:user.email username:user.username altUsername:user.altUsername firstName:user.firstName lastName:user.lastName phone:user.phone phoneType:user.phoneType smsStatus:user.smsStatus locationAccess:locationAccess category:userCategory schedules:schedules avatarFileId:user.avatarFileId temporary:temporary accessEndDate:accessEndDate];
    return locationUser;
}

@end
