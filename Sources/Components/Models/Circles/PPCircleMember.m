//
//  PPCircleMember.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCircleMember.h"

@implementation PPCircleMember

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(RLMArray *)userPermissions tags:(RLMArray *)tags locations:(RLMArray *)locations badges:(RLMArray *)badges organizations:(RLMArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId nickname:(NSString *)nickname admin:(PPCircleMemberAdmin)admin status:(PPCircleMemberStatus)status phoneStatus:(PPCircleMemberPhoneStatus)phoneStatus circleUserId:(NSString *)circleUserId {
    self = [super initWithUserId:userId email:email username:username altUsername:altUsername firstName:firstName lastName:lastName communityName:nil language:language phone:phone phoneType:phoneType smsStatus:smsStatus anonymous:anonymous userPermissions:userPermissions tags:tags locations:locations badges:badges organizations:organizations avatarFileId:avatarFileId creationDate:nil authClients:nil userCommunities:nil locationCommunities:nil];
    if(self) {
        self.nickname = nickname;
        self.admin = admin;
        self.status = status;
        self.phoneStatus = phoneStatus;
        self.circleUserId = circleUserId;
    }
    return self;
}

+ (PPCircleMember *)initWithDictionary:(NSDictionary *)memberDict {
    PPUser *user = [PPUser initWithDictionary:memberDict];
    
    PPCircleMemberAdmin admin = PPCircleMemberAdminNone;
    if([memberDict objectForKey:@"admin"]) {
        admin = (PPCircleMemberAdmin)((NSString *)[memberDict objectForKey:@"admin"]).integerValue;
    }
    PPCircleMemberStatus status = PPCircleMemberStatusNone;
    if([memberDict objectForKey:@"status"]) {
        status = (PPCircleMemberStatus)((NSString *)[memberDict objectForKey:@"status"]).integerValue;
    }
    PPCircleMemberPhoneStatus phoneStatus = PPCircleMemberPhoneStatusNone;
    if([memberDict objectForKey:@"phoneStatus"]) {
        phoneStatus = (PPCircleMemberPhoneStatus)((NSString *)[memberDict objectForKey:@"phoneStatus"]).integerValue;
    }
    
    NSString *nickname = [memberDict objectForKey:@"nickname"];
    
    NSString *circleUserId = [memberDict objectForKey:@"circleUserId"];
    
    PPCircleMember *member = [[PPCircleMember alloc] initWithUserId:user.userId email:user.email username:user.username altUsername:user.altUsername firstName:user.firstName lastName:user.lastName language:user.language phone:user.phone phoneType:user.phoneType smsStatus:user.smsStatus anonymous:user.anonymous userPermissions:user.userPermissions tags:user.tags locations:user.locations badges:user.badges organizations:user.organizations avatarFileId:user.avatarFileId nickname:nickname admin:admin status:status phoneStatus:phoneStatus circleUserId:circleUserId];
    return member;
}

@end
