//
//  PPOperationToken.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

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
