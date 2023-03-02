//
//  PPOperationToken.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPOperationToken.h"
#import "PPCloudEngine.h"

@interface PPOperationToken ()

@property (nonatomic, strong) PPOperationTokenValidityBlock validityCallback;
@property (nonatomic) BOOL shouldCancel;
@end

@implementation PPOperationToken

- (id)initWithToken:(NSString *)token type:(PPOperationTokenType)type validFrom:(NSDate *)validFrom expire:(NSDate *)expire {
    self = [super init];
    if(self) {
        self.token = token;
        self.type = type;
        self.validFrom = validFrom;
        self.expire = expire;
        self.shouldCancel = NO;
    }
    return self;
}

/**
 * Check operation token validitiy
 *
 * This method will wait to return a true statement if the current time is earlier then the token's validFrom time.
 * This method will return a false statement if the current time is later then the token's expire time.
 *
 * @param callback PPBooleanBlock Booling callback block. True if token is valid.
 */
- (void)isValid:(PPBooleanBlock)callback {
    _validityCallback = callback;
    [self validityRunLoop];
}

- (void)cancelValidation {
    _shouldCancel = YES;
}

- (void)validityRunLoop {
    if(_shouldCancel) {
        _validityCallback(NO);
        _validityCallback = nil;
        return;
    }
#ifdef DEBUG
    NSLog(@"%s\n" \
          ">> Current   = %.1f\n" \
          ">> validFrom = %.1f\n" \
          ">> exipre    = %.1f\n", __PRETTY_FUNCTION__, [[NSDate date] timeIntervalSince1970], [self.validFrom timeIntervalSince1970], [self.expire timeIntervalSince1970]
          );
#endif
    if(([[NSDate date] timeIntervalSince1970] - [self.validFrom timeIntervalSince1970]) < 0) {
#ifdef DEBUG
        NSLog(@"%s >> go to sleeeeeeep....", __PRETTY_FUNCTION__);
#endif
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self validityRunLoop];
        });
        return;
    }
    
    if([[NSDate date] timeIntervalSince1970] - [self.expire timeIntervalSince1970] > 0) {
#ifdef DEBUG
        NSLog(@"%s INVALID", __PRETTY_FUNCTION__);
#endif
        _validityCallback(NO);
        _validityCallback = nil;
        return;
    }
    
#ifdef DEBUG
    NSLog(@"%s VALID", __PRETTY_FUNCTION__);
#endif
    _validityCallback(YES);
    _validityCallback = nil;
}
@end
