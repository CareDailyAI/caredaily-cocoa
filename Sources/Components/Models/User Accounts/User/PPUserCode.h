//
//  PPUserCode.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

/* User codes are similar to passwords.
 They are not retrievable in any readable form, so a name is provided instead.
 It is up to the user to remember their codes (or delete and recreate). */
@interface PPUserCode : PPBaseModel

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
