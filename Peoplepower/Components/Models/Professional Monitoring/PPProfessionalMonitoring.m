//
//  PPProfessionalMonitoring.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPProfessionalMonitoring.h"
#import "PPCloudEngine.h"

@implementation PPProfessionalMonitoring

#pragma mark - Session Management

#pragma mark Call Center

__strong static NSMutableDictionary*_sharedCallCenter = nil;

/**
 * Shared subscriptions across the entire application
 */
+ (PPCallCenter *)sharedCallCenterForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedCallCenter) {
        [PPProfessionalMonitoring initializeSharedCallCenter];
    }
    PPCallCenter *sharedCallCenter;
    NSMutableArray *callCenterArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedCallCenter.allKeys) {
        PPCallCenter *callCenter = [_sharedCallCenter objectForKey:userIdKey];
        [callCenterArray addObject:@{@"status": @(callCenter.status)}];
        
        if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
            sharedCallCenter = callCenter;
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedCallCenter=%@", __PRETTY_FUNCTION__, callCenterArray);
#endif
#endif
    return sharedCallCenter;
}

+ (void)initializeSharedCallCenter {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedCallCenter = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedCallCenterData = [defaults objectForKey:@"user.callCenter"];
//    if(storedCallCenterData) {
//        _sharedCallCenter = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedCallCenterData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add call center.
 * Add call center to local reference.
 *
 * @param callCenter PPCallCenter Call Center
 * @param userId Required PPUserId User Id to associate this token with
 **/
+ (void)addCallCenter:(PPCallCenter *)callCenter userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s callCenter=%@", __PRETTY_FUNCTION__, callCenter);
#endif
#endif
    if(!_sharedCallCenter) {
        [PPProfessionalMonitoring initializeSharedCallCenter];
    }
    
    [_sharedCallCenter setObject:callCenter forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedTokenData = [NSKeyedArchiver archivedDataWithRootObject:_sharedCallCenter];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedTokenData forKey:@"user.callCenter"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s status=%li", __PRETTY_FUNCTION__, (long)callCenter.status);
#endif
#endif
}

/**
 * Remove call center.
 * Remove call center from local reference.
 *
 * @param userId Required PPUserId User Id to disassociate this call center with
 **/
+ (void)removeCallCenterForUserId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedCallCenter) {
        [PPProfessionalMonitoring initializeSharedCallCenter];
    }
    
    [_sharedCallCenter removeObjectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedTokenData = [NSKeyedArchiver archivedDataWithRootObject:_sharedCallCenter];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedTokenData forKey:@"user.notificationCallCenter"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Alerts

__strong static NSMutableDictionary*_sharedCallCenterAlerts = nil;

/**
 * Shared alerts across the entire application
 */
+ (NSArray *)sharedAlertsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedCallCenterAlerts) {
        [PPProfessionalMonitoring initializeSharedCallCenterAlerts];
    }
    
    NSArray* sharedAlerts = @[];
    
    NSMutableArray *sharedAlertsArray = [[NSMutableArray alloc] initWithCapacity:[sharedAlerts count]];
    NSMutableArray *alertsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCallCenterAlert *alert in sharedAlerts) {
        [sharedAlertsArray addObject:alert];

        [alertsArrayDebug addObject:@{@"alertDate": alert.alertDate}];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedAlerts=%@", __PRETTY_FUNCTION__, alertsArrayDebug);
#endif
#endif
    return sharedAlertsArray;
}

+ (void)initializeSharedCallCenterAlerts {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedCallCenterAlerts = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *storedCallCenterData = [defaults objectForKey:@"user.callCenter"];
    if(storedCallCenterData) {
        _sharedCallCenter = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedCallCenterData];
    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add alerts.
 * Add alerts to local reference.
 *
 * @param alerts NSArray Array of alerts to add.
 **/
+ (void)addAlerts:(NSArray *)alerts userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s alerts=%@", __PRETTY_FUNCTION__, alerts);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove alerts.
 * Remove alerts from local reference.
 *
 * @param alerts NSArray Array of alerts to remove.
 **/
+ (void)removeAlerts:(NSArray *)alerts userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s alerts=%@", __PRETTY_FUNCTION__, alerts);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Call Center

/**
 * Get call center.
 * Retrieve call center service statuses, if the service is available and if the registration in the third party application has been completed. If the service is available, but the registration has not been completed yet, then the IoT Software Suite does not have enough information to do it.
 * Call center registration can have following statuses:
 *      Value   Status                  Description
 *      0       Unavailable             The service never purchased
 *      1       Available               The service purchased, but the user does not have enough information for registration
 *      2       Registration pending    The registration process has not been completed yet
 *      3       Registered              Registration completed
 *      4       Cancellation pending    The cancellation has not been completed yet
 *      5       Canceled                Cancellation completed
 * To complete the call center registration the user has to submit own name, phone number and address using the update user info API and a list of emergency contacts. The complete list of missing fields is returned.
 * Also this API returns an array of emergency contacts including the first and the last name, the phone number of the person in the order, how they have to be contacted.
 * The alert status with the alert date is returned in a case of an emergency situation. It can have following values:
 *      Value   Status      Description
 *      0                   An alert never raised
 *      1       Raised      An alert raised, but the call center not contacted yet
 *      3       Reported    The alert reported to the call center
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId Used by administrators to access specific user information
 * @param callback PPCallCenterBlock Call center block containing call center object
 **/
+ (void)getCallCenter:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPCallCenterBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"callCenter?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.profesionalmonitoring.getCallCenter()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCallCenter *callCenter;
            
            if(!error) {
                callCenter = [PPCallCenter initWithDictionary:[root objectForKey:@"callCenter"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(callCenter, error);
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
+ (void)getCallCenter:(PPCallCenterBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +getCallCenter:userId:callback:", __FUNCTION__);
    [PPProfessionalMonitoring getCallCenter:PPLocationIdNone userId:PPUserIdNone callback:callback];
}

/**
 * Update call center.
 * Update user's call center record. The API can raise a alert by setting the alert status.
 * If the new alert status is not provided, the API overwrites the call center contacts information. Submitting null or an empty contacts array will not affect existing contacts data.
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID to associate the Call Center Site Owner to a specific user
 * @param alertStatus PPCallCenterAlertStatus New alert status
 * @param contacts NSArray Udpated contact list
 * @param codeword NSString New codeword
 * @param permit NSString New permit ID
 * @param callback PPCallCenterBlock Call center callback block
 **/
+ (void)updateCallCenter:(PPLocationId)locationId userId:(PPUserId)userId alertStatus:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray *)contacts codeword:(NSString *)codeword permit:(NSString *)permit callback:(PPCallCenterBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"callCenter?locationId=%li&", (long)locationId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    PPCallCenter *callCenter = [[PPCallCenter alloc] initWithStatus:PPCallCenterStatusNone userId:userId missingFields:nil contacts:contacts codeword:codeword permit:permit alertStatus:alertStatus alertDate:nil alertStatusDate:nil];
    [JSONString appendFormat:@"\"callCenter\": %@", [PPCallCenter stringify:callCenter]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.profesionalmonitoring.updateCallCenter()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCallCenter *callCenter;
            
            if(!error) {
                callCenter = [PPCallCenter initWithDictionary:[root objectForKey:@"callCenter"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(callCenter, error);
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
+ (void)updateCallCenter:(PPLocationId)locationId alertStatus:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray *)contacts codeword:(NSString *)codeword permit:(NSString *)permit callback:(PPCallCenterBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +updateCallCenter:userId:alertStatus:contacts:codeword:permit:callback:", __FUNCTION__);
    [PPProfessionalMonitoring updateCallCenter:locationId userId:PPUserIdNone alertStatus:alertStatus contacts:contacts codeword:codeword permit:permit callback:callback];
}
+ (void)updateCallCenter:(PPCallCenterAlertStatus)alertStatus contacts:(NSArray *)contacts codeword:(NSString *)codeword permit:(NSString *)permit callback:(PPCallCenterBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +updateCallCenter:userId:alertStatus:contacts:codeword:permit:callback:", __FUNCTION__);
    [PPProfessionalMonitoring updateCallCenter:PPLocationIdNone userId:PPUserIdNone alertStatus:alertStatus contacts:contacts codeword:codeword permit:permit callback:callback];
}

/**
 * Cancel call center.
 * Update user's call center record status to available and delete contacts.
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPErrorBlock Error callback block
 */
+ (void)cancelCallCenter:(PPLocationId)locationId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"callCenter?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.profesionalmonitoring.cancelCallCenter()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
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

#pragma mark - Call Center Alerts

/**
 * Get call center alerts.
 * Retrieve history of call center alerts.The alert source type can have following values:
 *      Value   Description
 *      0       Unknown
 *      1       Raised by a rule
 *      2       Raised by a composer app
 *      3       Raised by an app API
 *
 * @param locationId Required PPLocationId Location ID
 * @param callback PPCallCenterAlertsBlock Call center alerts callback
 **/
+ (void)getCallCenterAlerts:(PPLocationId)locationId callback:(PPCallCenterAlertsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"callCenterAlerts?"];
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.profesionalmonitoring.getCallCenterAlerts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *alerts;
            
            if(!error) {
                alerts = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *alertDict in [root objectForKey:@"callCenterAlerts"]) {
                    PPCallCenterAlert *alert = [PPCallCenterAlert initWithDictionary:alertDict];
                    [alerts addObject:alert];
                }
            }
                
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(alerts, error);
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
+ (void)getCallCenterAlerts:(PPCallCenterAlertsBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated. Use +getCallCenterAlerts:callback:", __FUNCTION__);
    [PPProfessionalMonitoring getCallCenterAlerts:PPLocationIdNone callback:callback];
}

@end

