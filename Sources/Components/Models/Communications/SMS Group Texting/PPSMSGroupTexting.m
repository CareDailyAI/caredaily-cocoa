//
//  PPSMSGroupTexting.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPSMSGroupTexting.h"
#import "PPCloudEngine.h"

@implementation PPSMSGroupTexting

#pragma mark - Session Management

/**
 * Shared subscribers across the entire application
 */
+ (NSArray *)sharedSubscribersForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPSMSSubscriber *> *sharedSubscribers = [PPSMSSubscriber allObjects];
    
    NSMutableArray *sharedSubscribersArray = [[NSMutableArray alloc] initWithCapacity:[sharedSubscribers count]];
    NSMutableArray *subscribersArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPSMSSubscriber *subscriber in sharedSubscribers) {
        [sharedSubscribersArray addObject:subscriber];
        
        NSMutableDictionary *subscriberIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [subscriberIdentifiers setValue:subscriber.phone forKey:@"phone"];
        if(subscriber.initials) {
            [subscriberIdentifiers setValue:subscriber.initials forKey:@"initials"];
        }
        [subscribersArrayDebug addObject:subscriberIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedSubscribers=%@", __PRETTY_FUNCTION__, subscribersArrayDebug);
#endif
#endif
    return sharedSubscribersArray;
}

/**
 * Add subscribers.
 * Add subscribers from local reference.
 *
 * @param subscribers NSArray Array of subscribers to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)addSubscribers:(NSArray *)subscribers userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s subscribers=%@", __PRETTY_FUNCTION__, subscribers);
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPSMSSubscriber *subscriber in subscribers) {
        [PPSMSSubscriber createOrUpdateInDefaultRealmWithValue:subscriber];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove subscribers.
 * Remove subscribers from local reference.
 *
 * @param subscribers NSArray Array of subscribers to remove.
 * @param userId Required PPUserId User Id to associate these objects with
 **/
+ (void)removeSubscribers:(NSArray *)subscribers userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s subscribers=%@", __PRETTY_FUNCTION__, subscribers);
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPSMSSubscriber *subscriber in subscribers) {
            [[PPRealm defaultRealm] deleteObject:[PPSMSSubscriber objectForPrimaryKey:subscriber.phone]];
        }
    }];
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - SMS Group Texting

/**
 * Get SMS Subscribers
 *
 * @param categories NSArray Communication category filter. Multiple values supported.
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param callback PPSMSGroupTextingSubscribersCallback SMS Group Texting subscribers callback containing array of subscribers
 **/
+ (void)getSMSSubscribers:(NSArray *)categories userId:(PPUserId)userId callback:(PPSMSGroupTextingSubscribersCallback)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"smsSubscribers"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(categories) {
        [categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"category" value:(NSNumber *)obj]];
        }];
    }
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.smsgrouptexting.getSMSSubscribers()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *subscribers;
            
            if(!error) {
                subscribers = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *subscriberDict in [root objectForKey:@"subscribers"]) {
                    PPSMSSubscriber *subscriber = [PPSMSSubscriber initWithDictionary:subscriberDict];
                    [subscribers addObject:subscriber];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(subscribers, error);
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
 * Add / Update Subscriber
 *
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param subscriber Required PPSMSSubscriber Subscriber object to add / update
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateSubscriber:(PPUserId)userId subscriber:(PPSMSSubscriber *)subscriber callback:(PPErrorBlock)callback {
    NSAssert1(subscriber != nil, @"%s missing subscriber", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"smsSubscribers"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    data[@"subscriber"] = [PPSMSSubscriber data:subscriber];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.smsgrouptexting.updateSubscriber()", DISPATCH_QUEUE_SERIAL);
    
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

/**
 * Delete Subscriber
 *
 * @param phone Required NSString Phone number to delete
 * @param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteSubscriber:(NSString *)phone userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(phone != nil, @"%s missing phone", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"smsSubscribers"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"phone" value:phone]];
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.smsgrouptexting.deleteSubscriber()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end
