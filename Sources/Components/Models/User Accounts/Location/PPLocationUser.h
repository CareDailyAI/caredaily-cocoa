//
//  PPLocationUser.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationUserSchedule.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPLocationUser : PPUser

@property (nonatomic) PPLocationId locationId;
@property (nonatomic) PPLocationAccess locationAccess;
@property (nonatomic) PPLocationCategory category;
@property (nonatomic, strong) NSArray * _Nullable schedules;
@property (nonatomic) PPLocationTemporary temporary;
@property (nonatomic, strong) NSDate * _Nullable accessEndDate;

- (id _Nonnull )initWithUserId:(PPUserId)userId
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
           schedules:(NSArray * _Nullable )schedules
        avatarFileId:(PPUserAvatarFileId)avatarFileId
           temporary:(PPLocationTemporary)temporary
       accessEndDate:(NSDate * _Nullable )accessEndDate;

+ (PPLocationUser * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )userDict;

@end

NS_ASSUME_NONNULL_END
