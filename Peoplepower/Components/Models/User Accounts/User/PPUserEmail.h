//
//  PPUserEmail.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPUserEmailStatus) {
    PPUserEmailStatusNone = -1,
    PPUserEmailStatusOK = 0,
    PPUserEmailStatusHardBound = 1,
    PPUserEmailStatusSpamComplaint = 2,
    PPUserEmailStatusBadAddress = 3,
    PPUserEmailStatusSpamNotification = 4,
};

typedef NS_OPTIONS(NSInteger, PPUserEmailVerified) {
    PPUserEmailVerifiedNone = -1,
    PPUserEmailVerifiedFalse = 0,
    PPUserEmailVerifiedTrue = 1
};

@interface PPUserEmail : RLMObject <NSCopying>

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

RLM_ARRAY_TYPE(PPUserEmail)
