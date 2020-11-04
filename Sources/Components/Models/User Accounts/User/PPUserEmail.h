//
//  PPUserEmail.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPUserEmail : PPBaseModel <NSCopying>

/* An email address is required when registering a new user. */
@property (nonatomic, strong) NSString *email;

/* true if the email address was verified. */
@property (nonatomic) PPUserEmailVerified verified;

/* Email address status. */
@property (nonatomic) PPUserEmailStatus status;

- (id)initWithEmail:(NSString *)email verified:(PPUserEmailVerified)verified status:(PPUserEmailStatus)status;

+ (PPUserEmail *)initWithDictionary:(NSDictionary *)emailDict;

+ (NSString *)stringify:(PPUserEmail *)email;

#pragma mark - Helper methods

- (void)sync:(PPUserEmail *)userEmail;

@end
