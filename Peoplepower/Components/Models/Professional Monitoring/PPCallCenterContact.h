//
//  PPCallCenterContact.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPCallCenterContactPhoneType) {
    PPCallCenterContactPhoneTypeNone = -1,
    PPCallCenterContactPhoneTypeUnknown = 0,
    PPCallCenterContactPhoneTypeCell = 1,
    PPCallCenterContactPhoneTypeHome = 2,
    PPCallCenterContactPhoneTypeWork = 3,
    PPCallCenterContactPhoneTypeOffice = 4
};
@interface PPCallCenterContact : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic) PPCallCenterContactPhoneType phoneType;
@property (nonatomic) PPUserId userId;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone phoneType:(PPCallCenterContactPhoneType)phoneType userId:(PPUserId)userId;

+ (PPCallCenterContact *)initWithDictionary:(NSDictionary *)contactDict;

+ (NSString *)stringify:(PPCallCenterContact *)contact;

@end
