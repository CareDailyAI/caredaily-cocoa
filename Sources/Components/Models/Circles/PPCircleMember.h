//
//  PPCircleMember.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUser.h"

@interface PPCircleMember : PPUser

@property (nonatomic) PPCircleMemberAdmin admin;
@property (nonatomic) PPCircleMemberStatus status;
@property (nonatomic) PPCircleMemberPhoneStatus phoneStatus;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *circleUserId;

- (id)initWithUserId:(PPUserId)userId email:(PPUserEmail *)email username:(NSString *)username altUsername:(NSString *)altUsername firstName:(NSString *)firstName lastName:(NSString *)lastName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType smsStatus:(PPUserSMSStatus)smsStatus anonymous:(PPUserAnonymousType)anonymous userPermissions:(NSArray *)userPermissions tags:(NSArray *)tags locations:(NSArray *)locations badges:(NSArray *)badges organizations:(NSArray *)organizations avatarFileId:(PPUserAvatarFileId)avatarFileId nickname:(NSString *)nickname admin:(PPCircleMemberAdmin)admin status:(PPCircleMemberStatus)status phoneStatus:(PPCircleMemberPhoneStatus)phoneStatus circleUserId:(NSString *)circleUserId;

+ (PPCircleMember *)initWithDictionary:(NSDictionary *)memberDict;

@end
