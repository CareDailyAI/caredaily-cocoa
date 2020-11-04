//
//  PPCrowdFeedbacks.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCrowdFeedbacks.h"
#import "PPCloudEngine.h"

@implementation PPCrowdFeedbacks

#pragma mark - Session Management

/**
 * Shared feedbacks across the entire application
 */
+ (NSArray *)sharedFeedbacksForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    RLMResults<PPCrowdFeedback *> *sharedFeedbacks = [PPCrowdFeedback allObjects];
    NSMutableArray *sharedFeedbacksArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *feedbacksArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCrowdFeedback *feedback in sharedFeedbacks) {
        [sharedFeedbacksArray addObject:feedback];
        
        NSMutableDictionary *feedbackIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [feedbackIdentifiers setValue:@(feedback.feedbackId) forKey:@"ID"];
        [feedbacksArrayDebug addObject:feedbackIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFeedbacks=%@", __PRETTY_FUNCTION__, feedbacksArrayDebug);
#endif
#endif
    return sharedFeedbacksArray;
}

/**
 * Add feedbacks.
 * Add feedbacks from local reference.
 *
 * @param feedbacks NSArray Array of feedbacks to remove.
 * @param userId Required PPUserId User Id to associate these feedbacks with
 **/
+ (void)addFeedbacks:(NSArray *)feedbacks userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s feedbacks=%@", __PRETTY_FUNCTION__, feedbacks);
#endif
#endif
    [[PPRealm defaultRealm] beginWriteTransaction];
    for(PPCrowdFeedback *feedback in feedbacks) {
        [PPCrowdFeedback createOrUpdateInDefaultRealmWithValue:feedback];
    }
    [[PPRealm defaultRealm] commitWriteTransaction];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove feedbacks.
 * Remove feedbacks from local reference.
 *
 * @param feedbacks NSArray Array of feedbacks to remove.
 * @param userId Required PPUserId User Id to associate these feedbacks with
 **/
+ (void)removeFeedbacks:(NSArray *)feedbacks userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s feedbacks=%@", __PRETTY_FUNCTION__, feedbacks);
#endif
#endif
    [[PPRealm defaultRealm] transactionWithBlock:^{
        for(PPCrowdFeedback *feedback in feedbacks) {
            [[PPRealm defaultRealm] deleteObject:[PPCrowdFeedback objectForPrimaryKey:@(feedback.feedbackId)]];
        }
    }];
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Post Crowd Feedback

/**
 * Post Crowd Feedback.
 * The API returns the created feedback record ID and if a ticket has been created in a support cloud, then the ticket ID and the brand name.
 *
 * @param feedback required PPCrowdFeedback Feedback to send
 * @param callback PPCrowdFeedbacksTicketBlock Feedback callback block containing ticket response
 **/
+ (void)postCrowdFeedback:(PPCrowdFeedback *)feedback callback:(PPCrowdFeedbacksTicketBlock)callback {
    NSAssert1(feedback != nil, @"%s missing feedback", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"feedback"] resolvingAgainstBaseURL:NO];
    
    NSMutableDictionary *data = @{}.mutableCopy;
    
    feedback.feedbackId = PPCrowdFeedbackIdNone;
    data[@"feedback"] = [PPCrowdFeedback data:feedback];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.postCrowdFeedback", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCrowdFeedbackTicket *ticket;
            
            if(!error) {
                ticket = [PPCrowdFeedbackTicket initWithDictionary:root];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ticket, error);
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

#pragma mark - Get Crowd Feedback by Searching

/**
 * Get Crowd Feedback by Searching
 *
 * @param appName Required NSString Unique name / identifier of the app or product, selected by the developer
 * @param type Required PPCrowdFeedbackType Crowd feedback type
 * @param startPosition PPCrowdFeedbacksStartPosition Index of the first record to be returned
 * @param length Required PPCrowdFeedbacksLength Number of records to return
 * @param productIds NSArray Filter the response by product ID. You may include multiple of these parameters to filter by multiple product IDs
 * @param productCategories NSArray Filter the response by product category. You may include multiple of these parameters to filter by multiple product categories
 * @param disabled PPCrowdFeedbacksDisabled Return not enabled feedbacks as well
 * @param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
+ (void)getCrowdFeedbackBySearching:(NSString *)appName type:(PPCrowdFeedbackType)type startPosition:(PPCrowdFeedbacksStartPosition)startPosition length:(PPCrowdFeedbacksLength)length productIds:(NSArray *)productIds productCategories:(NSArray *)productCategories disabled:(PPCrowdFeedbacksDisabled)disabled callback:(PPCrowdFeedbacksBlock)callback {
    NSAssert1(appName != nil, @"%s missing appName", __FUNCTION__);
    NSAssert1(type != PPCrowdFeedbackTypeNone, @"%s missing type", __FUNCTION__);
    NSAssert1(length != PPCrowdFeedbacksLengthNone, @"%s missing length", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"feedback/%@/%@", appName, @(type)]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(startPosition != PPCrowdFeedbacksStartPositionNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startPos" value:@(startPosition).stringValue]];
    }
    if(length != PPCrowdFeedbacksLengthNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"length" value:@(length).stringValue]];
    }
    if(productIds) {
        [productIds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"productId" value:obj]];
        }];
    }
    if(productCategories) {
        [productCategories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"productCategory" value:obj]];
        }];
    }
    if(disabled != PPCrowdFeedbacksDisabledNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"disabled" value:(disabled) ? @"true" : @"false"]];
    }
    components.queryItems = queryItems;
    components.percentEncodedQuery = [[components.percentEncodedQuery stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.getCrowdFeedbackBySearching()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            NSMutableArray *feedbacks;
            if(!error) {
                feedbacks = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *feedbackDict in [root objectForKey:@"feedbacks"]) {
                    PPCrowdFeedback *feedback = [PPCrowdFeedback initWithDictionary:feedbackDict];
                    [feedbacks addObject:feedback];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(feedbacks, error);
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

#pragma mark - Get Specific Crowd Feedback

/**
 * Get Specific crowd feebdack
 *
 * @param feedbackId Required PPCrowdFeedbackId Specific feedback ID to obtain
 * @param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
+ (void)getSpecificCrowdFeedback:(PPCrowdFeedbackId)feedbackId callback:(PPCrowdFeedbacksBlock)callback {
    NSAssert1(feedbackId != PPCrowdFeedbackIdNone, @"%s missing feedbackId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"feedback/%@", @(feedbackId)]] resolvingAgainstBaseURL:NO];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.getSpecificCrowdFeedback()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *feedbacks;
            if(!error) {
                feedbacks = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *feedbackDict in [root objectForKey:@"feedbacks"]) {
                    PPCrowdFeedback *feedback = [PPCrowdFeedback initWithDictionary:feedbackDict];
                    [feedbacks addObject:feedback];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(feedbacks, error);
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

#pragma mark - Update Feedback

/**
 * Update feedback.
 * An administrator can update feedback left by users related to his organizations.
 *
 * @param feedbackId Requried PPCrowdFeedbackId Specific feedback ID to update
 * @param feedback Required PPCrowdFeedback Feedback object to update the reference with
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateFeedback:(PPCrowdFeedbackId)feedbackId feedback:(PPCrowdFeedback *)feedback callback:(PPErrorBlock)callback {
    NSAssert1(feedbackId != PPCrowdFeedbackIdNone, @"%s missing feedbackId", __FUNCTION__);
    NSAssert1(feedback != nil, @"%s missing feedback", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"feedback/%@", @(feedbackId)]] resolvingAgainstBaseURL:NO];
    
    NSMutableDictionary *data = @{}.mutableCopy;
    data[@"feedback"] = [PPCrowdFeedback data:feedback];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.updateFeedback()", DISPATCH_QUEUE_SERIAL);
    
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

#pragma mark - Vote for Feedback

/**
 * Vote for feedback.
 *
 * @param feedbackId Required PPCrowdFeedbackId Specific feedback ID to update
 * @param rank Required PPCrowdFeedbackRank Cast a vote or remove existing vote
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)voteForFeedback:(PPCrowdFeedbackId)feedbackId rank:(PPCrowdFeedbackRank)rank callback:(PPErrorBlock)callback {
    NSAssert1(feedbackId != PPCrowdFeedbackIdNone, @"%s missing feedbackId", __FUNCTION__);
    NSAssert1(rank != PPCrowdFeedbackRankNone, @"%s missing rank", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"feedback/%@/%@", @(feedbackId), @(rank)]] resolvingAgainstBaseURL:NO];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.voteForFeedback()", DISPATCH_QUEUE_SERIAL);
    
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Request Support

/**
 * Request Support.
 * If a ticket has been created in a support cloud, then the API returns the ticket ID and the brand name.
 *
 * @param appName NSString  App name to forward the support request
 * @param feedbackSupport PPCrowdFeedbackSupport Feedback support object
 * @param callback PPCrowdFeedbacksTicketBlock Feedbacks ticket block
 **/
+ (void)requestSupport:(NSString *)appName feedbackSupport:(PPCrowdFeedbackSupport *)feedbackSupport callback:(PPCrowdFeedbacksTicketBlock)callback {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"support"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    components.queryItems = queryItems;
    
    NSDictionary *data = [PPCrowdFeedbackSupport data:feedbackSupport];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.communications.crowdfeedback.requestSupport()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCrowdFeedbackTicket *ticket;
            
            if(!error) {
                ticket = [PPCrowdFeedbackTicket initWithDictionary:root];
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(ticket, error);
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



@end
