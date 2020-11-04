//
//  PPUserCode.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPUserCodeType) {
    PPUserCodeTypeManual   = 1,
    PPUserCodeTypeCard     = 2,
    PPUserCodeTypeCombined = 3,
    PPUserCodeTypeKeypad   = 4,
};

typedef NS_OPTIONS(NSInteger, PPUserCodeExpiry) {
    PPUserCodeExpiryNone    = -1,
    PPUserCodeExpiryDefault = 60
};

typedef NS_OPTIONS(NSInteger, PPUserCodeVerified) {
    PPUserCodeVerifiedNone    = -1,
    PPUserCodeVerifiedFalse   = 0,
    PPUserCodeVerifiedTrue    = 1,
};

/* User codes are similar to passwords.
 They are not retrievable in any readable form, so a name is provided instead.
 It is up to the user to remember their codes (or delete and recreate). */
@interface PPUserCode : NSObject

/* Name assigned to this code */
@property (strong, nonatomic) NSString *name;

/* Type of code*/
@property (nonatomic) PPUserCodeType type;

/* Code - Maintain local reference to the code */
@property (strong, nonatomic) NSString *code;

/* Verified - The code is verified if it has been used at least one time successfully on the keypad */
@property (nonatomic) PPUserCodeVerified verified;

- (id)initWithName:(NSString *)name
              type:(PPUserCodeType)type
          verified:(PPUserCodeVerified)verified;

+ (PPUserCode *)initWithDictionary:(NSDictionary *)codeDict;

@end
