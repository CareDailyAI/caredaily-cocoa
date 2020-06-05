//
//  PPOperationTokenManagement.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOperationToken.h"

@interface PPOperationTokenManagement : PPBaseModel

#pragma mark - Operation token
/**
 * Generate a new operation token, which can be used in other API calls instead of optional API key. The operation token is valid exactly between two time values in milliseconds from the current moment retruned by the API with the token and can be used only once.
 * The token value should be provided in the "PPCAuthorization" HTTP header with the "op token=" prefix. For example, "PPCAuthorization: op token=abc123456"
 *
 * @param tokenType PPOperationTokenType Type of operation token to be received:
 *      1 = User registration. Create a new user account API.
 * @param callback PPOperationTokenBlock Operation token class object.
 */
+ (void)getOperationToken:(PPOperationTokenType)tokenType callback:(PPOperationTokenBlock)callback;

#pragma mark - Locking Accounts

+ (void)lockAccount:(NSString *)username root:(NSDictionary *)root;
+ (BOOL)isAccountLockedForUser:(NSString *)username error:(NSError **)lockError;
+ (BOOL)isAccountLocked:(NSString *)username error:(NSError **)lockError;

@end
