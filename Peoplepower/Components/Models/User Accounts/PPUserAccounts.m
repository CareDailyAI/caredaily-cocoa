//
//  PPUserAccounts.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPUserAccounts.h"
#import "PPCloudEngine.h"
#import "PPDeviceProxy.h"

@implementation PPUserAccounts

#pragma mark - Session Management

#pragma mark Users

__strong static PPUser *_currentUser = nil;

/**
 * Shared user across the entire application
 */
+ (NSArray *)sharedUsers {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPUser *> *sharedUsers = [PPUser allObjects];
    if([sharedUsers count] == 0) {
        [PPUserAccounts initializeSharedUsers];
    }
    NSMutableArray *sharedUserArray = [[NSMutableArray alloc] initWithCapacity:[sharedUsers count]];
    for(PPUser *user in sharedUsers) {
        [sharedUserArray addObject:user];
    }
    return sharedUserArray;
}

/**
 * Current active user
 */
+ (PPUser *)currentUser {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPUser *> *sharedUsers = [PPUser allObjects];
    if([sharedUsers count] == 0) {
        [PPUserAccounts initializeSharedUsers];
    }
    if(_currentUser == nil) {
        _currentUser = [PPUserAccounts initUserWithCachedUser];
    }
    if([_currentUser isInvalidated]) {
        return nil;
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s currentUser=%li username=%@", __PRETTY_FUNCTION__, (long)_currentUser.userId, _currentUser.username);
#endif
#endif
    return _currentUser;
}

+ (void)initializeSharedUsers {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPUser *> *existingUsers = [PPUser allObjectsInRealm:[PPRealm defaultRealm]];
    if(_currentUser == nil) {
        _currentUser = [PPUserAccounts initUserWithCachedUser];
    }
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPUser *user in existingUsers) {
            if([user isEqualToUser:_currentUser]) {
                [PPUser sync:user withUser:_currentUser];
                _currentUser = user;
            }
            else {
                NSString *sessionKey = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", user.username]];
                if(sessionKey && ![sessionKey isEqualToString:@""]) {
                    user.sessionKey = sessionKey;
                }
            }
        }
    }];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
     NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

+ (PPUser *)initUserWithCachedUser {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSString *username = [UICKeyChainStore keyChainStore][@"user.username"];
    NSString *sessionKey = [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", username]];
    
    if(sessionKey) {
        if(!_currentUser) {
            _currentUser = [[PPUser alloc] initWithSessionKey:sessionKey username:username];
        }
        
        if(![sessionKey isEqualToString:_currentUser.sessionKey]) {
            _currentUser.sessionKey = sessionKey;
        }
        if(![username isEqualToString:_currentUser.username]) {
            _currentUser.username = username;
        }
        
        [PPCloudEngine setUser:_currentUser];
    
        [[PPRealm defaultRealm] beginWriteTransaction];
        [PPUser createOrUpdateInDefaultRealmWithValue:_currentUser];
        [[PPRealm defaultRealm] commitWriteTransaction];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s currentUser=%@ username=%@", __PRETTY_FUNCTION__, _currentUser, _currentUser.username);
#endif
#endif
    return _currentUser;
}


/**
 * Switch to active user.
 *
 * @param user PPUser User to switch to
 **/
+ (void)switchUser:(PPUser *)user {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s user=%@ username=%@", __PRETTY_FUNCTION__, user, user.username);
#endif
#endif
    RLMResults<PPUser *> *sharedUsers = [PPUser allObjects];
    if([sharedUsers count] == 0) {
        [PPUserAccounts initializeSharedUsers];
    }
    
    if(user == nil) {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s ! invalid user", __PRETTY_FUNCTION__);
#endif
#endif
        return;
    }
    
    if(![_currentUser isInvalidated] && [_currentUser isEqualToUser:user]) {
        if(_currentUser.userId == PPUserIdNone && _currentUser.userId != user.userId) {
            
            user.sessionKey = _currentUser.sessionKey;
            user.sessionKeyExpiry = _currentUser.sessionKeyExpiry;
            
            // Remove our currently managed user if needed
            PPUser *managedUser = [PPUser objectForPrimaryKey:@(_currentUser.userId)];
            if (managedUser) {
                [[PPRealm defaultRealm] transactionWithBlock:^{
                    [[PPRealm defaultRealm] deleteObject:managedUser];
                }];
            }
            
            _currentUser = user;
        }
        else {
            [[PPRealm defaultRealm] transactionWithBlock:^{
                [PPUser sync:_currentUser withUser:user];
            }];
        }
    }
    else {
//        _currentUser = user;
//#warning Realm RLMArray objects are non-null objects, causing unwanted replacement of existing properties
//        /*
        BOOL found = NO;
        for(PPUser *sharedUser in sharedUsers) {
            if([sharedUser isEqualToUser:user]) {
                found = YES;
                _currentUser = sharedUser;
                [[PPRealm defaultRealm] transactionWithBlock:^{
                    [PPUser sync:sharedUser withUser:user];
                }];
                break;
            }
        }
        if(!found) {
            _currentUser = user;
        }
//         */
    }
    
    [[PPRealm defaultRealm] beginWriteTransaction];
    [PPUser createOrUpdateInDefaultRealmWithValue:_currentUser];
    [[PPRealm defaultRealm] commitWriteTransaction];
    
    _currentUser = [PPUser objectForPrimaryKey:@(_currentUser.userId)];
    
    [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", _currentUser.username]] = _currentUser.sessionKey;
    [UICKeyChainStore keyChainStore][@"user.username"] = _currentUser.username;
    
    [PPCloudEngine setUser:_currentUser];
        
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Sign out users locally.
 * Does not log users out.  API keys will remain active on other devices.
 *
 * @param users NSArray Array of users to sign out.
 **/
+ (void)signOut:(NSArray *)users {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s users=%@", __PRETTY_FUNCTION__, users);
#endif
#endif
    // If signing out of current user then sign out of all other users
    BOOL found = NO;
    for(PPUser *sharedUser in users) {
        if([sharedUser isEqualToUser:_currentUser]) {
            found = YES;
        }
    }
    if(found) {
#ifdef DEBUG
#ifdef DEBUG_MODELS
        NSLog(@"%s Sign out of all users and remove sessionKey", __PRETTY_FUNCTION__);
#endif
#endif
        [UICKeyChainStore keyChainStore][[NSString stringWithFormat:@"user.sessionKey:%@", _currentUser.username]] = nil;
        [UICKeyChainStore keyChainStore][@"user.username"] = nil;
        [UICKeyChainStore keyChainStore][@"user.locationId"] = nil;;
        _currentUser = nil;
        [PPCloudEngine setUser:nil];
        [PPDeviceProxy setProxy:nil];
        
        [[PPRealm defaultRealm] beginWriteTransaction];
        [[PPRealm defaultRealm] deleteObjects:[PPUser allObjects]];
        [[PPRealm defaultRealm] commitWriteTransaction];
    }
    else {
        [[PPRealm defaultRealm] transactionWithBlock:^{
            for(PPUser *user in users) {
                [[PPRealm defaultRealm] deleteObject:[PPUser objectForPrimaryKey:@(user.userId)]];
            }
        }];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s users=%@", __PRETTY_FUNCTION__, [PPUser allObjects]);
#endif
#endif
}

#pragma mark Location Scenes History

/**
 * Shared location scene history across the entire application
 *
 * @param locationId PPLocationId History of scenes for a given location
 * @param userId Required PPUserId User Id to associate these objects with
 */
+ (NSArray *)sharedSceneHistoryForLocation:(PPLocationId)locationId userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    
    RLMResults<PPLocationSceneEvent *> *sharedEvents;
    if(locationId) {
        sharedEvents = [PPDevice objectsWhere:@"locationId == %li", (long)locationId];
    }
    else {
        sharedEvents = [PPLocationSceneEvent allObjects];
    }
    NSMutableArray *sharedEventsArray = [[NSMutableArray alloc] initWithCapacity:[sharedEvents count]];
    NSMutableArray *eventsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPLocationSceneEvent *event in sharedEvents) {
        [sharedEventsArray addObject:event];
        
        [eventsArrayDebug addObject:@{@"event": event.event, @"locationId": @(event.locationId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedEvents=%@", __PRETTY_FUNCTION__, eventsArrayDebug);
#endif
#endif
    return sharedEventsArray;
}

/**
 * Add location scene history.
 * Add location scene history to local reference.
 *
 * @param locationSceneHistory NSArray Array of location scene history to add.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addLocationSceneHistory:(NSArray *)locationSceneHistory userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s locationSceneHistory=%@", __PRETTY_FUNCTION__, locationSceneHistory);
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPLocationSceneEvent *scene in locationSceneHistory) {
        [PPLocationSceneEvent createOrUpdateInDefaultRealmWithValue:scene];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove location scene history.
 * Remove location scene history from local reference.
 *
 * @param locationSceneHistory scene history NSArray Array of location scene history to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeLocationSceneHistory:(NSArray *)locationSceneHistory userId:(PPUserId)userId{
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s locationSceneHistory=%@", __PRETTY_FUNCTION__, locationSceneHistory);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPLocationSceneEvent *scene in locationSceneHistory) {
            [[PPRealm defaultRealm] deleteObject:[PPLocationSceneEvent objectForPrimaryKey:scene.eventId]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Countries, States, and Timezones

__strong static NSMutableDictionary*_sharedCountries = nil;

/**
 * Shared countries across the entire application
 */
+ (PPCountriesStatesAndTimezones *)sharedCountriesStatesAndTimezonesForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPCountry *> *sharedCountries = [PPCountry allObjects];
    PPCountriesStatesAndTimezones *countries = [[PPCountriesStatesAndTimezones alloc] initWithCountries:(RLMArray *)sharedCountries];
    NSMutableArray *countriesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCountry *country in sharedCountries) {
        [countriesArrayDebug addObject:@{@"id": @(country.countryId)}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedCountries=%@", __PRETTY_FUNCTION__, countriesArrayDebug);
#endif
#endif
    return countries;
}

/**
 * Add countries.
 * Add countries from local reference.
 *
 * @param countries NSArray Array of countries to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addCountries:(PPCountriesStatesAndTimezones *)countries userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s countries=%@", __PRETTY_FUNCTION__, countries);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPCountry *country in countries.countries) {
        [[PPRealm defaultRealm] addObject:country];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove countries.
 * Remove countries from local reference.
 *
 * @param countries NSArray Countries object to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeCountries:(NSArray *)countries userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPCountry *country in countries) {
            [[PPRealm defaultRealm] deleteObject:[PPCountry objectForPrimaryKey:@(country.countryId)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Manage a user

/**
 * Register a new user and location.
 * When creating a new user, the email address field and appName are mandatory. If the password is not set, the user account will be created, but the user will not be able to login and will have to go throw the password renew process. Although it's not required, we recommend creating a default Location when creating a new User account, to begin grouping Devices by Location and to take advantage of Home / Away settings for that Location.
 * The API returns the registered user ID and a new API key.
 * A new user account can be created by an existing user. In this case the API key must be used. Otherwise an operation token of type 1 must be provided.
 * An operation token must first be gathered to register a new user.
 *
 * @param username NSString Email being used to register new user.
 * @param altUsername NSString Alternate username
 * @param password NSString Password being used to register new user. Regex provided by system property SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX, or for specific appNames SYSTEM_PROPERTY_PASSWORD_REGEX(appName)
 * @param firstName NSString First name
 * @param lastName NSString Last name
 * @param email NSString Email
 * @param appName NSString App name
 * @param language NSString Language
 * @param phone NSString Phone
 * @param phoneType PPUserPhoneType Phone type
 * @param anonymous PPUserAnonymousType Anonymous
 * @param location PPLocation User location
 * @param operationToken PPOperationToken Operation token
 * @param callback PPUserRegistrationBlock User registration block containing userId, locationId, API key, and API key expire date
 **/
+ (void)registerWithUsername:(NSString *)username altUsername:(NSString *)altUsername password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email appName:(NSString *)appName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous location:(PPLocation *)location operationToken:(PPOperationToken *)operationToken callback:(PPUserAccountsRegistrationBlock)callback {
    NSAssert1(username != nil || email != nil, @"%s missing username or email", __FUNCTION__);
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    
    NSMutableDictionary *userData = @{}.mutableCopy;
    
    if (username) {
        userData[@"username"] = [[username stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (altUsername) {
        userData[@"altUsername"] = [[altUsername stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (firstName) {
        userData[@"firstName"] = firstName;
    }
    if (lastName) {
        userData[@"lastName"] = lastName;
    }
    if (email) {
        userData[@"email"] = [[email stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (appName) {
        userData[@"appName"] = appName;
    }
    if (language) {
        userData[@"language"] = language;
    }
    if (phone) {
        userData[@"phone"] = phone;
    }
    if (phoneType) {
        userData[@"phoneType"] = @(phoneType);
    }
    if (anonymous) {
        userData[@"anonymous"] = (anonymous) ? @"true" : @"false";
    }
    
    NSMutableDictionary *data = @{@"user": userData}.mutableCopy;
    
    if (location) {
        data[@"location"] = [PPLocation JSONData:location appName:appName];
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, nil, nil, nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSString *encodedPassword = [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:password];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:@"user" relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    [request addValue:encodedPassword forHTTPHeaderField:HTTP_HEADER_PASSWORD];
    [request setValue:nil forHTTPHeaderField:HTTP_HEADER_API_KEY];
    [request setValue:[NSString stringWithFormat:@"op token=%@", operationToken.token] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    [request setHTTPBody:body];
    
    [operationToken isValid:^(BOOL isValid) {
        if(isValid) {
            
            dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.registerWithUsername()", DISPATCH_QUEUE_SERIAL);
            
            dispatch_async(queue, ^{
                
                PPLogAPI(@"> %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                
                [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
                    
                    dispatch_async(queue, ^{
                        
                        NSError *error = nil;
                        NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
                        
                        
                        NSString *userId;
                        NSString *locationId;
                        NSString *key;
                        NSDate *userKeyExpireDate;
                        
                        if(!error) {
                            
                            userId = [root objectForKey:@"userId"];
                            locationId = [root objectForKey:@"locationId"];
                            key = [root objectForKey:@"key"];
                            NSString *userKeyExpireDateString = [root objectForKey:@"keyExpire"];
                            
                            userKeyExpireDate = [NSDate date];
                            if(userKeyExpireDateString != nil) {
                                if(![userKeyExpireDateString isEqualToString:@""]) {
                                    userKeyExpireDate = [PPNSDate parseDateTime:userKeyExpireDateString];
                                }
                            }
                        }
                        
                        PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            callback(userId, locationId, key, userKeyExpireDate, error);
                        });
                    });
                    
                } failure:^(NSError *error) {
                    
                    dispatch_async(queue, ^{
                        
                        PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            callback(nil, nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
                        });
                    });
                }];
            });
        }
        else {
            callback(nil, nil, nil, nil, [PPBaseModel resultCodeToNSError:10040 originatingClass:NSStringFromClass([self class])]);
        }
    }];
}
+ (void)registerWithUsername:(NSString *)username password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email appName:(NSString *)appName language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous location:(PPLocation *)location operationToken:(PPOperationToken *)operationToken callback:(PPUserAccountsRegistrationBlock)callback {
    NSLog(@"%s deprecated. Use +registerWithUsername:altUsername:password:firstName:lastName:email:appName:language:phone:phoneType:anonymous:location:operationToken:callback:", __FUNCTION__);
    [PPUserAccounts registerWithUsername:username altUsername:nil password:password firstName:firstName lastName:lastName email:email appName:appName language:language phone:phone phoneType:phoneType anonymous:anonymous location:location operationToken:operationToken callback:callback];
}

/**
 * Get user information.
 * Obtain all the information previously stored on this user, user permissions, locations, paid services, badges, organizations membership information, authorization information in 3'rd party applications (Twitter, GreenButton, etc.), list of 3'rd party applications having access to the user account.
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to receive a specific user's account.
 * @param organizationId PPOrganizationId Organization ID to get user status from a specific organization, including notes and the group the user belongs to.
 * @param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 **/
+ (void)getUserInformationUserId:(PPUserId)userId organizationId:(PPOrganizationId)organizationId callback:(PPUserAccountsBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"user"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(organizationId != PPOrganizationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"organizationId" value:@(organizationId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getUserInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPUser *user;
            
            if(!error) {
                user = [PPUser initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(user, error);
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

/**
 * Update user.
 * Upate the user's information. All fields are optional.
 *
 * @param username NSString Username
 * @param altUsername NSString Alternative Username
 * @param password NSString Password
 * @param firstName NSString First name
 * @param lastName NSString Last name
 * @param communityName NSString Community name
 * @param email NSString Email
 * @param emailResetStatus PPUserEmailStatus Email reset status.
 * @param language NSString Language
 * @param phone NSString Phone
 * @param phoneType PPUserPhoneType as NSNumber. Phone type.
 * @param anonymous PPUserAnonymousType Anonymous.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param callback PPUserAccountsBlock Callback method provides PPUser object and optional error
 */
+ (void)updateUsername:(NSString * _Nullable )username altUsername:(NSString * _Nullable )altUsername password:(NSString * _Nullable )password firstName:(NSString * _Nullable )firstName lastName:(NSString * _Nullable )lastName communityName:(NSString * _Nullable )communityName email:(NSString * _Nullable )email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString * _Nullable )language phone:(NSString * _Nullable )phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock _Nullable )callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"user"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    if(username) {
        userDict[@"username"] = username;
    }
    if(altUsername) {
        userDict[@"altUsername"] = altUsername;
    }
    if(firstName) {
        userDict[@"firstName"] = firstName;
    }
    if(lastName) {
        userDict[@"lastName"] = lastName;
    }
    if(communityName) {
        userDict[@"communityName"] = communityName;
    }
    if(email) {
        userDict[@"email"] = email;
    }
    if(emailResetStatus != PPUserEmailStatusNone) {
        userDict[@"emailResetStatus"] = @(emailResetStatus);
    }
    if(language) {
        userDict[@"language"] = language;
    }
    if(phone) {
        userDict[@"phone"] = phone;
    }
    if(phoneType != PPUserPhoneTypeNone) {
        userDict[@"phoneType"] = @(phoneType);
    }
    if(anonymous != PPUserAnonymousTypeNone) {
        userDict[@"anonymous"] = (anonymous) ? @"true" : @"false";
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"user":userDict} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSString *encodedPassword = [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:password];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request addValue:encodedPassword forHTTPHeaderField:HTTP_HEADER_PASSWORD];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.updateUser()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)updateUsername:(NSString *)username altUsername:(NSString *)altUsername password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateUsername:password:firstName:lastName:communityName:email:emailResetStatus:language:phone:phoneType:anonymous:userId:callback:callback", __FUNCTION__);
    [PPUserAccounts updateUsername:username altUsername:altUsername password:password firstName:firstName lastName:lastName communityName:nil email:email emailResetStatus:emailResetStatus language:language phone:phone phoneType:phoneType anonymous:anonymous userId:userId callback:callback];
}
+ (void)updateUsername:(NSString *)username password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email emailResetStatus:(PPUserEmailStatus)emailResetStatus language:(NSString *)language phone:(NSString *)phone phoneType:(PPUserPhoneType)phoneType anonymous:(PPUserAnonymousType)anonymous userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +updateUsername:password:firstName:lastName:communityName:email:emailResetStatus:language:phone:phoneType:anonymous:userId:callback:callback", __FUNCTION__);
    [PPUserAccounts updateUsername:username altUsername:nil password:password firstName:firstName lastName:lastName communityName:nil email:email emailResetStatus:emailResetStatus language:language phone:phone phoneType:phoneType anonymous:anonymous userId:userId callback:callback];
}

/**
 * Delete user.
 * Delete this user and removes all devices attached to the user's account. Any legal agreements the user signed will be retained in the backend.
 * This API can copy (merge) deleted user account resources to other user account.
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param merge PPUserAccountsMerge Merge deleted user account to another user
 * @param mergeUserId PPUserId User ID where to merge the deleted user provided by an administrator
 * @param mergeUserApiKey NSString API Key of user we want to merge with
 * @param callback NSErrorBlock Error callback block
 */
+ (void)deleteUser:(PPUserId)userId merge:(PPUserAccountsMerge)merge mergeUserId:(PPUserId)mergeUserId mergeUserApiKey:(NSString *)mergeUserApiKey callback:(PPErrorBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"user"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    if(merge != PPUserAccountsMergeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"merge" value:(merge == PPUserAccountsMergeTrue) ? @"true" : @"false"]];
    }
    if(mergeUserId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"mergeUserId" value:@(mergeUserId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"DELETE" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if (mergeUserApiKey) {
        NSString *apiKeyHeader = [request valueForHTTPHeaderField:HTTP_HEADER_API_KEY];
        [request setValue:[NSString stringWithFormat:@"%@,%@", apiKeyHeader, mergeUserApiKey] forHTTPHeaderField:HTTP_HEADER_API_KEY];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteUser()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

+ (void)deleteUser:(PPUserId)userId callback:(PPErrorBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +deleteUser:merge:mergeUserId:mergeUserApiKey:callback:", __FUNCTION__);
    [PPUserAccounts deleteUser:userId merge:PPUserAccountsMergeNone mergeUserId:PPUserIdNone mergeUserApiKey:nil callback:callback];
}

#pragma mark - Get user by device
#warning Move to PPDevices
/**
 * Get user by device
 * A gateway or proxy can request some information about an owner. Currently only assigned paid services are returned.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:Using a Device Authentication Token:
 *      PPCAuthorization: esp token="ABC12345"
 *      Using a Streaming Session ID: PPCAuthorization: stream session="DEF67890"
 *
 * @param proxyId Required NSString Device ID of the gateway or proxy
 * @param token Required if authorizationType set to PPUserAccountAuthorizationTypeDeviceAuthenticationToken NSString Auth token.
 * @param sessionId Required if authorizationType set to PPUserAccountAuthorizationTypeStreamingSessionId NSString Session ID.
 * @param callback PPUserAccountsServicesBlock Callback method provides PPUser object and optional error
 */
+ (void)getServicesByDevice:(NSString *)proxyId authorizationType:(PPUserAccountAuthorizationType)authorizationType token:(NSString *)token sessionId:(NSString *)sessionId callback:(PPUserAccountsServicesBlock)callback {
    NSAssert1(proxyId != nil, @"%s missing proxyId", __FUNCTION__);
    NSAssert1(authorizationType != PPUserAccountAuthorizationTypeNone, @"%s missing authorizationType", __FUNCTION__);
    if(authorizationType == PPUserAccountAuthorizationTypeDeviceAuthenticationToken) {
        NSAssert1(token != nil, @"%s missing token", __FUNCTION__);
    }
    if(authorizationType == PPUserAccountAuthorizationTypeStreamingSessionId) {
        NSAssert1(sessionId != nil, @"%s missing sessionId", __FUNCTION__);
    }
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"devices/%@/services", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:proxyId]]];

    NSError *error;
    PPCloudEngine *cloudEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeApp];
    NSMutableURLRequest *request = [[cloudEngine getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setValue:nil forHTTPHeaderField:HTTP_HEADER_API_KEY];
    if(authorizationType == PPUserAccountAuthorizationTypeDeviceAuthenticationToken) {
        [request setValue:[NSString stringWithFormat:@"esp token=%@", token] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    else {
        [request setValue:[NSString stringWithFormat:@"stream session=%@", sessionId] forHTTPHeaderField:HTTP_HEADER_PPC_AUTHORIZATION];
    }
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getServicesByDevice()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *services;
            if(!error) {
                services = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *serviceDict in [root objectForKey:@"services"]) {
                    PPUserService *service = [PPUserService initWithDictionary:serviceDict];
                    [services addObject:service];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(services, error);
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
+ (void)getUserByDevice:(NSString *)proxyId authorizationType:(PPUserAccountAuthorizationType)authorizationType token:(NSString *)token sessionId:(NSString *)sessionId callback:(PPUserAccountsServicesBlock)callback {
    NSLog(@"%s deprecated. Use +getServicesByDevice:authorizationType:token:sessionId:callback:", __FUNCTION__);
    [PPUserAccounts getServicesByDevice:proxyId authorizationType:authorizationType token:token sessionId:sessionId callback:callback];
}

#pragma mark - Get user by email (undocumented)

/**
 * Get users by email
 * Return a list of users that already have an account.  This API is undocumented
 * Either an array of emails or phone numbers is required
 *
 * @param emails Required NSArray List of emails to check agains
 * @param phones Required NSArray List of phone numbers to check against
 * @param sendAsRequest PPUserAccountSendAsRequest Determine if the API should send the list using url query parameters or in the http body
 * @param callback PPUserAccountsUsersListBlock Callback method provides list of PPUser objects and optional error
 */
+ (void)getUsersByEmails:(NSArray *)emails phones:(NSArray *)phones sendAsRequest:(PPUserAccountSendAsRequest)sendAsRequest callback:(PPUserAccountsUsersListBlock)callback {
    NSAssert1((emails != nil && [emails count] > 0) || (phones != nil && [phones count] > 0) , @"%s missing emails", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"users"] resolvingAgainstBaseURL:NO];
        
    if(sendAsRequest == PPUserAccountSendAsRequestTrue) {
        
        NSMutableArray *queryItems = @[].mutableCopy;
        
        for(NSString *email in emails) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"email" value:[[email stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
        }
        for(NSString *phone in phones) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"phone" value:[[phone stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
        }
        components.queryItems = queryItems;

        dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getUserByEmails()", DISPATCH_QUEUE_SERIAL);
        
        PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
        [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
            
            dispatch_async(queue, ^{
            
                NSError *error = nil;
                NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
                
                NSMutableArray *users;
                if(!error) {
                    users = [[NSMutableArray alloc] initWithCapacity:0];
                    for(NSDictionary *userDict in [root objectForKey:@"users"]) {
                        PPUser *user = [PPUser initWithDictionary:userDict];
                        [users addObject:user];
                    }
                }
                PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(users, error);
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
    else {
        
        NSMutableDictionary *data = @{}.mutableCopy;
        
        if(emails) {
            NSMutableArray *emails = @[].mutableCopy;
            for(NSString *email in emails) {
                [emails addObject:email];
            }
            data[@"emails"] = emails;
        }
        
        if(phones) {
            NSMutableArray *phones = @[].mutableCopy;
            for(NSString *phone in phones) {
                [phones addObject:phone];
            }
            data[@"phones"] = phones;
        }
        
        NSError *dataError;
        NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
        if(dataError) {
            callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
            return;
        }
        
        NSError *error;
        NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
        [request setHTTPBody:body];

        dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getUserByEmails()", DISPATCH_QUEUE_SERIAL);
        
        PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
        [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
            
            dispatch_async(queue, ^{
                
                NSError *error = nil;
                NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
                
                NSMutableArray *users;
                
                if(!error) {
                    users = [[NSMutableArray alloc] initWithCapacity:0];
                    for(NSDictionary *userDict in [root objectForKey:@"users"]) {
                        PPUser *user = [PPUser initWithDictionary:userDict];
                        [users addObject:user];
                    }
                }
                
                PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(users, error);
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
}
+ (void)getUsersByEmails:(NSArray *)emails sendAsRequest:(PPUserAccountSendAsRequest)sendAsRequest callback:(PPUserAccountsUsersListBlock)callback {
    [PPUserAccounts getUsersByEmails:emails phones:nil sendAsRequest:sendAsRequest callback:callback];
}
#pragma mark - New Location

/**
 * Add a new Location to an existing user
 *
 * @param name NSString Location name
 * @param type PPLocationType Type of location
 * @param utilityAccountNo NSString Utility account number
 * @param timezone PPTimezone Timezone for this location
 * @param addrStreet1 NSString Address - Street 1
 * @param addrStreet2 NSString Address - Street 2
 * @param addrCity NSString Address - City
 * @param state PPState State for this location
 * @param country PPCountry Country for this location
 * @param zip NSString Zip / Postal code
 * @param latitude NSString Latitude for this location
 * @param longitude NSString Longitude for this location
 * @param size PPLocationSize Size representing this location
 * @param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @param heatingType PPLocationHeatingType Heating type for this location
 * @param coolingType PPLocationCoolingType Cooling type for this location
 * @param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @param thermostatType PPLocationThermostatType Thermostat type for this location
 * @param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to update a specific user's account.
 * @param appName NSString App name to associate this location with an organization.
 * @param test PPLocationTest Test location
 * @param locationCallback PPUserAccountsAddLocationBlock Error callback block
 **/
+ (void)addNewLocationToExistingUser:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId appName:(NSString *)appName test:(PPLocationTest)test locationCallback:(PPUserAccountsAddLocationBlock)locationCallback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"location"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    PPLocation *location = [[PPLocation alloc] initWithLocationId:0 name:name locationAccess:PPLocationAccessNone userCategory:PPLocationCategoryNone event:nil type:type owner:PPLocationOwnerNone utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:(RLMArray *)occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy auths:nil clients:nil services:nil temporary:PPLocationTemporaryNone accessEndDate:nil smsPhone:nil creationDate:nil appName:nil organizationId:PPOrganizationIdNone organization:nil test:test codeType:PPLocationCodeTypeNone];
    
    NSDictionary *data = @{@"location": [PPLocation JSONData:location appName:appName]};

    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        locationCallback(PPLocationIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.addNewLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLocationId locationId = PPLocationIdNone;
            
            if(!error) {
                if([root objectForKey:@"locationId"]) {
                    locationId = (PPLocationId)((NSString *)[root objectForKey:@"locationId"]).integerValue;
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                locationCallback(locationId, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                locationCallback(PPLocationIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)addNewLocationToExistingUser:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId appName:(NSString *)appName locationCallback:(PPUserAccountsAddLocationBlock)locationCallback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +addNewLocationToExistingUser:type:utilityAccountNo:timezone:addrStreet1:addrStreet2:addrCity:state:country:zip:latitude:longitude:size:storiesNumber:roomsNumber:bathroomsNumber:occupantsNumber:occupantsRanges:usagePeriod:heatingType:coolingType:waterHeaterType:thermostatType:fileUploadPolicy:userId:appName:test:locationCallback:", __FUNCTION__);
    [PPUserAccounts addNewLocationToExistingUser:name type:type utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy userId:userId appName:nil test:PPLocationTestNone locationCallback:locationCallback];
}
+ (void)addNewLocationToExistingUser:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId locationCallback:(PPUserAccountsAddLocationBlock)locationCallback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +addNewLocationToExistingUser:type:utilityAccountNo:timezone:addrStreet1:addrStreet2:addrCity:state:country:zip:latitude:longitude:size:storiesNumber:roomsNumber:bathroomsNumber:occupantsNumber:occupantsRanges:usagePeriod:heatingType:coolingType:waterHeaterType:thermostatType:fileUploadPolicy:userId:appName:test:locationCallback:", __FUNCTION__);
    [PPUserAccounts addNewLocationToExistingUser:name type:type utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy userId:userId appName:nil test:PPLocationTestNone locationCallback:locationCallback];
}
+ (void)addNewLocationToExistingUser:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy userId:(PPUserId)userId callback:(PPErrorBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +addNewLocationToExistingUser:type:utilityAccountNo:timezone:addrStreet1:addrStreet2:addrCity:state:country:zip:latitude:longitude:size:storiesNumber:roomsNumber:bathroomsNumber:occupantsNumber:occupantsRanges:usagePeriod:heatingType:coolingType:waterHeaterType:thermostatType:fileUploadPolicy:userId:appName:test:locationCallback:", __FUNCTION__);
    [PPUserAccounts addNewLocationToExistingUser:name type:type utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy userId:userId appName:nil test:PPLocationTestNone locationCallback:^(PPLocationId locationId, NSError *error) {
        callback(error);
    }];
}

#pragma mark - Update Location

/**
 * Edit a location.
 * Location ID parameter is required.  All others are optional.
 *
 * @param locationId PPLocationId Location id
 * @param name NSString Location name
 * @param type PPLocationType Type of location
 * @param utilityAccountNo NSString Utility account number
 * @param timezone PPTimezone Timezone for this location
 * @param addrStreet1 NSString Address - Street 1
 * @param addrStreet2 NSString Address - Street 2
 * @param addrCity NSString Address - City
 * @param state PPState State for this location
 * @param country PPCountry Country for this location
 * @param zip NSString Zip / Postal code
 * @param latitude NSString Latitude for this location
 * @param longitude NSString Longitude for this location
 * @param size PPLocationSize Size representing this location
 * @param storiesNumber PPLocationStoriesNumber Number of stories for this location
 * @param roomsNumber PPLocationRoomsNumber Number of rooms for this location
 * @param bathroomsNumber PPLocationBathroomsNumber Number of bathrooms for this location
 * @param occupantsNumber PPLocationOccupantsNumber Number of occupants for this location
 * @param occupantsRanges NSArray Array of PPLocationOccupantsRange objects describing occupants ranges for this location
 * @param usagePeriod PPLocationUsagePeriod Usage period for this location
 * @param heatingType PPLocationHeatingType Heating type for this location
 * @param coolingType PPLocationCoolingType Cooling type for this location
 * @param waterHeaterType PPLocationWaterHeaterType Water heater type for this location
 * @param thermostatType PPLocationThermostatType Thermostat type for this location
 * @param fileUploadPolicy PPLocationFileUploadPolicy File upload policy.
 * @param test PPLocationTest Test location marker
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)editLocation:(PPLocationId)locationId name:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy test:(PPLocationTest)test callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"location/%@", @(locationId)]];
    
    PPLocation *location = [[PPLocation alloc] initWithLocationId:0 name:name locationAccess:PPLocationAccessNone userCategory:PPLocationCategoryNone event:nil type:type owner:PPLocationOwnerNone utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:(RLMArray *)occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy auths:nil clients:nil services:nil temporary:PPLocationTemporaryNone accessEndDate:nil smsPhone:nil creationDate:nil appName:nil organizationId:PPOrganizationIdNone organization:nil test:test codeType:PPLocationCodeTypeNone];
    
    NSDictionary *data = @{@"location": [PPLocation JSONData:location appName:nil]};
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.editLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)editLocation:(PPLocationId)locationId name:(NSString *)name type:(PPLocationType)type utilityAccountNo:(NSString *)utilityAccountNo timezone:(PPTimezone *)timezone addrStreet1:(NSString *)addrStreet1 addrStreet2:(NSString *)addrStreet2 addrCity:(NSString *)addrCity state:(PPState *)state country:(PPCountry *)country zip:(NSString *)zip latitude:(NSString *)latitude longitude:(NSString *)longitude size:(PPLocationSize *)size storiesNumber:(PPLocationStoriesNumber)storiesNumber roomsNumber:(PPLocationRoomsNumber)roomsNumber bathroomsNumber:(PPLocationBathroomsNumber)bathroomsNumber occupantsNumber:(PPLocationOccupantsNumber)occupantsNumber occupantsRanges:(NSArray *)occupantsRanges usagePeriod:(PPLocationUsagePeriod)usagePeriod heatingType:(PPLocationHeatingType)heatingType coolingType:(PPLocationCoolingType)coolingType waterHeaterType:(PPLocationWaterHeaterType)waterHeaterType thermostatType:(PPLocationThermostatType)thermostatType fileUploadPolicy:(PPLocationFileUploadPolicy)fileUploadPolicy callback:(PPErrorBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +aeditLocation:name:type:utilityAccountNo:timezone:addrStreet1:addrStreet2:addrCity:state:statezip:latitude:longitude:size:storiesNumber:roomsNumber:bathroomsNumber:occupantsNumber:occupantsRanges:usagePeriod:heatingType:coolingType:waterHeaterType:thermostatType:fileUploadPolicy:callback:", __FUNCTION__);
    [PPUserAccounts editLocation:locationId name:name type:type utilityAccountNo:utilityAccountNo timezone:timezone addrStreet1:addrStreet1 addrStreet2:addrStreet2 addrCity:addrCity state:state country:country zip:zip latitude:latitude longitude:longitude size:size storiesNumber:storiesNumber roomsNumber:roomsNumber bathroomsNumber:bathroomsNumber occupantsNumber:occupantsNumber occupantsRanges:occupantsRanges usagePeriod:usagePeriod heatingType:heatingType coolingType:coolingType waterHeaterType:waterHeaterType thermostatType:thermostatType fileUploadPolicy:fileUploadPolicy test:PPLocationTestNone callback:callback];
    
}

#warning DELETE Location API returns error code 29 (API not available)
/**
 * Delete a location.
 *
 * @param locationId PPLocationId Location id
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteLocation:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:[NSString stringWithFormat:@"location/%li", (long)locationId] success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Set Location Scene

/**
 * Change the scene at a location
 * By changing the scene at a location, you may cause user-defined Rules to execute such as "When I am home do something" or "When I am going to sleep turn of the TV".
 * The API returns a list user devices shared with friends and their names. If some devices were shared before and by changing the location scene they are not shared anymore, they will be returned as well.
 *
 * @param locationId Required PPLocationId The Location ID for which to trigger an event.
 * @param eventName Required NSString Developer-defined name of the scene. For example, 'HOME', 'AWAY', 'SLEEP', 'VACATION', 'FOOSBALL'. You can define any name you want. The name represents some state, and can be fed into Rules and other areas of the app. Presence uses 'HOME', 'AWAY', 'SLEEP', and 'VACATION'.
 * @param comment NSString Comment on why this event was changed
 * @param callback PPUserAccountsLocationSceneBlockBlock Scene callback block containing shared and unshared devices
 **/
+ (void)changeSceneAtLocation:(PPLocationId)locationId eventName:(NSString *)eventName comment:(NSString *)comment callback:(PPUserAccountsLocationSceneBlockBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(eventName != nil, @"%s missing eventName", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"location/%@/event/%@", @(locationId), eventName]];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(comment) {

        NSDictionary *data = @{@"comment": comment};
        
        NSError *dataError;
        NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
        if(dataError) {
            callback(nil, nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
            return;
        }
        [request setHTTPBody:body];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.changeSceneAtLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([root objectForKey:@"sharedDevices"], [root objectForKey:@"stopSharingDevices"], error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Location Scenes

/**
 * Location scenes history
 * Return location change schemes history in backward order (latest first).
 *
 * @param locationId Required PPLocationId Location Id for this location
 * @param startDate NSDate Start date to begin receiving data
 * @param endDate NSDate End date to stop receiving data. Default is the current date.
 * @param callback PPUserAccountsLocationSceneBlockHistoryBlock Scene history callback block containing array of events
 **/
+ (void)locationScenesHistory:(PPLocationId)locationId startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPUserAccountsLocationSceneBlockHistoryBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"location/%@/events", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(startDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.locationSceneHistory()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *events;
            
            if(!error) {
                events = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *eventDict in [root objectForKey:@"events"]) {
                    PPLocationSceneEvent *event = [PPLocationSceneEvent initWithDictionary:eventDict];
                    event.locationId = locationId;
                    [events addObject:event];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(events, error);
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




#pragma mark - Verify email address or phone number

/**
 * Send a verification message
 * Send an email or an SMS to the user containing a link to a temporary page which is valid for one day and/or a verification code, to verify the email address or if this phone number able to receive SMS. When the user clicks on that link, the email address is marked as verified and the user is forwarded to a success page. If the link is expired, the user is forwarded to an error page.
 * By default the IoT Software Suite will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param type Required PPUserEmailVerificationType Message type
 * @param callback PPErrorBlock Error callback block
 */
+ (void)sendAVerificationMessage:(NSString *)brand appName:(NSString *)appName type:(PPUserEmailVerificationType)type callback:(PPErrorBlock)callback {
    NSAssert1(type != PPUserEmailVerificationTypeNone, @"%s missing type", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"emailVerificationMessage"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;

    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(type).stringValue]];
    if(brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    
    if(appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.sendAVerificationMessage()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Provide verification code
 *
 * @param code Required NSString Verification code
 * @param type Required PPUserEmailVerificationType Message type
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)provideVerificationCode:(NSString *)code type:(PPUserEmailVerificationType)type callback:(PPErrorBlock)callback {
    NSAssert1(code != nil, @"%s missing code", __FUNCTION__);
    NSAssert1(type != PPUserEmailVerificationTypeNone, @"%s missing type", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"emailVerificationMessage"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(type)]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"code" value:code]];
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.provideVerificationCode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Recover password

/**
 * Recover user's password.
 * By default the IoT Software Suit will use a Customer's specific email template based on the preferable user organization. This customization can be overwritten by brand or appName parameter.
 *
 * @param username NSString The username, which is typically the user's email address
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)recoverPassword:(NSString *)username brand:(NSString *)brand appName:(NSString *)appName callback:(PPErrorBlock) callback {
    NSAssert1(username != nil, @"%s missing username", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"newPassword"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    if (appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"username" value:[[username stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.recoverPassword()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Put new password.
 * The app calls this API to submit a new password.
 * End users must provide either a temporary API key sent by email or a regular user API key and the old password.
 *
 * @param password Required NSString New Password
 * @param oldPassword Required NSString New Password
 * @param passcode NSString Passcode
 * @param tempKey NSString Temporary API key
 * @param brand NSString A parameter identifying a Customer's specific email template, among other customization settings
 * @param appName NSString App name to identify the brand
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)putNewPassword:(NSString *)password oldPassword:(NSString *)oldPassword passcode:(NSString *)passcode tempKey:(NSString *)tempKey brand:(NSString *)brand appName:(NSString *)appName callback:(PPErrorBlock)callback {
    NSAssert1(password != nil, @"%s missing password", __FUNCTION__);
    NSAssert1((oldPassword != nil || passcode != nil || tempKey != nil), @"%s missing oldPassword, passcode or tempKey", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"newPassword"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    if (appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:3];
    [data setObject:password forKey:@"newPassword"];
    if (tempKey == nil) {
        if (oldPassword) {
            [data setObject:oldPassword forKey:@"oldPassword"];
        }
        else if (passcode) {
            [data setObject:passcode forKey:@"passcode"];
        }
    }
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }

    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    if (tempKey) {
        [request setValue:tempKey forHTTPHeaderField:HTTP_HEADER_API_KEY];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.newPassword()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Badges

/**
 * Reset badges
 *
 * @param type PPUserBadgeType Type of badge being reset.  If none type is provided, all badge counts will be reset.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)resetBadges:(PPUserBadgeType)type callback:(PPErrorBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"badges"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (type != PPUserBadgeTypeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:@(type)]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.resetBadges()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Sign Terms of Service

/**
 * Sign terms of service
 * Adds a unique signature identifier to the list of agreements the user has signed.
 *
 * @param termsOfServiceId NSString Terms of service ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)signTermsOfService:(NSString *)termsOfServiceId callback:(PPErrorBlock)callback {
    NSAssert1(termsOfServiceId != nil, @"%s missing termsOfServiceId", __FUNCTION__);
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.signTermsOfService()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:[NSString stringWithFormat:@"termsOfServices/%@", termsOfServiceId] success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Get Terms of Service
/**
 * Get Signatures
 * Retrieve all of the Terms of Service agreement signature identifiers to which the user has previously agreed.
 *
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)getSignatures:(PPUserAccountTermsOfServiceBlock)callback {
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getSignatures()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:@"termsOfServices" success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *strings;
            
            if(!error) {
            
                NSArray *signatureElements = [root objectForKey:@"termsOfServices"];
                strings = [[NSMutableArray alloc] initWithCapacity:[signatureElements count]];
                
                for (NSString *signature in signatureElements) {
                    if(signature != nil) {
                        [strings addObject:signature];
                    }
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(strings, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - User Tags

/**
 * Apply tag
 *
 * @param tag Required NSString Tag value
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)applyTag:(NSString *)tag callback:(PPErrorBlock)callback {
    NSAssert1(tag != nil, @"%s missing tag", __FUNCTION__);
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.applyTag()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] PUT:[NSString stringWithFormat:@"usertags/%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:tag]] success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete tag
 *
 * @param tag Required NSString Tag value
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)deleteTag:(NSString *)tag callback:(PPErrorBlock)callback {
    NSAssert1(tag != nil, @"%s missing tag", __FUNCTION__);
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteTag()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:[NSString stringWithFormat:@"usertags/%@", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:tag]] success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - User Codes

/**
 * Put user code
 * This API allows to add a new or overwrite an existing user code or update a shared code on the location. A user code can be set by either providing the actual code value or by initiating a process entering the code on the device. If the code is set by the device, process expiry time in seconds can be provided in the setExpiry field.
 *
 * @param type Required PPUserCodeType Code type
 * @param code NSString Alphanumeric string of 4 or more characters.  Codes of type Combined are joined using the "+" character.
 * @param locationId PPLocationId Assign code to a location.  Name is ignored.
 * @param name NSString Code name.  Ignored when including locationId.
 * @param deviceId NSString Device ID
 * @param setExpiry PPUserCodeExpiry Expiry in seconds
 * @param callback NSErrorBlock Error callback block
 **/
+ (void)putUserCode:(PPUserCodeType)type code:(NSString * _Nullable )code locationId:(PPLocationId)locationId name:(NSString * _Nullable )name deviceId:(NSString * _Nullable )deviceId setExpiry:(PPUserCodeExpiry)setExpiry callback:(PPErrorBlock _Nonnull )callback {
    NSAssert1(type != -1, @"%s invalid type", __FUNCTION__);
    NSAssert1(code != nil || deviceId != nil, @"%s missing code or device ID", __FUNCTION__);
    NSAssert1(locationId != PPLocationIdNone || name != nil, @"%s missing locationId or name", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"userCodes"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    else {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{
        @"type": @(type)
    }.mutableCopy;
    if (code != nil) {
        data[@"code"] = code;
    }
    else if (deviceId != nil) {
        data[@"deviceId"] = deviceId;
    }
    if (setExpiry != PPUserCodeExpiryNone) {
        data[@"setExpiry"] = @(setExpiry);
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if (dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.putUserCode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)putUserCode:(PPUserCodeType)type code:(NSString * _Nonnull )code locationId:(PPLocationId)locationId name:(NSString * _Nullable )name callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +deleteLocationUser:userIds:callback:", __FUNCTION__);
    [PPUserAccounts putUserCode:type code:code locationId:locationId name:name deviceId:nil setExpiry:PPUserCodeExpiryNone callback:callback];
}

/**
 * Delete user code
 *
 * @param name Required NSString Code Namef
  * Either name or locationId is required
  *
  * @param name NSString Code Name
  * @param locationId PPLocationId LocationId to remove this code from
  * @param callback NSErrorBlock Error callback block
  **/
+ (void)deleteUserCode:(NSString * _Nullable )name locationId:(PPLocationId)locationId callback:(PPErrorBlock _Nonnull )callback {
    NSAssert1(name != nil || locationId != PPLocationIdNone, @"%s missing name or location ID", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"userCodes"] resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = @[].mutableCopy;
    if (locationId != PPLocationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    }
    else {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteUserCode()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Get user codes
 *
 * @param callback PPUserAccountsUserCodesBlock Error callback block
 **/
+ (void)getUserCodes:(PPUserAccountsUserCodesBlock _Nonnull )callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"userCodes"] resolvingAgainstBaseURL:NO];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteTag()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *userCodes;
            
            if(!error) {
                userCodes = @[].mutableCopy;
                for (NSDictionary *codeDict in [root objectForKey:@"codes"]) {
                    [userCodes addObject:[PPUserCode initWithDictionary:codeDict]];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(userCodes, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Coutries, states and time zones

/**
 * Get countries, states and time zones.
 * Return a list of countries currently supported on the IoT Software Suite. The Country ID is used when referencing this country in other API calls.
 *
 * @param organizationId PPOrganizationId Filter response by the organization ID
 * @param countryCode NSString Filter response by country codes. You may specify multiple countryCode URL parameters with different values to gather multiple countries data.
 * @param lang NSString Use for language specific response
 * @param callback PPUserAccountCountriesStatesAndTimeszonesBlock Countries, States, and Timezones callback block
 **/
+ (void)getCountries:(PPOrganizationId)organizationId countryCode:(NSString *)countryCode lang:(NSString *)lang callback:(PPUserAccountCountriesStatesAndTimeszonesBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"countries"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (organizationId != PPOrganizationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"organizationId" value:@(organizationId)]];
    }
    if (countryCode) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"countryCode" value:countryCode]];
    }
    if (lang) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"lang" value:lang]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getCountries()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCountriesStatesAndTimezones *countriesStatesAndTimezones;
            
            if(!error) {
                NSMutableArray *countries = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *countryDict in [root objectForKey:@"countries"]) {
                    PPCountry *country = [PPCountry initWithDictionary:countryDict];
                    [countries addObject:country];
                }
                countriesStatesAndTimezones = [[PPCountriesStatesAndTimezones alloc] initWithCountries:countries];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(countriesStatesAndTimezones, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Location Users

/**
 * Get location users
 * An owner of a location can assign other existing users to access and manage the location and devices on it and receive notifications related to this location.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPUserAccountsUsersListBlock Location users callback block
 **/
+ (void)getLocationUsers:(PPLocationId)locationId callback:(PPUserAccountsUsersListBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"location/%@/users", @(locationId)]];

    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getLocationUsers()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *users;
            
            if(!error) {
                users = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *userDict in [root objectForKey:@"users"]) {
                    
                    PPLocationUser *user = [PPLocationUser initWithDictionary:userDict];
                    [users addObject:user];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(users, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Add location users
 *
 * @param locationId Required PPLocationId Location ID
 * @param users Required NSDictionary Dictionary of users to add. e.g. {"id": 123, "locationAccess": 10, "category": 1}
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addLocationUsers:(PPLocationId)locationId users:(NSArray *)users callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(users != nil && [users count] > 0, @"%s missing users", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"location/%@/users", @(locationId)]];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"users":users} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.addLocationUsers()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
    });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#warning TODO: Add Update Location Users API

/**
 * Delete location user
 *
 * @param locationId Required PPLocationId Location ID
 * @param userIds NSArray User ID to delete from the location, multiple values supported. If not set, the calling user will be deleted from the location.
 * @param callback PPErrorBlock Error callback block
 */
+ (void)deleteLocationUser:(PPLocationId)locationId userIds:(NSArray *)userIds callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"location/%@/users", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (userIds != nil && [userIds count] > 0) {
        for (NSNumber *userId in userIds) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:userId.stringValue]];
        }
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteLocationUser()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteLocationUser:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated, use +deleteLocationUser:userIds:callback:", __FUNCTION__);
    NSAssert1(userId != PPUserIdNone, @"%s missing userId", __FUNCTION__);
    NSArray *userIds;
    if (userId != PPUserIdNone) {
        userIds = @[@(userId)];
    }
    [PPUserAccounts deleteLocationUser:locationId userIds:userIds callback:callback];
}

#pragma mark - Location Spaces

/**
 * Get spaces
 * A user can define location zones called spaces.  A space has a type and a name.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPUserAccountsLocationSpacesBlock Location spaces callback block
 **/
+ (void)getLocationSpaces:(PPLocationId)locationId callback:(PPUserAccountsLocationSpacesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"location/%@/spaces", @(locationId)]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getLocationSpaces()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *spaces;
            
            if(!error) {
                spaces = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *spaceDict in [root objectForKey:@"spaces"]) {
                    
                    PPLocationSpace *space = [PPLocationSpace initWithDictionary:spaceDict];
                    [spaces addObject:space];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(spaces, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Update space
 * Add new or modify existing space.
 *
 * @param locationId Required PPLocationId Location ID
 * @param space Required PPLocationSpace Location space to add or modify
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateLocationSpace:(PPLocationId)locationId space:(PPLocationSpace *)space callback:(PPUserAccountsUpdateLocationSpacesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(space != nil, @"%s missing space", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"location/%@/spaces", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(space.spaceId != PPLocationSpaceIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"spaceId" value:@(space.spaceId).stringValue]];
    }
    components.queryItems = queryItems;

    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"space":[PPLocationSpace data:space]} options:0 error:&dataError];
    if(dataError) {
        callback(PPLocationSpaceIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.updateLocationSpace()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLocationSpaceId spaceId = PPLocationSpaceIdNone;
            if(!error) {
                if([root objectForKey:@"spaceId"]) {
                    spaceId = (PPLocationSpaceId)((NSString *)[root objectForKey:@"spaceId"]).integerValue;
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(spaceId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPLocationSpaceIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * delete space
 *
 * @param locationId Required PPLocationId Location ID
 * @param spaceId Required PPLocationSpaceId Location space id to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteLocationSpace:(PPLocationId)locationId spaceId:(PPLocationSpaceId)spaceId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(spaceId != PPLocationSpaceIdNone, @"%s missing spaceId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"location/%@/spaces", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"spaceId" value:@(spaceId).stringValue]];
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteLocationSpace()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] DELETE:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Narratives

/**
 * Create/Update a narrative
 * If `narrativeId` and `narrativeTime` parameters are provided then the API updates the narrative with this ID and time. Otherwise a new narrative is created.
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId PPLocationNarrativeId ID of narrative to update - required for update
 * @param narrativeTime PPLocationNarrativeTime Current record narrative time to update - required for update
 * @param narrative Required PPLocationNarrative Narrative content to put
 * @param analyticAPIKey Required NSString Analytic/Bot API Key
 * @param callback PPUserAccountsPutNarrativeBlock Narrative callback block
 **/
+ (void)createOrUpdateNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId narrativeTime:(PPLocationNarrativeTime)narrativeTime narrative:(PPLocationNarrative *)narrative analyticAPIKey:(NSString *)analyticAPIKey callback:(PPUserAccountsPutNarrativeBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(narrative != nil, @"%s missing narrative", __FUNCTION__);
    NSAssert1(analyticAPIKey != nil, @"%s missing analyticAPIKey", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/narratives", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(narrativeId != PPLocationNarrativeIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"narrativeId" value:@(narrativeId).stringValue]];
    }
    if(narrativeTime != PPLocationNarrativeTimeNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"narrativeTime" value:@(narrativeTime).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"narrative": [PPLocationNarrative data:narrative]} options:0 error:&dataError];
    if(dataError) {
        callback(PPLocationNarrativeIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setValue:analyticAPIKey forHTTPHeaderField:@"ANALYTIC_API_KEY"];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.createOrUpdateNarrative()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLocationNarrativeId narrativeId = PPLocationNarrativeIdNone;
            if(!error) {
                if([root objectForKey:@"narrativeId"]) {
                    narrativeId = (PPLocationNarrativeId)((NSString *)[root objectForKey:@"narrativeId"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(narrativeId, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
        PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
        
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPLocationNarrativeIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete a narrative
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId PPLocationNarrativeId ID of narrative to delete
 * @param analyticAPIKey Required NSString Analytic/Bot API Key
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId analyticAPIKey:(NSString *)analyticAPIKey callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(narrativeId != PPLocationNarrativeIdNone, @"%s missing narrativeId", __FUNCTION__);
    NSAssert1(analyticAPIKey != nil, @"%s missing analyiticAPIKey", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/narratives", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"narrativeId" value:@(narrativeId).stringValue]];
    components.queryItems = queryItems;
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"DELETE" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setValue:analyticAPIKey forHTTPHeaderField:@"ANALYTIC_API_KEY"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.deleteNarrative()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)deleteNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId narrativeTime:(PPLocationNarrativeTime)narrativeTime analyticAPIKey:(NSString *)analyticAPIKey callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated, use +deleteNarrative:narrativeId:analyticaAPIKey:callback:", __FUNCTION__);
    [PPUserAccounts deleteNarrative:locationId narrativeId:narrativeId analyticAPIKey:analyticAPIKey callback:callback];
}

/**
 * Get narratives
 * The search results are organized by "pages". Each page contains a set of elements sorted by the 'narrativeTime' in descending order. The pages follow one another in reverse chronological order.
 * The rowCount parameter specifies the maximum number of elements per page. The result may include the "nextMarker" property - this means that there are more pages for the current search criteria. To get the next page, the value of "nextMarker" must be passed to the "pageMarker" parameter on the next API call.
 *
 * @param locationId Required PPLocationId Location ID
 * @param narrativeId PPLocationNarrativeId Filter by ID
 * @param priority PPLocationNarrativePriority Filter by priority higher or equal that that
 * @param toPriority PPLocationNarrativePriority Filter by priority less or equal than that
 * @param searchBy NSString Filter by keywors (like "Door" - show me any recent events that contained the word Door in the title or description)
 * @param startDate NSDate Narrative date range start
 * @param endDate NSDate Narrative date range end
 * @param rowCount PPLocationNarrativeRowCount Maximum rows number to return
 * @param pageMarker NSString Marker to the next page
 * @param analyticAPIKey NSString Analytic/Bot API Key
 * @param sortOptions NSDictionary Sort options
 * @param callback PPUserAccountsNarrativesBlock Narratives callback block
 **/
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority toPriority:(PPLocationNarrativePriority)toPriority searchBy:(NSString *)searchBy startDate:(NSDate *)startDate endDate:(NSDate *)endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString *)pageMarker analyticAPIKey:(NSString *)analyticAPIKey sortOptions:(NSDictionary *)sortOptions callback:(PPUserAccountsNarrativesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/narratives", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(narrativeId != PPLocationNarrativeIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"narrativeId" value:@(narrativeId).stringValue]];
    }
    if(priority != PPLocationNarrativePriorityNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"priority" value:@(priority).stringValue]];
    }
    if(toPriority != PPLocationNarrativePriorityNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"toPriority" value:@(toPriority).stringValue]];
    }
    if(searchBy) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"searchBy" value:searchBy]];
    }
    if(startDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    if(rowCount != PPLocationNarrativeRowCountNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"rowCount" value:@(rowCount).stringValue]];
    }
    if(pageMarker) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"pageMarker" value:pageMarker]];
    }
    if(sortOptions) {
        for(NSString *key in sortOptions.allKeys) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:key value:[sortOptions objectForKey:key]]];
        }
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getNarrative()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *narratives;
            NSString *nextMarker;
            
            if(!error) {
                narratives = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *narrativeDict in [root objectForKey:@"narratives"]) {
                    PPLocationNarrative *narrative = [PPLocationNarrative initWithDictionary:narrativeDict];
                    [narratives addObject:narrative];
                }
            
                nextMarker = [root objectForKey:@"nextMarker"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(narratives, nextMarker, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority searchBy:(NSString *)searchBy startDate:(NSDate *)startDate endDate:(NSDate *)endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString *)pageMarker analyticAPIKey:(NSString *)analyticAPIKey sortOptions:(NSDictionary *)sortOptions callback:(PPUserAccountsNarrativesBlock)callback {
    [PPUserAccounts getNarrative:locationId narrativeId:narrativeId priority:priority toPriority:PPLocationNarrativePriorityNone searchBy:searchBy startDate:startDate endDate:endDate rowCount:rowCount pageMarker:pageMarker analyticAPIKey:analyticAPIKey sortOptions:sortOptions callback:callback];
}
+ (void)getNarrative:(PPLocationId)locationId narrativeId:(PPLocationNarrativeId)narrativeId priority:(PPLocationNarrativePriority)priority searchBy:(NSString *)searchBy startDate:(NSDate *)startDate endDate:(NSDate *)endDate rowCount:(PPLocationNarrativeRowCount)rowCount pageMarker:(NSString *)pageMarker analyticAPIKey:(NSString *)analyticAPIKey callback:(PPUserAccountsNarrativesBlock)callback {
    [PPUserAccounts getNarrative:locationId narrativeId:narrativeId priority:priority toPriority:PPLocationNarrativePriorityNone searchBy:searchBy startDate:startDate endDate:endDate rowCount:rowCount pageMarker:pageMarker analyticAPIKey:analyticAPIKey sortOptions:nil callback:callback];
}

#pragma mark - Location States
/**
 * A way for bots to set named location states with flexible JSON object structure.
 **/

/**
 * Set State
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param name Required NSString State name
 * @ param data NSDictionary State information
 * @ param overwrite PPUserAccountsStateOverwrite Overwrite the entire state with completely new content
 * @ param callback PPErrorBlock Error callback block
 **/
+ (void)setState:(PPLocationId)locationId name:(NSString *)name data:(NSDictionary *)data overwrite:(PPUserAccountsStateOverwrite)overwrite callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/state", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    if (overwrite != PPUserAccountsStateOverwriteNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"overwrite" value:(overwrite == PPUserAccountsStateOverwriteTrue) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"value": data} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.setState()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}
+ (void)setState:(PPLocationId)locationId name:(NSString *)name data:(NSDictionary *)data callback:(PPErrorBlock)callback {
    NSLog(@"%s deprecated. Use +setState:name:data:overwrite:callback:", __FUNCTION__);
    [PPUserAccounts setState:locationId name:name data:data overwrite:PPUserAccountsStateOverwriteNone callback:callback];
}

/**
 * Get State
 *
 * @ param locationId Required PPLocationId Location ID
 * @ param name Required NSString State name
 * @ param callback PPUserAccountsStateBlock State callback block
 **/
+ (void)getState:(PPLocationId)locationId name:(NSString *)name callback:(PPUserAccountsStateBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/state", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getState()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSDictionary *data;
            
            if(!error) {
                data = [root objectForKey:@"value"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(data, error);
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

/**
 * Get States
 *
 * @param locationId Required PPLocationId Location ID
 * @param names Required NSArray Array of state names
 * @param callback PPUserAccountsStatesBlock State callback block
 **/
+ (void)getStates:(PPLocationId)locationId names:(NSArray *)names callback:(PPUserAccountsStatesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(names != nil && [names count] > 0, @"%s missing names", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/state", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    for (NSString *name in names) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getState()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSArray *states;
            
            if(!error) {
                if ([root objectForKey:@"value"]) {
                    NSDictionary *data = [root objectForKey:@"value"];
                    states = @[@{@"name": names[0], @"data": data}];
                }
                else if ([root objectForKey:@"states"]) {
                    NSMutableArray *_states = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *stateDict in [root objectForKey:@"states"]) {
                        NSString *name = [stateDict objectForKey:@"name"];
                        NSDictionary *data = [stateDict objectForKey:@"value"];
                        [_states addObject:@{@"name": name, @"data": data}];
                    }
                    states = _states;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(states, error);
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
 
#pragma mark - Location Time States
/**
 * A way for bots to set time based location states with flexible JSON object structure.
 * The state value can be an any valid JSON node. It can be a single value node (string, integer, etc) or an array or an object node {}.
 * To delete a location state set the value to null.
 * If the value is an object node, the API will read the current state value and try to update only changed fields. To delete a field from the current value set it to null.
 **/

/**
 * Set Time State
 *
 * @param locationId Required PPLocationId Location ID
 * @param date Required NSDate State date or time value
 * @param name Required NSString State name
 * @param overwrite PPUserAccountsStateOverwrite Overwrite the entire state with completely new content
 * @param data NSDictionary State information
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)setTimeState:(PPLocationId)locationId date:(NSDate *)date name:(NSString *)name data:(NSDictionary *)data overwrite:(PPUserAccountsStateOverwrite)overwrite callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(date != nil, @"%s missing date", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/timeStates", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"date" value:[PPNSDate apiFriendStringFromDate:date]]];
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    if (overwrite != PPUserAccountsStateOverwriteNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"overwrite" value:(overwrite == PPUserAccountsStateOverwriteTrue) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"value": data} options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.setTimeState()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Get Time States
 *
 * @param locationId Required PPLocationId Location ID
 * @param startDate Required NSDate Retrun states with dates greater or equal to this value
 * @param endDate NSDate Return states with dates less than this value. If not set, only states with dates exactly equal to startDate will be returned.
 * @param names Required NSArray Array of state names
 * @param callback PPUserAccountsStatesBlock State callback block
 **/
+ (void)getTimeStates:(PPLocationId)locationId startDate:(NSDate *)startDate endDate:(NSDate *)endDate names:(NSArray *)names callback:(PPUserAccountsStatesBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
    NSAssert1(names != nil && [names count] > 0, @"%s missing names", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"locations/%@/timeStates", @(locationId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    for (NSString *name in names) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"name" value:name]];
    }
    if (endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getTimeStates()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSArray *states;
            
            if(!error) {
                NSMutableArray *_states = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *stateDict in [root objectForKey:@"states"]) {
                    NSMutableDictionary *state = [[NSMutableDictionary alloc] initWithCapacity:0];
                    
                    NSString *name = [stateDict objectForKey:@"name"];
                    [state setValue:name forKey:@"name"];
                    
                    if ([stateDict objectForKey:@"stateDate"]) {
                        NSString *stateDateString = [stateDict objectForKey:@"stateDate"];
                    
                        NSDate *stateDate = nil;
                        if(stateDateString != nil) {
                            if(![stateDateString isEqualToString:@""]) {
                                stateDate = [PPNSDate parseDateTime:stateDateString];
                            }
                        }

                        [state setValue:stateDate forKey:@"stateDate"];
                    }
                    
                    if([stateDict objectForKey:@"stateDateMs"]) {
                         NSInteger stateDateMS = ((NSString *)[stateDict objectForKey:@"stateDateMs"]).integerValue;
                    }
                    
                    NSDictionary *data = [stateDict objectForKey:@"value"];
                    [state setValue:data forKey:@"data"];
                    [_states addObject:state];
                }
                states = _states;
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(states, error);
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

#pragma mark - Location Totals
/// See Dynamic UIs

#pragma mark - Location Presence
/**
 These APIs determine if a person is physically present nearby one of the location gateways, where the user has read access.
 **/

/**
 * Get Presence IDs
 *
 * Return UUIDs provided by all gateways, where the user has read access.
 *
 * @param callback PPUserAccountsLocationPresenceBlock Presence IDs callback block
 **/
+ (void)getPresenceIDs:(PPUserAccountsLocationPresenceBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"presence"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.getPresenceIDs()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *ibeaconUUIDs;
            
            if(!error) {
                ibeaconUUIDs = [root objectForKey:@"ibeaconUuids"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ibeaconUUIDs, error);
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

/**
 * Authorize Access
 *
 * Authorize access to the location, where the gateway with provided parameters is located.
 *
 * @param uuid Required NSString UUID string
 * @param major Required NSString Major string
 * @param minor Required NSString Minor string
 * @param callback PPUserAccountsLocationIdBlock Location ID callback block
 **/
+ (void)authorizeAccess:(NSString *)uuid major:(NSString *)major minor:(NSString *)minor callback:(PPUserAccountsLocationIdBlock)callback {
    NSAssert1(uuid != nil, @"%s missing uuid", __FUNCTION__);
    NSAssert1(major != nil, @"%s missing major", __FUNCTION__);
    NSAssert1(minor != nil, @"%s missing minor", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithString:@"presence"];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"paramsMap": @{@"ibeaconUuid": uuid, @"ibeaconMajor": major, @"ibeaconMinor": minor}} options:0 error:&dataError];
    if(dataError) {
        callback(PPLocationIdNone, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.user.authorizeAccess()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLocationId locationId = PPLocationIdNone;
            if(!error) {
                if([root objectForKey:@"locationId"]) {
                    locationId = (PPLocationId)((NSString *)[root objectForKey:@"locationId"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(locationId, error);
            });
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPLocationIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

@end

