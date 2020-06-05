//
//  PPOperationToken.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@class PPOperationToken;

typedef void (^PPOperationTokenBlock)(PPOperationToken * _Nullable operationToken, NSError * _Nullable error);
typedef void (^PPOperationTokenValidityBlock)(BOOL isValid);

/**
 * Opeartion Token types
 */
typedef enum {
    PPOperationTokenTypeUserRegistration = 1
} PPOperationTokenType;

@interface PPOperationToken : PPBaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic) PPOperationTokenType type;
@property (nonatomic, strong) NSDate *validFrom;
@property (nonatomic, strong) NSDate *expire;

- (id)initWithToken:(NSString *)token type:(PPOperationTokenType)type validFrom:(NSDate *)validFrom expire:(NSDate *)expire;

/**
 * Check operation token validitiy
 *
 * This method will wait to return a true statement if the current time is earlier then the token's validFrom time.
 * This method will return a false statement if the current time is later then the token's expire time.
 *
 * @param callback PPBooleanBlock Booling callback block. True if token is valid.
 */
- (void)isValid:(PPBooleanBlock)callback;
- (void)cancelValidation;

@end
