//
//  PPCircleMember.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUser.h"

typedef NS_OPTIONS(NSInteger, PPCircleMemberStatus) {
    PPCircleMemberStatusNone = -1,
    PPCircleMemberStatusInvited = 0,
    PPCircleMemberStatusOptIn = 1,
    PPCircleMemberStatusOptOut = 2
};

typedef NS_OPTIONS(NSInteger, PPCircleMemberAdmin) {
    PPCircleMemberAdminNone = -1,
    PPCircleMemberAdminFalse = 0,
    PPCircleMemberAdminTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPCircleMemberPhoneStatus) {
    PPCircleMemberPhoneStatusNone = -1,
    PPCircleMemberPhoneStatusUnknown = 0,
    PPCircleMemberPhoneStatusVerified = 1, // verification code sent and verified
    PPCircleMemberPhoneStatusAllowed = 2, // mobile phone number, which can receive SMS, but not verified yet
    PPCircleMemberPhoneStatusInvalid = 3 // invalid phone number
};

@interface PPCircleMember : PPUser

@property (nonatomic) PPCircleMemberAdmin admin;
@property (nonatomic) PPCircleMemberStatus status;
@property (nonatomic) PPCircleMemberPhoneStatus phoneStatus;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *circleUserId;

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(RLMArray *)userPermissions tags:(RLMArray *)tags locations:(RLMArray *)locations badges:(RLMArray *)badges organizations:(RLMArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId nickname:(NSString *)nickname admin:(PPCircleMemberAdmin)admin status:(PPCircleMemberStatus)status phoneStatus:(PPCircleMemberPhoneStatus)phoneStatus circleUserId:(NSString *)circleUserId;

+ (PPCircleMember *)initWithDictionary:(NSDictionary *)memberDict;

@end

