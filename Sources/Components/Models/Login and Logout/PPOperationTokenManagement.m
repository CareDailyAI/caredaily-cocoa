//
//  PPOperationTokenManagement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPOperationTokenManagement.h"
#import "PPCloudEngine.h"

@implementation PPOperationTokenManagement

#pragma mark - Operation token

/**
 * Generate a new operation token, which can be used in other API calls instead of optional API key. The operation token is valid exactly between two time values in milliseconds from the current moment retruned by the API with the token and can be used only once.
 * The token value should be provided in the "PPCAuthorization" HTTP header with the "op token=" prefix. For example, "PPCAuthorization: op token=abc123456"
 *
 * @param tokenType PPOperationTokenType Type of operation token to be received:
 *      1 = User registration. Create a new user account API.
 * @param callback PPOperationTokenBlock Operation token class object.
 */
+ (void)getOperationToken:(PPOperationTokenType)tokenType callback:(PPOperationTokenBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"token"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(tokenType).stringValue]];
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.operationToken.getOperationToken()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPOperationToken *operationToken;
            
            if(!error) {
            
                PPLogAPI(@"%s >> %@", __PRETTY_FUNCTION__, root);
                
                NSString *token = [root objectForKey:@"token"];
                PPOperationTokenType type = ((NSString *)[root objectForKey:@"tokenType"]).intValue;
                float validFrom = ((NSString *)[root objectForKey:@"validFrom"]).floatValue;
                float expire = ((NSString *)[root objectForKey:@"expire"]).floatValue;
                
                NSDate *validFromDate = [NSDate date];
                NSDate *expireDate = [NSDate date];
                
                if([[root allKeys] containsObject:@"expiryMs"]) {
                    NSString *validFromDateString = [root objectForKey:@"validFrom"];
                    NSString *expireDateString = [root objectForKey:@"expiry"];
                    
                    if(validFromDateString != nil) {
                        if(![validFromDateString isEqualToString:@""]) {
                            validFromDate = [PPNSDate parseDateTime:validFromDateString];
                        }
                    }
                    
                    if(expireDateString != nil) {
                        if(![expireDateString isEqualToString:@""]) {
                            expireDate = [PPNSDate parseDateTime:expireDateString];
                        }
                    }
                }
                else {
                    validFromDate = [NSDate dateWithTimeIntervalSinceNow:(validFrom / 1000)];
                    expireDate = [NSDate dateWithTimeIntervalSinceNow:(expire / 1000)];
                }
            
                operationToken = [[PPOperationToken alloc] initWithToken:token type:type validFrom:validFromDate expire:expireDate];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(operationToken, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Locking Accounts

+ (void)lockAccount:(NSString *)username root:(NSDictionary *)root {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lockString = ((NSNumber *)[root objectForKey:@"lockTime"]).stringValue;
    if(username == nil || [username isEqualToString:@""]) {
        username = @"default";
    }
    NSString *key = [NSString stringWithFormat:@"account-%@-lockTime", username];
    [userDefaults setObject:lockString forKey:key];
    [userDefaults synchronize];
}

+ (BOOL)isAccountLockedForUser:(NSString *)username error:(NSError **)lockError {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if(username == nil || [username isEqualToString:@""]) {
        username = @"default";
    }
    NSString *key = [NSString stringWithFormat:@"account-%@-lockTime", username];
    NSString *lockString = [userDefaults objectForKey:key];
    if(lockString != nil && ![lockString isEqualToString:@""]) {
        NSTimeInterval lockTime = lockString.floatValue;
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970] * 1000;
        *lockError = [PPBaseModel resultCodeToNSError:16 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Account is locked until %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Account is locked until {lockTime}"), [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:(lockTime / 1000)] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle]]];
        if(lockTime > now) {
            return YES;
        }
        else {
            [userDefaults setObject:nil forKey:key];
            [userDefaults synchronize];
        }
    }
    return NO;
}

+ (BOOL)isAccountLocked:(NSString *)username error:(NSError **)lockError {
    return [PPOperationTokenManagement isAccountLockedForUser:username error:lockError];
}
@end
