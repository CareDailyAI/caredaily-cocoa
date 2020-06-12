//
//  PPQuestions.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPQuestions.h"
#import "PPCloudEngine.h"

@implementation PPQuestions

#pragma mark - Session Management

#pragma mark Collections

__strong static NSMutableDictionary*_sharedCollections = nil;

/**
 * Shared questions across the entire application
 */
+ (NSArray *)sharedCollectionsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedCollections) {
        [PPQuestions initializeSharedCollections];
    }
    NSMutableArray *sharedCollections = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *collectionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedCollections.allKeys) {
        for(PPQuestionCollection *collection in [_sharedCollections objectForKey:userIdKey]) {
            NSMutableDictionary *collectionIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [collectionIdentifiers setValue:collection.name forKey:@"ID"];
            [collectionsArray addObject:collectionIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedCollections addObject:collection];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedCollections=%@", __PRETTY_FUNCTION__, collectionsArray);
#endif
#endif
    return sharedCollections;
}

+ (void)initializeSharedCollections {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedCollections = [[NSMutableDictionary alloc] initWithCapacity:0];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSData *storedCollectionsData = [defaults objectForKey:@"user.notificationCollections"];
    //    if(storedCollectionsData) {
    //        _sharedCollections = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedCollectionsData];
    //    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add collections.
 * Add collections from local reference.
 *
 * @param collections NSArray Array of collections to remove.
 * @param userId Required PPUserId User Id to associate these collections with
 **/
+ (void)addCollections:(NSArray *)collections userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s collections=%@", __PRETTY_FUNCTION__, collections);
#endif
#endif
    if(!_sharedCollections) {
        [PPQuestions initializeSharedCollections];
    }
    
    NSMutableArray *collectionsArray = [_sharedCollections objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!collectionsArray) {
        collectionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPQuestionCollection *collection in collections) {
        
        BOOL found = NO;
        for(PPQuestionCollection *sharedCollection in collectionsArray) {
            if([sharedCollection isEqualToCollection:collection]) {
                [sharedCollection sync:collection];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[collections indexOfObject:collection]];
        }
    }
    
    [collectionsArray addObjectsFromArray:[collections objectsAtIndexes:indexSet]];
    [_sharedCollections setObject:collectionsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
    //    NSData *sharedCollectionData = [NSKeyedArchiver archivedDataWithRootObject:_sharedCollections];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:sharedCollectionData forKey:@"user.notificationCollections"];
    //    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s collectionsArray=%@", __PRETTY_FUNCTION__, collectionsArray);
#endif
#endif
}

/**
 * Remove collections.
 * Remove collections from local reference.
 *
 * @param collections NSArray Array of collections to remove.
 * @param userId Required PPUserId User Id to associate these collections with
 **/
+ (void)removeCollections:(NSArray *)collections userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s collections=%@", __PRETTY_FUNCTION__, collections);
#endif
#endif
    
    if(!_sharedCollections) {
        [PPQuestions initializeSharedCollections];
    }
    
    NSMutableArray *collectionsArray = [_sharedCollections objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!collectionsArray) {
        collectionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPQuestionCollection *collection in collections) {
        for(PPQuestionCollection *sharedCollection in collectionsArray) {
            if([sharedCollection isEqualToCollection:collection]) {
                [indexSet addIndex:[collectionsArray indexOfObject:sharedCollection]];
                break;
            }
        }
    }
    
    [collectionsArray removeObjectsAtIndexes:indexSet];
    [_sharedCollections setObject:collectionsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
    //    NSData *sharedCollectionData = [NSKeyedArchiver archivedDataWithRootObject:_sharedCollections];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:sharedCollectionData forKey:@"user.notificationCollections"];
    //    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s collectionsArray=%@", __PRETTY_FUNCTION__, collectionsArray);
#endif
#endif
}

#pragma mark Questions

__strong static NSMutableDictionary*_sharedQuestions = nil;

/**
 * Shared questions across the entire application
 */
+ (NSArray *)sharedQuestionsForUser:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    if(!_sharedQuestions) {
        [PPQuestions initializeSharedQuestions];
    }
    NSMutableArray *sharedQuestions = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *questionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSString *userIdKey in _sharedQuestions.allKeys) {
        for(PPQuestion *question in [_sharedQuestions objectForKey:userIdKey]) {
            NSMutableDictionary *questionIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
            [questionIdentifiers setValue:@(question.questionId) forKey:@"ID"];
            [questionsArray addObject:questionIdentifiers];
            
            if([userIdKey isEqualToString:[NSString stringWithFormat:@"%li", (long)userId]]) {
                [sharedQuestions addObject:question];
            }
        }
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedQuestions=%@", __PRETTY_FUNCTION__, questionsArray);
#endif
#endif
    return sharedQuestions;
}

+ (void)initializeSharedQuestions {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    _sharedQuestions = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *storedQuestionsData = [defaults objectForKey:@"user.notificationQuestions"];
//    if(storedQuestionsData) {
//        _sharedQuestions = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:storedQuestionsData];
//    }
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Add questions.
 * Add questions from local reference.
 *
 * @param questions NSArray Array of questions to remove.
 * @param userId Required PPUserId User Id to associate these questions with
 **/
+ (void)addQuestions:(NSArray *)questions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s questions=%@", __PRETTY_FUNCTION__, questions);
#endif
#endif
    if(!_sharedQuestions) {
        [PPQuestions initializeSharedQuestions];
    }
    
    NSMutableArray *questionsArray = [_sharedQuestions objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!questionsArray) {
        questionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPQuestion *question in questions) {
        
        BOOL found = NO;
        for(PPQuestion *sharedQuestion in questionsArray) {
            if([sharedQuestion isEqualToQuestion:question]) {
                [sharedQuestion sync:question];
                found = YES;
                break;
            }
        }
        if(!found) {
            [indexSet addIndex:[questions indexOfObject:question]];
        }
    }
    
    [questionsArray addObjectsFromArray:[questions objectsAtIndexes:indexSet]];
    [_sharedQuestions setObject:questionsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedQuestionData = [NSKeyedArchiver archivedDataWithRootObject:_sharedQuestions];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedQuestionData forKey:@"user.notificationQuestions"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s questionsArray=%@", __PRETTY_FUNCTION__, questionsArray);
#endif
#endif
}

/**
 * Remove questions.
 * Remove questions from local reference.
 *
 * @param questions NSArray Array of questions to remove.
 * @param userId Required PPUserId User Id to associate these questions with
 **/
+ (void)removeQuestions:(NSArray *)questions userId:(PPUserId)userId {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s questions=%@", __PRETTY_FUNCTION__, questions);
#endif
#endif
    
    if(!_sharedQuestions) {
        [PPQuestions initializeSharedQuestions];
    }
    
    NSMutableArray *questionsArray = [_sharedQuestions objectForKey:[NSString stringWithFormat:@"%li", (long)userId]];
    if(!questionsArray) {
        questionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for(PPQuestion *question in questions) {
        for(PPQuestion *sharedQuestion in questionsArray) {
            if([sharedQuestion isEqualToQuestion:question]) {
                [indexSet addIndex:[questionsArray indexOfObject:sharedQuestion]];
                break;
            }
        }
    }
    
    [questionsArray removeObjectsAtIndexes:indexSet];
    [_sharedQuestions setObject:questionsArray forKey:[NSString stringWithFormat:@"%li", (long)userId]];
    
//    NSData *sharedQuestionData = [NSKeyedArchiver archivedDataWithRootObject:_sharedQuestions];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:sharedQuestionData forKey:@"user.notificationQuestions"];
//    [defaults synchronize];
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s questionsArray=%@", __PRETTY_FUNCTION__, questionsArray);
#endif
#endif
}

#pragma mark - Get Questions

/**
 * Get Questions.
 * Retrieve requested questions.
 * For an individual user, there should be at most one unanswered question available per day, unless the question is urgent. For public users, there can be many questions as we are using this on public surveys during a sign up process.
 *
 * @param answerStatuses NSArray Return questions with the specific answer status. By default questions with statuses 2 and 3 are returned. Multiple values are supported.
 * @param editable PPQuestionEditable Filter answered questions: true - return only editable answered questions, false - return only not editable answered questions, otherwise return all answered questions.
 * @param organizationId PPOrganizationId Organization ID to filter questions by
 * @param collectionName NSString Questions collection name filter
 * @param generalPublic PPQuestionCollectionGeneralPublic true - return only public questions, false - return only private questions
 * @param questionId PPQuestionId Extract a specifc question Id
 * @param appInstanceId PPBotengineAppInstanceId Only retrieve quetsions for a specific botengine app
 * @param lang NSString Quetsions text language. If not set, user's or default language will be used.
 * @param limit PPQuestionsLimit Maximum number of questions to return. The default is 0 (unlimited)
 * @param startDate NSDate Start date to select question
 * @param endDate NSDate End date to select questions. Default is the current date.
 * @param userId PPUserId Get specific user questions by organization administrator
 * @param callback PPQuestionsBlock Questions callback block containing arrays of collections and questions.
 **/
+ (void)getQuestions:(PPLocationId)locationId answerStatuses:(NSArray *)answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString *)collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString *)lang limit:(PPQuestionsLimit)limit startDate:(NSDate *)startDate endDate:(NSDate *)endDate userId:(PPUserId)userId callback:(PPQuestionsBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"questions"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    if(answerStatuses) {
        [answerStatuses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"answerStatus" value:([obj isKindOfClass:[NSNumber class]]) ? ((NSNumber *)obj).stringValue : (NSString *)obj]];
            }
        }];
    }
    if(editable != PPQuestionEditableNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"editable" value:(editable) ? @"true" : @"false"]];
    }
    if(organizationId != PPOrganizationIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"organizationId" value:@(organizationId).stringValue]];
    }
    if(collectionName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"collectionName" value:collectionName]];
    }
    if(generalPublic != PPQuestionCollectionGeneralPublicNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"generalPublic" value:(generalPublic) ? @"true" : @"false"]];
    }
    if(questionId != PPQuestionIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"questionId" value:@(questionId).stringValue]];
    }
    if(appInstanceId != PPBotengineAppInstanceIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appInstanceId" value:@(appInstanceId).stringValue]];
    }
    if(lang) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"lang" value:lang]];
    }
    if(limit != PPQuestionsLimitNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"limit" value:@(limit).stringValue]];
    }
    if(startDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"startDate" value:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(endDate) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"endDate" value:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    components.queryItems = queryItems;
    
    PPCloudEngine *cloudEngine = [PPCloudEngine sharedAppEngine];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.questions.getQuestions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [cloudEngine GET:components.string success:^(NSData *responseData) {
    
        dispatch_async(queue, ^{
        
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *collections;
            NSMutableArray *questions;
            
            if(!error) {
                collections = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *collectionDict in [root objectForKey:@"collections"]) {
                    PPQuestionCollection *collection = [PPQuestionCollection initWithDictionary:collectionDict];
                    [collections addObject:collection];
                }
                
                questions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *questionDict in [root objectForKey:@"questions"]) {
                    PPQuestion *question = [PPQuestion initWithDictionary:questionDict];
                    [questions addObject:question];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(collections, questions, error);
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

+ (void)getQuestions:(NSArray *)answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString *)collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString *)lang limit:(PPQuestionsLimit)limit startDate:(NSDate *)startDate endDate:(NSDate *)endDate userId:(PPUserId)userId callback:(PPQuestionsBlock)callback {
    NSLog(@"%s deprecated, use +getQuestions:answerStatuses:editable:organizationId:collectionName:generalPublic:questionId:appInstanceId:lang:limit:startDate:endDate:userId:callback:", __FUNCTION__);
    [PPQuestions getQuestions:PPLocationIdNone answerStatuses:answerStatuses editable:editable organizationId:organizationId collectionName:collectionName generalPublic:generalPublic questionId:questionId appInstanceId:appInstanceId lang:lang limit:limit startDate:startDate endDate:endDate userId:PPUserIdNone callback:callback];
}
+ (void)getQuestions:(NSArray *)answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString *)collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString *)lang limit:(PPQuestionsLimit)limit publicQuestion:(PPQuestionsPublic)publicQuestion startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPQuestionsBlock)callback {
    NSLog(@"%s deprecated, use +getQuestions:answerStatuses:editable:organizationId:collectionName:generalPublic:questionId:appInstanceId:lang:limit:startDate:endDate:userId:callback:", __FUNCTION__);
    [PPQuestions getQuestions:PPLocationIdNone answerStatuses:answerStatuses editable:editable organizationId:organizationId collectionName:collectionName generalPublic:generalPublic questionId:questionId appInstanceId:appInstanceId lang:lang limit:limit startDate:startDate endDate:endDate userId:PPUserIdNone callback:callback];
}

/**
 * Answer a question.
 * After answering a question, the user should see how many points they earned (if any), and if the question is aggregated publicly then the user should also see how other people voted.
 * A user can skip the question or prefer to not answer it by setting the corresponding answer status. Providing just the question ID the UI app can mark the question as notified.
 * Only editable questions can be updated later. Typically editable questions are used to configure Composer Apps and add further context to the user's data later.
 * If any points were previously rewarded for previously answering this question, then answering the question again should not result in more points. However, if no points were previously rewarded and now the user is updating the answer to one that does reward points, then the user should receive those points.
 * The user's tagged attributes should migrate with the question, such that when a new answer is selected, any previous tags are removed and new tags are applied.
 * The body and response is designed to handle answers to multiple questions simultaneously.
 *
 * @param locationId Required PPLocationId Location ID to answer questions
 * @param questions NSArray Array of answered questions
 * @param userId PPUserId Answer specific user questions by organization administrator
 * @param callback PPQuestionsAnswersBlock Answers callback block
 **/
+ (void)answerQuestions:(PPLocationId)locationId questions:(NSArray *)questions userId:(PPUserId)userId callback:(PPQuestionsAnswersBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(questions != nil && [questions count] > 0, @"%s missing questions", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"questions"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"locationId" value:@(locationId).stringValue]];
    
    if(userId != PPUserIdNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"userId" value:@(userId).stringValue]];
    }
    components.queryItems = queryItems;
    
    NSMutableDictionary *data = @{}.mutableCopy;
    NSMutableArray *questionsData = @[].mutableCopy;
    [questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [questionsData addObject:[PPQuestion data:(PPQuestion *)obj]];
    }];
    data[@"questions"] = questionsData;
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback(nil, [PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.inappmessaging.answerQuestions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *questions;
            
            if(!error) {
                questions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *questionDict in [root objectForKey:@"questions"]) {
                    PPQuestion *question = [PPQuestion initWithDictionary:questionDict];
                    [questions addObject:question];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(questions, error);
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
+ (void)answerQuestions:(NSArray *)questions userId:(PPUserId)userId callback:(PPQuestionsAnswersBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +answerQuestions:questions:userId:callback:", __FUNCTION__);
    [PPQuestions answerQuestions:PPLocationIdNone questions:questions userId:PPUserIdNone callback:callback];
}
+ (void)answerQuestions:(NSArray *)questions publicQuestion:(PPQuestionsPublic)publicQuestion callback:(PPQuestionsAnswersBlock)callback __attribute__((deprecated)) {
    NSLog(@"%s deprecated, use +answerQuestions:questions:userId:callback:", __FUNCTION__);
    [PPQuestions answerQuestions:PPLocationIdNone questions:questions userId:PPUserIdNone callback:callback];
}

@end
